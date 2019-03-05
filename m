Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EFB206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCEAfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:35:34 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:32985 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:35:33 -0500
Received: from orion.localdomain ([77.2.115.28]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAgIQ-1gq0lv48HA-00B012; Tue, 05 Mar 2019 01:35:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH] drivers: gpio: Kconfig: pedantic formatting cleanups
Date:   Tue,  5 Mar 2019 01:35:31 +0100
Message-Id: <1551746131-10232-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:1vgKvGmk/e8Z5hd9MdnF2TmL3Aa6/Ls3nwrJA6COHBcSYpq7V7o
 6huwGXvegMCwe8YG540zd+bEQj9bqcPY6sdNwzbJyYz+mmfJbM0cXfeoYIKthsOeTFyX7Qs
 nwPK2Ju3kLIgIJXHxJpx4HIDsSN4DKNu39SxXJZJdtpz6rQLASo5q6G4rN1uVitB5Sqzp9+
 0lPDVQcSePYHxKPfZUNtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cLTxoHkVM2U=:5ft3qtgJcXWeIIAYXdMLtE
 UsgVvr5TAf91ljBJ7nWqneIjvkFRW2jgn5DCufalkE4pdhuVtHGuBD8THOYgHO46mWGmbQO/s
 stRtknUXkP0ltCklUwr00uWNzOrwHWGsdmC+xcZHrG3vElfr6GMt+f3M5mNxZNl+UULQcy5bX
 L2UMuuSOm90RwFU0PKwGaX6pcyu/dYDSO7XUk+3t/d5FQ/4BdEZTO+prRqwk9+7IDHvz9/yE2
 CmDVIYi9E5eYJXFNcXdBn9LfW+U7J4k5t+5sWmeumrWoCyJlELh6Wn3INLxtSeyvxEbu6CkD0
 cQp88EQrqCVEfRYd66T7dqV1E1K7ZaEfrhteAMGPyurGF2uBL4Io/AG/jfETLea19HQPVUlvq
 FnRhN8rSRJZegmAi1+eL15MfDjBAXh1OutFzCwKele3qgDPoRAxem7Ajqt+6uSYHxtofF9VxY
 SBy8FPkicENHSce4he4x9AnRJDoh2Nn+EVu2MwkjTo8Bl7lmKriJ8+ZfDXWKQa/hKH8mwMWnJ
 2Atty2slBJVPDftvaXEpv3B7Ol2nc+ADai0i+XhcVQhc+rbPGq+NDrPG471rNb/mhJDWsAGcY
 /QXlk7XpkgqS8gOLflTjsn9IwlS9cZWK+P//QFrfYcGS9487QuVcvK1GgYTRAJRsBZHE9Pp8L
 XHqB9cbUyrmimhy0pTXaFQgaXXH8KaBpn0XqWu19yuEQs0wNfNbBW7wkFMZkQHO++frSh8yim
 mtNhIzxN8/BlpouvZFRTMp6oflqIIbeaE6bGJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the Kconfig formatting with the vast majority of the Kconfig
files, to make it a bit easier / more pleasant to read ;-)

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/Kconfig | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3f50526..c5420e6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -27,12 +27,12 @@ config GPIOLIB_FASTPATH_LIMIT
 	range 32 512
 	default 512
 	help
-	   This adjusts the point at which certain APIs will switch from
-	   using a stack allocated buffer to a dynamically allocated buffer.
+	  This adjusts the point at which certain APIs will switch from
+	  using a stack allocated buffer to a dynamically allocated buffer.
 
-	   You shouldn't need to change this unless you really need to
-	   optimize either stack space or performance. Change this carefully
-	   since setting an incorrect value could cause stack corruption.
+	  You shouldn't need to change this unless you really need to
+	  optimize either stack space or performance. Change this carefully
+	  since setting an incorrect value could cause stack corruption.
 
 config OF_GPIO
 	def_bool y
@@ -320,7 +320,7 @@ config GPIO_MENZ127
 	depends on MCB
 	select GPIO_GENERIC
 	help
-	 Say yes here to support the MEN 16Z127 GPIO Controller
+	  Say yes here to support the MEN 16Z127 GPIO Controller
 
 config GPIO_MM_LANTIQ
 	bool "Lantiq Memory mapped GPIOs"
@@ -862,11 +862,11 @@ config GPIO_MAX732X
 	  Input and Output (designed by 'P'). The combinations are listed
 	  below:
 
-	  8 bits:	max7319 (8I), max7320 (8O), max7321 (8P),
-		  	max7322 (4I4O), max7323 (4P4O)
+	  8 bits:       max7319 (8I), max7320 (8O), max7321 (8P),
+	                max7322 (4I4O), max7323 (4P4O)
 
-	  16 bits:	max7324 (8I8O), max7325 (8P8O),
-		  	max7326 (4I12O), max7327 (4P12O)
+	  16 bits:      max7324 (8I8O), max7325 (8P8O),
+	                max7326 (4I12O), max7327 (4P12O)
 
 	  Board setup code must specify the model to use, and the start
 	  number for these GPIOs.
@@ -893,17 +893,17 @@ config GPIO_PCA953X
 	  SMBus I/O expanders, made mostly by NXP or TI.  Compatible
 	  models include:
 
-	  4 bits:	pca9536, pca9537
+	  4 bits:       pca9536, pca9537
 
-	  8 bits:	max7310, max7315, pca6107, pca9534, pca9538, pca9554,
-			pca9556, pca9557, pca9574, tca6408, tca9554, xra1202
+	  8 bits:       max7310, max7315, pca6107, pca9534, pca9538, pca9554,
+	                pca9556, pca9557, pca9574, tca6408, tca9554, xra1202
 
-	  16 bits:	max7312, max7313, pca9535, pca9539, pca9555, pca9575,
-			tca6416
+	  16 bits:      max7312, max7313, pca9535, pca9539, pca9555, pca9575,
+	                tca6416
 
-	  24 bits:	tca6424
+	  24 bits:      tca6424
 
-	  40 bits:	pca9505, pca9698
+	  40 bits:      pca9505, pca9698
 
 config GPIO_PCA953X_IRQ
 	bool "Interrupt controller support for PCA953x"
@@ -925,7 +925,7 @@ config GPIO_PCF857X
 
 	  8 bits:   pcf8574, pcf8574a, pca8574, pca8574a,
 	            pca9670, pca9672, pca9674, pca9674a,
-	  	    max7328, max7329
+	            max7328, max7329
 
 	  16 bits:  pcf8575, pcf8575c, pca8575,
 	            pca9671, pca9673, pca9675
@@ -1047,9 +1047,9 @@ config HTC_EGPIO
 	bool "HTC EGPIO support"
 	depends on GPIOLIB && ARM
 	help
-	    This driver supports the CPLD egpio chip present on
-	    several HTC phones.  It provides basic support for input
-	    pins, output pins, and irqs.
+	  This driver supports the CPLD egpio chip present on
+	  several HTC phones.  It provides basic support for input
+	  pins, output pins, and irqs.
 
 config GPIO_JANZ_TTL
 	tristate "Janz VMOD-TTL Digital IO Module"
@@ -1085,7 +1085,7 @@ config GPIO_LP873X
 	  on LP873X PMICs.
 
 	  This driver can also be built as a module. If so, the module will be
-          called gpio-lp873x.
+	  called gpio-lp873x.
 
 config GPIO_LP87565
 	tristate "TI LP87565 GPIO"
@@ -1436,9 +1436,9 @@ config GPIO_VIPERBOARD
 	  Say yes here to access the GPIO signals of Nano River
 	  Technologies Viperboard. There are two GPIO chips on the
 	  board: gpioa and gpiob.
-          See viperboard API specification and Nano
-          River Tech's viperboard.h for detailed meaning
-          of the module parameters.
+	  See viperboard API specification and Nano
+	  River Tech's viperboard.h for detailed meaning
+	  of the module parameters.
 
 endmenu
 
-- 
1.9.1

