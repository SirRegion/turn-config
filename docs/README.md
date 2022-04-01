# Allgemeine Doku zur internen Infrastruktur

## "Infrastruktur as Code"

Wir versuchen das Konzept "Infrastruktur as Code" ansatzweise umzusetzen. (Bitte! :wink:)

Dazu sind die Server `stage.mdctec.com` und `gitlab.mdctec.com` folgendermaßen strukturiert:

 -  Das MDCTec Infrastructure Gitlab Repository liegt geklont unter `/root/mtec-repos/infrastructure`
    Für den `Stage` Server (`stage.mdctec.com`) sieht das z.B. so aus:
    ```sh
    root@gitlabrunnerstage:~# ls -la mtec-repos/infrastructure/
    total 20
    drwxr-xr-x 5 root root 4096 Apr  1 07:21 .
    drwxr-xr-x 3 root root 4096 Apr  1 07:00 ..
    drwxr-xr-x 8 root root 4096 Apr  1 09:00 .git
    drwxr-xr-x 3 root root 4096 Apr  1 06:58 machines
    drwxr-xr-x 4 root root 4096 Apr  1 07:24 scripts
    ```

    Achtung: Es wird das [sparse-checkout](https://git-scm.com/docs/git-sparse-checkout) feature von Git verwendet!
    ```sh
    root@gitlabrunnerstage:~/mtec-repos/infrastructure# cat .git/info/sparse-checkout
    /machines/stage.mdctec.com
    /scripts/
    ```
 -  Es gibt einen Link `/root/stage-infrastructure` bzw `/root/gitlab-infrastructure` auf das entsprechende Unterverzeichnis in `machines/*`

    ```sh
    root@gitlabrunnerstage:~# ls -l stage-infrastructure
    lrwxrwxrwx 1 root root 58 Apr  1 07:09 stage-infrastructure -> /root/mtec-repos/infrastructure/machines/stage.mdctec.com/
    ```

## Typischer Workflow zur Wartung der Infrastruktur

 1. Verbindung herstellen
    ```sh
    ssh <USER>@stage.mdctec.com
    ```

 2. Gott-Modus einschalten (wenn du würdig bist)
    ```sh
    sudo -i
    ```

 3. Zu den Konfigurationsdateien wechseln.
    ```sh
    cd stage-infrastructure
    ```

 4. Hier sollten jetzt alle Konfigurationsdateien liegen, die die aktuelle Maschine betreffen.
    Anpassungen sind lokal auf dem Server möglich und können mit Git verwaltet und auch gepusht werden
