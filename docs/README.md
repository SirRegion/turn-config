# Allgemeine Doku zur internen Infrastruktur

- [Allgemeine Doku zur internen Infrastruktur](#allgemeine-doku-zur-internen-infrastruktur)
    - [Typischer Workflow zur Wartung eines Servers](#typischer-workflow-zur-wartung-eines-servers)
    - ["Infrastruktur as Code"](#infrastruktur-as-code)
    - [Setup der Infrastruktur](#setup-der-infrastruktur)

## Typischer Workflow zur Wartung eines Servers

1. Verbindung herstellen
   ```shell
   ssh <USER>@dev.mdctec.local
   ```

   :information_source: `<USER>` besteht aus `"<1. Buchstabe Vorname><5 Buchstaben Nachname>"`  
   also z.B.: `qbuech`, `marndt`

   :information_source: Jeder Benutzer hat
   initial [dieses Standart Passwort](https://mdctecapps.mdctec.local:10001/WebClient/Main?itemId=1f1c47e6-71d5-4c2a-b42a-b8cd52f078be)
   welches beim ersten Login geändert werden muss.


2. Zu den Konfigurationsdateien wechseln.
    ```shell
    cd /etc/mtec/dev-infrastructure
    ```

   :information_source: Der Ordnername - hier `dev-infrastructure` - heißt auf jeder Maschine anders, entsprechend dem Hostnamen.
   Andere Beispiele: `gitlab-infrastructure`

    

4. Hier sollten jetzt alle Konfigurationsdateien liegen, die die aktuelle Maschine betreffen.

    ```shell
    root@dev:/etc/mtec/dev-infrastructure# ll
    total 24
    drwxrwsr-x 4 root mtec 4096 Apr  5 15:37 ./
    drwxrwsr-x 3 root mtec 4096 Apr  5 13:29 ../
    -rw-rwxr-- 1 root mtec 1935 Apr  5 15:37 README.md*
    -rw-rwxr-- 1 root mtec  734 Apr  5 13:29 docker-compose.yml*
    drwxrwsr-x 2 root mtec 4096 Apr  5 13:44 gitlab-runner/
    drwxrwsr-x 2 root mtec 4096 Apr  5 13:29 registry/
    ```

   :information_source: Anpassungen sind lokal auf dem Server möglich und können mit Git verwaltet und auch gepusht
   werden

## Infrastruktur as Code

Wir versuchen das Konzept "Infrastruktur as Code" ansatzweise umzusetzen. (Bitte! :wink:)

### :scroll: Regeln
 - Alles, was auf einer Servermaschine manuell installiert/konfiguriert soll in das [Mdctec Infrastructure Repository](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/tree/master)
   aufgenommen werden


### :bulb: Konzept
Dazu sind die Server `dev.mdctec.local` und `gitlab.mdctec.com` folgendermaßen strukturiert:

- Das MDCTec Infrastructure Gitlab Repository liegt geklont unter `/etc/mtec/infrastructure`  
  Für den DEV Server (`dev.mdctec.local`) sieht das z.B. so aus:
  ```shell
  root@dev:~# ls -la /etc/mtec/infrastructure
  total 20
  drwxr-xr-x 5 root root 4096 Apr  1 07:21 .
  drwxr-xr-x 3 root root 4096 Apr  1 07:00 ..
  drwxr-xr-x 8 root root 4096 Apr  1 09:00 .git
  drwxr-xr-x 3 root root 4096 Apr  1 06:58 machines
  drwxr-xr-x 4 root root 4096 Apr  1 07:24 scripts
  ```

  Achtung: Es wird das [sparse-checkout](https://git-scm.com/docs/git-sparse-checkout) feature von Git verwendet!
  ```shell
  root@dev:/etc/mtec/infrastructure# cat .git/info/sparse-checkout
  /machines/dev.mdctec.local
  /scripts/
  ```
- Es gibt einen Link `/etc/mtec/dev-infrastructure` bzw `/etc/mtec/gitlab-infrastructure` auf das entsprechende
  Unterverzeichnis in [`machines/*`](./machines)

  ```shell
  root@dev:/etc/mtec# ls -l dev-infrastructure
  lrwxrwxrwx 1 root mtec 58 Apr  1 07:09 dev-infrastructure -> ./infrastructure/machines/dev.mdctec.local/
  ```

## Setup der Infrastruktur

[Details wie ein Server neu installiert werden kann](./setup-infrastructure.README.md)

