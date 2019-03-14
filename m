Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D60EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC2F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="UXzPodrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfCNUpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:45:44 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:53062 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbfCNUpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:45:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id B393E704;
        Thu, 14 Mar 2019 21:45:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1552596341; x=1554410742;
         bh=gZnAtZonqTCORZDQIqR8n2TVq2shQla8wFcsaD9ANEM=; b=UXzPodrK3/Hy
        wo+N+AX8TzH7PS7V7d51gGyn2tDg9QidUVGD67TeVHZMygT9abpGUG9KmZLiFnQr
        v8Y/P0Ms7Vfo6IKDwOkknSiMwT91Wra5EQNPTnpL2Cpf81bp0XQ/AQu5KuyHIE+2
        Gq1QPPgPagg8z4ehE+BBC8LKjb1irgQCZk1/cq4rm0FsbVZPDjrVwAinwFmcJTe9
        aVijVNYb8XhkOubp/vJzcOWRJo1ikhDLfSRA0IDkqcQhx8Cc+8gm/404mw8SLZNA
        Ir8ih7h9kDkuXecp4G2vi/IKoB0p0ru2YVYOVHAiZQxUC0LnyFfI+uTxnVhykMt4
        DGtwAxNIPiKLIKHvHZ+tf+kLcAcFsRyiu55N1VsZpmpjrcKQlmBPqhXDLTInpvx7
        GnudKs5Pb7tnZZZNyMIAxIOItEEnOaYaCA7iLco9qgtjqM7F3Zh8BS4rf4jwbhU1
        hIAK/zIvG9dSDT+i8eFu2KS5bsCYc1IPLyNGjtJRxVbkjjtXEfyBBiSQatoEqy3a
        TY8mL9wBTYJ47yH4Geyw6IKp51IYRTRRqgDFlCtCeOboDPlLQsC2mF0oLy8P5ZiS
        9HdOQSIrv1KFK4KXQ21w6xITL2vIK7zqsd8fTuZQI15l4nonTZKhJgVc4R2H10Ka
        exqKWiNL8h9nca4ZPxeDJHE5aH48Aa8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gaqSWeT94G5E; Thu, 14 Mar 2019 21:45:41 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 48FAC2D0;
        Thu, 14 Mar 2019 21:45:41 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 1D91C2C26;
        Thu, 14 Mar 2019 21:45:41 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: add translation disclaimer
Date:   Thu, 14 Mar 2019 21:45:16 +0100
Message-Id: <20190314204516.10890-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the translation disclaimer in English as reference
for other languages.  Translations must include this disclaimer
in their language so that readers are properly informed.

This very same patch updates the Italian translation accordingly.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/index.rst          | 42 ++++++++++++++
 .../translations/it_IT/disclaimer-ita.rst     | 13 +----
 Documentation/translations/it_IT/index.rst    | 57 +++++++++++++------
 3 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index 7f77c52d33aa..d7a38fd28b50 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -4,6 +4,48 @@
 Translations
 ============
 
+.. _translations_disclaimer:
+
+Disclaimer
+----------
+
+Translation's purpose is to ease reading and understating in languages other
+than English. Its aim is to help people who do not understand English or have
+doubts about its interpretation. Additionally, some people prefer to read
+documentation in their native language, but please bear in mind that the
+*only* official documentation is the English one: :ref:`linux_doc`.
+
+It is very unlikely that an update to :ref:`linux_doc` will be propagated
+immediately to all translations.  Translations' maintainers - and
+contributors - follow the evolution of the official documentation and they
+maintain translations aligned as much as they can.  For this reason there is
+no guarantee that a translation is up to date.  If what you read in a
+translation does not sound right compared to what you read in the code, please
+inform the translation maintainer and - if you can - check also the English
+documentation.
+
+A translation is not a fork of the official documentation, therefore
+translations' users should not find information that differs from the official
+English documentation.  Any content addition, removal or update, must be
+applied to the English documents first.  Afterwards and when possible, the
+same change should be applied to translations.  Translations' maintainers
+accept only contributions that are merely translation related (e.g. new
+translations, updates, fixes).
+
+Translations try to be as accurate as possible but it is not possible to map
+one language directly to all other languages. Each language has its own
+grammar and culture, so the translation of an English statement may need to be
+adapted to fit a different language.  For this reason, when viewing
+translations, you may find slight differences that carry the same message but
+in a different form.
+
+If you need to communicate with the Linux community but you do not feel
+comfortable to write in English, you can ask to the translation's
+maintainers for help.
+
+Translations
+------------
+
 .. toctree::
    :maxdepth: 1
 
diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst b/Documentation/translations/it_IT/disclaimer-ita.rst
index d68e52de6a5d..bfe8a384baed 100644
--- a/Documentation/translations/it_IT/disclaimer-ita.rst
+++ b/Documentation/translations/it_IT/disclaimer-ita.rst
@@ -1,13 +1,6 @@
 :orphan:
 
-.. note::
-   This document is maintained by Federico Vaga <federico.vaga@vaga.pv.it>.
-   If you find any difference between this document and the original file or a
-   problem with the translation, please contact the maintainer of this file.
-   Following people helped to translate or review:
-   Alessia Mantegazza <amantegazza@vaga.pv.it>
-
 .. warning::
-   The purpose of this file is to be easier to read and understand for Italian
-   speakers and is not intended as a fork. So, if you have any comments or
-   updates for this file please try to update the original English file first.
+   In caso di dubbi sulla correttezza del contenuto di questa traduzione,
+   l'unico riferimento valido è la documentazione ufficiale in inglese.
+   Per maggiori informazioni consultate le :ref:`avvertenze <it_disclaimer>`.
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index 02432b97a43e..409eaac03e9f 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -4,26 +4,49 @@
 Traduzione italiana
 ===================
 
-L'obiettivo di questa traduzione è di rendere più facile la lettura e
-la comprensione per chi preferisce leggere in lingua italiana.
-Tenete presente che la documentazione di riferimento rimane comunque
-quella in lingua inglese: :ref:`linux_doc`
-
-Questa traduzione cerca di essere il più fedele possibile all'originale ma
-è ovvio che alcune frasi vadano trasformate: non aspettatevi una traduzione
-letterale. Quando possibile, si eviteranno gli inglesismi ed al loro posto
-verranno utilizzate le corrispettive parole italiane.
+:manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
 
-Se notate che la traduzione non è più aggiornata potete contattare
-direttamente il manutentore della traduzione italiana.
+.. _it_disclaimer:
 
-Se notate che la documentazione contiene errori o dimenticanze, allora
-verificate la documentazione di riferimento in lingua inglese. Se il problema
-è presente anche nella documentazione di riferimento, contattate il suo
-manutentore. Se avete problemi a scrivere in inglese, potete comunque
-riportare il problema al manutentore della traduzione italiana.
+Avvertenze
+==========
 
-Manutentore della traduzione italiana: Federico Vaga <federico.vaga@vaga.pv.it>
+L'obiettivo di questa traduzione è di rendere più facile la lettura e
+la comprensione per chi non capisce l'inglese o ha dubbi sulla sua
+interpretazione, oppure semplicemente per chi preferisce leggere in lingua
+italiana. Tuttavia, tenete ben presente che l'*unica* documentazione
+ufficiale è quella in lingua inglese: :ref:`linux_doc`
+
+La propagazione simultanea a tutte le traduzioni di una modifica in
+:ref:`linux_doc` è altamente improbabile. I manutentori delle traduzioni -
+e i contributori - seguono l'evolversi della documentazione ufficiale e
+cercano di mantenere le rispettive traduzioni allineate nel limite del
+possibile.  Per questo motivo non c'è garanzia che una traduzione sia
+aggiornata all'ultima modifica.  Se quello che leggete in una traduzione
+non corrisponde a quello che leggete nel codice, informate il manutentore
+della traduzione e - se potete - verificate anche la documentazione in
+inglese.
+
+Una traduzione non è un *fork* della documentazione ufficiale, perciò gli
+utenti non vi troveranno alcuna informazione diversa rispetto alla versione
+ufficiale.  Ogni aggiunta, rimozione o modifica dei contenuti deve essere
+fatta prima nei documenti in inglese. In seguito, e quando è possibile, la
+stessa modifica dovrebbe essere applicata anche alle traduzioni.  I manutentori
+delle traduzioni accettano contributi che interessano prettamente l'attività
+di traduzione (per esempio, nuove traduzioni, aggiornamenti, correzioni).
+
+Le traduzioni cercano di essere il più possibile accurate ma non è possibile
+mappare direttamente una lingua in un'altra. Ogni lingua ha la sua grammatica
+e una sua cultura alle spalle, quindi la traduzione di una frase in inglese
+potrebbe essere modificata per adattarla all'italiano. Per questo motivo,
+quando leggete questa traduzione, potreste trovare alcune differenze di forma
+ma che trasmettono comunque il messaggio originale.  Nonostante la grande
+diffusione di inglesismi nella lingua parlata, quando possibile, questi
+verranno sostituiti dalle corrispettive parole italiane
+
+Se avete bisogno d'aiuto per comunicare con la comunità Linux ma non vi sentite
+a vostro agio nello scrivere in inglese, potete chiedere aiuto al manutentore
+della traduzione.
 
 La documentazione del kernel Linux
 ==================================
-- 
2.20.1

