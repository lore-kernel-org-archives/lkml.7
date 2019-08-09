Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A86AC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48037217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfHIU3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:29:14 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfHIU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:29:13 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MuluN-1iDqgZ18F9-00rrQN; Fri, 09 Aug 2019 22:29:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 15/16] usb: remove ehci-w90x900 driver
Date:   Fri,  9 Aug 2019 22:27:43 +0200
Message-Id: <20190809202749.742267-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809202749.742267-1-arnd@arndb.de>
References: <20190809202749.742267-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wPb76nKdF5ukUOXyjS8AZRENduOC7LpgNPFvMuock5ZAhYRqQao
 gvKLPV1umWtIhcVdiLRa0DoIQV/OCyejR4JycbIVVOZHIjlNDDyMW9SvIPThUT9kg9EZ/KS
 sz1mPeOFO52p033XspngdYSQSIKfCFpDqhzxuG4VGoq0IQw7eh5HIEXCtDtSNZeKVZW1Rpc
 eif2zt/I1wUHaS+eVsdag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:krqIrxD/H+I=:F0XIUeNMJNSMKpdBEraPd+
 wszOmk23slJ2+EFaf9xDGvXs57+uug+Uyr7YOcF3PNTX5tqBgn7APWopxEH+8J9jQBE3Rhp1t
 UG0BNlUNayakZ4x1JGMqAAjXTtnpahPPQoLiDNZidHFcFc8aZdMkq0TL7JhR5HOw0ImnJi/ni
 Xh6oRwgnKwlmvvzHLUiEaGZbtXHzqPArI33vUB3wL/Iq9sppHdDFSxFTjrFjXVF3dkxr80Vqv
 OxeSWBikJpauDwvpJ10v7/NBP9pejfOLlWS6WZEarELZsIkOQpoporUE21dpD4mG3ny90amFO
 O8oSeWGL1jdnbI9VEXaeJkB+qj6wX98bRFv2xE2m/3h3cX97RtV400NDMonaXl5Aig5Z28AJX
 ZBH4Es7pvN+xwpivDxi4IFPqsL63OZvcd5Qq1MFVpJXzacsQ0jRa3vq8rvPXqqZ+KSRaUuTFw
 DMDC7ec8gQODBg7wJRM5i70y9+5dPVtcse7JkfVbJjjUZZCFL/+3Z9oMjY2QY8w96ug7a+Rhg
 fT3w7OpFnSP7zxbQhVcyXj2uBlue4r7RpWloUni61z9cgFUrCywgvNUzLSWImzU1SdExHLF3e
 +d6reW7nUJJX42K96EQ1vbfjtIkZ+D2u2z17itfY5PwP02JvjFrG93xPGS+hrDmDLiFxwWdVN
 wuW5q+zgLDwFiO9p61bkj/4T1fzDed83ty6e8lAYJh6dL3SiYnsKVTD2Af6bggiPd4lw5glnH
 ugqB7yHhWupiqsW2gfCNIj1BZOlQcLZGPyxpbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM w90x900 platform is getting removed, so this driver is obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/Kconfig        |   6 --
 drivers/usb/host/Makefile       |   1 -
 drivers/usb/host/ehci-w90x900.c | 130 --------------------------------
 3 files changed, 137 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-w90x900.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 40b5de597112..782ead054a90 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -287,12 +287,6 @@ config USB_EHCI_MV
 	  Dova, Armada 370 and Armada XP. See "Support for Marvell EBU
 	  on-chip EHCI USB controller" for those.
 
-config USB_W90X900_EHCI
-	tristate "W90X900(W90P910) EHCI support"
-	depends on ARCH_W90X900
-	---help---
-		Enables support for the W90X900 USB controller
-
 config USB_CNS3XXX_EHCI
 	bool "Cavium CNS3XXX EHCI Module (DEPRECATED)"
 	depends on ARCH_CNS3XXX
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 84514f71ae44..0bba93de7654 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -51,7 +51,6 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)	+= ehci-st.o
 obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
 obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 obj-$(CONFIG_USB_EHCI_TEGRA)	+= ehci-tegra.o
-obj-$(CONFIG_USB_W90X900_EHCI)	+= ehci-w90x900.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
diff --git a/drivers/usb/host/ehci-w90x900.c b/drivers/usb/host/ehci-w90x900.c
deleted file mode 100644
index 6d77ace1697b..000000000000
--- a/drivers/usb/host/ehci-w90x900.c
+++ /dev/null
@@ -1,130 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/driver/usb/host/ehci-w90x900.c
- *
- * Copyright (c) 2008 Nuvoton technology corporation.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/usb.h>
-#include <linux/usb/hcd.h>
-
-#include "ehci.h"
-
-/* enable phy0 and phy1 for w90p910 */
-#define	ENPHY		(0x01<<8)
-#define PHY0_CTR	(0xA4)
-#define PHY1_CTR	(0xA8)
-
-#define DRIVER_DESC "EHCI w90x900 driver"
-
-static const char hcd_name[] = "ehci-w90x900 ";
-
-static struct hc_driver __read_mostly ehci_w90x900_hc_driver;
-
-static int ehci_w90x900_probe(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd;
-	struct ehci_hcd *ehci;
-	struct resource *res;
-	int retval = 0, irq;
-	unsigned long val;
-
-	hcd = usb_create_hcd(&ehci_w90x900_hc_driver,
-			&pdev->dev, "w90x900 EHCI");
-	if (!hcd) {
-		retval = -ENOMEM;
-		goto err1;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hcd->regs)) {
-		retval = PTR_ERR(hcd->regs);
-		goto err2;
-	}
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = resource_size(res);
-
-	ehci = hcd_to_ehci(hcd);
-	ehci->caps = hcd->regs;
-	ehci->regs = hcd->regs +
-		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
-
-	/* enable PHY 0,1,the regs only apply to w90p910
-	 *  0xA4,0xA8 were offsets of PHY0 and PHY1 controller of
-	 *  w90p910 IC relative to ehci->regs.
-	 */
-	val = __raw_readl(ehci->regs+PHY0_CTR);
-	val |= ENPHY;
-	__raw_writel(val, ehci->regs+PHY0_CTR);
-
-	val = __raw_readl(ehci->regs+PHY1_CTR);
-	val |= ENPHY;
-	__raw_writel(val, ehci->regs+PHY1_CTR);
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		retval = irq;
-		goto err2;
-	}
-
-	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
-	if (retval != 0)
-		goto err2;
-
-	device_wakeup_enable(hcd->self.controller);
-	return retval;
-err2:
-	usb_put_hcd(hcd);
-err1:
-	return retval;
-}
-
-static int ehci_w90x900_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_remove_hcd(hcd);
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-static struct platform_driver ehci_hcd_w90x900_driver = {
-	.probe  = ehci_w90x900_probe,
-	.remove = ehci_w90x900_remove,
-	.driver = {
-		.name = "w90x900-ehci",
-	},
-};
-
-static int __init ehci_w90X900_init(void)
-{
-	if (usb_disabled())
-		return -ENODEV;
-
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
-	ehci_init_driver(&ehci_w90x900_hc_driver, NULL);
-	return platform_driver_register(&ehci_hcd_w90x900_driver);
-}
-module_init(ehci_w90X900_init);
-
-static void __exit ehci_w90X900_cleanup(void)
-{
-	platform_driver_unregister(&ehci_hcd_w90x900_driver);
-}
-module_exit(ehci_w90X900_cleanup);
-
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
-MODULE_ALIAS("platform:w90p910-ehci");
-MODULE_LICENSE("GPL v2");
-- 
2.20.0

