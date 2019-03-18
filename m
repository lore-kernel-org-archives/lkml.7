Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DDBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE87217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920734;
	bh=WP8ZFE44kNi7WvmycETzCtrWD6BFBf5IMF6RnBWT1nk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fpPDjaF6v0F7ZZjtlOxnDrSMhBz97ZxvMrBhcosQ8757EK1wwgyvKO7O3Xgybiu/n
	 Qvqgn/QYzBHwJJ3VUeahDvWO2LZWkNODWgATsws7GRe/q3MOF+cvtQ9NLV4hMGu7cI
	 ptjRpZZMpkWah0edNU3i/VzlLSGUmlUy7eS9EVlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfCROwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56006 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfCROwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IlwlBwPQJvU1zYA8iQGoLVmbjsz/2SV+qFCTjkN+pyo=; b=lloDMekoPMyX
        h4qZ5221CWUwyeYt07rbl9uPnxhrJ36LwXWo/MH+8MsLxMTLot8cU9Dnnm6JTYoTO1EajIdBb19+m
        tDdYQh43yj3rilc4IGEWu5QZ8nvhjL3TMSnSz/hJLf+hKLWh/msXIVr2qqO4H3wv4qKOAQq6qfoOW
        3EjII=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tcN-0005pY-Pj; Mon, 18 Mar 2019 14:51:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4DEDC1128874; Mon, 18 Mar 2019 14:51:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Esben Haabendal <esben@geanix.com>,
        Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-fsl-spi: support use of the SPISEL_BOOT signal on MPC8309" to the spi tree
In-Reply-To:  <20190306103156.19897-1-rasmus.villemoes@prevas.dk>
X-Patchwork-Hint: ignore
Message-Id: <20190318145159.4DEDC1128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-spi: support use of the SPISEL_BOOT signal on MPC8309

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 69b921acae8a5b7feef03921d9b42c3634f3b9d1 Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 6 Mar 2019 10:32:05 +0000
Subject: [PATCH] spi: spi-fsl-spi: support use of the SPISEL_BOOT signal on
 MPC8309

The MPC8309 has a dedicated signal, SPISEL_BOOT, usually used as chip
select for the flash device from which the bootloader is loaded. It is
not an ordinary gpio, but is simply controlled via the SPI_CS register
in the system configuration.

To allow accessing such a spi slave, we need to teach
fsl_spi_cs_control() how to control the SPISEL_BOOT signal. To
distinguish the gpio-controlled slaves, continue to have those use
chip_select values of 0..ngpios-1, and use chip_select == ngpios for
the boot flash.

I'm not too happy with all the ifdeffery, but it seems to be necessary
for guarding the sysdev/fsl_soc.h and use of
get_immrbase() (spi-fsl-lib.c already contains similar ifdeffery).

Googling suggests that the MPC8306 is similar, with the SPI_CS
register at the same offset.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/fsl-spi.txt       |  4 ++
 drivers/spi/spi-fsl-lib.h                     |  2 +
 drivers/spi/spi-fsl-spi.c                     | 40 ++++++++++++++++---
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentation/devicetree/bindings/spi/fsl-spi.txt
index 8854004a1d3a..411375eac54d 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -18,6 +18,10 @@ Optional properties:
 - gpios : specifies the gpio pins to be used for chipselects.
   The gpios will be referred to as reg = <index> in the SPI child nodes.
   If unspecified, a single SPI device without a chip select can be used.
+- fsl,spisel_boot : for the MPC8306 and MPC8309, specifies that the
+  SPISEL_BOOT signal is used as chip select for a slave device. Use
+  reg = <number of gpios> in the corresponding child node, i.e. 0 if
+  the gpios property is not present.
 
 Example:
 	spi@4c0 {
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index f303f306b38e..483734bc1b1e 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -95,8 +95,10 @@ static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *reg)
 
 struct mpc8xxx_spi_probe_info {
 	struct fsl_spi_platform_data pdata;
+	int ngpios;
 	int *gpios;
 	bool *alow_flags;
+	__be32 __iomem *immr_spi_cs;
 };
 
 extern u32 mpc8xxx_spi_tx_buf_u8(struct mpc8xxx_spi *mpc8xxx_spi);
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8f2e97857e8b..3d7b50c65f36 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -39,6 +39,14 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
 
+#ifdef CONFIG_FSL_SOC
+#include <sysdev/fsl_soc.h>
+#endif
+
+/* Specific to the MPC8306/MPC8309 */
+#define IMMR_SPI_CS_OFFSET 0x14c
+#define SPI_BOOT_SEL_BIT   0x80000000
+
 #include "spi-fsl-lib.h"
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-spi.h"
@@ -701,10 +709,17 @@ static void fsl_spi_cs_control(struct spi_device *spi, bool on)
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
 	u16 cs = spi->chip_select;
-	int gpio = pinfo->gpios[cs];
-	bool alow = pinfo->alow_flags[cs];
 
-	gpio_set_value(gpio, on ^ alow);
+	if (cs < pinfo->ngpios) {
+		int gpio = pinfo->gpios[cs];
+		bool alow = pinfo->alow_flags[cs];
+
+		gpio_set_value(gpio, on ^ alow);
+	} else {
+		if (WARN_ON_ONCE(cs > pinfo->ngpios || !pinfo->immr_spi_cs))
+			return;
+		iowrite32be(on ? SPI_BOOT_SEL_BIT : 0, pinfo->immr_spi_cs);
+	}
 }
 
 static int of_fsl_spi_get_chipselects(struct device *dev)
@@ -712,12 +727,15 @@ static int of_fsl_spi_get_chipselects(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
+	bool spisel_boot = IS_ENABLED(CONFIG_FSL_SOC) &&
+		of_property_read_bool(np, "fsl,spisel_boot");
 	int ngpios;
 	int i = 0;
 	int ret;
 
 	ngpios = of_gpio_count(np);
-	if (ngpios <= 0) {
+	ngpios = max(ngpios, 0);
+	if (ngpios == 0 && !spisel_boot) {
 		/*
 		 * SPI w/o chip-select line. One SPI device is still permitted
 		 * though.
@@ -726,6 +744,7 @@ static int of_fsl_spi_get_chipselects(struct device *dev)
 		return 0;
 	}
 
+	pinfo->ngpios = ngpios;
 	pinfo->gpios = kmalloc_array(ngpios, sizeof(*pinfo->gpios),
 				     GFP_KERNEL);
 	if (!pinfo->gpios)
@@ -769,7 +788,18 @@ static int of_fsl_spi_get_chipselects(struct device *dev)
 		}
 	}
 
-	pdata->max_chipselect = ngpios;
+#if IS_ENABLED(CONFIG_FSL_SOC)
+	if (spisel_boot) {
+		pinfo->immr_spi_cs = ioremap(get_immrbase() + IMMR_SPI_CS_OFFSET, 4);
+		if (!pinfo->immr_spi_cs) {
+			ret = -ENOMEM;
+			i = ngpios - 1;
+			goto err_loop;
+		}
+	}
+#endif
+
+	pdata->max_chipselect = ngpios + spisel_boot;
 	pdata->cs_control = fsl_spi_cs_control;
 
 	return 0;
-- 
2.20.1

