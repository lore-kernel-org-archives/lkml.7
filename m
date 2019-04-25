Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8809AC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938DE20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220327;
	bh=KV3gq9pr0me2AZwveqykUo6tQOT+1vpqICvyXiVfzQ4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kfaiOiMc4HgrXyrCIEgnOG/WV/pOafHiIJE6T/IOxp1zS2VJNBFhjo1d6ITdQ345b
	 R9dNZynHY0xeGV+nlOXbq3SNLi6YuSIu0FDq53z72q1r8BKdLZtqLqelk9zvzsK16V
	 pj5C+LO3ED3oW6fDF29kJAU1cQYZcG9IqOFB1wdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfDYTYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:24:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDYTYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=h+bKMpZkdBP0hCypHsmqht4vODzV02EvUrlpDU2PPMY=; b=eUpoJK7gXof2
        SI28KlSgj2AFIjLjcfRNaXnSubc+Er3O6VvrgUlB0d88cO0amt4m1IbCH2OaltdOrqisosAnacRM0
        PDwmxXlsOl1G+dIl6yG4ZwrUbwHqKgol+amqfjw1OxzrjrIWneR8tq9bDQXjkuHU3Y7XeneYmhIAM
        EGO/U=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjz0-0004Yj-MT; Thu, 25 Apr 2019 19:24:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AC32B441D3B; Thu, 25 Apr 2019 20:24:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     alsa-devel@alsa-project.org, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        orsonzhai@gmail.com, perex@perex.cz, robh+dt@kernel.org,
        tiwai@suse.com, zhang.lyra@gmail.com
Subject: Applied "ASoC: sprd: Add Spreadtrum multi-channel data transfer support" to the asoc tree
In-Reply-To: <045f33cca3b34aadec7ec69be2697b05b1b069d8.1555917711.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190425192433.AC32B441D3B@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Add Spreadtrum multi-channel data transfer support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From d7bff893e04f4e7b4a0789486da1435df5920f5a Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 23 Apr 2019 10:26:22 +0800
Subject: [PATCH] ASoC: sprd: Add Spreadtrum multi-channel data transfer
 support

On Spreadtrum platform, the audio subsystem will use the multi-channel
data transfer controller to transfer sound stream between audio subsystem
and other AP/CP subsystem.

It can support 10 DAC channel and 10 ADC channel, and each channel has
512 bytes depth data fifo. Moreover each channel can be used DMA mode
or interrupt mode to transfer data.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/Kconfig     |    8 +
 sound/soc/sprd/Makefile    |    2 +
 sound/soc/sprd/sprd-mcdt.c | 1011 ++++++++++++++++++++++++++++++++++++
 sound/soc/sprd/sprd-mcdt.h |  107 ++++
 4 files changed, 1128 insertions(+)
 create mode 100644 sound/soc/sprd/sprd-mcdt.c
 create mode 100644 sound/soc/sprd/sprd-mcdt.h

diff --git a/sound/soc/sprd/Kconfig b/sound/soc/sprd/Kconfig
index 3b1eb320dab4..21f9cc34f8bd 100644
--- a/sound/soc/sprd/Kconfig
+++ b/sound/soc/sprd/Kconfig
@@ -5,3 +5,11 @@ config SND_SOC_SPRD
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Spreadtrum SoCs' Audio interfaces.
+
+config SND_SOC_SPRD_MCDT
+	bool "Spreadtrum multi-channel data transfer support"
+	depends on SND_SOC_SPRD
+	help
+	  Say y here to enable multi-channel data transfer support. It
+	  is used for sound stream transmission between audio subsystem
+	  and other AP/CP subsystem.
diff --git a/sound/soc/sprd/Makefile b/sound/soc/sprd/Makefile
index e6c2606da8e2..a95fa56cd000 100644
--- a/sound/soc/sprd/Makefile
+++ b/sound/soc/sprd/Makefile
@@ -4,3 +4,5 @@
 snd-soc-sprd-platform-objs := sprd-pcm-dma.o sprd-pcm-compress.o
 
 obj-$(CONFIG_SND_SOC_SPRD) += snd-soc-sprd-platform.o
+
+obj-$(CONFIG_SND_SOC_SPRD_MCDT) += sprd-mcdt.o
diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
new file mode 100644
index 000000000000..28f5e649733d
--- /dev/null
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -0,0 +1,1011 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Spreadtrum Communications Inc.
+
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#include "sprd-mcdt.h"
+
+/* MCDT registers definition */
+#define MCDT_CH0_TXD		0x0
+#define MCDT_CH0_RXD		0x28
+#define MCDT_DAC0_WTMK		0x60
+#define MCDT_ADC0_WTMK		0x88
+#define MCDT_DMA_EN		0xb0
+
+#define MCDT_INT_EN0		0xb4
+#define MCDT_INT_EN1		0xb8
+#define MCDT_INT_EN2		0xbc
+
+#define MCDT_INT_CLR0		0xc0
+#define MCDT_INT_CLR1		0xc4
+#define MCDT_INT_CLR2		0xc8
+
+#define MCDT_INT_RAW1		0xcc
+#define MCDT_INT_RAW2		0xd0
+#define MCDT_INT_RAW3		0xd4
+
+#define MCDT_INT_MSK1		0xd8
+#define MCDT_INT_MSK2		0xdc
+#define MCDT_INT_MSK3		0xe0
+
+#define MCDT_DAC0_FIFO_ADDR_ST	0xe4
+#define MCDT_ADC0_FIFO_ADDR_ST	0xe8
+
+#define MCDT_CH_FIFO_ST0	0x134
+#define MCDT_CH_FIFO_ST1	0x138
+#define MCDT_CH_FIFO_ST2	0x13c
+
+#define MCDT_INT_MSK_CFG0	0x140
+#define MCDT_INT_MSK_CFG1	0x144
+
+#define MCDT_DMA_CFG0		0x148
+#define MCDT_FIFO_CLR		0x14c
+#define MCDT_DMA_CFG1		0x150
+#define MCDT_DMA_CFG2		0x154
+#define MCDT_DMA_CFG3		0x158
+#define MCDT_DMA_CFG4		0x15c
+#define MCDT_DMA_CFG5		0x160
+
+/* Channel water mark definition */
+#define MCDT_CH_FIFO_AE_SHIFT	16
+#define MCDT_CH_FIFO_AE_MASK	GENMASK(24, 16)
+#define MCDT_CH_FIFO_AF_MASK	GENMASK(8, 0)
+
+/* DMA channel select definition */
+#define MCDT_DMA_CH0_SEL_MASK	GENMASK(3, 0)
+#define MCDT_DMA_CH0_SEL_SHIFT	0
+#define MCDT_DMA_CH1_SEL_MASK	GENMASK(7, 4)
+#define MCDT_DMA_CH1_SEL_SHIFT	4
+#define MCDT_DMA_CH2_SEL_MASK	GENMASK(11, 8)
+#define MCDT_DMA_CH2_SEL_SHIFT	8
+#define MCDT_DMA_CH3_SEL_MASK	GENMASK(15, 12)
+#define MCDT_DMA_CH3_SEL_SHIFT	12
+#define MCDT_DMA_CH4_SEL_MASK	GENMASK(19, 16)
+#define MCDT_DMA_CH4_SEL_SHIFT	16
+#define MCDT_DAC_DMA_SHIFT	16
+
+/* DMA channel ACK select definition */
+#define MCDT_DMA_ACK_SEL_MASK	GENMASK(3, 0)
+
+/* Channel FIFO definition */
+#define MCDT_CH_FIFO_ADDR_SHIFT	16
+#define MCDT_CH_FIFO_ADDR_MASK	GENMASK(9, 0)
+#define MCDT_ADC_FIFO_SHIFT	16
+#define MCDT_FIFO_LENGTH	512
+
+#define MCDT_ADC_CHANNEL_NUM	10
+#define MCDT_DAC_CHANNEL_NUM	10
+#define MCDT_CHANNEL_NUM	(MCDT_ADC_CHANNEL_NUM + MCDT_DAC_CHANNEL_NUM)
+
+enum sprd_mcdt_fifo_int {
+	MCDT_ADC_FIFO_AE_INT,
+	MCDT_ADC_FIFO_AF_INT,
+	MCDT_DAC_FIFO_AE_INT,
+	MCDT_DAC_FIFO_AF_INT,
+	MCDT_ADC_FIFO_OV_INT,
+	MCDT_DAC_FIFO_OV_INT
+};
+
+enum sprd_mcdt_fifo_sts {
+	MCDT_ADC_FIFO_REAL_FULL,
+	MCDT_ADC_FIFO_REAL_EMPTY,
+	MCDT_ADC_FIFO_AF,
+	MCDT_ADC_FIFO_AE,
+	MCDT_DAC_FIFO_REAL_FULL,
+	MCDT_DAC_FIFO_REAL_EMPTY,
+	MCDT_DAC_FIFO_AF,
+	MCDT_DAC_FIFO_AE
+};
+
+struct sprd_mcdt_dev {
+	struct device *dev;
+	void __iomem *base;
+	spinlock_t lock;
+	struct sprd_mcdt_chan chan[MCDT_CHANNEL_NUM];
+};
+
+static LIST_HEAD(sprd_mcdt_chan_list);
+static DEFINE_MUTEX(sprd_mcdt_list_mutex);
+
+static void sprd_mcdt_update(struct sprd_mcdt_dev *mcdt, u32 reg, u32 val,
+			     u32 mask)
+{
+	u32 orig = readl_relaxed(mcdt->base + reg);
+	u32 tmp;
+
+	tmp = (orig & ~mask) | val;
+	writel_relaxed(tmp, mcdt->base + reg);
+}
+
+static void sprd_mcdt_dac_set_watermark(struct sprd_mcdt_dev *mcdt, u8 channel,
+					u32 full, u32 empty)
+{
+	u32 reg = MCDT_DAC0_WTMK + channel * 4;
+	u32 water_mark =
+		(empty << MCDT_CH_FIFO_AE_SHIFT) & MCDT_CH_FIFO_AE_MASK;
+
+	water_mark |= full & MCDT_CH_FIFO_AF_MASK;
+	sprd_mcdt_update(mcdt, reg, water_mark,
+			 MCDT_CH_FIFO_AE_MASK | MCDT_CH_FIFO_AF_MASK);
+}
+
+static void sprd_mcdt_adc_set_watermark(struct sprd_mcdt_dev *mcdt, u8 channel,
+					u32 full, u32 empty)
+{
+	u32 reg = MCDT_ADC0_WTMK + channel * 4;
+	u32 water_mark =
+		(empty << MCDT_CH_FIFO_AE_SHIFT) & MCDT_CH_FIFO_AE_MASK;
+
+	water_mark |= full & MCDT_CH_FIFO_AF_MASK;
+	sprd_mcdt_update(mcdt, reg, water_mark,
+			 MCDT_CH_FIFO_AE_MASK | MCDT_CH_FIFO_AF_MASK);
+}
+
+static void sprd_mcdt_dac_dma_enable(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     bool enable)
+{
+	u32 shift = MCDT_DAC_DMA_SHIFT + channel;
+
+	if (enable)
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, BIT(shift), BIT(shift));
+	else
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, 0, BIT(shift));
+}
+
+static void sprd_mcdt_adc_dma_enable(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     bool enable)
+{
+	if (enable)
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, BIT(channel), BIT(channel));
+	else
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, 0, BIT(channel));
+}
+
+static void sprd_mcdt_ap_int_enable(struct sprd_mcdt_dev *mcdt, u8 channel,
+				    bool enable)
+{
+	if (enable)
+		sprd_mcdt_update(mcdt, MCDT_INT_MSK_CFG0, BIT(channel),
+				 BIT(channel));
+	else
+		sprd_mcdt_update(mcdt, MCDT_INT_MSK_CFG0, 0, BIT(channel));
+}
+
+static void sprd_mcdt_dac_write_fifo(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     u32 val)
+{
+	u32 reg = MCDT_CH0_TXD + channel * 4;
+
+	writel_relaxed(val, mcdt->base + reg);
+}
+
+static void sprd_mcdt_adc_read_fifo(struct sprd_mcdt_dev *mcdt, u8 channel,
+				    u32 *val)
+{
+	u32 reg = MCDT_CH0_RXD + channel * 4;
+
+	*val = readl_relaxed(mcdt->base + reg);
+}
+
+static void sprd_mcdt_dac_dma_chn_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	switch (dma_chan) {
+	case SPRD_MCDT_DMA_CH0:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH0_SEL_SHIFT,
+				 MCDT_DMA_CH0_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH1:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH1_SEL_SHIFT,
+				 MCDT_DMA_CH1_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH2:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH2_SEL_SHIFT,
+				 MCDT_DMA_CH2_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH3:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH3_SEL_SHIFT,
+				 MCDT_DMA_CH3_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH4:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH4_SEL_SHIFT,
+				 MCDT_DMA_CH4_SEL_MASK);
+		break;
+	}
+}
+
+static void sprd_mcdt_adc_dma_chn_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	switch (dma_chan) {
+	case SPRD_MCDT_DMA_CH0:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH0_SEL_SHIFT,
+				 MCDT_DMA_CH0_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH1:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH1_SEL_SHIFT,
+				 MCDT_DMA_CH1_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH2:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH2_SEL_SHIFT,
+				 MCDT_DMA_CH2_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH3:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH3_SEL_SHIFT,
+				 MCDT_DMA_CH3_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH4:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH4_SEL_SHIFT,
+				 MCDT_DMA_CH4_SEL_MASK);
+		break;
+	}
+}
+
+static u32 sprd_mcdt_dma_ack_shift(u8 channel)
+{
+	switch (channel) {
+	default:
+	case 0:
+	case 8:
+		return 0;
+	case 1:
+	case 9:
+		return 4;
+	case 2:
+		return 8;
+	case 3:
+		return 12;
+	case 4:
+		return 16;
+	case 5:
+		return 20;
+	case 6:
+		return 24;
+	case 7:
+		return 28;
+	}
+}
+
+static void sprd_mcdt_dac_dma_ack_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	u32 reg, shift = sprd_mcdt_dma_ack_shift(channel), ack = dma_chan;
+
+	switch (channel) {
+	case 0 ... 7:
+		reg = MCDT_DMA_CFG2;
+		break;
+
+	case 8 ... 9:
+		reg = MCDT_DMA_CFG3;
+		break;
+
+	default:
+		return;
+	}
+
+	sprd_mcdt_update(mcdt, reg, ack << shift,
+			 MCDT_DMA_ACK_SEL_MASK << shift);
+}
+
+static void sprd_mcdt_adc_dma_ack_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	u32 reg, shift = sprd_mcdt_dma_ack_shift(channel), ack = dma_chan;
+
+	switch (channel) {
+	case 0 ... 7:
+		reg = MCDT_DMA_CFG4;
+		break;
+
+	case 8 ... 9:
+		reg = MCDT_DMA_CFG5;
+		break;
+
+	default:
+		return;
+	}
+
+	sprd_mcdt_update(mcdt, reg, ack << shift,
+			 MCDT_DMA_ACK_SEL_MASK << shift);
+}
+
+static bool sprd_mcdt_chan_fifo_sts(struct sprd_mcdt_dev *mcdt, u8 channel,
+				    enum sprd_mcdt_fifo_sts fifo_sts)
+{
+	u32 reg, shift;
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_CH_FIFO_ST0;
+		break;
+	case 4 ... 7:
+		reg = MCDT_CH_FIFO_ST1;
+		break;
+	case 8 ... 9:
+		reg = MCDT_CH_FIFO_ST2;
+		break;
+	default:
+		return false;
+	}
+
+	switch (channel) {
+	case 0:
+	case 4:
+	case 8:
+		shift = fifo_sts;
+		break;
+
+	case 1:
+	case 5:
+	case 9:
+		shift = 8 + fifo_sts;
+		break;
+
+	case 2:
+	case 6:
+		shift = 16 + fifo_sts;
+		break;
+
+	case 3:
+	case 7:
+		shift = 24 + fifo_sts;
+		break;
+
+	default:
+		return false;
+	}
+
+	return !!(readl_relaxed(mcdt->base + reg) & BIT(shift));
+}
+
+static void sprd_mcdt_dac_fifo_clear(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	sprd_mcdt_update(mcdt, MCDT_FIFO_CLR, BIT(channel), BIT(channel));
+}
+
+static void sprd_mcdt_adc_fifo_clear(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	u32 shift = MCDT_ADC_FIFO_SHIFT + channel;
+
+	sprd_mcdt_update(mcdt, MCDT_FIFO_CLR, BIT(shift), BIT(shift));
+}
+
+static u32 sprd_mcdt_dac_fifo_avail(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	u32 reg = MCDT_DAC0_FIFO_ADDR_ST + channel * 8;
+	u32 r_addr = (readl_relaxed(mcdt->base + reg) >>
+		      MCDT_CH_FIFO_ADDR_SHIFT) & MCDT_CH_FIFO_ADDR_MASK;
+	u32 w_addr = readl_relaxed(mcdt->base + reg) & MCDT_CH_FIFO_ADDR_MASK;
+
+	if (w_addr >= r_addr)
+		return 4 * (MCDT_FIFO_LENGTH - w_addr + r_addr);
+	else
+		return 4 * (r_addr - w_addr);
+}
+
+static u32 sprd_mcdt_adc_fifo_avail(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	u32 reg = MCDT_ADC0_FIFO_ADDR_ST + channel * 8;
+	u32 r_addr = (readl_relaxed(mcdt->base + reg) >>
+		      MCDT_CH_FIFO_ADDR_SHIFT) & MCDT_CH_FIFO_ADDR_MASK;
+	u32 w_addr = readl_relaxed(mcdt->base + reg) & MCDT_CH_FIFO_ADDR_MASK;
+
+	if (w_addr >= r_addr)
+		return 4 * (w_addr - r_addr);
+	else
+		return 4 * (MCDT_FIFO_LENGTH - r_addr + w_addr);
+}
+
+static u32 sprd_mcdt_int_type_shift(u8 channel,
+				    enum sprd_mcdt_fifo_int int_type)
+{
+	switch (channel) {
+	case 0:
+	case 4:
+	case 8:
+		return int_type;
+
+	case 1:
+	case 5:
+	case 9:
+		return  8 + int_type;
+
+	case 2:
+	case 6:
+		return 16 + int_type;
+
+	case 3:
+	case 7:
+		return 24 + int_type;
+
+	default:
+		return 0;
+	}
+}
+
+static void sprd_mcdt_chan_int_en(struct sprd_mcdt_dev *mcdt, u8 channel,
+				  enum sprd_mcdt_fifo_int int_type, bool enable)
+{
+	u32 reg, shift = sprd_mcdt_int_type_shift(channel, int_type);
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_INT_EN0;
+		break;
+	case 4 ... 7:
+		reg = MCDT_INT_EN1;
+		break;
+	case 8 ... 9:
+		reg = MCDT_INT_EN2;
+		break;
+	default:
+		return;
+	}
+
+	if (enable)
+		sprd_mcdt_update(mcdt, reg, BIT(shift), BIT(shift));
+	else
+		sprd_mcdt_update(mcdt, reg, 0, BIT(shift));
+}
+
+static void sprd_mcdt_chan_int_clear(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     enum sprd_mcdt_fifo_int int_type)
+{
+	u32 reg, shift = sprd_mcdt_int_type_shift(channel, int_type);
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_INT_CLR0;
+		break;
+	case 4 ... 7:
+		reg = MCDT_INT_CLR1;
+		break;
+	case 8 ... 9:
+		reg = MCDT_INT_CLR2;
+		break;
+	default:
+		return;
+	}
+
+	sprd_mcdt_update(mcdt, reg, BIT(shift), BIT(shift));
+}
+
+static bool sprd_mcdt_chan_int_sts(struct sprd_mcdt_dev *mcdt, u8 channel,
+				   enum sprd_mcdt_fifo_int int_type)
+{
+	u32 reg, shift = sprd_mcdt_int_type_shift(channel, int_type);
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_INT_MSK1;
+		break;
+	case 4 ... 7:
+		reg = MCDT_INT_MSK2;
+		break;
+	case 8 ... 9:
+		reg = MCDT_INT_MSK3;
+		break;
+	default:
+		return false;
+	}
+
+	return !!(readl_relaxed(mcdt->base + reg) & BIT(shift));
+}
+
+static irqreturn_t sprd_mcdt_irq_handler(int irq, void *dev_id)
+{
+	struct sprd_mcdt_dev *mcdt = (struct sprd_mcdt_dev *)dev_id;
+	int i;
+
+	spin_lock(&mcdt->lock);
+
+	for (i = 0; i < MCDT_ADC_CHANNEL_NUM; i++) {
+		if (sprd_mcdt_chan_int_sts(mcdt, i, MCDT_ADC_FIFO_AF_INT)) {
+			struct sprd_mcdt_chan *chan = &mcdt->chan[i];
+
+			sprd_mcdt_chan_int_clear(mcdt, i, MCDT_ADC_FIFO_AF_INT);
+			if (chan->cb)
+				chan->cb->notify(chan->cb->data);
+		}
+	}
+
+	for (i = 0; i < MCDT_DAC_CHANNEL_NUM; i++) {
+		if (sprd_mcdt_chan_int_sts(mcdt, i, MCDT_DAC_FIFO_AE_INT)) {
+			struct sprd_mcdt_chan *chan =
+				&mcdt->chan[i + MCDT_ADC_CHANNEL_NUM];
+
+			sprd_mcdt_chan_int_clear(mcdt, i, MCDT_DAC_FIFO_AE_INT);
+			if (chan->cb)
+				chan->cb->notify(chan->cb->data);
+		}
+	}
+
+	spin_unlock(&mcdt->lock);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * sprd_mcdt_chan_write - write data to the MCDT channel's fifo
+ * @chan: the MCDT channel
+ * @tx_buf: send buffer
+ * @size: data size
+ *
+ * Note: We can not write data to the channel fifo when enabling the DMA mode,
+ * otherwise the channel fifo data will be invalid.
+ *
+ * If there are not enough space of the channel fifo, it will return errors
+ * to users.
+ *
+ * Returns 0 on success, or an appropriate error code on failure.
+ */
+int sprd_mcdt_chan_write(struct sprd_mcdt_chan *chan, char *tx_buf, u32 size)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int avail, i = 0, words = size / 4;
+	u32 *buf = (u32 *)tx_buf;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable) {
+		dev_err(mcdt->dev,
+			"Can not write data when DMA mode enabled\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	if (sprd_mcdt_chan_fifo_sts(mcdt, chan->id, MCDT_DAC_FIFO_REAL_FULL)) {
+		dev_err(mcdt->dev, "Channel fifo is full now\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EBUSY;
+	}
+
+	avail = sprd_mcdt_dac_fifo_avail(mcdt, chan->id);
+	if (size > avail) {
+		dev_err(mcdt->dev,
+			"Data size is larger than the available fifo size\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EBUSY;
+	}
+
+	while (i++ < words)
+		sprd_mcdt_dac_write_fifo(mcdt, chan->id, *buf++);
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_write);
+
+/**
+ * sprd_mcdt_chan_read - read data from the MCDT channel's fifo
+ * @chan: the MCDT channel
+ * @rx_buf: receive buffer
+ * @size: data size
+ *
+ * Note: We can not read data from the channel fifo when enabling the DMA mode,
+ * otherwise the reading data will be invalid.
+ *
+ * Usually user need start to read data once receiving the fifo full interrupt.
+ *
+ * Returns data size of reading successfully, or an error code on failure.
+ */
+int sprd_mcdt_chan_read(struct sprd_mcdt_chan *chan, char *rx_buf, u32 size)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int i = 0, avail, words = size / 4;
+	u32 *buf = (u32 *)rx_buf;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable) {
+		dev_err(mcdt->dev, "Can not read data when DMA mode enabled\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	if (sprd_mcdt_chan_fifo_sts(mcdt, chan->id, MCDT_ADC_FIFO_REAL_EMPTY)) {
+		dev_err(mcdt->dev, "Channel fifo is empty\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EBUSY;
+	}
+
+	avail = sprd_mcdt_adc_fifo_avail(mcdt, chan->id);
+	if (size > avail)
+		words = avail / 4;
+
+	while (i++ < words)
+		sprd_mcdt_adc_read_fifo(mcdt, chan->id, buf++);
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+	return words * 4;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_read);
+
+/**
+ * sprd_mcdt_chan_int_enable - enable the interrupt mode for the MCDT channel
+ * @chan: the MCDT channel
+ * @water_mark: water mark to trigger a interrupt
+ * @cb: callback when a interrupt happened
+ *
+ * Now it only can enable fifo almost full interrupt for ADC channel and fifo
+ * almost empty interrupt for DAC channel. Morevoer for interrupt mode, user
+ * should use sprd_mcdt_chan_read() or sprd_mcdt_chan_write() to read or write
+ * data manually.
+ *
+ * For ADC channel, user can start to read data once receiving one fifo full
+ * interrupt. For DAC channel, user can start to write data once receiving one
+ * fifo empty interrupt or just call sprd_mcdt_chan_write() to write data
+ * directly.
+ *
+ * Returns 0 on success, or an error code on failure.
+ */
+int sprd_mcdt_chan_int_enable(struct sprd_mcdt_chan *chan, u32 water_mark,
+			      struct sprd_mcdt_chan_callback *cb)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable || chan->int_enable) {
+		dev_err(mcdt->dev, "Failed to set interrupt mode.\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_adc_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_adc_set_watermark(mcdt, chan->id, water_mark,
+					    MCDT_FIFO_LENGTH - 1);
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_ADC_FIFO_AF_INT, true);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, true);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_dac_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_dac_set_watermark(mcdt, chan->id,
+					    MCDT_FIFO_LENGTH - 1, water_mark);
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_DAC_FIFO_AE_INT, true);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, true);
+		break;
+
+	default:
+		dev_err(mcdt->dev, "Unsupported channel type\n");
+		ret = -EINVAL;
+	}
+
+	if (!ret) {
+		chan->cb = cb;
+		chan->int_enable = true;
+	}
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_int_enable);
+
+/**
+ * sprd_mcdt_chan_int_disable - disable the interrupt mode for the MCDT channel
+ * @chan: the MCDT channel
+ */
+void sprd_mcdt_chan_int_disable(struct sprd_mcdt_chan *chan)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (!chan->int_enable) {
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_ADC_FIFO_AF_INT, false);
+		sprd_mcdt_chan_int_clear(mcdt, chan->id, MCDT_ADC_FIFO_AF_INT);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, false);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_DAC_FIFO_AE_INT, false);
+		sprd_mcdt_chan_int_clear(mcdt, chan->id, MCDT_DAC_FIFO_AE_INT);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, false);
+		break;
+
+	default:
+		break;
+	}
+
+	chan->int_enable = false;
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_int_disable);
+
+/**
+ * sprd_mcdt_chan_dma_enable - enable the DMA mode for the MCDT channel
+ * @chan: the MCDT channel
+ * @dma_chan: specify which DMA channel will be used for this MCDT channel
+ * @water_mark: water mark to trigger a DMA request
+ *
+ * Enable the DMA mode for the MCDT channel, that means we can use DMA to
+ * transfer data to the channel fifo and do not need reading/writing data
+ * manually.
+ *
+ * Returns 0 on success, or an error code on failure.
+ */
+int sprd_mcdt_chan_dma_enable(struct sprd_mcdt_chan *chan,
+			      enum sprd_mcdt_dma_chan dma_chan,
+			      u32 water_mark)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable || chan->int_enable ||
+	    dma_chan > SPRD_MCDT_DMA_CH4) {
+		dev_err(mcdt->dev, "Failed to set DMA mode\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_adc_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_adc_set_watermark(mcdt, chan->id,
+					    water_mark, MCDT_FIFO_LENGTH - 1);
+		sprd_mcdt_adc_dma_enable(mcdt, chan->id, true);
+		sprd_mcdt_adc_dma_chn_select(mcdt, chan->id, dma_chan);
+		sprd_mcdt_adc_dma_ack_select(mcdt, chan->id, dma_chan);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_dac_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_dac_set_watermark(mcdt, chan->id,
+					    MCDT_FIFO_LENGTH - 1, water_mark);
+		sprd_mcdt_dac_dma_enable(mcdt, chan->id, true);
+		sprd_mcdt_dac_dma_chn_select(mcdt, chan->id, dma_chan);
+		sprd_mcdt_dac_dma_ack_select(mcdt, chan->id, dma_chan);
+		break;
+
+	default:
+		dev_err(mcdt->dev, "Unsupported channel type\n");
+		ret = -EINVAL;
+	}
+
+	if (!ret)
+		chan->dma_enable = true;
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_dma_enable);
+
+/**
+ * sprd_mcdt_chan_dma_disable - disable the DMA mode for the MCDT channel
+ * @chan: the MCDT channel
+ */
+void sprd_mcdt_chan_dma_disable(struct sprd_mcdt_chan *chan)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (!chan->dma_enable) {
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_adc_dma_enable(mcdt, chan->id, false);
+		sprd_mcdt_adc_fifo_clear(mcdt, chan->id);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_dac_dma_enable(mcdt, chan->id, false);
+		sprd_mcdt_dac_fifo_clear(mcdt, chan->id);
+		break;
+
+	default:
+		break;
+	}
+
+	chan->dma_enable = false;
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_dma_disable);
+
+/**
+ * sprd_mcdt_request_chan - request one MCDT channel
+ * @channel: channel id
+ * @type: channel type, it can be one ADC channel or DAC channel
+ *
+ * Rreturn NULL if no available channel.
+ */
+struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
+					      enum sprd_mcdt_channel_type type)
+{
+	struct sprd_mcdt_chan *temp, *chan = NULL;
+
+	mutex_lock(&sprd_mcdt_list_mutex);
+
+	list_for_each_entry(temp, &sprd_mcdt_chan_list, list) {
+		if (temp->type == type && temp->id == channel) {
+			chan = temp;
+			break;
+		}
+	}
+
+	if (chan)
+		list_del(&chan->list);
+
+	mutex_unlock(&sprd_mcdt_list_mutex);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_request_chan);
+
+/**
+ * sprd_mcdt_free_chan - free one MCDT channel
+ * @chan: the channel to be freed
+ */
+void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan)
+{
+	struct sprd_mcdt_chan *temp;
+
+	sprd_mcdt_chan_dma_disable(chan);
+	sprd_mcdt_chan_int_disable(chan);
+
+	mutex_lock(&sprd_mcdt_list_mutex);
+
+	list_for_each_entry(temp, &sprd_mcdt_chan_list, list) {
+		if (temp == chan) {
+			mutex_unlock(&sprd_mcdt_list_mutex);
+			return;
+		}
+	}
+
+	list_add_tail(&chan->list, &sprd_mcdt_chan_list);
+	mutex_unlock(&sprd_mcdt_list_mutex);
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_free_chan);
+
+static void sprd_mcdt_init_chans(struct sprd_mcdt_dev *mcdt,
+				 struct resource *res)
+{
+	int i;
+
+	for (i = 0; i < MCDT_CHANNEL_NUM; i++) {
+		struct sprd_mcdt_chan *chan = &mcdt->chan[i];
+
+		if (i < MCDT_ADC_CHANNEL_NUM) {
+			chan->id = i;
+			chan->type = SPRD_MCDT_ADC_CHAN;
+			chan->fifo_phys = res->start + MCDT_CH0_RXD + i * 4;
+		} else {
+			chan->id = i - MCDT_ADC_CHANNEL_NUM;
+			chan->type = SPRD_MCDT_DAC_CHAN;
+			chan->fifo_phys = res->start + MCDT_CH0_TXD +
+				(i - MCDT_ADC_CHANNEL_NUM) * 4;
+		}
+
+		chan->mcdt = mcdt;
+		INIT_LIST_HEAD(&chan->list);
+
+		mutex_lock(&sprd_mcdt_list_mutex);
+		list_add_tail(&chan->list, &sprd_mcdt_chan_list);
+		mutex_unlock(&sprd_mcdt_list_mutex);
+	}
+}
+
+static int sprd_mcdt_probe(struct platform_device *pdev)
+{
+	struct sprd_mcdt_dev *mcdt;
+	struct resource *res;
+	int ret, irq;
+
+	mcdt = devm_kzalloc(&pdev->dev, sizeof(*mcdt), GFP_KERNEL);
+	if (!mcdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mcdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!mcdt->base)
+		return -ENOMEM;
+
+	mcdt->dev = &pdev->dev;
+	spin_lock_init(&mcdt->lock);
+	platform_set_drvdata(pdev, mcdt);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get MCDT interrupt\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, sprd_mcdt_irq_handler,
+			       0, "sprd-mcdt", mcdt);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request MCDT IRQ\n");
+		return ret;
+	}
+
+	sprd_mcdt_init_chans(mcdt, res);
+
+	return 0;
+}
+
+static int sprd_mcdt_remove(struct platform_device *pdev)
+{
+	struct sprd_mcdt_chan *temp;
+
+	mutex_lock(&sprd_mcdt_list_mutex);
+
+	list_for_each_entry(temp, &sprd_mcdt_chan_list, list)
+		list_del(&temp->list);
+
+	mutex_unlock(&sprd_mcdt_list_mutex);
+
+	return 0;
+}
+
+static const struct of_device_id sprd_mcdt_of_match[] = {
+	{ .compatible = "sprd,sc9860-mcdt", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sprd_mcdt_of_match);
+
+static struct platform_driver sprd_mcdt_driver = {
+	.probe = sprd_mcdt_probe,
+	.remove = sprd_mcdt_remove,
+	.driver = {
+		.name = "sprd-mcdt",
+		.of_match_table = sprd_mcdt_of_match,
+	},
+};
+
+module_platform_driver(sprd_mcdt_driver);
+
+MODULE_DESCRIPTION("Spreadtrum Multi-Channel Data Transfer Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/sprd/sprd-mcdt.h b/sound/soc/sprd/sprd-mcdt.h
new file mode 100644
index 000000000000..9cc7e207ac76
--- /dev/null
+++ b/sound/soc/sprd/sprd-mcdt.h
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __SPRD_MCDT_H
+#define __SPRD_MCDT_H
+
+enum sprd_mcdt_channel_type {
+	SPRD_MCDT_DAC_CHAN,
+	SPRD_MCDT_ADC_CHAN,
+	SPRD_MCDT_UNKNOWN_CHAN,
+};
+
+enum sprd_mcdt_dma_chan {
+	SPRD_MCDT_DMA_CH0,
+	SPRD_MCDT_DMA_CH1,
+	SPRD_MCDT_DMA_CH2,
+	SPRD_MCDT_DMA_CH3,
+	SPRD_MCDT_DMA_CH4,
+};
+
+struct sprd_mcdt_chan_callback {
+	void (*notify)(void *data);
+	void *data;
+};
+
+/**
+ * struct sprd_mcdt_chan - this struct represents a single channel instance
+ * @mcdt: the mcdt controller
+ * @id: channel id
+ * @fifo_phys: channel fifo physical address which is used for DMA transfer
+ * @type: channel type
+ * @cb: channel fifo interrupt's callback interface to notify the fifo events
+ * @dma_enable: indicate if use DMA mode to transfer data
+ * @int_enable: indicate if use interrupt mode to notify users to read or
+ * write data manually
+ * @list: used to link into the global list
+ *
+ * Note: users should not modify any members of this structure.
+ */
+struct sprd_mcdt_chan {
+	struct sprd_mcdt_dev *mcdt;
+	u8 id;
+	unsigned long fifo_phys;
+	enum sprd_mcdt_channel_type type;
+	enum sprd_mcdt_dma_chan dma_chan;
+	struct sprd_mcdt_chan_callback *cb;
+	bool dma_enable;
+	bool int_enable;
+	struct list_head list;
+};
+
+#ifdef CONFIG_SND_SOC_SPRD_MCDT
+struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
+					      enum sprd_mcdt_channel_type type);
+void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan);
+
+int sprd_mcdt_chan_write(struct sprd_mcdt_chan *chan, char *tx_buf, u32 size);
+int sprd_mcdt_chan_read(struct sprd_mcdt_chan *chan, char *rx_buf, u32 size);
+int sprd_mcdt_chan_int_enable(struct sprd_mcdt_chan *chan, u32 water_mark,
+			      struct sprd_mcdt_chan_callback *cb);
+void sprd_mcdt_chan_int_disable(struct sprd_mcdt_chan *chan);
+
+int sprd_mcdt_chan_dma_enable(struct sprd_mcdt_chan *chan,
+			      enum sprd_mcdt_dma_chan dma_chan, u32 water_mark);
+void sprd_mcdt_chan_dma_disable(struct sprd_mcdt_chan *chan);
+
+#else
+
+struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
+					      enum sprd_mcdt_channel_type type)
+{
+	return NULL;
+}
+
+void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan)
+{ }
+
+int sprd_mcdt_chan_write(struct sprd_mcdt_chan *chan, char *tx_buf, u32 size)
+{
+	return -EINVAL;
+}
+
+int sprd_mcdt_chan_read(struct sprd_mcdt_chan *chan, char *rx_buf, u32 size)
+{
+	return 0;
+}
+
+int sprd_mcdt_chan_int_enable(struct sprd_mcdt_chan *chan, u32 water_mark,
+			      struct sprd_mcdt_chan_callback *cb)
+{
+	return -EINVAL;
+}
+
+void sprd_mcdt_chan_int_disable(struct sprd_mcdt_chan *chan)
+{ }
+
+int sprd_mcdt_chan_dma_enable(struct sprd_mcdt_chan *chan,
+			      enum sprd_mcdt_dma_chan dma_chan, u32 water_mark)
+{
+	return -EINVAL;
+}
+
+void sprd_mcdt_chan_dma_disable(struct sprd_mcdt_chan *chan)
+{ }
+
+#endif
+
+#endif /* __SPRD_MCDT_H */
-- 
2.20.1

