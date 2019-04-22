Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04933C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA05320652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939924;
	bh=H7cb+Qr6SlB0fVVMYdapquNKMCRBYuhyfC6taE5EGic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TvUMf9aHzqz3ypKnm4wcZA5ui66o9LYfRB6xYpE5A7Q1Li45xrSEmBeauIiOn+yz3
	 7ReI/DbVnTlNhisVpkS3WSaoWkMDaMQRH/wAzjP45SCNxoN06JsX/3DdC2P3GS4tRq
	 432Ef3iNgmxY/n4tSFQfV0rQ4mam0WtoYw/2DATc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfDVNcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:32:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfDVN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qjzvHIEbJD5Q3KxFQzG3t21Lmz+5nSk8H9G5j1H5Eqo=; b=kKLCXNSVDRlCWHwPx8/C9mBOCE
        wte+zz30OaUdr+FOTGA/FD+YWui8VWFgE+3og2oIaAvr6hkBbGGRo37YNVWr/MUCnRooe19Nmq1Sb
        sBfLYxruZKCS0Biv0JyCilC/r16jggLNo1coJWiQJjONFgeJuEWH8zcaD2BM9MC4gNSSmPQdx52Gf
        2+gTBP1PdmvUG3duwYJePzJBSyig6+csL9dBtbXYbjpRrh5EzNVMbwwh8MWrhQGzav6wTjMHmtzAz
        M8yrEAuxGAZ9/pKmP9ItPlOY4BXOBIid+3MntgrsTaIXJ1u8/z88/53m6n1+N6IL8bMmPqVYaxSii
        ANxmW2Kw==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzc-0005Hh-2E; Mon, 22 Apr 2019 13:28:20 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzT-0005np-SR; Mon, 22 Apr 2019 10:28:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 54/79] docs: phy: convert samsung-usb2.txt to ReST format
Date:   Mon, 22 Apr 2019 10:27:43 -0300
Message-Id: <f514497d70f22ef6b2002138c9a3d99210bc1d74.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to merge it into a Sphinx book, we need first to
convert to ReST.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.


Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{samsung-usb2.txt => samsung-usb2.rst}    | 62 ++++++++++---------
 MAINTAINERS                                   |  2 +-
 2 files changed, 34 insertions(+), 30 deletions(-)
 rename Documentation/phy/{samsung-usb2.txt => samsung-usb2.rst} (77%)

diff --git a/Documentation/phy/samsung-usb2.txt b/Documentation/phy/samsung-usb2.rst
similarity index 77%
rename from Documentation/phy/samsung-usb2.txt
rename to Documentation/phy/samsung-usb2.rst
index ed12d437189d..98b5952fcb97 100644
--- a/Documentation/phy/samsung-usb2.txt
+++ b/Documentation/phy/samsung-usb2.rst
@@ -1,9 +1,11 @@
-.------------------------------------------------------------------------------+
-|			Samsung USB 2.0 PHY adaptation layer		       |
-+-----------------------------------------------------------------------------+'
+:orphan:
 
-| 1. Description
-+----------------
+====================================
+Samsung USB 2.0 PHY adaptation layer
+====================================
+
+1. Description
+--------------
 
 The architecture of the USB 2.0 PHY module in Samsung SoCs is similar
 among many SoCs. In spite of the similarities it proved difficult to
@@ -14,8 +16,8 @@ the PHY powering up process had to be altered. This adaptation layer is
 a compromise between having separate drivers and having a single driver
 with added support for many special cases.
 
-| 2. Files description
-+----------------------
+2. Files description
+--------------------
 
 - phy-samsung-usb2.c
    This is the main file of the adaptation layer. This file contains
@@ -32,44 +34,45 @@ with added support for many special cases.
    driver. In addition it should contain extern declarations for
    structures that describe particular SoCs.
 
-| 3. Supporting SoCs
-+--------------------
+3. Supporting SoCs
+------------------
 
 To support a new SoC a new file should be added to the drivers/phy
 directory. Each SoC's configuration is stored in an instance of the
-struct samsung_usb2_phy_config.
+struct samsung_usb2_phy_config::
 
-struct samsung_usb2_phy_config {
+  struct samsung_usb2_phy_config {
 	const struct samsung_usb2_common_phy *phys;
 	int (*rate_to_clk)(unsigned long, u32 *);
 	unsigned int num_phys;
 	bool has_mode_switch;
-};
+  };
 
-The num_phys is the number of phys handled by the driver. *phys is an
+The num_phys is the number of phys handled by the driver. `*phys` is an
 array that contains the configuration for each phy. The has_mode_switch
 property is a boolean flag that determines whether the SoC has USB host
 and device on a single pair of pins. If so, a special register has to
 be modified to change the internal routing of these pins between a USB
 device or host module.
 
-For example the configuration for Exynos 4210 is following:
+For example the configuration for Exynos 4210 is following::
 
-const struct samsung_usb2_phy_config exynos4210_usb2_phy_config = {
+  const struct samsung_usb2_phy_config exynos4210_usb2_phy_config = {
 	.has_mode_switch        = 0,
 	.num_phys		= EXYNOS4210_NUM_PHYS,
 	.phys			= exynos4210_phys,
 	.rate_to_clk		= exynos4210_rate_to_clk,
-}
+  }
+
+- `int (*rate_to_clk)(unsigned long, u32 *)`
 
-- int (*rate_to_clk)(unsigned long, u32 *)
 	The rate_to_clk callback is to convert the rate of the clock
 	used as the reference clock for the PHY module to the value
 	that should be written in the hardware register.
 
-The exynos4210_phys configuration array is as follows:
+The exynos4210_phys configuration array is as follows::
 
-static const struct samsung_usb2_common_phy exynos4210_phys[] = {
+  static const struct samsung_usb2_common_phy exynos4210_phys[] = {
 	{
 		.label		= "device",
 		.id		= EXYNOS4210_DEVICE,
@@ -95,29 +98,30 @@ static const struct samsung_usb2_common_phy exynos4210_phys[] = {
 		.power_off	= exynos4210_power_off,
 	},
 	{},
-};
+  };
+
+- `int (*power_on)(struct samsung_usb2_phy_instance *);`
+  `int (*power_off)(struct samsung_usb2_phy_instance *);`
 
-- int (*power_on)(struct samsung_usb2_phy_instance *);
-- int (*power_off)(struct samsung_usb2_phy_instance *);
 	These two callbacks are used to power on and power off the phy
 	by modifying appropriate registers.
 
 Final change to the driver is adding appropriate compatible value to the
 phy-samsung-usb2.c file. In case of Exynos 4210 the following lines were
-added to the struct of_device_id samsung_usb2_phy_of_match[] array:
+added to the struct of_device_id samsung_usb2_phy_of_match[] array::
 
-#ifdef CONFIG_PHY_EXYNOS4210_USB2
+  #ifdef CONFIG_PHY_EXYNOS4210_USB2
 	{
 		.compatible = "samsung,exynos4210-usb2-phy",
 		.data = &exynos4210_usb2_phy_config,
 	},
-#endif
+  #endif
 
 To add further flexibility to the driver the Kconfig file enables to
 include support for selected SoCs in the compiled driver. The Kconfig
-entry for Exynos 4210 is following:
+entry for Exynos 4210 is following::
 
-config PHY_EXYNOS4210_USB2
+  config PHY_EXYNOS4210_USB2
 	bool "Support for Exynos 4210"
 	depends on PHY_SAMSUNG_USB2
 	depends on CPU_EXYNOS4210
@@ -128,8 +132,8 @@ config PHY_EXYNOS4210_USB2
 	  phys are available - device, host, HSCI0 and HSCI1.
 
 The newly created file that supports the new SoC has to be also added to the
-Makefile. In case of Exynos 4210 the added line is following:
+Makefile. In case of Exynos 4210 the added line is following::
 
-obj-$(CONFIG_PHY_EXYNOS4210_USB2)       += phy-exynos4210-usb2.o
+  obj-$(CONFIG_PHY_EXYNOS4210_USB2)       += phy-exynos4210-usb2.o
 
 After completing these steps the support for the new SoC should be ready.
diff --git a/MAINTAINERS b/MAINTAINERS
index 10cac0512711..9c99c5f47381 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13783,7 +13783,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/phy/samsung-phy.txt
-F:	Documentation/phy/samsung-usb2.txt
+F:	Documentation/phy/samsung-usb2.rst
 F:	drivers/phy/samsung/phy-exynos4210-usb2.c
 F:	drivers/phy/samsung/phy-exynos4x12-usb2.c
 F:	drivers/phy/samsung/phy-exynos5250-usb2.c
-- 
2.20.1

