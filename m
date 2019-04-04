Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF99C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4507C2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfDDIZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:25:54 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42880 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:25:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,306,1549954800"; 
   d="scan'208";a="27638899"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 04 Apr 2019 01:25:54 -0700
Received: from soft-dev3.microsemi.net (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Thu, 4 Apr 2019 01:25:53 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>,
        <ralf@linux-mips.org>, <paul.burton@mips.com>, <jhogan@kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2] MIPS: generic: Add switchdev, pinctrl and fit to ocelot_defconfig
Date:   Thu, 4 Apr 2019 10:25:28 +0200
Message-ID: <1554366328-16459-1-git-send-email-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the configuration were not selected by default anymore, therefore
enable them again. Also remove some configs which are used for MSCC Ocelot.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/mips/configs/generic/board-ocelot.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
index f607888..184eb65 100644
--- a/arch/mips/configs/generic/board-ocelot.config
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -1,6 +1,10 @@
 # require CONFIG_CPU_MIPS32_R2=y
 
 CONFIG_LEGACY_BOARD_OCELOT=y
+CONFIG_FIT_IMAGE_FDT_OCELOT=y
+
+CONFIG_BRIDGE=y
+CONFIG_GENERIC_PHY=y
 
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -19,6 +23,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 
 CONFIG_NETDEVICES=y
+CONFIG_NET_SWITCHDEV=y
+CONFIG_NET_DSA=y
 CONFIG_MSCC_OCELOT_SWITCH=y
 CONFIG_MSCC_OCELOT_SWITCH_OCELOT=y
 CONFIG_MDIO_MSCC_MIIM=y
@@ -35,6 +41,8 @@ CONFIG_SPI_DESIGNWARE=y
 CONFIG_SPI_DW_MMIO=y
 CONFIG_SPI_SPIDEV=y
 
+CONFIG_PINCTRL_OCELOT=y
+
 CONFIG_GPIO_SYSFS=y
 
 CONFIG_POWER_RESET=y
-- 
2.7.4

