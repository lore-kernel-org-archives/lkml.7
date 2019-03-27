Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F1C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95084217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="F8USnXZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfC0W2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:28:54 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:50644 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC0W2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:28:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 7D7E4411C0;
        Wed, 27 Mar 2019 23:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1553725724; x=1555540125;
         bh=HXL+W52amwaK7XklPsPOZAepydCSlzNghj7COcMWlTQ=; b=F8USnXZj1xI2
        nIB4wiGQlL4CjrReKeLcltG+0FrVd9OzWSOQtUwiJ0mR3/yeV6K2/tdJUADZN6/S
        7RuzyrSlxvb5BXf2oDv8aYoJw3tZCBHqEKCelIyaF7YHZMzwH/QF79EeLw/17e+B
        YOhjZANBHKPKVIfboGRPkgZ5yPXUb7PEvVPxIuFDlnRMdPH6Ly8R3zbp3sjH6HG8
        YPqMYVR9OGNvsjDl4Sxse5L6OrPO8MOPyxZwwX94mkc/yL9fwPzgye0EW7encRij
        XQz1Qjxu/S6dENNA2ShzX1NfiOmdPKhT6AokzSzmUhsrSzC5LSmBDY3vZg1Cd7GA
        cB534wKBJ6d+JOR0HNDmC41Uwm2DCAakEr6MYsG3s+ebFPZ/0ZfDjntFOgFdUHrg
        nboUr2SjiY7NwjBycEp1+gCHYCuZk8P5b1tGD7Y6HrmFTF+x/a0VT/XbOf3/akGv
        YRIGRzCf/TdL0gBTK8PhyJjRIek5vcxWjWwh+uBA/5HFk6jJ9RT6oOsDr4GijJAj
        cfM7RF1JKH0g9X8tQNUa6El1pow4T4LVI10F+q1YslzEguxzjfzf4pj0Nfv+nJ9C
        SHZRS2sQbAjS7Sn69p8oQbb4mGOPtLlH5ly/+NAEqgxIpTpL8Vz+VROrzrzZBD0b
        WpkpSK7cNfQjh7ST/YYjh422FYNC7Pw=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SEOF3OhgXSXm; Wed, 27 Mar 2019 23:28:44 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id C57FD411BD;
        Wed, 27 Mar 2019 23:28:44 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 9FA79190F;
        Wed, 27 Mar 2019 23:28:44 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc:it: alignement clarification about sign-off and Co-developed-by
Date:   Wed, 27 Mar 2019 23:28:35 +0100
Message-Id: <20190327222835.27497-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align Italian documentation after the following patch to the main documents

commit 24a2bb90741b docs: Clarify the usage and sign-off requirements for Co-developed-by

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/process/5.Posting.rst  | 10 +++--
 .../it_IT/process/submitting-patches.rst      | 41 ++++++++++++++++---
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
index b979266aa884..1476d51eb5e5 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -233,10 +233,12 @@ Le etichette in uso più comuni sono:
    :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`.
    Codice che non presenta una firma appropriata non potrà essere integrato.
 
- - Co-developed-by: indica che la patch è stata sviluppata anche da un altro
-   sviluppatore assieme all'autore originale.  Questo è utile quando più
-   persone lavorano sulla stessa patch.  Da notare che questa persona deve
-   avere anche una riga "Signed-off-by:" nella patch.
+ - Co-developed-by: indica che la patch è stata cosviluppata da diversi
+   sviluppatori; viene usato per assegnare più autori (in aggiunta a quello
+   associato all'etichetta From:) quando più persone lavorano ad una patch.
+   Ogni Co-developed-by: dev'essere seguito immediatamente da un Signed-off-by:
+   del corrispondente coautore.  Maggiori dettagli ed esempi sono disponibili
+   in :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`.
 
  - Acked-by: indica il consenso di un altro sviluppatore (spesso il manutentore
    del codice in oggetto) all'integrazione della patch nel kernel.
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 713fba075b9d..7d7ea92c5c5a 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -567,11 +567,42 @@ alcunché - ma dovrebbe indicare che la persona ha ricevuto una copia della
 patch.  Questa etichetta documenta che terzi potenzialmente interessati sono
 stati inclusi nella discussione.
 
-L'etichetta Co-developed-by: indica che la patch è stata scritta dall'autore in
-collaborazione con un altro sviluppatore.  Qualche volta questo è utile quando
-più persone lavorano sulla stessa patch.  Notate, questa persona deve avere
-nella patch anche una riga Signed-off-by:.
+Co-developed-by: indica che la patch è stata cosviluppata da diversi
+sviluppatori; viene usato per assegnare più autori (in aggiunta a quello
+associato all'etichetta From:) quando più persone lavorano ad una patch.  Dato
+che Co-developed-by: implica la paternità della patch, ogni Co-developed-by:
+dev'essere seguito immediatamente dal Signed-off-by: del corrispondente
+coautore. Qui si applica la procedura di base per sign-off, in pratica
+l'ordine delle etichette Signed-off-by: dovrebbe riflettere il più possibile
+l'ordine cronologico della storia della patch, indipendentemente dal fatto che
+la paternità venga assegnata via From: o Co-developed-by:. Da notare che
+l'ultimo Signed-off-by: dev'essere quello di colui che ha sottomesso la patch.
 
+Notate anche che l'etichetta From: è opzionale quando l'autore in From: è
+anche la persona (e indirizzo email) indicato nel From: dell'intestazione
+dell'email.
+
+Esempio di una patch sottomessa dall'autore in From:::
+
+	<changelog>
+
+	Co-developed-by: First Co-Author <first@coauthor.example.org>
+	Signed-off-by: First Co-Author <first@coauthor.example.org>
+	Co-developed-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: From Author <from@author.example.org>
+
+Esempio di una patch sottomessa dall'autore Co-developed-by:::
+
+	From: From Author <from@author.example.org>
+
+	<changelog>
+
+	Co-developed-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: From Author <from@author.example.org>
+	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
+	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
 13) Utilizzare Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: e Fixes:
 -----------------------------------------------------------------------------
@@ -719,7 +750,7 @@ Un paio di esempi di oggetti::
 La riga ``from`` dev'essere la prima nel corpo del messaggio ed è nel
 formato:
 
-        From: Original Author <author@example.com>
+        From: Patch Author <author@example.com>
 
 La riga ``from`` indica chi verrà accreditato nel changelog permanente come
 l'autore della patch.  Se la riga ``from`` è mancante, allora per determinare
-- 
2.20.1

