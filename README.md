# PBL-Sterowanie-predykcyjne-dla-wybranych-układów-automatyki-procesowej

 Obiektem regulacji jest przepływowy podgrzewacz ciepła. Obiekt ten charakteryzuje się silnymi nieliniowościami. Tradycyjne sterowanie oparte o regulator PID daje akceptowalną jakość regulacji tylko dla niewielkich odchyłek od punktu pracy. Poprawa jakości regulacji możliwa jest dzięki zastosowaniu zaawansowanych regulatorów takich jak regulatory z rodziny MPC (ang. Model Predictive Control). W celu podniesienia wartości merytorycznej projektu planowana jest także równoległa weryfikacja zaproponowanych rozwiązań dla reaktora biologicznego z osadem czynnym.

## Przyjęte założenia

Sterowanie predykcyjne dla procesu dystrybucji ciepła. Obiektem regulacji jest przepływowy podgrzewacz ciepła. Obiekt ten charakteryzuje się silnymi nieliniowościami. Tradycyjne sterowanie oparte o regulator PID daje akceptowalną jakość regulacji tylko dla niewielkich odchyłek od punktu pracy. Poprawa jakości regulacji możliwa jest dzięki zastosowaniu zaawansowanych regulatorów takich jak regulatory z rodziny MPC (ang. Model Predictive Control). W celu podniesienia wartości merytorycznej projektu planowana jest także równoległa weryfikacja zaproponowanych rozwiązań dla reaktora biologicznego z osadem czynnym.

## Osiągnięte Cele

Głównym celem, osiągniętym na przestrzeniprojektu było stworzenie rozproszonego systemu sterowania, przy pomocy serwerów
OPC, przekazującego informacje z regulatora predykcyjnego DMC. W projekcie
zadbano o możliwość wykorzystania rozwiązań opartych o fog computing,
realizowanego także z wykorzystaniem urządzenia brzegowego (Raspberry Pi).
Kluczowymi zagadnieniami które zostały poruszone w projekcie było zapewnienie
bezpieczeństwa oraz determinizmu czasowego zastosowanych algorytmów,
szczególnie w instalacji cieplnej. Z tego powodu stworzono dodatkowy algorytm
na sterowniku PLC z zapewnieniem mechanizmu bez uderzeniowego przełączania
pomiędzy algorytmami sterującymi zewnętrznymi oraz wewnątrz sterownika. Ponadto
na drugiej dostępnej instalacji bioreaktora zaimplementowano system Watchdoga,
który dodatkowa analizował przepływ danych z zewnętrznego regulatora.**

## Zastosowane metody realizacji

Projekt łączył w sobie
zagadnienia związane z automatyką przemysłową oraz informatyką. W ramach niego wykonano
program sterowania w środowisku TIA Portal (Siemens). Następnie zestawiono
komunikacje poprzez technologie OPC UA z zaimplementowanym w sieci lokalnej
serwerze OPC, poprzez przetestowanie przepływu informacji w strukturze DB,
która to wymieniała informacje z testowym programem na Raspberry Pi. Stworzono
własną implementację algorytmu MPC z wykorzystaniem języka Python. W celu
zarządzania rozproszoną mocą obliczeniową wykorzystano środowisko Fog
Computingu. W środowisku tym zaimplementowano rozwiązywanie obliczeń związanych
z algorytmem sterowania obiektem.

## Osiągnięte wyniki

Wszystkie osiągnięte cele zaprezentowano w raporcie oraz
przedstawiono w prezentacji praktycznej. Zaprezentowano możliwości
implementacji zaawansowanych algorytmów regulacji W dostępnych na przestrzeni
projektu układach automatyki procesowej. Osiągnięto także prawidłowy przepływ danych we wszystkich
zaimplementowanych serwerach OPC, także dla tego, w którym była implementowana
komunikacja za pomocą protokołu s7.

## Osiągnięte kamienie milowe

· **Zaimplementowano własny algorytm MPC z
wykorzystaniem języka Python**

· **Zaimplementowano wymianę informacji pomiędzy
sterownikiem a Raspberry Pi**

· **Wykorzystano ideę Fog Computingu**

· **Wykonano testy bezpieczeństwa, obciążenia oraz utraty połączenia pomiędzy
elementami całego systemu**
