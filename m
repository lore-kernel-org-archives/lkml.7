Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF19C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B98E206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfCFSPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:15:50 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:33093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbfCFSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:15:50 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N9MYu-1gyYER3ssW-015IwI; Wed, 06 Mar 2019 19:15:48 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org
Subject: [PATCH] drivers: leds: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:15:46 +0100
Message-Id: <1551896146-17719-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:cV1ACnoL0BZu1M+uVjDJ0xGMTi9m/lZjjZPsCyTg6Dr3slanbdb
 EPqkgYJzZHH5sSja9ci3V1ZocOC0btZtvr+34mWU0+qXy3umyeZvfWCa7nuelymFmxg0OUQ
 nSMK36yoRCdjhjArLZaBRT1+BsHsC1UO1J2qej3ArCiYpBYKzceVMbmg5HIf3gan0wsgSS8
 aG8B5t3aE1K01r9cr09Bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zwnmi0bzFZI=:F7p/oNEAnkB61Fvc4YYKDk
 UH0cven9/HDrIyVatvmM+o3hASwIstUZtptqXaBLSpGc+8zkCnGYntxXgt7vs/c7qBRSwRW6q
 1aYJsTr4utTxdqPayBGCvlVFWrstvOdczvBWccHmiCBRThcS5PvcD7cVZJEX3oWkcV8GZQew5
 +d4O8PWhMN3E3y8y/MtZ4bLpQq0sqjfTDZCXM3cNE9kOU+otM/zoN1Do6L7TPkrpBx+pEDcuW
 W17lL7l26hNcF9blIZdOjNPl2MyMpATndJ1Dfk4IkGFoF/DhVLxf0h+YbT9wD1mU8ELLJ8VRN
 ph6cfvDfMmc8BGiKoTybKiveHxejkUVM5wErGi5SRJ9/9wTddWRKc2ZqrUVQ8ViSTprqDpTyw
 FWmYI+SA+ueUwnJmjw/RbWYKTScl11y08ICaH55495HDt6ITbBppGfGX251DnYBgyOl82pJCm
 IzuUMH9nGlVJfVgTqh/6LYJgjLc9RACaPnpMzzv4fCd8sX7erbs2h4I34TJHQ7l8j6fZB4Q2r
 E2Ijr3PPg5lpj9uWYWcJExeS8OfMyzU/lDdhcbGWN6/HcwlNymc6ocF+A6LRF5023ghU5hf6e
 XxSpLwH73DvpUmW01EAxaxZMN/Xf3G8cKDVBrcKIiZfiUmYBzTlMfxmr0p06N0coe3Q2TT3wQ
 CH0pYGfmAZbd7p9P27WgXPalvcJyC9fWwPssOtMoTRKTILAsDA7JMv2dx++3YEI3PINaxgKLz
 KLv2SMLHfagUwULXlHTXmxfpcJaZ8h85NhywRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/leds/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97f..2b5ae50 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -56,7 +56,7 @@ config LEDS_AAT1290
 	depends on OF
 	depends on PINCTRL
 	help
-	 This option enables support for the LEDs on the AAT1290.
+	  This option enables support for the LEDs on the AAT1290.
 
 config LEDS_AN30259A
 	tristate "LED support for Panasonic AN30259A"
@@ -413,13 +413,13 @@ config LEDS_CLEVO_MAIL
 
 	  This module can drive the mail LED for the following notebooks:
 
-	  	Clevo D400P
-	  	Clevo D410J
-	  	Clevo D410V
-	  	Clevo D400V/D470V (not tested, but might work)
-	  	Clevo M540N
-	  	Clevo M5x0N (not tested, but might work)
-	  	Positivo Mobile (Clevo M5x0V)
+	        Clevo D400P
+	        Clevo D410J
+	        Clevo D410V
+	        Clevo D400V/D470V (not tested, but might work)
+	        Clevo M540N
+	        Clevo M5x0N (not tested, but might work)
+	        Positivo Mobile (Clevo M5x0V)
 
 	  If your model is not listed here you can try the "nodetect"
 	  module parameter.
@@ -462,7 +462,7 @@ config LEDS_WM831X_STATUS
 	depends on MFD_WM831X
 	help
 	  This option enables support for the status LEDs of the WM831x
-          series of PMICs.
+	  series of PMICs.
 
 config LEDS_WM8350
 	tristate "LED Support for WM8350 AudioPlus PMIC"
-- 
1.9.1

