Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99992C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D472082F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="N/EeLoi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCOXDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:03:53 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:8072 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfCOXDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:03:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id EEC60704;
        Fri, 15 Mar 2019 23:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1552690687; x=1554505088;
         bh=2Ufe//9CH8IpeNiU8eraoBQnkUEeNQbowjbWWBafy0w=; b=N/EeLoi7dFa6
        gTr6xkTClIw+ErnSCK0A7IXymZf5pk1NGRQavrtKfr7PLkn4T1ovh+exEOraz9JM
        vbhKdQlcOdPrY41WXLNfKSY9swzkQMkAM7WXzrZSPjSo3eSwYZ5IFJihgee4fvZL
        u3p+LOqi2vgm/+dHUJj1aFQErn9zn7iQAQN9GH2luRViCs0nhVlcI7roRWUuHNjL
        QUuaVN2FsDR6f5qPpAm4C8xjXc+jUKZFZQWcn1Mfe7vv6VCrZODfSOmM8EyV/Bvw
        Z5/SliMjVoGOzJuY46VyyzNPOpdwhSOS3s5t7yC/w3+oIKRDVKLSbZcV0vAQmnjY
        2jW8CFbKfiATfrlvKqrvU0aLv5AcobDpafZTLV4zWYcXJJmocOHUiUnOgI0VJn7k
        kD91jLgCJS5OeIWPIIa0HRi0u+olfLvrLNVSPqGU2tIrpLQ/EeR9AeQIJKQp8ztY
        w4hBybH801tIE6s0GNIGekyoqTrCsn7uCFIEXaZuS667eSVRk9sIUIP8wWCmHYNU
        d/k9FmcX64GcuLLmfhigba3BIc7AZ6NbQ4/MJKRObhbIfW2Z4fBOSj837ZMdsqDX
        T2dKS8T9b6ltSwFXbnwjMFPX1BDNpgekaESYD09QBwA6aokLkE3g7MS6LVqyNXC/
        b1e9DVsMaMMTpiAAjbiNGOydVcuODQ8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lNk_9MZIYG_m; Fri, 15 Mar 2019 23:58:07 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 932D13FE;
        Fri, 15 Mar 2019 23:58:07 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 5CA532404;
        Fri, 15 Mar 2019 23:58:07 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux@rasmusvillemoes.dk, Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] doc: add translation disclaimer
Date:   Fri, 15 Mar 2019 23:57:47 +0100
Message-Id: <20190315225747.11953-1-federico.vaga@vaga.pv.it>
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
 Documentation/translations/index.rst          | 56 ++++++++++++------
 .../translations/it_IT/disclaimer-ita.rst     |  6 +-
 Documentation/translations/it_IT/index.rst    | 59 ++++++++++++-------
 3 files changed, 80 insertions(+), 41 deletions(-)

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index b46c8ce98d6e..e446e5ed00a6 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -4,28 +4,50 @@
 Translations
 ============
 
+.. toctree::
+   :maxdepth: 1
+
+   zh_CN/index
+   it_IT/index
+   ko_KR/index
+   ja_JP/index
+
+
 .. _translations_disclaimer:
 
 Disclaimer
 ----------
-Write some text in English here to explain that:
 
-- its purpose is to ease reading and understanding in other languages
-- this is not a fork
-- the only official documentation is :ref:`linux_doc`
-- there are not guarantee about translations being in line with the
-  main documentation
-- translation's maintainer can help people who can't write in English
-- only comments and patches about translations are accepted, any other
-  discussion about Documentation does not belong here
+Translation's purpose is to ease reading and understanding in languages other
+than English. Its aim is to help people who do not understand English or have
+doubts about its interpretation. Additionally, some people prefer to read
+documentation in their native language, but please bear in mind that the
+*only* official documentation is the English one: :ref:`linux_doc`.
 
-Translations
-------------
+It is very unlikely that an update to :ref:`linux_doc` will be propagated
+immediately to all translations.  Translations' maintainers - and
+contributors - follow the evolution of the official documentation and they
+maintain translations aligned as much as they can.  For this reason there is
+no guarantee that a translation is up to date.  If what you read in a
+translation does not sound right compared to what you read in the code, please
+inform the translation maintainer and - if you can - check also the English
+documentation.
 
-.. toctree::
-   :maxdepth: 1
+A translation is not a fork of the official documentation, therefore
+translations' users should not find information that differs from the official
+English documentation.  Any content addition, removal or update, must be
+applied to the English documents first.  Afterwards and when possible, the
+same change should be applied to translations.  Translations' maintainers
+accept only contributions that are merely translation related (e.g. new
+translations, updates, fixes).
 
-   zh_CN/index
-   it_IT/index
-   ko_KR/index
-   ja_JP/index
+Translations try to be as accurate as possible but it is not possible to map
+one language directly to all other languages. Each language has its own
+grammar and culture, so the translation of an English statement may need to be
+adapted to fit a different language.  For this reason, when viewing
+translations, you may find slight differences that carry the same message but
+in a different form.
+
+If you need to communicate with the Linux community but you do not feel
+comfortable writing in English, you can ask the translation's maintainers
+for help.
diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst b/Documentation/translations/it_IT/disclaimer-ita.rst
index aacc1a0346db..bfe8a384baed 100644
--- a/Documentation/translations/it_IT/disclaimer-ita.rst
+++ b/Documentation/translations/it_IT/disclaimer-ita.rst
@@ -1,6 +1,6 @@
 :orphan:
 
 .. warning::
-   Short (to not pollute the document) text in Italian to explain that for any
-   doubt about the documentation content people should refer to the English
-   documentation. Read the :ref:`it_disclaimer`.
+   In caso di dubbi sulla correttezza del contenuto di questa traduzione,
+   l'unico riferimento valido è la documentazione ufficiale in inglese.
+   Per maggiori informazioni consultate le :ref:`avvertenze <it_disclaimer>`.
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index a67092599634..409eaac03e9f 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -4,32 +4,49 @@
 Traduzione italiana
 ===================
 
+:manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
+
 .. _it_disclaimer:
 
-Disclaimer
+Avvertenze
 ==========
-The following text should be the translation of :ref:`translations_disclaimer`
 
 L'obiettivo di questa traduzione è di rendere più facile la lettura e
-la comprensione per chi preferisce leggere in lingua italiana.
-Tenete presente che la documentazione di riferimento rimane comunque
-quella in lingua inglese: :ref:`linux_doc`
-
-Questa traduzione cerca di essere il più fedele possibile all'originale ma
-è ovvio che alcune frasi vadano trasformate: non aspettatevi una traduzione
-letterale. Quando possibile, si eviteranno gli inglesismi ed al loro posto
-verranno utilizzate le corrispettive parole italiane.
-
-Se notate che la traduzione non è più aggiornata potete contattare
-direttamente il manutentore della traduzione italiana.
-
-Se notate che la documentazione contiene errori o dimenticanze, allora
-verificate la documentazione di riferimento in lingua inglese. Se il problema
-è presente anche nella documentazione di riferimento, contattate il suo
-manutentore. Se avete problemi a scrivere in inglese, potete comunque
-riportare il problema al manutentore della traduzione italiana.
-
-Manutentore della traduzione italiana: Federico Vaga <federico.vaga@vaga.pv.it>
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

