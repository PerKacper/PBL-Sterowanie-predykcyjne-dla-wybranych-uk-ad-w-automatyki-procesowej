import logging
import asyncio
from asyncio import Task

from asyncua import Server


class OpcServer:
    def __init__(self, endpoint: str, uri: str):
        self._server = Server()
        self._endpoint = endpoint
        self._uri = uri
        self._namespace_id: int = 0
        self._variables: dict = {}
        self._logger = logging.getLogger('asyncua')

    def _get_variables(self) -> list:
        return [name + " " + var.__str__() for name, var in self._variables.items()]

    def _print_on_startup(self):
        print('Starting server!')
        print(f'Current namespace id is {self._namespace_id}, registered variables are: {self._get_variables()}')

    async def _add_variable(self, variable_name, value):
        if variable_name in self._variables.keys():
            raise NameError(f"Variable {variable_name} already exists")
        new_var = await self._server.nodes.objects.add_variable(self._namespace_id, variable_name, value)
        await new_var.set_writable()
        self._variables[variable_name] = new_var

    async def _create_variables(self):
        await self._add_variable("Watchdog", 0)  # watchdog cancel
        await self._add_variable("Aeration", False)  # aeration pump control - controlled variable
        await self._add_variable("Oxygen", 0.0)  # value of oxygen saturation - process variable
        await self._add_variable("Control", False)  # distant control
        await self._add_variable("Talkback", False)  # confirms watchdog cancel

    async def init(self):
        await self._server.init()
        self._namespace_id = await self._server.register_namespace(self._uri)
        await self._create_variables()
        self._print_on_startup()

    async def _cancel_watchdog(self, interval: float):
        async with self._server:
            while True:
                current_val = await self._variables["Watchdog"].get_value()
                print(f"Watchdog: {int(not current_val)}")
                await self._variables["Watchdog"].set_value(int(not current_val))
                await asyncio.sleep(interval)

    async def _monitor_variable_value(self, variable_name: str, interval: float):
        while True:
            print(f"{variable_name}: {await self._variables[variable_name].get_value()}")
            await asyncio.sleep(interval)

    async def update_variable_value(self, variable_name: str, value):
        if variable_name not in self._variables.keys():
            raise NameError(f"Variable {variable_name} does not exist")
        await self._variables[variable_name].write_value(value)

    def create_task_watchdog(self, interval: float) -> Task:
        return asyncio.create_task(self._cancel_watchdog(interval))

    def create_task_monitor(self, variable_name: str, interval: float) -> Task:
        return asyncio.create_task(self._monitor_variable_value(variable_name, interval))


async def main():
    endpoint = 'opc.tcp://0.0.0.0:4840/'
    uri = 'server'
    server = OpcServer(endpoint, uri)
    await server.init()
    watchdog = server.create_task_watchdog(10)
    oxygen = server.create_task_monitor("Oxygen", 1)
    aeration = server.create_task_monitor("Aeration", 1)
    control = server.create_task_monitor("Control", 10)
    talkback = server.create_task_monitor("Talkback", 10)
    await watchdog
    await oxygen
    await aeration
    await control
    await talkback

if __name__ == '__main__':
    # logging.basicConfig(level=logging.INFO)
    asyncio.run(main(), debug=True)
