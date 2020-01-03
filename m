Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E741C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B2B20866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071609;
	bh=YExA720C2zKhWsisoqLbN/UbWLsHxMgSyDoDzqvYOYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Rw1IoYkQhj8r6DcAs+LadIvBvyEnJ9pFz3M57AdwbtKGMgzqmMP2uSbm1DugjYWj
	 CoJv6DGy70gxKe7TF6tTsYGy8hKOFGKrfPL8ShOTsYDHLZgbM7Uq5BRyR9EXQhiNwt
	 mHngVJF4JWwXO4ofGWFDihweniN7DeWGqrUtXv3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgACRMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgACRMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:12:40 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB6320866;
        Fri,  3 Jan 2020 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071559;
        bh=YExA720C2zKhWsisoqLbN/UbWLsHxMgSyDoDzqvYOYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxsRs5JSRASe0LR8ZJjnkZ/nhak9Ww7c3pgSwMgZ7h5DePeHBXgztz8Mtw/EUuYew
         dSzvY8/DtzFqNGLErbcqiAjEibf9J1Trqn0XPfleVmuVlesSqmsPJDJmO0x45vPVZ6
         hSoGxVr40Hf6/jJpHMFSMjCs7hp6Kb/XSsXzP25U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 09/19] phy: exynos: Rename Exynos to lowercase
Date:   Fri,  3 Jan 2020 18:11:21 +0100
Message-Id: <20200103171131.9900-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/phy/samsung-phy.txt | 6 +++---
 drivers/phy/allwinner/phy-sun4i-usb.c                 | 2 +-
 drivers/phy/samsung/Kconfig                           | 8 ++++----
 drivers/phy/samsung/phy-exynos-dp-video.c             | 4 ++--
 drivers/phy/samsung/phy-exynos-mipi-video.c           | 4 ++--
 drivers/phy/samsung/phy-exynos-pcie.c                 | 2 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c              | 6 +++---
 drivers/phy/samsung/phy-samsung-usb2.c                | 2 +-
 8 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 1c40ccd40ce4..7510830a79bd 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -1,4 +1,4 @@
-Samsung S5P/EXYNOS SoC series MIPI CSIS/DSIM DPHY
+Samsung S5P/Exynos SoC series MIPI CSIS/DSIM DPHY
 -------------------------------------------------
 
 Required properties:
@@ -27,7 +27,7 @@ the PHY specifier identifies the PHY and its meaning is as follows:
 supports additional fifth PHY:
   4 - MIPI CSIS 2.
 
-Samsung EXYNOS SoC series Display Port PHY
+Samsung Exynos SoC series Display Port PHY
 -------------------------------------------------
 
 Required properties:
@@ -38,7 +38,7 @@ Required properties:
 		      control pmu registers for power isolation.
 - #phy-cells : from the generic PHY bindings, must be 0;
 
-Samsung S5P/EXYNOS SoC series USB PHY
+Samsung S5P/Exynos SoC series USB PHY
 -------------------------------------------------
 
 Required properties:
diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 856927382248..7e09ad6a0b42 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -7,7 +7,7 @@
  * Based on code from
  * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
  *
- * Modelled after: Samsung S5P/EXYNOS SoC series MIPI CSIS/DSIM DPHY driver
+ * Modelled after: Samsung S5P/Exynos SoC series MIPI CSIS/DSIM DPHY driver
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
  */
diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 290a6c70f570..3b39bec101b2 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -3,23 +3,23 @@
 # Phy drivers for Samsung platforms
 #
 config PHY_EXYNOS_DP_VIDEO
-	tristate "EXYNOS SoC series Display Port PHY driver"
+	tristate "Exynos SoC series Display Port PHY driver"
 	depends on OF
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	default ARCH_EXYNOS
 	select GENERIC_PHY
 	help
-	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
+	  Support for Display Port PHY found on Samsung Exynos SoCs.
 
 config PHY_EXYNOS_MIPI_VIDEO
-	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
+	tristate "S5P/Exynos SoC series MIPI CSI-2/DSI PHY driver"
 	depends on HAS_IOMEM
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select GENERIC_PHY
 	default y if ARCH_S5PV210 || ARCH_EXYNOS
 	help
 	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
-	  and EXYNOS SoCs.
+	  and Exynos SoCs.
 
 config PHY_EXYNOS_PCIE
 	bool "Exynos PCIe PHY driver"
diff --git a/drivers/phy/samsung/phy-exynos-dp-video.c b/drivers/phy/samsung/phy-exynos-dp-video.c
index 6c607df1dc9a..2b670ef91deb 100644
--- a/drivers/phy/samsung/phy-exynos-dp-video.c
+++ b/drivers/phy/samsung/phy-exynos-dp-video.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Samsung EXYNOS SoC series Display Port PHY driver
+ * Samsung Exynos SoC series Display Port PHY driver
  *
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  * Author: Jingoo Han <jg1.han@samsung.com>
@@ -115,5 +115,5 @@ static struct platform_driver exynos_dp_video_phy_driver = {
 module_platform_driver(exynos_dp_video_phy_driver);
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
-MODULE_DESCRIPTION("Samsung EXYNOS SoC DP PHY driver");
+MODULE_DESCRIPTION("Samsung Exynos SoC DP PHY driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/samsung/phy-exynos-mipi-video.c b/drivers/phy/samsung/phy-exynos-mipi-video.c
index bb51195f189f..c1df1ef3ee3c 100644
--- a/drivers/phy/samsung/phy-exynos-mipi-video.c
+++ b/drivers/phy/samsung/phy-exynos-mipi-video.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Samsung S5P/EXYNOS SoC series MIPI CSIS/DSIM DPHY driver
+ * Samsung S5P/Exynos SoC series MIPI CSIS/DSIM DPHY driver
  *
  * Copyright (C) 2013,2016 Samsung Electronics Co., Ltd.
  * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
@@ -364,6 +364,6 @@ static struct platform_driver exynos_mipi_video_phy_driver = {
 };
 module_platform_driver(exynos_mipi_video_phy_driver);
 
-MODULE_DESCRIPTION("Samsung S5P/EXYNOS SoC MIPI CSI-2/DSI PHY driver");
+MODULE_DESCRIPTION("Samsung S5P/Exynos SoC MIPI CSI-2/DSI PHY driver");
 MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 659e7ae0a6cf..7e28b1aea0d1 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Samsung EXYNOS SoC series PCIe PHY driver
+ * Samsung Exynos SoC series PCIe PHY driver
  *
  * Phy provider for PCIe controller on Exynos SoC series
  *
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index e510732afb8b..eb06ce9f748f 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Samsung EXYNOS5 SoC series USB DRD PHY driver
+ * Samsung Exynos5 SoC series USB DRD PHY driver
  *
  * Phy provider for USB 3.0 DRD controller on Exynos5 SoC series
  *
@@ -33,7 +33,7 @@
 #define EXYNOS5_FSEL_24MHZ		0x5
 #define EXYNOS5_FSEL_50MHZ		0x7
 
-/* EXYNOS5: USB 3.0 DRD PHY registers */
+/* Exynos5: USB 3.0 DRD PHY registers */
 #define EXYNOS5_DRD_LINKSYSTEM			0x04
 
 #define LINKSYSTEM_FLADJ_MASK			(0x3f << 1)
@@ -958,7 +958,7 @@ static struct platform_driver exynos5_usb3drd_phy = {
 };
 
 module_platform_driver(exynos5_usb3drd_phy);
-MODULE_DESCRIPTION("Samsung EXYNOS5 SoCs USB 3.0 DRD controller PHY driver");
+MODULE_DESCRIPTION("Samsung Exynos5 SoCs USB 3.0 DRD controller PHY driver");
 MODULE_AUTHOR("Vivek Gautam <gautam.vivek@samsung.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:exynos5_usb3drd_phy");
diff --git a/drivers/phy/samsung/phy-samsung-usb2.c b/drivers/phy/samsung/phy-samsung-usb2.c
index 090aa02e02de..a3ed3ff04690 100644
--- a/drivers/phy/samsung/phy-samsung-usb2.c
+++ b/drivers/phy/samsung/phy-samsung-usb2.c
@@ -255,7 +255,7 @@ static struct platform_driver samsung_usb2_phy_driver = {
 };
 
 module_platform_driver(samsung_usb2_phy_driver);
-MODULE_DESCRIPTION("Samsung S5P/EXYNOS SoC USB PHY driver");
+MODULE_DESCRIPTION("Samsung S5P/Exynos SoC USB PHY driver");
 MODULE_AUTHOR("Kamil Debski <k.debski@samsung.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:samsung-usb2-phy");
-- 
2.17.1

