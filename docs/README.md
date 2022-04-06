# Allgemeine Doku zur internen Infrastruktur

- [Allgemeine Doku zur internen Infrastruktur](#allgemeine-doku-zur-internen-infrastruktur)
  - ["Infrastruktur as Code"](#infrastruktur-as-code)
  - [Typischer Workflow zur Wartung der Infrastruktur](#typischer-workflow-zur-wartung-der-infrastruktur)
  - [Setup der Infrastruktur](#setup-der-infrastruktur)

## "Infrastruktur as Code"

Wir versuchen das Konzept "Infrastruktur as Code" ansatzweise umzusetzen. (Bitte! :wink:)

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

## Typischer Workflow zur Wartung der Infrastruktur

1. Verbindung herstellen
   ```shell
   ssh <USER>@dev.mdctec.local
   ```

   :information_source: `<USER>` besteht aus `"<1. Buchstabe Vorname><5 Buchstaben Nachname>"`  
   also z.B.: `qbuech`, `marndt`

   :information_source: Jeder Benutzer hat initial [dieses Standart Passwort](https://mdctecapps.mdctec.local:10001/WebClient/Main?itemId=1f1c47e6-71d5-4c2a-b42a-b8cd52f078be) welches beim ersten Login geändert werden muss. 


3. Zu den Konfigurationsdateien wechseln.
    ```shell
    cd /etc/mtec/dev-infrastructure
    ```

4. Hier sollten jetzt alle Konfigurationsdateien liegen, die die aktuelle Maschine betreffen. Anpassungen sind lokal auf
   dem Server möglich und können mit Git verwaltet und auch gepusht werden

## Setup der Infrastruktur

[Details wie ein Server neu installiert werden kann](./setup-infrastructure.README.md)
