Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA91C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F508206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="kgzx8oIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGWGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:06:13 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:19180 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGWGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:06:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 0C75E404EE;
        Wed,  8 May 2019 00:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1557266768; x=1559081169;
         bh=PX87WpDrIxp8L2RYRles5DX7wyZMmqVIc4/AQkhrgJI=; b=kgzx8oIV6WFF
        G2CFHrR6W1hdZQch7VSc8J1hiQT0sxGazWKcrEqxsc0MPwAMy7pD2fq6Z3DPLo5A
        tIe0maigNYDuWywTTpoZHrEUMOMbNP6FNF5e9PhMYRiOMzv1Cpb6CyCWPu+n7eyU
        MJftGoZ/q+tiro65CYYZW1arIcuPkzx6rMQGMIHhiyE4MaANKkopnqxODV5xfJC+
        yUIl+20aDpz6/koPuMsHIT49z9cGh8rPuAl3Os70zz4+JFg+Waei/d8oDAoTx0IE
        Gd7/EThNqOxxMlH6m5SY0mszkv8xhh63iXRXaNcPOPq0bEeNht9zuQcbLZ6LDYAV
        Dtfgdm8t25Xcijxy2UnzMKqSahoUi/MWz53IX69nXUTwRLHzJryc6RFmrdmf1gKX
        T/CBlWdvEK1ltfAV+t06iuFNhnbTZpqkgEUehDrAElQN9A7EUrDSAOUyt4L+bnCu
        VCn2vEa0j31oQzyZEyrsW3tcj+1PwDgqgsMu+KhquXI4Q6uscL1SAZSoLE73p4CD
        OvLeCThEdR19FspscGLY30Rp61/iiSsYjwocH1qjTWA2ITM9IsSMg1N9BYc6vLEw
        sCC7mV4DCm2+rWu7unSoJpb3v51qUgO6fAFabW3HPy3BEstSbsli56QEHYE8CUJv
        wUCNfvDFIYomY1UEczHQcNFRz3DpHDI=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0-HV4Nuj7TLa; Wed,  8 May 2019 00:06:08 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id AFBCF403A8;
        Wed,  8 May 2019 00:06:08 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 4D50E4696;
        Wed,  8 May 2019 00:06:08 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc:it_IT: align documentation after licenses patches
Date:   Wed,  8 May 2019 00:05:25 +0200
Message-Id: <20190507220525.23189-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch translates in Italian the following updates

62be257e986d LICENSES: Rename other to deprecated
8ea8814fcdcb LICENSES: Clearly mark dual license only licenses
6132c37ca543 docs: Don't reference the ZLib license in license-rules.rst

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/process/license-rules.rst           | 60 +++++++++++++++++--
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/it_IT/process/license-rules.rst b/Documentation/translations/it_IT/process/license-rules.rst
index 91a8794ffd79..f058e06996dc 100644
--- a/Documentation/translations/it_IT/process/license-rules.rst
+++ b/Documentation/translations/it_IT/process/license-rules.rst
@@ -249,13 +249,13 @@ essere categorizzate in:
 
 |
 
-2. Licenze non raccomandate:
+2. Licenze deprecate:
 
    Questo tipo di licenze dovrebbero essere usate solo per codice già esistente
    o quando si prende codice da altri progetti.  Le licenze sono disponibili
    nei sorgenti del kernel nella cartella::
 
-     LICENSES/other/
+     LICENSES/deprecated/
 
    I file in questa cartella contengono il testo completo della licenza e i
    `Metatag`_.  Il nome di questi file è lo stesso usato come identificatore
@@ -263,14 +263,14 @@ essere categorizzate in:
 
    Esempi::
 
-     LICENSES/other/ISC
+     LICENSES/deprecated/ISC
 
    Contiene il testo della licenza Internet System Consortium e i suoi
    metatag::
 
-     LICENSES/other/ZLib
+     LICENSES/deprecated/GPL-1.0
 
-   Contiene il testo della licenza ZLIB e i suoi metatag.
+   Contiene il testo della versione 1 della licenza GPL e i suoi metatag.
 
    Metatag:
 
@@ -294,7 +294,55 @@ essere categorizzate in:
 
 |
 
-3. _`Eccezioni`:
+3. Solo per doppie licenze
+
+   Queste licenze dovrebbero essere usate solamente per codice licenziato in
+   combinazione con un'altra licenza che solitamente è quella preferita.
+   Queste licenze sono disponibili nei sorgenti del kernel nella cartella::
+
+     LICENSES/dual
+
+   I file in questa cartella contengono il testo completo della rispettiva
+   licenza e i suoi `Metatags`_.  I nomi dei file sono identici agli
+   identificatori di licenza SPDX che dovrebbero essere usati nei file
+   sorgenti.
+
+   Esempi::
+
+     LICENSES/dual/MPL-1.1
+
+   Questo file contiene il testo della versione 1.1 della licenza *Mozilla
+   Pulic License* e i metatag necessari::
+
+     LICENSES/dual/Apache-2.0
+
+   Questo file contiene il testo della versione 2.0 della licenza Apache e i
+   metatag necessari.
+
+   Metatag:
+
+   I requisiti per le 'altre' ('*other*') licenze sono identici a quelli per le
+   `Licenze raccomandate`_.
+
+   Esempio del formato del file::
+
+   Valid-License-Identifier: MPL-1.1
+   SPDX-URL: https://spdx.org/licenses/MPL-1.1.html
+   Usage-Guide:
+     Do NOT use. The MPL-1.1 is not GPL2 compatible. It may only be used for
+     dual-licensed files where the other license is GPL2 compatible.
+     If you end up using this it MUST be used together with a GPL2 compatible
+     license using "OR".
+     To use the Mozilla Public License version 1.1 put the following SPDX
+     tag/value pair into a comment according to the placement guidelines in
+     the licensing rules documentation:
+   SPDX-License-Identifier: MPL-1.1
+   License-Text:
+     Full license text
+
+|
+
+4. _`Eccezioni`:
 
    Alcune licenze possono essere corrette con delle eccezioni che forniscono
    diritti aggiuntivi.  Queste eccezioni sono disponibili nei sorgenti del
-- 
2.21.0

