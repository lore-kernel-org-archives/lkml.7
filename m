Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C67C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C7820657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfCKNTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:29 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6lxY-1h8Jhx2fle-008Hg5 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:27 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 001/114] drivers: gpio: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:13 +0100
Message-Id: <1552310346-7629-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ejjcvAzyls6sHQOvoDOcMZJC1qbAC+6RBRvAklbon/vzDh6qBaF
 mc3NUhINuTrdrYaDyGwkp4fVvlaMia3Utx8zo9h0ZN/gdWmuFOsbZd9fwrt8Yuki8T4CGJ3
 26h9lNjefgHxqLHIIAoSYFxmV4KMB5iy8aZpPB2OL6V2RLC9o4QvSU9XRKqwasj7+N3EtRv
 HwC9hhqr98B9ChO17NARw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PbSyNX7pOM0=:qSyjP4hH5WfRkvEaP87N80
 yR7t1EWQpcf8GJ7npONPZ4mOC7jyRsmOdXJ4CGZwcvRXRSLJDdKsZt3TkFlLgXa7GmncFZaaW
 2Eewt/UwxfNZBRHkr+LRPNprRVv82u8oYlW6xG51HFX26gvgWQbKsrtfwRHphskuK+LeHbRxx
 /lt4Ab4z6O5fGcCSBV9dnxO5TuJ9Hd5YjN9skuTR8O/lJjIj/zGEUOfaHF9UPxSTvGqQTKSqL
 YJRQS9ZcrO35KVGug+6zxTM2n5TCoUL3EcPXnV9oPxJAhpnmv4oVRGVmQaZbg+14ePlBm/XiL
 CG8zC2+rLojSPf+S/mQ/g85G0Y7dzNfinQMFCsTH/RRBw2OaLkrxEKbusKNtxVcMtVujZK2o4
 rHjpSrbGOVkClMwsTy8CNzdhUAVDwZDTcukFO5w4JMeA7MubwsjE2ucwrZt3tsnaIoLIyRJ42
 TdJx5OKG/qmcdoM9BsZdtiHW6LeppWp6SfTyToTKxY8DHTO7HRrhYmyOsEaCsQYoBau2N/uzN
 Pyp0LJ/YOfR9aMCVsoxNS9xqGlDo4ZWu3QIogNCpr/1u5q2iYwqLWPuJztN83S2NHxuihiFLa
 gFrioo0eNWNKMaZrC7c/yS37X1zGbA0nPaz9JL6M05zX1E7vvHvyTmIR4gOs9rN7w057riONA
 1gvdBV2U7p3BFn7TmbrEMndQNPWe9qrTE/10j2uFDjhiPExKlEg+hm0gmdLEtMwUOuOhdavpo
 lho0cWPY6jZQWu8HvvFKhBS55vV+xUJtKYVx6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

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

