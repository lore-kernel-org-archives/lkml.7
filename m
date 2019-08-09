Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B93C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251AB208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436469AbfHIOlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:41:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:41:37 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MV2Sk-1hmqRB0T3u-00S5Pl; Fri, 09 Aug 2019 16:41:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 01/13] usb: ohci-nxp: enable compile-testing
Date:   Fri,  9 Aug 2019 16:40:27 +0200
Message-Id: <20190809144043.476786-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AxvKy6jf+t9d21xZPdfYBHuuoe857kj7IZxWzWdJ5LgVwyC0plW
 N6v6x9Z00yOXwvoWPiV5buUcxhC7491l21ZEe9ZhO/frzZGRWBRGEtxAgjyECNA0rqmcq9k
 qAkEMP1R6koIhhI7cMjIF86JqouP/hAVmc3zysqtAlmNOiYXxl3nl9Ohf3PxuG4WFdO4T6V
 yZnJxYGQpu+NzxMGEWryA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vnpa/i6Pl7A=:Z8kSVbOHBcIByVsErk7lNg
 Wy/jyu6PzaL2faqwyCBwVD4rWeBx+r/t+GSSyMt/Fa/c6ESek2LtBW2K6fPkBtsNoM2c5lH6w
 Xe/Y0bLHLxUyhoTjzGjm8pIXTuAGKe8r1Shcr0AofFlt2GR9Gcxs/WjrU1ukmH4T+rq9UNxXJ
 yWvAzju0cr0EJk/sz/XnFL+0bX75TktvnIoGnNDu4Rtqk/fgj8YFggpH9+04/n5Ri5P3Wq+fv
 uYLmrn+hHD7QQa6VIh5SvhqRNkQaoagTJHV6QjTJ3C0KHYXjn7+Gykj1rJvUY8AWJid3N3d80
 iEAzVt2i/UhXyj84HPEgA+EapGcSXAf9v4tPZALZaUzjK0m3hpw0mvFpkSV/I+CCzQo0XWJ5t
 zwg67JeZFvVJuliDkaBW7dAeNkZN4/pRZCUpWtYH7i1gp/KMtE+PIbwwp0DI1qQJkCzYYWrsG
 v3k2P2DXqD7PP9liCvOxA5n20zC2BmudSavUt/uo1xYtKmC6u6pWsCcclLRsyxu62+Jq/z+C3
 rB5eyLzGmteCDmGPRo/Gn7a+iHO/ZqqQgtlmNhBk+b4x2y/kPLEyQ8bvI0TdL83LJceYg3VnD
 SM+d6RnIDLkimjhIVYA7H4OUQQUtH2BRFL3lcoq5x7xxau3rgbKYFgc3X5iUiRJog50xL04U/
 Jqy6JmOaWtM+3PfJmjNtWKmy+IEnztgLAEMgU4yHAGCpmYfBDdlEvfUrz7fW9lnbatFdeOjGH
 pPc0iQtZ8VZNHbm5ycRuzPfWoQxIeANRCiWZyw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver hardcodes a hardware I/O address the way one should
generally not do, and this prevents both compile-testing, and
moving the platform to CONFIG_ARCH_MULTIPLATFORM.

Change the code to be independent of the machine headers
to allow those two. Removing the hardcoded address would
be hard and is not necessary, so leave that in place for now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/Kconfig    |  3 ++-
 drivers/usb/host/ohci-nxp.c | 25 ++++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 40b5de597112..73d233d3bf4d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -441,7 +441,8 @@ config USB_OHCI_HCD_S3C2410
 
 config USB_OHCI_HCD_LPC32XX
 	tristate "Support for LPC on-chip OHCI USB controller"
-	depends on USB_OHCI_HCD && ARCH_LPC32XX
+	depends on USB_OHCI_HCD
+	depends on ARCH_LPC32XX || COMPILE_TEST
 	depends on USB_ISP1301
 	default y
 	---help---
diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index f5f532601092..c561881d0e79 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -29,10 +29,7 @@
 
 #include "ohci.h"
 
-#include <mach/hardware.h>
-
 #define USB_CONFIG_BASE		0x31020000
-#define USB_OTG_STAT_CONTROL	IO_ADDRESS(USB_CONFIG_BASE + 0x110)
 
 /* USB_OTG_STAT_CONTROL bit defines */
 #define TRANSPARENT_I2C_EN	(1 << 7)
@@ -122,19 +119,33 @@ static inline void isp1301_vbus_off(void)
 
 static void ohci_nxp_start_hc(void)
 {
-	unsigned long tmp = __raw_readl(USB_OTG_STAT_CONTROL) | HOST_EN;
+	void __iomem *usb_otg_stat_control = ioremap(USB_CONFIG_BASE + 0x110, 4);
+	unsigned long tmp;
+
+	if (WARN_ON(!usb_otg_stat_control))
+		return;
+
+	tmp = __raw_readl(usb_otg_stat_control) | HOST_EN;
 
-	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
+	__raw_writel(tmp, usb_otg_stat_control);
 	isp1301_vbus_on();
+
+	iounmap(usb_otg_stat_control);
 }
 
 static void ohci_nxp_stop_hc(void)
 {
+	void __iomem *usb_otg_stat_control = ioremap(USB_CONFIG_BASE + 0x110, 4);
 	unsigned long tmp;
 
+	if (WARN_ON(!usb_otg_stat_control))
+		return;
+
 	isp1301_vbus_off();
-	tmp = __raw_readl(USB_OTG_STAT_CONTROL) & ~HOST_EN;
-	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
+	tmp = __raw_readl(usb_otg_stat_control) & ~HOST_EN;
+	__raw_writel(tmp, usb_otg_stat_control);
+
+	iounmap(usb_otg_stat_control);
 }
 
 static int ohci_hcd_nxp_probe(struct platform_device *pdev)
-- 
2.20.0

