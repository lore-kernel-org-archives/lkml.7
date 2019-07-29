Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202ED20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="WBSjQ597"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfG2V7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:59:22 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:29794 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbfG2V7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:59:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 2221C5B5;
        Mon, 29 Jul 2019 23:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1564437558; x=1566251959;
         bh=gmrks1gL8rsotA022rT28bK42uNcWkGQHEPJY39U71w=; b=WBSjQ597086J
        LZMCKHP/8Pwv73dnSnLFg177Cs/8lH6bQ3/j7n25tVkEf1QZeuDWZ5kTbK1lUS90
        R1ZUgIQW996FjzCadA6aOM3wXtTYar0C6pE5YecvwsUzOLn8Jkx3Fh9AR+hRQtNM
        y3+KqSa+XsdiDyv9N4BFQcZduillxAtRCm4X8y4P1GANKrBnnbXP9KDYZ50M51cF
        5ea0TxZxYBpKXb3j7L96qYYLm/J7+85gle8VJpjkwcVHY5VKXbzEtclrhFA55am/
        Ea4BE9hUs7WQ1lpKvq7RxBFLnLzy+43wFVU9S6Ou6j9Tk1HD4ggYFGedHjhwGKP2
        nju7MCwtKCzxd6Y/Bz0oHRi2hehqiaoiY20j8EUidTyNVSZpW6qZ+8+VclY7wL6l
        aG+Nib9G37L09U0XHyTpF5xcTSoJq/zBagbeaUALPMAyx1JX0c+vjSNCQ97U80kN
        KlsPD/Z/7ARr3+LRuYn+/U7gTJVs3Id78qL5mjm2ZBvzxJ2JCCOX4HhT9NDYMxJi
        6mzZrWCSVSfSQvsXvx+uXcEUwpZguQQjkhDgOkBHIZEJfxexkndiI4vDkzmX7NnJ
        vZTFBC/N4lvMSlNWBodj2hGht3UB7WRb4357GYRZoaxn6D0aNWYUWhbRqorTWjxZ
        I6EBiJ4a5kMGmUiHrAL/IQ0GfomBLxU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wqn3w0dfto0H; Mon, 29 Jul 2019 23:59:18 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 7413135F;
        Mon, 29 Jul 2019 23:59:17 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 52444B23;
        Mon, 29 Jul 2019 23:59:16 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: [PATCH] doc:it_IT: align translation to mainline
Date:   Mon, 29 Jul 2019 23:58:56 +0200
Message-Id: <20190729215856.11128-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch translates the following patches in Italian:

1fb12b35e5ff kbuild: Raise the minimum required binutils version to 2.21
9c3c0c204814 isdn: remove isdn4linux

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/process/changes.rst    | 22 ++++---------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index d0874327f301..94a6499742ac 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -26,16 +26,15 @@ Prima di pensare d'avere trovato un baco, aggiornate i seguenti programmi
 usando, il comando indicato dovrebbe dirvelo.
 
 Questa lista presume che abbiate già un kernel Linux funzionante.  In aggiunta,
-non tutti gli strumenti sono necessari ovunque; ovviamente, se non avete un
-modem ISDN, per esempio, probabilmente non dovreste preoccuparvi di
-isdn4k-utils.
+non tutti gli strumenti sono necessari ovunque; ovviamente, se non avete una
+PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
 
 ====================== =================  ========================================
         Programma       Versione minima       Comando per verificare la versione
 ====================== =================  ========================================
 GNU C                  4.6                gcc --version
 GNU make               3.81               make --version
-binutils               2.20               ld -v
+binutils               2.21               ld -v
 flex                   2.5.35             flex --version
 bison                  2.0                bison --version
 util-linux             2.10o              fdformat --version
@@ -49,7 +48,6 @@ btrfs-progs            0.18               btrfsck
 pcmciautils            004                pccardctl -V
 quota-tools            3.09               quota -V
 PPP                    2.4.0              pppd --version
-isdn4k-utils           3.1pre1            isdnctrl 2>&1|grep version
 nfs-utils              1.0.5              showmount --version
 procps                 3.2.0              ps --version
 oprofile               0.9                oprofiled --version
@@ -81,10 +79,7 @@ Per compilare il kernel vi servirà GNU make 3.81 o successivo.
 Binutils
 --------
 
-Il sistema di compilazione, dalla versione 4.13,  per la produzione dei passi
-intermedi, si è convertito all'uso di *thin archive* (`ar T`) piuttosto che
-all'uso del *linking* incrementale (`ld -r`). Questo richiede binutils 2.20 o
-successivo.
+Per generare il kernel è necessario avere Binutils 2.21 o superiore.
 
 pkg-config
 ----------
@@ -286,11 +281,6 @@ col seguente comando::
 
   mknod /dev/ppp c 108 0
 
-Isdn4k-utils
-------------
-
-Per via della modifica del campo per il numero di telefono, il pacchetto
-isdn4k-utils dev'essere ricompilato o (preferibilmente) aggiornato.
 
 NFS-utils
 ---------
@@ -456,10 +446,6 @@ PPP
 
 - <ftp://ftp.samba.org/pub/ppp/>
 
-Isdn4k-utils
-------------
-
-- <ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/>
 
 NFS-utils
 ---------
-- 
2.21.0

