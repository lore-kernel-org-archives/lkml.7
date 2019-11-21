Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A985FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279B20715
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574342957;
	bh=oEF0TfEmI5WbhcAKUDT9nBHfxFGfK9gs2w7wsiab6Iw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bMEBoiz12haRksPn+Z0OIbS4uD3lRFsS3jWjwPiaEFPrfdHPHcWZEPmvHuiCHsbIs
	 QqsuddBL+x7Q5tNxkUQIHTcVJ/TNwX9NUQ4+/sIjeG70U579tCgYEZptmphlbJ8R7R
	 fF7qQgSirxaSBioxOdvslQSZ85n82+C1uGvV9qOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKUN3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfKUN3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:15 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B061E20715;
        Thu, 21 Nov 2019 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342953;
        bh=oEF0TfEmI5WbhcAKUDT9nBHfxFGfK9gs2w7wsiab6Iw=;
        h=From:To:Cc:Subject:Date:From;
        b=MIZ/vWIUBRhsqvyiX0JpG5JLd/5n9l5z5vfX/MJMMfa4NiLFCUig6mCSlFZu2nW1T
         YfKrrlrozHBWOMZOU4pu7AEIe6u/1a3cYNbb1MhaMQn9LYqIVu9GJrftipIjxa1HOb
         SBquITR8Z3thHnCcXYGnVYxA6pwVGd3dwDHXbn7Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: host: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:29:10 +0800
Message-Id: <20191121132910.29310-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/host/Kconfig | 50 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d6164ede63d3..8d730180db06 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -38,9 +38,9 @@ config USB_XHCI_DBGCAP
 	  before enabling this option. If unsure, say 'N'.
 
 config USB_XHCI_PCI
-       tristate
-       depends on USB_PCI
-       default y
+	tristate
+	depends on USB_PCI
+	default y
 
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
@@ -245,13 +245,13 @@ config USB_EHCI_HCD_AT91
 	  Atmel chips.
 
 config USB_EHCI_TEGRA
-       tristate "NVIDIA Tegra HCD support"
-       depends on ARCH_TEGRA
-       select USB_EHCI_ROOT_HUB_TT
-       select USB_TEGRA_PHY
-       help
-	 This driver enables support for the internal USB Host Controllers
-	 found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
+	tristate "NVIDIA Tegra HCD support"
+	depends on ARCH_TEGRA
+	select USB_EHCI_ROOT_HUB_TT
+	select USB_TEGRA_PHY
+	help
+	  This driver enables support for the internal USB Host Controllers
+	  found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
 
 config USB_EHCI_HCD_PPC_OF
 	bool "EHCI support for PPC USB controller on OF platform bus"
@@ -269,10 +269,10 @@ config USB_EHCI_SH
 	  If you use the PCI EHCI controller, this option is not necessary.
 
 config USB_EHCI_EXYNOS
-       tristate "EHCI support for Samsung S5P/EXYNOS SoC Series"
-       depends on ARCH_S5PV210 || ARCH_EXYNOS
-       help
-	Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
+	tristate "EHCI support for Samsung S5P/EXYNOS SoC Series"
+	depends on ARCH_S5PV210 || ARCH_EXYNOS
+	help
+	  Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
 
 config USB_EHCI_MV
 	tristate "EHCI support for Marvell PXA/MMP USB controller"
@@ -545,7 +545,7 @@ config USB_OHCI_EXYNOS
 	tristate "OHCI support for Samsung S5P/EXYNOS SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS
 	help
-	 Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
+	  Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
 
 config USB_CNS3XXX_OHCI
 	bool "Cavium CNS3XXX OHCI Module (DEPRECATED)"
@@ -609,8 +609,8 @@ config USB_UHCI_PLATFORM
 	default y if (ARCH_VT8500 || ARCH_ASPEED)
 
 config USB_UHCI_ASPEED
-       bool
-       default y if ARCH_ASPEED
+	bool
+	default y if ARCH_ASPEED
 
 config USB_FHCI_HCD
 	tristate "Freescale QE USB Host Controller support"
@@ -713,14 +713,14 @@ config USB_RENESAS_USBHS_HCD
 	  module will be called renesas-usbhs.
 
 config USB_IMX21_HCD
-       tristate "i.MX21 HCD support"
-       depends on ARM && ARCH_MXC
-       help
-	 This driver enables support for the on-chip USB host in the
-	 i.MX21 processor.
-
-	 To compile this driver as a module, choose M here: the
-	 module will be called "imx21-hcd".
+	tristate "i.MX21 HCD support"
+	depends on ARM && ARCH_MXC
+	help
+	  This driver enables support for the on-chip USB host in the
+	  i.MX21 processor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called "imx21-hcd".
 
 config USB_HCD_BCMA
 	tristate "BCMA usb host driver"
-- 
2.17.1

