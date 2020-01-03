Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8274B215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071548;
	bh=tikjmOkXzl67kgxwPdvLRaRJqpldgktGgrS2H4m1wPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Jxngl5pf+SBOYqWSi7MiIILCSKjUy6AfzIew2PxofV0pAgO5fO8Cl7zPcRRVNZNF
	 ufem02P7pv6IEG3b/Utp/8527DidjmNwWg/wpA6bwoElGqel+AK56Er73YlKiBnn7O
	 GFQtJ3cZH8qyVa6sqD/aHN1mlr7cPbTalCW8sPRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgACRM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgACRMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:12:23 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02A4222C3;
        Fri,  3 Jan 2020 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071542;
        bh=tikjmOkXzl67kgxwPdvLRaRJqpldgktGgrS2H4m1wPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8E9zX4UIDLzAd5zOxAsedGIcpvNFV5QzvrJO9liwyDUdG5pRAfWIR/WCSA7Dazjh
         YqU2FZ0UlUVfA9KpckU7TXkL0418Ra24J7/qwELuAIJG5kF7NmcO4E6zBi+TC9BXUR
         q/jTgkFKzInc7v4lKvkcNEXn4bJMnx+aH14vSPgY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 07/19] usb: exynos: Rename Samsung and Exynos to lowercase
Date:   Fri,  3 Jan 2020 18:11:19 +0100
Message-Id: <20200103171131.9900-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
and "Exynos" names.

"SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
names.  Therefore they should be written with lowercase letters starting
with capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/dwc3/dwc3-exynos.c | 4 ++--
 drivers/usb/host/Kconfig       | 4 ++--
 drivers/usb/host/ehci-exynos.c | 4 ++--
 drivers/usb/host/ohci-exynos.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index c1e9ea621f41..90bb022737da 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /**
- * dwc3-exynos.c - Samsung EXYNOS DWC3 Specific Glue layer
+ * dwc3-exynos.c - Samsung Exynos DWC3 Specific Glue layer
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -255,4 +255,4 @@ module_platform_driver(dwc3_exynos_driver);
 
 MODULE_AUTHOR("Anton Tikhomirov <av.tikhomirov@samsung.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("DesignWare USB3 EXYNOS Glue Layer");
+MODULE_DESCRIPTION("DesignWare USB3 Exynos Glue Layer");
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8d730180db06..ed49d08f2f9e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -269,7 +269,7 @@ config USB_EHCI_SH
 	  If you use the PCI EHCI controller, this option is not necessary.
 
 config USB_EHCI_EXYNOS
-	tristate "EHCI support for Samsung S5P/EXYNOS SoC Series"
+	tristate "EHCI support for Samsung S5P/Exynos SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS
 	help
 	  Enable support for the Samsung Exynos SOC's on-chip EHCI controller.
@@ -542,7 +542,7 @@ config USB_OHCI_SH
 	  If you use the PCI OHCI controller, this option is not necessary.
 
 config USB_OHCI_EXYNOS
-	tristate "OHCI support for Samsung S5P/EXYNOS SoC Series"
+	tristate "OHCI support for Samsung S5P/Exynos SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS
 	help
 	  Enable support for the Samsung Exynos SOC's on-chip OHCI controller.
diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 01debfd03d4a..a4e9abcbdc4f 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * SAMSUNG EXYNOS USB HOST EHCI Controller
+ * Samsung Exynos USB HOST EHCI Controller
  *
  * Copyright (C) 2011 Samsung Electronics Co.Ltd
  * Author: Jingoo Han <jg1.han@samsung.com>
@@ -21,7 +21,7 @@
 
 #include "ehci.h"
 
-#define DRIVER_DESC "EHCI EXYNOS driver"
+#define DRIVER_DESC "EHCI Exynos driver"
 
 #define EHCI_INSNREG00(base)			(base + 0x90)
 #define EHCI_INSNREG00_ENA_INCR16		(0x1 << 25)
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index d5ce98e205c7..bd40e597f256 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -19,7 +19,7 @@
 
 #include "ohci.h"
 
-#define DRIVER_DESC "OHCI EXYNOS driver"
+#define DRIVER_DESC "OHCI Exynos driver"
 
 static const char hcd_name[] = "ohci-exynos";
 static struct hc_driver __read_mostly exynos_ohci_hc_driver;
-- 
2.17.1

