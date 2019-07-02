Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF19AC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760602173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cxtqcHWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGBJlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:41:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:53553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfGBJlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562060458;
        bh=P78rL3Ld2zVHKNP51vJ5yxaFpjg+8kHYhm1mASieWfo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cxtqcHWW8BKBfk5Ohh9Shxx0GsuKswn85+c2dXMLoN7+SgO/iMclX94FZ21BpEpPU
         PL5lm9zKNBrOHQpFk5GojDrUEHBwPsYUUa/P8wZsgO38vKbh30Ne4M+VTqWCHScHxM
         xM5VdpI4Pin4fg88UGsjq28wcQ4g1D9BRQ1weqVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.147.59]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MdefJ-1iHJ3D0quX-00ZgaA; Tue, 02 Jul 2019 11:40:58 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Josef Friedl <josef.friedl@speed.at>
Subject: [PATCH 3/3] add driver and MAINTAINERS for poweroff
Date:   Tue,  2 Jul 2019 11:40:45 +0200
Message-Id: <20190702094045.3652-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702094045.3652-1-frank-w@public-files.de>
References: <20190702094045.3652-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:6FmA4arq4ZzpiAobLjMPQOA6UtycJ2Yp9uDqjSKL0F1XwQyhxZV
 o3Zj4Q4+na5rZtIAKS34Ir22r/3iV6tcpvT1Yte+gGd17xGVUxzysG8nQA37Dl1XrdsuVF2
 vXmRR8wuUzpvqkRyCv7MYJIootWmgi4qdRlyPn9PttDfI9ygAkPzQfXD6dp+8i2/ZC5ULvF
 KhxzfZRd7Dazs/53UHjRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wsHrJiLhzcY=:43YkmyE05ntG7JmOQ7Y/Qk
 ND5H8cXwUfbAK5DK/eBjq3Qvj4zJYAomi1aE2ODxArk5cVyFNQ7e7R6BdubNZ0Qj4zHHcpBZD
 SeJuEKrWByU4u8qKQUqBHj8+QhkbxMh/A6WkESosw1WyRZOpLCdhjp/GTYdgja1XkfSEBRCD4
 T53brgE4dWiRkkkNaZkXeUSmJ3JWmKTfiJENvfBP612SBHEzMD0wJGFXyxe2JFiX46lTI8Ui/
 2NSuc5eVuu8ZpOHOHJ0ly8tHpLBsWMPoTWrm3mbKOlFu9j/VJ26Ynd+VfVFNh3yb54X2qwjRI
 mpKl9YHeJ2OfmDNaBhRCV8/iah0Yt2z0Pn9pdlazvIR6pzXsE5J/V0i4Xx6EmOKHGb/Gl3mkd
 zDf6+2yO9fxTPumwIcTm0MBCWdtIvujEYrojPqMrOg/dxu7IYAJUKBnncDS9Zw5wgCaaEZySi
 kc3WEhO0Ff+K8jU7UObsIE1rqq+p+XaXGfzDE3mRCqDbO62KRM+rK6gD5/u+vBcxBySDLC6qm
 THS2L/b3NKBnBjAZ4oesT5cNyypTlWI7LuK63vFpZQG/NZeuY5m02F4sGBB3SQGCYVfdPUlqe
 tIrUr4yRlAgwYUEhHkwjQBjCYFbKN0BnrdRMMPE/14hbiFqZJBpMteP9OyJYRPeWyczGTHzvN
 eKHFw/2Mb2UWLR5GN3aK/JHVorxjK4GgkIVSkJ8+4MWE5Z8li9EKBt3axWKUtFuqHwPc4gd0r
 4hmonUtn/A0+PwwD5PlS5LVzW3Fz9/LOndyYx6pxS5rlJKorpfXVYUECjeYuyPN3zoRXp2dLr
 lNbYxvWusi5IfubbULvtqWeJNo82Npl7fm6t/SNQuIKjlxY2HcUChyVncpWyl7GMEgt5DhEPn
 KDfWAxdOBeDjKT75fn+x+ewXIbv6XwJx8l9vlqZobQ/uSoW/XHtI+7Z0WVpbSWN257VTjkbn3
 S5/dyX0xMZ5VW5sTMvMhZlihc0Mtgb2oxzG2/4Lu6Ch5HfzD0RoCnaeOprfDvy+qgyPf+j2sP
 l0ijEIUik1V/H0rWHRLc6cidd4xWQbXJf60+C6tU+eZUkMU6uSY74wwVlFmwOzjg12a1feLPS
 gldbKDCqBPqQBk=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

poweroff for BPI-R2
Suggested-by: Frank Wunderlich <frank-w@public-files.de>

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
=2D--
 MAINTAINERS                           |   1 +
 drivers/mfd/mt6397-core.c             |  40 +++++++---
 drivers/power/reset/Kconfig           |  10 +++
 drivers/power/reset/Makefile          |   1 +
 drivers/power/reset/mt6323-poweroff.c |  97 +++++++++++++++++++++++
 drivers/rtc/rtc-mt6397.c              | 110 ++++++--------------------
 include/linux/mfd/mt6397/core.h       |   2 +
 include/linux/mfd/mt6397/rtc.h        |  71 +++++++++++++++++
 8 files changed, 234 insertions(+), 98 deletions(-)
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ec6ff342aa3c..31c1e882b7d2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9925,6 +9925,7 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
+F:	drivers/power/reset/mt6323-poweroff.c

 MEDIATEK JPEG DRIVER
 M:	Rick Chang <rick.chang@mediatek.com>
diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 337bcccdb914..a4abce00f156 100644
=2D-- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2014-2018 MediaTek Inc.
  * Author: Flora Fu, MediaTek
  */

 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -15,24 +16,27 @@
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6323/registers.h>

+#define MT6323_RTC_BASE		0x8000
+#define MT6323_RTC_SIZE		0x40
+
 #define MT6397_RTC_BASE		0xe000
 #define MT6397_RTC_SIZE		0x3e

+#define MT6323_PWRC_BASE	0x8000
+#define MT6323_PWRC_SIZE	0x40
+
 #define MT6323_CID_CODE		0x23
 #define MT6391_CID_CODE		0x91
 #define MT6397_CID_CODE		0x97

+static const struct resource mt6323_rtc_resources[] =3D {
+	DEFINE_RES_MEM(MT6323_RTC_BASE, MT6323_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_RTC),
+};
+
 static const struct resource mt6397_rtc_resources[] =3D {
-	{
-		.start =3D MT6397_RTC_BASE,
-		.end   =3D MT6397_RTC_BASE + MT6397_RTC_SIZE,
-		.flags =3D IORESOURCE_MEM,
-	},
-	{
-		.start =3D MT6397_IRQ_RTC,
-		.end   =3D MT6397_IRQ_RTC,
-		.flags =3D IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(MT6397_RTC_BASE, MT6397_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
 };

 static const struct resource mt6323_keys_resources[] =3D {
@@ -45,8 +49,17 @@ static const struct resource mt6397_keys_resources[] =
=3D {
 	DEFINE_RES_IRQ(MT6397_IRQ_HOMEKEY),
 };

+static const struct resource mt6323_pwrc_resources[] =3D {
+	DEFINE_RES_MEM(MT6323_PWRC_BASE, MT6323_PWRC_SIZE),
+};
+
 static const struct mfd_cell mt6323_devs[] =3D {
 	{
+		.name =3D "mt6323-rtc",
+		.num_resources =3D ARRAY_SIZE(mt6323_rtc_resources),
+		.resources =3D mt6323_rtc_resources,
+		.of_compatible =3D "mediatek,mt6323-rtc",
+	}, {
 		.name =3D "mt6323-regulator",
 		.of_compatible =3D "mediatek,mt6323-regulator"
 	}, {
@@ -57,6 +70,11 @@ static const struct mfd_cell mt6323_devs[] =3D {
 		.num_resources =3D ARRAY_SIZE(mt6323_keys_resources),
 		.resources =3D mt6323_keys_resources,
 		.of_compatible =3D "mediatek,mt6323-keys"
+	}, {
+		.name =3D "mt6323-pwrc",
+		.num_resources =3D ARRAY_SIZE(mt6323_pwrc_resources),
+		.resources =3D mt6323_pwrc_resources,
+		.of_compatible =3D "mediatek,mt6323-pwrc"
 	},
 };

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 980951dff834..492678e22088 100644
=2D-- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -140,6 +140,16 @@ config POWER_RESET_LTC2952
 	  This driver supports an external powerdown trigger and board power
 	  down via the LTC2952. Bindings are made in the device tree.

+config POWER_RESET_MT6323
+       bool "MediaTek MT6323 power-off driver"
+       depends on MFD_MT6397
+       help
+         The power-off driver is responsible for externally shutdown down
+         the power of a remote MediaTek SoC MT6323 is connected to throug=
h
+         controlling a tiny circuit BBPU inside MT6323 RTC.
+
+         Say Y if you have a board where MT6323 could be found.
+
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
 	depends on OF_GPIO && PLAT_ORION
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0aebee954ac1..94eaceb01d66 100644
=2D-- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
 obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
 obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/m=
t6323-poweroff.c
new file mode 100644
index 000000000000..1caf43d9e46d
=2D-- /dev/null
+++ b/drivers/power/reset/mt6323-poweroff.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Power off through MediaTek PMIC
+ *
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6397/rtc.h>
+
+struct mt6323_pwrc {
+	struct device *dev;
+	struct regmap *regmap;
+	u32 base;
+};
+
+static struct mt6323_pwrc *mt_pwrc;
+
+static void mt6323_do_pwroff(void)
+{
+	struct mt6323_pwrc *pwrc =3D mt_pwrc;
+	unsigned int val;
+	int ret;
+
+	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
+	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
+
+	ret =3D regmap_read_poll_timeout(pwrc->regmap,
+					pwrc->base + RTC_BBPU, val,
+					!(val & RTC_BBPU_CBUSY),
+					MTK_RTC_POLL_DELAY_US,
+					MTK_RTC_POLL_TIMEOUT);
+	if (ret)
+		dev_err(pwrc->dev, "failed to write BBPU: %d\n", ret);
+
+	/* Wait some time until system down, otherwise, notice with a warn */
+	mdelay(1000);
+
+	WARN_ONCE(1, "Unable to power off system\n");
+}
+
+static int mt6323_pwrc_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6397_chip =3D dev_get_drvdata(pdev->dev.parent);
+	struct mt6323_pwrc *pwrc;
+	struct resource *res;
+
+	pwrc =3D devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
+	if (!pwrc)
+		return -ENOMEM;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwrc->base =3D res->start;
+	pwrc->regmap =3D mt6397_chip->regmap;
+	pwrc->dev =3D &pdev->dev;
+	mt_pwrc =3D pwrc;
+
+	pm_power_off =3D &mt6323_do_pwroff;
+
+	return 0;
+}
+
+static int mt6323_pwrc_remove(struct platform_device *pdev)
+{
+	if (pm_power_off =3D=3D &mt6323_do_pwroff)
+		pm_power_off =3D NULL;
+
+	return 0;
+}
+
+static const struct of_device_id mt6323_pwrc_dt_match[] =3D {
+	{ .compatible =3D "mediatek,mt6323-pwrc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
+
+static struct platform_driver mt6323_pwrc_driver =3D {
+	.probe          =3D mt6323_pwrc_probe,
+	.remove         =3D mt6323_pwrc_remove,
+	.driver         =3D {
+		.name   =3D "mt6323-pwrc",
+		.of_match_table =3D mt6323_pwrc_dt_match,
+	},
+};
+
+module_platform_driver(mt6323_pwrc_driver);
+
+MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index b46ed4dc7015..e5ddf0d0b6f1 100644
=2D-- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -4,69 +4,19 @@
 * Author: Tianping.Fang <tianping.fang@mediatek.com>
 */

-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/irqdomain.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/mfd/mt6397/core.h>
-
-#define RTC_BBPU		0x0000
-#define RTC_BBPU_CBUSY		BIT(6)
-
-#define RTC_WRTGR		0x003c
-
-#define RTC_IRQ_STA		0x0002
-#define RTC_IRQ_STA_AL		BIT(0)
-#define RTC_IRQ_STA_LP		BIT(3)
-
-#define RTC_IRQ_EN		0x0004
-#define RTC_IRQ_EN_AL		BIT(0)
-#define RTC_IRQ_EN_ONESHOT	BIT(2)
-#define RTC_IRQ_EN_LP		BIT(3)
-#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
-
-#define RTC_AL_MASK		0x0008
-#define RTC_AL_MASK_DOW		BIT(4)
-
-#define RTC_TC_SEC		0x000a
-/* Min, Hour, Dom... register offset to RTC_TC_SEC */
-#define RTC_OFFSET_SEC		0
-#define RTC_OFFSET_MIN		1
-#define RTC_OFFSET_HOUR		2
-#define RTC_OFFSET_DOM		3
-#define RTC_OFFSET_DOW		4
-#define RTC_OFFSET_MTH		5
-#define RTC_OFFSET_YEAR		6
-#define RTC_OFFSET_COUNT	7
-
-#define RTC_AL_SEC		0x0018
-
-#define RTC_PDN2		0x002e
-#define RTC_PDN2_PWRON_ALARM	BIT(4)
-
-#define RTC_MIN_YEAR		1968
-#define RTC_BASE_YEAR		1900
-#define RTC_NUM_YEARS		128
-#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
-
-struct mt6397_rtc {
-	struct device		*dev;
-	struct rtc_device	*rtc_dev;
-	struct mutex		lock;
-	struct regmap		*regmap;
-	int			irq;
-	u32			addr_base;
-};
+#include <linux/mfd/mt6397/rtc.h>
+#include <linux/mod_devicetable.h>

 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 {
-	unsigned long timeout =3D jiffies + HZ;
 	int ret;
 	u32 data;

@@ -74,19 +24,13 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rt=
c)
 	if (ret < 0)
 		return ret;

-	while (1) {
-		ret =3D regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
-				  &data);
-		if (ret < 0)
-			break;
-		if (!(data & RTC_BBPU_CBUSY))
-			break;
-		if (time_after(jiffies, timeout)) {
-			ret =3D -ETIMEDOUT;
-			break;
-		}
-		cpu_relax();
-	}
+	ret =3D regmap_read_poll_timeout(rtc->regmap,
+					rtc->addr_base + RTC_BBPU, data,
+					!(data & RTC_BBPU_CBUSY),
+					MTK_RTC_POLL_DELAY_US,
+					MTK_RTC_POLL_TIMEOUT);
+	if (ret < 0)
+		dev_err(rtc->dev, "failed to write WRTGE: %d\n", ret);

 	return ret;
 }
@@ -324,14 +268,11 @@ static int mtk_rtc_probe(struct platform_device *pde=
v)

 	platform_set_drvdata(pdev, rtc);

-	rtc->rtc_dev =3D devm_rtc_allocate_device(rtc->dev);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
+	ret =3D devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
+					mtk_rtc_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					"mt6397-rtc", rtc);

-	ret =3D request_threaded_irq(rtc->irq, NULL,
-				   mtk_rtc_irq_handler_thread,
-				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-				   "mt6397-rtc", rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
@@ -340,6 +281,10 @@ static int mtk_rtc_probe(struct platform_device *pdev=
)

 	device_init_wakeup(&pdev->dev, 1);

+	rtc->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
 	rtc->rtc_dev->ops =3D &mtk_rtc_ops;

 	ret =3D rtc_register_device(rtc->rtc_dev);
@@ -355,15 +300,6 @@ static int mtk_rtc_probe(struct platform_device *pdev=
)
 	return ret;
 }

-static int mtk_rtc_remove(struct platform_device *pdev)
-{
-	struct mt6397_rtc *rtc =3D platform_get_drvdata(pdev);
-
-	free_irq(rtc->irq, rtc);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mt6397_rtc_suspend(struct device *dev)
 {
@@ -390,6 +326,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_sus=
pend,
 			mt6397_rtc_resume);

 static const struct of_device_id mt6397_rtc_of_match[] =3D {
+	{ .compatible =3D "mediatek,mt6323-rtc", },
 	{ .compatible =3D "mediatek,mt6397-rtc", },
 	{ }
 };
@@ -402,7 +339,6 @@ static struct platform_driver mtk_rtc_driver =3D {
 		.pm =3D &mt6397_pm_ops,
 	},
 	.probe	=3D mtk_rtc_probe,
-	.remove =3D mtk_rtc_remove,
 };

 module_platform_driver(mtk_rtc_driver);
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/co=
re.h
index 25a95e72179b..652da61e3711 100644
=2D-- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -7,6 +7,8 @@
 #ifndef __MFD_MT6397_CORE_H__
 #define __MFD_MT6397_CORE_H__

+#include <linux/mutex.h>
+
 enum mt6397_irq_numbers {
 	MT6397_IRQ_SPKL_AB =3D 0,
 	MT6397_IRQ_SPKR_AB,
diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc=
.h
new file mode 100644
index 000000000000..b702c29e8c74
=2D-- /dev/null
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2014-2018 MediaTek Inc.
+ *
+ * Author: Tianping.Fang <tianping.fang@mediatek.com>
+ *        Sean Wang <sean.wang@mediatek.com>
+ */
+
+#ifndef _LINUX_MFD_MT6397_RTC_H_
+#define _LINUX_MFD_MT6397_RTC_H_
+
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+#define RTC_BBPU               0x0000
+#define RTC_BBPU_CBUSY         BIT(6)
+#define RTC_BBPU_KEY            (0x43 << 8)
+
+#define RTC_WRTGR              0x003c
+
+#define RTC_IRQ_STA            0x0002
+#define RTC_IRQ_STA_AL         BIT(0)
+#define RTC_IRQ_STA_LP         BIT(3)
+
+#define RTC_IRQ_EN             0x0004
+#define RTC_IRQ_EN_AL          BIT(0)
+#define RTC_IRQ_EN_ONESHOT     BIT(2)
+#define RTC_IRQ_EN_LP          BIT(3)
+#define RTC_IRQ_EN_ONESHOT_AL  (RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
+
+#define RTC_AL_MASK            0x0008
+#define RTC_AL_MASK_DOW                BIT(4)
+
+#define RTC_TC_SEC             0x000a
+/* Min, Hour, Dom... register offset to RTC_TC_SEC */
+#define RTC_OFFSET_SEC         0
+#define RTC_OFFSET_MIN         1
+#define RTC_OFFSET_HOUR                2
+#define RTC_OFFSET_DOM         3
+#define RTC_OFFSET_DOW         4
+#define RTC_OFFSET_MTH         5
+#define RTC_OFFSET_YEAR                6
+#define RTC_OFFSET_COUNT       7
+
+#define RTC_AL_SEC             0x0018
+
+#define RTC_PDN2               0x002e
+#define RTC_PDN2_PWRON_ALARM   BIT(4)
+
+#define RTC_MIN_YEAR           1968
+#define RTC_BASE_YEAR          1900
+#define RTC_NUM_YEARS          128
+#define RTC_MIN_YEAR_OFFSET    (RTC_MIN_YEAR - RTC_BASE_YEAR)
+
+#define MTK_RTC_POLL_DELAY_US  10
+#define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
+
+struct mt6397_rtc {
+	struct device           *dev;
+	struct rtc_device       *rtc_dev;
+
+	/* Protect register access from multiple tasks */
+	struct mutex            lock;
+	struct regmap           *regmap;
+	int                     irq;
+	u32                     addr_base;
+};
+
+#endif /* _LINUX_MFD_MT6397_RTC_H_ */
=2D-
2.17.1

