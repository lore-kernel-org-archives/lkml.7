Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1BBC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04192075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="0ExZZwPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfG1JV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 05:21:27 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:52944 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfG1JV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 05:21:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 8AD4E5F6;
        Sun, 28 Jul 2019 11:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1564305676; x=1566120077;
         bh=YrNtpQC9cOsGOVzm1s+nQMwBw0AA/3atk2W1IhHQ5Ok=; b=0ExZZwPomFtx
        l+P0Dqzhr4jW+ybDHtxEWFAJjOCsIJgclGQ4n3kWmvINm+v9zsnl9V7sdujwcYcP
        DB1xc0MHOr7tTIneR5BoaB+UFqZo1ihxJXsfxbIuj95IWB/Gd6khoAyt16vR7oYa
        W6OkOJkAsxLqlWxahRXdk2pvt3GwNrrnlzzTU1JaYcnbGp32yQJfGFQgG4ei0LHU
        FCjbDy6Ow//OJbLnqAahVSf2q51YRsdbzE6R/lF9RO0bqxbUiSOfPdl14gaDddDK
        lbdYP7KIGz2iwE7+EZ/Je48dRrPfttdvdwu9BKjKocS6+cpabaofLQBE0B2ehDWL
        wPcV4DDCuPPAEABrgO87SDzXZ3g77skyVQaN8mOVdMKjiBYCHEWTdUNEEj8lybpo
        j3Sa+FiD8lAk5p898JkHoBcIA5AOi8NYcpKoPywyzxREDASL0O8E9nx7s+dlWFFa
        7XxK8XavqI5XFkZyehJnTAnC0bFEuuze/EZGzanjf/ov5Baq9TOoH5CwU9+wu42P
        aoqxpJfGJI+6/UYvN+ELPpolt9SvQUA7YMqJ4CfvtcArp+Zg4G5C8TIpnGf5UJPk
        61CDv+tUeV1ElGCUyqodIdSL2XyMY/NkLwtAJQ4j7GaMsH10DKqbrJ/4fzd+dgp1
        QuJYsP6ssm0DRBNjXrfErOEESJXlKHg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X_FTFB7XIVLq; Sun, 28 Jul 2019 11:21:16 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 698C3353;
        Sun, 28 Jul 2019 11:21:16 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 0DC582339;
        Sun, 28 Jul 2019 11:21:16 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: [PATCH] doc:it_IT: translations for documents in process/
Date:   Sun, 28 Jul 2019 11:20:54 +0200
Message-Id: <20190728092054.1183-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alessia Mantegazza <amantegazza@vaga.pv.it>

Translations for the following documents in process/:
    - email-clients
    - management-style

Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/process/email-clients.rst           | 328 +++++++++++++++++-
 .../it_IT/process/management-style.rst        | 290 +++++++++++++++-
 2 files changed, 612 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index 224ab031ffd3..fe579f063c73 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -1,12 +1,336 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
+:Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_email_clients:
 
 Informazioni sui programmi di posta elettronica per Linux
 =========================================================
 
-.. warning::
+Git
+---
 
-    TODO ancora da tradurre
+Oggigiorno, la maggior parte degli sviluppatori utilizza ``git send-email``
+al posto dei classici programmi di posta elettronica.  Le pagine man sono
+abbastanza buone. Dal lato del ricevente, i manutentori utilizzano ``git am``
+per applicare le patch.
+
+Se siete dei novelli utilizzatori di ``git`` allora inviate la patch a voi
+stessi. Salvatela come testo includendo tutte le intestazioni. Poi eseguite
+il comando ``git am messaggio-formato-testo.txt`` e revisionatene il risultato
+con ``git log``. Quando tutto funziona correttamente, allora potete inviare
+la patch alla lista di discussione più appropriata.
+
+Panoramica delle opzioni
+------------------------
+
+Le patch per il kernel vengono inviate per posta elettronica, preferibilmente
+come testo integrante del messaggio.  Alcuni manutentori accettano gli
+allegati, ma in questo caso gli allegati devono avere il *content-type*
+impostato come ``text/plain``.  Tuttavia, generalmente gli allegati non sono
+ben apprezzati perché rende più difficile citare porzioni di patch durante il
+processo di revisione.
+
+I programmi di posta elettronica che vengono usati per inviare le patch per il
+kernel Linux dovrebbero inviarle senza alterazioni.  Per esempio, non
+dovrebbero modificare o rimuovere tabulazioni o spazi, nemmeno all'inizio o
+alla fine delle righe.
+
+Non inviate patch con ``format=flowed``.  Questo potrebbe introdurre
+interruzioni di riga inaspettate e indesiderate.
+
+Non lasciate che il vostro programma di posta vada a capo automaticamente.
+Questo può corrompere le patch.
+
+I programmi di posta non dovrebbero modificare la codifica dei caratteri nel
+testo.  Le patch inviate per posta elettronica dovrebbero essere codificate in
+ASCII o UTF-8.
+Se configurate il vostro programma per inviare messaggi codificati con UTF-8
+eviterete possibili problemi di codifica.
+
+I programmi di posta dovrebbero generare e mantenere le intestazioni
+"References" o "In-Reply-To:" cosicché la discussione non venga interrotta.
+
+Di solito, il copia-e-incolla (o taglia-e-incolla) non funziona con le patch
+perché le tabulazioni vengono convertite in spazi.  Usando xclipboard, xclip
+e/o xcutsel potrebbe funzionare, ma è meglio che lo verifichiate o meglio
+ancora: non usate il copia-e-incolla.
+
+Non usate firme PGP/GPG nei messaggi che contengono delle patch.  Questo
+impedisce il corretto funzionamento di alcuni script per leggere o applicare
+patch (questo si dovrebbe poter correggere).
+
+Prima di inviare le patch sulle liste di discussione Linux, può essere una
+buona idea quella di inviare la patch a voi stessi, salvare il messaggio
+ricevuto, e applicarlo ai sorgenti con successo.
+
+
+Alcuni suggerimenti per i programmi di posta elettronica (MUA)
+--------------------------------------------------------------
+
+Qui troverete alcuni suggerimenti per configurare i vostri MUA allo scopo
+di modificare ed inviare patch per il kernel Linux.  Tuttavia, questi
+suggerimenti non sono da considerarsi come un riassunto di una configurazione
+completa.
+
+Legenda:
+
+- TUI = interfaccia utente testuale (*text-based user interface*)
+- GUI = interfaccia utente grafica (*graphical user interface*)
+
+Alpine (TUI)
+************
+
+Opzioni per la configurazione:
+
+Nella sezione :menuselection:`Sending Preferences`:
+
+- :menuselection:`Do Not Send Flowed Text` deve essere ``enabled``
+- :menuselection:`Strip Whitespace Before Sending` deve essere ``disabled``
+
+Quando state scrivendo un messaggio, il cursore dev'essere posizionato
+dove volete che la patch inizi, poi premendo :kbd:`CTRL-R` vi verrà chiesto
+di selezionare il file patch da inserire nel messaggio.
+
+Claws Mail (GUI)
+****************
+
+Funziona. Alcune persone riescono ad usarlo con successo per inviare le patch.
+
+Per inserire una patch usate :menuselection:`Messaggio-->Inserisci file`
+(:kbd:`CTRL-I`) oppure un editor esterno.
+
+Se la patch che avete inserito dev'essere modificata usato la finestra di
+scrittura di Claws, allora assicuratevi che l'"auto-interruzione" sia
+disabilitata :menuselection:`Configurazione-->Preferenze-->Composizione-->Interruzione riga`.
+
+Evolution (GUI)
+***************
+
+Alcune persone riescono ad usarlo con successo per inviare le patch.
+
+Quando state scrivendo una lettera selezionate: Preformatttato
+  da :menuselection:`Formato-->Stile del paragrafo-->Preformattato`
+  (:kbd:`CTRL-7`) o dalla barra degli strumenti
+
+Poi per inserire la patch usate:
+:menuselection:`Inserisci--> File di testo...` (:kbd:`ALT-N x`)
+
+Potete anche eseguire ``diff -Nru old.c new.c | xclip``, selezionare
+:menuselection:`Preformattato`, e poi usare il tasto centrale del mouse.
+
+Kmail (GUI)
+***********
+
+Alcune persone riescono ad usarlo con successo per inviare le patch.
+
+La configurazione base che disabilita la composizione di messaggi HTML è
+corretta; non abilitatela.
+
+Quando state scrivendo un messaggio, nel menu opzioni, togliete la selezione a
+"A capo automatico". L'unico svantaggio sarà che qualsiasi altra cosa scriviate
+nel messaggio non verrà mandata a capo in automatico ma dovrete farlo voi.
+Il modo più semplice per ovviare a questo problema è quello di scrivere il
+messaggio con l'opzione abilitata e poi di salvarlo nelle bozze. Riaprendo ora
+il messaggio dalle bozze le andate a capo saranno parte integrante del
+messaggio, per cui togliendo l'opzione "A capo automatico" non perderete nulla.
+
+Alla fine del vostro messaggio, appena prima di inserire la vostra patch,
+aggiungete il delimitatore di patch: tre trattini (``---``).
+
+Ora, dal menu :menuselection:`Messaggio`, selezionate :menuselection:`Inserisci file di testo...`
+quindi scegliete la vostra patch.
+Come soluzione aggiuntiva potreste personalizzare la vostra barra degli
+strumenti aggiungendo un'icona per :menuselection:`Inserisci file di testo...`.
+
+Allargate la finestra di scrittura abbastanza da evitare andate a capo.
+Questo perché in Kmail 1.13.5 (KDE 4.5.4), Kmail aggiunge andate a capo
+automaticamente al momento dell'invio per tutte quelle righe che graficamente,
+nella vostra finestra di composizione, si sono estete su una riga successiva.
+Disabilitare l'andata a capo automatica non è sufficiente. Dunque, se la vostra
+patch contiene delle righe molto lunghe, allora dovrete allargare la finestra
+di composizione per evitare che quelle righe vadano a capo. Vedere:
+https://bugs.kde.org/show_bug.cgi?id=174034
+
+Potete firmare gli allegati con GPG, ma per le patch si preferisce aggiungerle
+al testo del messaggio per cui non usate la firma GPG.  Firmare le patch
+inserite come testo del messaggio le rende più difficili da estrarre dalla loro
+codifica a 7-bit.
+
+Se dovete assolutamente inviare delle patch come allegati invece di integrarle
+nel testo del messaggio, allora premete il tasto destro sull'allegato e
+selezionate :menuselection:`Proprietà`, e poi attivate
+:menuselection:`Suggerisci visualizzazione automatica` per far si che
+l'allegato sia più leggibile venendo visualizzato come parte del messaggio.
+
+Per salvare le patch inviate come parte di un messaggio, selezionate il
+messaggio che la contiene, premete il tasto destro e selezionate
+:menuselection:`Salva come`. Se il messaggio fu ben preparato, allora potrete
+usarlo interamente senza alcuna modifica.
+I messaggi vengono salvati con permessi di lettura-scrittura solo per l'utente,
+nel caso in cui vogliate copiarli altrove per renderli disponibili ad altri
+gruppi o al mondo, ricordatevi di usare ``chmod`` per cambiare i permessi.
+
+Lotus Notes (GUI)
+*****************
+
+Scappate finché potete.
+
+IBM Verse (Web GUI)
+*******************
+
+Vedi il commento per Lotus Notes.
+
+Mutt (TUI)
+**********
+
+Un sacco di sviluppatori Linux usano ``mutt``, per cui deve funzionare
+abbastanza bene.
+
+Mutt non ha un proprio editor, quindi qualunque sia il vostro editor dovrete
+configurarlo per non aggiungere automaticamente le andate a capo.  Molti
+editor hanno un'opzione :menuselection:`Inserisci file` che inserisce il
+contenuto di un file senza alterarlo.
+
+Per usare ``vim`` come editor per mutt::
+
+  set editor="vi"
+
+Se per inserire la patch nel messaggio usate xclip, scrivete il comando::
+
+  :set paste
+
+prima di premere il tasto centrale o shift-insert. Oppure usate il
+comando::
+
+  :r filename
+
+(a)llega funziona bene senza ``set paste``
+
+Potete generare le patch con ``git format-patch`` e usare Mutt per inviarle::
+
+    $ mutt -H 0001-some-bug-fix.patch
+
+Opzioni per la configurazione:
+
+Tutto dovrebbe funzionare già nella configurazione base.
+Tuttavia, è una buona idea quella di impostare ``send_charset``::
+
+   set send_charset="us-ascii:utf-8"
+
+Mutt è molto personalizzabile. Qui di seguito trovate la configurazione minima
+per iniziare ad usare Mutt per inviare patch usando Gmail::
+
+  # .muttrc
+  # ================  IMAP ====================
+  set imap_user = 'yourusername@gmail.com'
+  set imap_pass = 'yourpassword'
+  set spoolfile = imaps://imap.gmail.com/INBOX
+  set folder = imaps://imap.gmail.com/
+  set record="imaps://imap.gmail.com/[Gmail]/Sent Mail"
+  set postponed="imaps://imap.gmail.com/[Gmail]/Drafts"
+  set mbox="imaps://imap.gmail.com/[Gmail]/All Mail"
+
+  # ================  SMTP  ====================
+  set smtp_url = "smtp://username@smtp.gmail.com:587/"
+  set smtp_pass = $imap_pass
+  set ssl_force_tls = yes # Require encrypted connection
+
+  # ================  Composition  ====================
+  set editor = `echo \$EDITOR`
+  set edit_headers = yes  # See the headers when editing
+  set charset = UTF-8     # value of $LANG; also fallback for send_charset
+  # Sender, email address, and sign-off line must match
+  unset use_domain        # because joe@localhost is just embarrassing
+  set realname = "YOUR NAME"
+  set from = "username@gmail.com"
+  set use_from = yes
+
+La documentazione di Mutt contiene molte più informazioni:
+
+    http://dev.mutt.org/trac/wiki/UseCases/Gmail
+
+    http://dev.mutt.org/doc/manual.html
+
+Pine (TUI)
+**********
+
+Pine aveva alcuni problemi con gli spazi vuoti, ma questi dovrebbero essere
+stati risolti.
+
+Se potete usate alpine (il successore di pine).
+
+Opzioni di configurazione:
+
+- Nelle versioni più recenti è necessario avere ``quell-flowed-text``
+- l'opzione ``no-strip-whitespace-before-send`` è necessaria
+
+Sylpheed (GUI)
+**************
+
+- funziona bene per aggiungere testo in linea (o usando allegati)
+- permette di utilizzare editor esterni
+- è lento su cartelle grandi
+- non farà l'autenticazione TSL SMTP su una connessione non SSL
+- ha un utile righello nella finestra di scrittura
+- la rubrica non comprende correttamente il nome da visualizzare e
+  l'indirizzo associato
+
+Thunderbird (GUI)
+*****************
+
+Thunderbird è un clone di Outlook a cui piace maciullare il testo, ma esistono
+modi per impedirglielo.
+
+- permettere l'uso di editor esterni:
+  La cosa più semplice da fare con Thunderbird e le patch è quello di usare
+  l'estensione "external editor" e di usare il vostro ``$EDITOR`` preferito per
+  leggere/includere patch nel vostro messaggio.  Per farlo, scaricate ed
+  installate l'estensione e aggiungete un bottone per chiamarla rapidamente
+  usando :menuselection:`Visualizza-->Barra degli strumenti-->Personalizza...`;
+  una volta fatto potrete richiamarlo premendo sul bottone mentre siete nella
+  finestra :menuselection:`Scrivi`
+
+  Tenete presente che "external editor" richiede che il vostro editor non
+  faccia alcun fork, in altre parole, l'editor non deve ritornare prima di
+  essere stato chiuso.  Potreste dover passare dei parametri aggiuntivi al
+  vostro editor oppure cambiargli la configurazione.  Per esempio, usando
+  gvim dovrete aggiungere l'opzione -f ``/usr/bin/gvim -f`` (Se il binario
+  si trova in ``/usr/bin``) nell'apposito campo nell'interfaccia di
+  configurazione di  :menuselection:`external editor`.  Se usate altri editor
+  consultate il loro  manuale per sapere come configurarli.
+
+Per rendere l'editor interno un po' più sensato, fate così:
+
+- Modificate le impostazioni di Thunderbird per far si che non usi
+  ``format=flowed``. Andate in :menuselection:`Modifica-->Preferenze-->Avanzate-->Editor di configurazione`
+  per invocare il registro delle impostazioni.
+
+- impostate ``mailnews.send_plaintext_flowed`` a ``false``
+
+- impostate ``mailnews.wraplength`` da ``72`` a ``0``
+
+- :menuselection:`Visualizza-->Corpo del messaggio come-->Testo semplice`
+
+- :menuselection:`Visualizza-->Codifica del testo-->Unicode`
+
+
+TkRat (GUI)
+***********
+
+Funziona. Usare "Inserisci file..." o un editor esterno.
+
+Gmail (Web GUI)
+***************
+
+Non funziona per inviare le patch.
+
+Il programma web Gmail converte automaticamente i tab in spazi.
+
+Allo stesso tempo aggiunge andata a capo ogni 78 caratteri. Comunque
+il problema della conversione fra spazi e tab può essere risolto usando
+un editor esterno.
+
+Un altro problema è che Gmail usa la codifica base64 per tutti quei messaggi
+che contengono caratteri non ASCII. Questo include cose tipo i nomi europei.
diff --git a/Documentation/translations/it_IT/process/management-style.rst b/Documentation/translations/it_IT/process/management-style.rst
index 07e68bfb8402..03794ebf7bd3 100644
--- a/Documentation/translations/it_IT/process/management-style.rst
+++ b/Documentation/translations/it_IT/process/management-style.rst
@@ -1,12 +1,294 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/management-style.rst <managementstyle>`
+:Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_managementstyle:
 
-Tipo di gestione del kernel Linux
-=================================
+Il modello di gestione del kernel Linux
+=======================================
 
-.. warning::
+Questo breve documento descrive il modello di gestione del kernel Linux.
+Per certi versi, esso rispecchia il documento
+:ref:`translations/it_IT/process/coding-style.rst <it_codingstyle>`,
+ed è principalmente scritto per evitare di rispondere [#f1]_ in continuazione
+alle stesse identiche (o quasi) domande.
 
-    TODO ancora da tradurre
+Il modello di gestione è qualcosa di molto personale e molto più difficile da
+qualificare rispetto a delle semplici regole di codifica, quindi questo
+documento potrebbe avere più o meno a che fare con la realtà.  È cominciato
+come un gioco, ma ciò non significa che non possa essere vero.
+Lo dovrete decidere voi stessi.
+
+In ogni caso, quando si parla del "dirigente del kernel", ci si riferisce
+sempre alla persona che dirige tecnicamente, e non a coloro che
+tradizionalmente hanno un ruolo direttivo all'interno delle aziende.  Se vi
+occupate di convalidare acquisti o avete una qualche idea sul budget del vostro
+gruppo, probabilmente non siete un dirigente del kernel.  Quindi i suggerimenti
+qui indicati potrebbero fare al caso vostro, oppure no.
+
+Prima di tutto, suggerirei di acquistare "Le sette regole per avere successo",
+e di non leggerlo. Bruciatelo, è un grande gesto simbolico.
+
+.. [#f1] Questo documento non fa molto per risponde alla domanda, ma rende
+	 così dannatamente ovvio a chi la pone che non abbiamo la minima idea
+	 di come rispondere.
+
+Comunque, partiamo:
+
+.. _it_decisions:
+
+1) Le decisioni
+---------------
+
+Tutti pensano che i dirigenti decidano, e che questo prendere decisioni
+sia importante.  Più grande e dolorosa è la decisione, più importante deve
+essere il dirigente che la prende.  Questo è molto profondo ed ovvio, ma non è
+del tutto vero.
+
+Il gioco consiste nell'"evitare" di dover prendere decisioni.  In particolare
+se qualcuno vi chiede di "Decidere" tra (a) o (b), e vi dice che ha
+davvero bisogno di voi per questo, come dirigenti siete nei guai.
+Le persone che gestite devono conoscere i dettagli più di quanto li conosciate
+voi, quindi se vengono da voi per una decisione tecnica, siete fottuti.
+Non sarete chiaramente competente per prendere quella decisione per loro.
+
+(Corollario: se le persone che gestite non conoscono i dettagli meglio di voi,
+anche in questo caso sarete fregati, tuttavia per altre ragioni.  Ossia state
+facendo il lavoro sbagliato, e che invece dovrebbero essere "loro" a gestirvi)
+
+Quindi il gioco si chiama "evitare" decisioni, almeno le più grandi e
+difficili.  Prendere decisioni piccoli e senza conseguenze va bene, e vi fa
+sembrare competenti in quello che state facendo, quindi quello che un dirigente
+del kernel ha bisogno di fare è trasformare le decisioni grandi e difficili
+in minuzie delle quali nessuno importa.
+
+Ciò aiuta a capire che la differenza chiave tra una grande decisione ed una
+piccola sta nella possibilità di modificare tale decisione in seguito.
+Qualsiasi decisione importante può essere ridotta in decisioni meno importanti,
+ma dovete assicurarvi che possano essere reversibili in caso di errori
+(presenti o futuri).  Improvvisamente, dovrete essere doppiamente dirigenti
+per **due** decisioni non sequenziali - quella sbagliata **e** quella giusta.
+
+E le persone vedranno tutto ciò come prova di vera capacità di comando
+(*cough* cavolata *cough*)
+
+Così la chiave per evitare le decisioni difficili diviene l'evitare
+di fare cose che non possono essere disfatte.  Non infilatevi in un angolo
+dal quale non potrete sfuggire.  Un topo messo all'angolo può rivelarsi
+pericoloso - un dirigente messo all'angolo è solo pietoso.
+
+**In ogni caso** dato che nessuno è stupido al punto da lasciare veramente ad
+un dirigente del kernel un enorme responsabilità, solitamente è facile fare
+marcia indietro. Annullare una decisione è molto facile: semplicemente dite a
+tutti che siete stati degli scemi incompetenti, dite che siete dispiaciuti, ed
+annullate tutto l'inutile lavoro sul quale gli altri hanno lavorato nell'ultimo
+anno.  Improvvisamente la decisione che avevate preso un anno fa non era poi
+così grossa, dato che può essere facilmente annullata.
+
+È emerso che alcune persone hanno dei problemi con questo tipo di approccio,
+questo per due ragioni:
+
+ - ammettere di essere degli idioti è più difficile di quanto sembri.  A tutti
+   noi piace mantenere le apparenze, ed uscire allo scoperto in pubblico per
+   ammettere che ci si è sbagliati è qualcosa di davvero impegnativo.
+ - avere qualcuno che ti dice che ciò su cui hai lavorato nell'ultimo anno
+   non era del tutto valido, può rivelarsi difficile anche per un povero ed
+   umile ingegnere, e mentre il **lavoro** vero era abbastanza facile da
+   cancellare, dall'altro canto potreste aver irrimediabilmente perso la
+   fiducia di quell'ingegnere.  E ricordate che l'"irrevocabile" era quello
+   che avevamo cercato di evitare fin dall'inizio, e la vostra decisione
+   ha finito per esserlo.
+
+Fortunatamente, entrambe queste ragioni posso essere mitigate semplicemente
+ammettendo fin dal principio che non avete una cavolo di idea, dicendo
+agli altri in anticipo che la vostra decisione è puramente ipotetica, e che
+potrebbe essere sbagliata.  Dovreste sempre riservarvi il diritto di cambiare
+la vostra opinione, e rendere gli altri ben **consapevoli** di ciò.
+Ed è molto più facile ammettere di essere stupidi quando non avete **ancora**
+fatto quella cosa stupida.
+
+Poi, quando è realmente emersa la vostra stupidità, le persone semplicemente
+roteeranno gli occhi e diranno "Uffa, no, ancora".
+
+Questa ammissione preventiva di incompetenza potrebbe anche portare le persone
+che stanno facendo il vero lavoro, a pensarci due volte.  Dopo tutto, se
+**loro** non sono certi se sia una buona idea, voi, sicuro come l'inferno,
+non dovreste incoraggiarli promettendogli che ciò su cui stanno lavorando
+verrà incluso.  Fate si che ci pensino due volte prima che si imbarchino in un
+grosso lavoro.
+
+Ricordate: loro devono sapere più cose sui dettagli rispetto a voi, e
+solitamente pensano di avere già la risposta a tutto. La miglior cosa che
+potete fare in qualità di dirigente è di non instillare troppa fiducia, ma
+invece fornire una salutare dose di pensiero critico su quanto stanno facendo.
+
+Comunque, un altro modo di evitare una decisione è quello di lamentarsi
+malinconicamente dicendo : "non possiamo farli entrambi e basta?" e con uno
+sguardo pietoso.  Fidatevi, funziona.  Se non è chiaro quale sia il miglior
+approccio, lo scopriranno.  La risposta potrebbe essere data dal fatto che
+entrambe i gruppi di lavoro diventano frustati al punto di rinunciarvi.
+
+Questo può suonare come un fallimento, ma di solito questo è un segno che
+c'era qualcosa che non andava in entrambe i progetti, e il motivo per
+il quale le persone coinvolte non abbiano potuto decidere era che entrambe
+sbagliavano.  Voi ne uscirete freschi come una rosa, e avrete evitato un'altra
+decisione con la quale avreste potuto fregarvi.
+
+
+2) Le persone
+-------------
+
+Molte persone sono idiote, ed essere un dirigente significa che dovrete
+scendere a patti con questo, e molto più importate, che **loro** devono avere
+a che fare con **voi**.
+
+Ne emerge che mentre è facile annullare degli errori tecnici, non è invece
+così facile annullare disordini della personalità.  Dovrete semplicemente
+convivere con i loro, ed i vostri, problemi.
+
+Comunque, al fine di preparavi in qualità di dirigenti del kernel, è meglio
+ricordare di non abbattere alcun ponte, bombardare alcun paesano innocente,
+o escludere troppi sviluppatori kernel. Ne emerge che escludere le persone
+è piuttosto facile, mentre includerle nuovamente è difficile. Così
+"l'esclusione" immediatamente cade sotto il titolo di "non reversibile", e
+diviene un no-no secondo la sezione :ref:`Le decisioni`.
+
+Esistono alcune semplici regole qui:
+
+ (1) non chiamate le persone teste di c*** (al meno, non in pubblico)
+ (2) imparate a scusarvi quando dimenticate la regola (1)
+
+Il problema del punto numero #1 è che è molto facile da rispettare, dato che
+è possibile dire "sei una testa di c***" in milioni di modi differenti [#f2]_,
+a volte senza nemmeno pensarci, e praticamente sempre con calda convinzione
+che siete nel giusto.
+
+E più convinti sarete che avete ragione (e diciamolo, potete chiamare
+praticamente **tutti** testa di c**, e spesso **sarete** nel giusto), più
+difficile sarà scusarvi successivamente.
+
+Per risolvere questo problema, avete due possibilità:
+
+ - diventare davvero bravi nello scusarsi
+ - essere amabili così che nessuno finirà col sentirsi preso di mira.  Siate
+   creativi abbastanza, e potrebbero esserne divertiti.
+
+L'opzione dell'essere immancabilmente educati non esiste proprio. Nessuno
+si fiderà di qualcuno che chiaramente sta nascondendo il suo vero carattere.
+
+.. [#f2] Paul Simon cantava: "50 modi per lasciare il vostro amante", perché,
+	 molto francamente, "Un milione di modi per dire ad uno sviluppatore
+	 Testa di c***" non avrebbe funzionato. Ma sono sicuro che ci abbia
+	 pensato.
+
+
+3) Le persone II - quelle buone
+-------------------------------
+
+Mentre emerge che la maggior parte delle persone sono idiote, il corollario
+a questo è la tristezza che anche voi siate tra queste, e che mentre possiamo
+tutti crogiolarci nella sicurezza di essere migliori della media delle persone
+(diciamocelo, nessuno crede di essere nelle media o sotto di essa), dovremmo
+anche ammettere che non siamo il "coltello più affilato" del circondario, e che
+ci saranno altre persone che sono meno stupide di quanto siete voi.
+
+Molti reagiscono male davanti alle persone intelligenti. Altri le usano a
+proprio vantaggio.
+
+Assicuratevi che voi, in qualità di manutentori del kernel, siate nel secondo
+gruppo. Inchinatevi dinanzi a loro, perché saranno le persone che vi renderanno
+il lavoro più facile.  In particolare, prenderanno le decisioni per voi, che è
+la oggetto di questo gioco.
+
+Quindi quando trovate qualcuno più sveglio di voi, prendetevela comoda.
+Le vostre responsabilità dirigenziali si ridurranno in gran parte nel dire
+"Sembra una buona idea - Vai", oppure "Sembra buono, ma invece circa questo e
+quello?".  La seconda versione in particolare è una gran modo per imparare
+qualcosa di nuovo circa "questo e quello" o di sembrare **extra** dirigenziali
+sottolineando qualcosa alla quale i più svegli non avevano pensato.  In
+entrambe i casi, vincete.
+
+Una cosa alla quale dovete fare attenzione è che l'essere grandi in qualcosa
+non si traduce automaticamente nell'essere grandi anche in altre cose.  Quindi
+dovreste dare una spintarella alle persone in una specifica direzione, ma
+diciamocelo, potrebbero essere bravi in ciò che fanno e far schifo in tutto
+il resto.  La buona notizia è che le persone tendono a gravitare attorno a ciò
+in cui sono bravi, quindi non state facendo nulla di irreversibile quando li
+spingete verso una certa direzione, solo non spingete troppo.
+
+
+4) Addossare le colpe
+---------------------
+
+Le cose andranno male, e le persone vogliono qualcuno da incolpare. Sarete voi.
+
+Non è poi così difficile accettare la colpa, specialmente se le persone
+riescono a capire che non era **tutta** colpa vostra.  Il che ci porta
+sulla miglior strada per assumersi la colpa: fatelo per qualcun'altro.
+Vi sentirete bene nel assumervi la responsabilità, e loro si sentiranno
+bene nel non essere incolpati, e coloro che hanno perso i loro 36GB di porno
+a causa della vostra incompetenza ammetteranno a malincuore che alla fine
+non avete cercato di fare il furbetto.
+
+Successivamente fate in modo che gli sviluppatori che in realtà hanno fallito
+(se riuscite a trovarli) sappiano **in privato** che sono "fottuti".
+Questo non per fargli sapere che la prossima volta possono evitarselo ma per
+fargli capire che sono in debito.  E, forse cosa più importante, sono loro che
+devono sistemare la cosa.  Perché, ammettiamolo, è sicuro non sarete voi a
+farlo.
+
+Assumersi la colpa è anche ciò che vi rendere dirigenti in prima battuta.
+È parte di ciò che spinge gli altri a fidarsi di voi, e vi garantisce
+la gloria potenziale, perché siete gli unici a dire "Ho fatto una cavolata".
+E se avete seguito le regole precedenti, sarete decisamente bravi nel dirlo.
+
+
+5) Le cose da evitare
+---------------------
+
+Esiste una cosa che le persone odiano più che essere chiamate "teste di c****",
+ed è essere chiamate "teste di c****" con fare da bigotto.  Se per il primo
+caso potrete comunque scusarvi, per il secondo non ve ne verrà data nemmeno
+l'opportunità.  Probabilmente smetteranno di ascoltarvi anche se tutto sommato
+state svolgendo un buon lavoro.
+
+Tutti crediamo di essere migliori degli altri, il che significa che quando
+qualcuno inizia a darsi delle arie, ci da **davvero** fastidio.  Potreste anche
+essere moralmente ed intellettualmente superiore a tutti quelli attorno a voi,
+ma non cercate di renderlo ovvio per gli altri a meno che non **vogliate**
+veramente far arrabbiare qualcuno [#f3]_.
+
+Allo stesso modo evitate di essere troppo gentili e pacati.  Le buone maniere
+facilmente finiscono per strabordare e nascondere i problemi, e come si usa
+dire, "su internet nessuno può sentire la vostra pacatezza".  Usate argomenti
+diretti per farvi capire, non potete sperare che la gente capisca in altro
+modo.
+
+Un po' di umorismo può aiutare a smorzare sia la franchezza che la moralità.
+Andare oltre i limiti al punto d'essere ridicolo può portare dei punti a casa
+senza renderlo spiacevole per i riceventi, i quali penseranno che stavate
+facendo gli scemi.  Può anche aiutare a lasciare andare quei blocchi mentali
+che abbiamo nei confronti delle critiche.
+
+.. [#f3] Suggerimento: i forum di discussione su internet, che non sono
+  collegati col vostro lavoro, sono ottimi modi per sfogare la frustrazione
+  verso altre persone. Di tanto in tanto scrivete messaggi offensivi col ghigno
+  in faccia per infiammare qualche discussione: vi sentirete purificati. Solo
+  cercate di non cagare troppo vicino a casa.
+
+6) Perché io?
+-------------
+
+Dato che la vostra responsabilità principale è quella di prendervi le colpe
+d'altri, e rendere dolorosamente ovvio a tutti che siete degli incompetenti,
+la domanda naturale che ne segue sarà : perché dovrei fare tutto ciò?
+
+Innanzitutto, potreste diventare o no popolari al punto da avere la fila di
+ragazzine (o ragazzini, evitiamo pregiudizi o sessismo) che gridano e bussano
+alla porta del vostro camerino, ma comunque **proverete** un immenso senso di
+realizzazione personale dall'essere "in carica".  Dimenticate il fatto che voi
+state discutendo con tutti e che cercate di inseguirli il più velocemente che
+potete. Tutti continueranno a pensare che voi siete la persona in carica.
+
+È un bel lavoro se riuscite ad adattarlo a voi.
-- 
2.21.0

