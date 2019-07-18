Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B8C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261012173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="kROGlJld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbfGRHrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:47:51 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:64828 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRHru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:47:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 0064749F;
        Thu, 18 Jul 2019 09:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1563436066; x=1565250467;
         bh=Q7GYEZo1p0BVSeuH3na7d2iciqETmxsES/KOXmL1GTs=; b=kROGlJld/cDL
        G0H1o5DI1xp43crpjCWwUdGJ/2nwJVkQUanT5/FO9qAbUq3G83MyGxVUoGcmjgYV
        m8cM1K52uPsF+2yyFiMbv4ZPn8z6niMFaUqjDwHw59Tcf7ytYcfuA6xVxEokYu/e
        5tdCuHFsN1854ABnAq93M1yEA2XPzspucD2iJCyT4Ouv3JGKcV8+7Js3+tnJyRwI
        OlYK9BviIR/82/aLA6O28+SwXfixFRmByFR/5E4GybrkvVYWSMYQAUPS6Tf9AI4c
        YWdBHY5CEzpGjPPRVmescEHzU+6WP7MVfsj2k35aH5Z2DJ/LKFe7kbVc3pTRTBS2
        SmvyKgpPQyUNQ9uCHnp+TE8l5PyLtEiujA+Yyl2POLIkjuKlqyOEpUB/0hI/IF6/
        f2i4Xo/Ij5P8aipBgxGBhESFAzP26dt9Ea8jhw1/TB5IolGf79xOzGFm8/0Zg6Dx
        cJmtE5IZ6v6qJ3YuHtdMeSmV277NGPaGvQokIJhntkhZjewjxQOxSdKUid2201Je
        d50s1dsXwn3Xz12+y2unUjPO1VRhe8PYWAtKc+YnJUvD++h3sqSJv0nGGHjfSlSm
        XFAl//zn/LrAkxSjJezFqDWnZEHN9w2KNOS+bdnedCU68tt9rZSwg37ctzcCnMVe
        5f5J9irYG4cTHsG+P8DBRysOPzf0eAU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U3iD4p3XRf_V; Thu, 18 Jul 2019 09:47:46 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 2766634C;
        Thu, 18 Jul 2019 09:47:45 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id D2726312;
        Thu, 18 Jul 2019 09:47:45 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 1/2] doc:it_IT: align translation to mainline
Date:   Thu, 18 Jul 2019 09:47:24 +0200
Message-Id: <20190718074724.29807-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch translates the following patches in Italian:

d9d7c0c497b8 docs: Note that :c:func: should no longer be used
83e8b971f81c sphinx.rst: Add note about code snippets embedded in the text
cca5e0b8a430 Documentation: PGP: update for newer HW devices

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/doc-guide/sphinx.rst   | 17 +++++++------
 .../it_IT/process/maintainer-pgp-guide.rst    | 25 ++++++++++++-------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 1739cba8863e..d9ee4b1f098f 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -243,7 +243,8 @@ del kernel:
   esempio, casi d'uso, eccetera): utilizzate ``::`` quando non è necessario
   evidenziare la sintassi, specialmente per piccoli frammenti; invece,
   utilizzate ``.. code-block:: <language>`` per blocchi di più lunghi che
-  potranno beneficiare dell'avere la sintassi evidenziata.
+  potranno beneficiare dell'avere la sintassi evidenziata. Per un breve pezzo
+  di codice da inserire nel testo, usate \`\`.
 
 
 Il dominio C
@@ -267,12 +268,14 @@ molto comune come ``open`` o ``ioctl``:
 
 Il nome della funzione (per esempio ioctl) rimane nel testo ma il nome del suo
 riferimento cambia da ``ioctl`` a ``VIDIOC_LOG_STATUS``. Anche la voce
-nell'indice cambia in ``VIDIOC_LOG_STATUS`` e si potrà quindi fare riferimento
-a questa funzione scrivendo:
-
-.. code-block:: rst
-
-     :c:func:`VIDIOC_LOG_STATUS`
+nell'indice cambia in ``VIDIOC_LOG_STATUS``.
+
+Notate che per una funzione non c'è bisogno di usare ``c:func:`` per generarne
+i riferimenti nella documentazione. Grazie a qualche magica estensione a
+Sphinx, il sistema di generazione della documentazione trasformerà
+automaticamente un riferimento ad una ``funzione()`` in un riferimento
+incrociato quando questa ha una voce nell'indice.  Se trovate degli usi di
+``c:func:`` nella documentazione del kernel, sentitevi liberi di rimuoverli.
 
 
 Tabelle a liste
diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index 276db0e37f43..118fb4153e8f 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -248,7 +248,10 @@ possano ricevere la vostra nuova sottochiave::
     kernel.
 
     Se per qualche ragione preferite rimanere con sottochiavi RSA, nel comando
-    precedente, sostituite "ed25519" con "rsa2048".
+    precedente, sostituite "ed25519" con "rsa2048". In aggiunta, se avete
+    intenzione di usare un dispositivo hardware che non supporta le chiavi
+    ED25519 ECC, come la Nitrokey Pro o la Yubikey, allora dovreste usare
+    "nistp256" al posto di "ed25519".
 
 Copia di riserva della chiave primaria per gestire il recupero da disastro
 --------------------------------------------------------------------------
@@ -449,23 +452,27 @@ implementi le funzionalità delle smartcard.  Sul mercato ci sono diverse
 soluzioni disponibili:
 
 - `Nitrokey Start`_: è Open hardware e Free Software, è basata sul progetto
-  `GnuK`_ della FSIJ. Ha il supporto per chiavi ECC, ma meno funzionalità di
-  sicurezza (come la resistenza alla manomissione o alcuni attacchi ad un
-  canale laterale).
+  `GnuK`_ della FSIJ. Questo è uno dei pochi dispositivi a supportare le chiavi
+  ECC ED25519, ma offre meno funzionalità di sicurezza (come la resistenza
+  alla manomissione o alcuni attacchi ad un canale laterale).
 - `Nitrokey Pro`_: è simile alla Nitrokey Start, ma è più resistente alla
-  manomissione e offre più funzionalità di sicurezza, ma l'ECC.
-- `Yubikey 4`_: l'hardware e il software sono proprietari, ma è più economica
+  manomissione e offre più funzionalità di sicurezza. La Pro 2 supporta la
+  crittografia ECC (NISTP).
+- `Yubikey 5`_: l'hardware e il software sono proprietari, ma è più economica
   della  Nitrokey Pro ed è venduta anche con porta USB-C il che è utile con i
   computer portatili più recenti. In aggiunta, offre altre funzionalità di
-  sicurezza come FIDO, U2F, ma non l'ECC
+  sicurezza come FIDO, U2F, e ora supporta anche le chiavi ECC (NISTP)
 
 `Su LWN c'è una buona recensione`_ dei modelli elencati qui sopra e altri.
+La scelta dipenderà dal costo, dalla disponibilità nella vostra area
+geografica e vostre considerazioni sull'hardware aperto/proprietario.
+
 Se volete usare chiavi ECC, la vostra migliore scelta sul mercato è la
 Nitrokey Start.
 
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
-.. _`Nitrokey Pro`: https://shop.nitrokey.com/shop/product/nitrokey-pro-3
-.. _`Yubikey 4`: https://www.yubico.com/product/yubikey-4-series/
+.. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
+.. _`Yubikey 5`: https://www.yubico.com/product/yubikey-5-overview/
 .. _Gnuk: http://www.fsij.org/doc-gnuk/
 .. _`Su LWN c'è una buona recensione`: https://lwn.net/Articles/736231/
 
-- 
2.21.0

