Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEADFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323CE2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393305AbfJPMsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:48:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56982 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391399AbfJPMsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:48:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 041461A0570;
        Wed, 16 Oct 2019 14:48:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EBB1B1A001A;
        Wed, 16 Oct 2019 14:48:30 +0200 (CEST)
Received: from fsr-ub1664-026.ea.freescale.net (fsr-ub1664-026.ea.freescale.net [10.171.81.59])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 60AE3205D2;
        Wed, 16 Oct 2019 14:48:30 +0200 (CEST)
From:   Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     jslaby@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 3/5] serial: fsl_linflexuart: Be consistent with the name
Date:   Wed, 16 Oct 2019 15:48:25 +0300
Message-Id: <1571230107-8493-4-git-send-email-stefan-gabriel.mirea@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
References: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency reasons, spell the controller name as "LINFlexD" in
comments and documentation.

Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 drivers/tty/serial/Kconfig                      | 8 ++++----
 drivers/tty/serial/fsl_linflexuart.c            | 4 ++--
 include/uapi/linux/serial_core.h                | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f8881e..6dbd871493af 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1101,7 +1101,7 @@
 			mapped with the correct attributes.
 
 		linflex,<addr>
-			Use early console provided by Freescale LinFlex UART
+			Use early console provided by Freescale LINFlexD UART
 			serial driver for NXP S32V234 SoCs. A valid base
 			address must be provided, and the serial port must
 			already be setup and configured.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 67a9eb3f94ce..c07c2667a2e4 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1392,19 +1392,19 @@ config SERIAL_FSL_LPUART_CONSOLE
 	  you can make it the console by answering Y to this option.
 
 config SERIAL_FSL_LINFLEXUART
-	tristate "Freescale linflexuart serial port support"
+	tristate "Freescale LINFlexD UART serial port support"
 	depends on PRINTK
 	select SERIAL_CORE
 	help
-	  Support for the on-chip linflexuart on some Freescale SOCs.
+	  Support for the on-chip LINFlexD UART on some Freescale SOCs.
 
 config SERIAL_FSL_LINFLEXUART_CONSOLE
-	bool "Console on Freescale linflexuart serial port"
+	bool "Console on Freescale LINFlexD UART serial port"
 	depends on SERIAL_FSL_LINFLEXUART=y
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-	  If you have enabled the linflexuart serial port on the Freescale
+	  If you have enabled the LINFlexD UART serial port on the Freescale
 	  SoCs, you can make it the console by answering Y to this option.
 
 config SERIAL_CONEXANT_DIGICOLOR
diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index a32f0d2afd59..205c31a61684 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Freescale linflexuart serial port driver
+ * Freescale LINFlexD UART serial port driver
  *
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
  * Copyright 2017-2019 NXP
@@ -940,5 +940,5 @@ static void __exit linflex_serial_exit(void)
 module_init(linflex_serial_init);
 module_exit(linflex_serial_exit);
 
-MODULE_DESCRIPTION("Freescale linflex serial port driver");
+MODULE_DESCRIPTION("Freescale LINFlexD serial port driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index e7fe550b6038..8ec3dd742ea4 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -290,7 +290,7 @@
 /* Sunix UART */
 #define PORT_SUNIX	121
 
-/* Freescale Linflex UART */
+/* Freescale LINFlexD UART */
 #define PORT_LINFLEXUART	122
 
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.22.0

