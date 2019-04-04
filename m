Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B022F2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365826;
	bh=JcrrORXkL1hqb+TESJ5ctT0QZGHxaZQmMUilP/1cO/E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=r6FbLLs9Xg+O7SUUwpkOITGUY1JCWEgUSBlmP7Ry23WttRrgeFtxQselG33z2wrzO
	 0emEI84+XVjnwBcceWXxdCWjVJ1bk5HpEKE5TKEv72U4Qbt++uYj/nJY3BTuURIX0M
	 Hx6s0DgXaiPpsAQ8E86G8CGjy+VJu5+B8tK6PQUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDDIRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDIRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hAV311Hv6SeJFckOxfBg969H9FP6zxbVT2n2++m2uug=; b=XrC3p9/Jl1do
        pouYpEOJoIQ290IkM96T4zVu85DTBslcTIJg3Bfa560zYpxRxLtceKUA+/hFH7gy4x6FIS1tSii8J
        ZBjPupneH/vkvEjaAd/wjnZmvT64Olw0Cgz+FZBIKGd28XceawA39hXtoSQYKripUWMB0UFiUGyqK
        V5w4U=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxYI-000525-0x; Thu, 04 Apr 2019 08:16:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1BCFA441D3C; Thu,  4 Apr 2019 15:16:47 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: pdm: fixup pdm fractional div" to the asoc tree
In-Reply-To:  <1554349869-23623-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081647.1BCFA441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:47 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: pdm: fixup pdm fractional div

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 624e8e00acafe3d31a7c31e67fa95ce06e324bf8 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:51:09 +0800
Subject: [PATCH] ASoC: rockchip: pdm: fixup pdm fractional div

This patch adds support fractional div for rk3308.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 172 ++++++++++++++++++++++--------
 sound/soc/rockchip/rockchip_pdm.h |   9 ++
 2 files changed, 139 insertions(+), 42 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index c50494b0ed0d..4f93a7454e85 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -17,14 +17,23 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/rational.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 
 #include "rockchip_pdm.h"
 
 #define PDM_DMA_BURST_SIZE	(8) /* size * width: 8*4 = 32 bytes */
+#define PDM_SIGNOFF_CLK_RATE	(100000000)
+
+enum rk_pdm_version {
+	RK_PDM_RK3229,
+	RK_PDM_RK3308,
+};
 
 struct rk_pdm_dev {
 	struct device *dev;
@@ -32,22 +41,51 @@ struct rk_pdm_dev {
 	struct clk *hclk;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	struct reset_control *reset;
+	enum rk_pdm_version version;
 };
 
 struct rk_pdm_clkref {
 	unsigned int sr;
 	unsigned int clk;
+	unsigned int clk_out;
+};
+
+struct rk_pdm_ds_ratio {
+	unsigned int ratio;
+	unsigned int sr;
 };
 
 static struct rk_pdm_clkref clkref[] = {
-	{ 8000, 40960000 },
-	{ 11025, 56448000 },
-	{ 12000, 61440000 },
+	{ 8000, 40960000, 2048000 },
+	{ 11025, 56448000, 2822400 },
+	{ 12000, 61440000, 3072000 },
+	{ 8000, 98304000, 2048000 },
+	{ 12000, 98304000, 3072000 },
+};
+
+static struct rk_pdm_ds_ratio ds_ratio[] = {
+	{ 0, 192000 },
+	{ 0, 176400 },
+	{ 0, 128000 },
+	{ 1, 96000 },
+	{ 1, 88200 },
+	{ 1, 64000 },
+	{ 2, 48000 },
+	{ 2, 44100 },
+	{ 2, 32000 },
+	{ 3, 24000 },
+	{ 3, 22050 },
+	{ 3, 16000 },
+	{ 4, 12000 },
+	{ 4, 11025 },
+	{ 4, 8000 },
 };
 
-static unsigned int get_pdm_clk(unsigned int sr)
+static unsigned int get_pdm_clk(struct rk_pdm_dev *pdm, unsigned int sr,
+				unsigned int *clk_src, unsigned int *clk_out)
 {
-	unsigned int i, count, clk, div;
+	unsigned int i, count, clk, div, rate;
 
 	clk = 0;
 	if (!sr)
@@ -59,14 +97,39 @@ static unsigned int get_pdm_clk(unsigned int sr)
 			continue;
 		div = sr / clkref[i].sr;
 		if ((div & (div - 1)) == 0) {
+			*clk_out = clkref[i].clk_out;
+			rate = clk_round_rate(pdm->clk, clkref[i].clk);
+			if (rate != clkref[i].clk)
+				continue;
 			clk = clkref[i].clk;
+			*clk_src = clkref[i].clk;
 			break;
 		}
 	}
 
+	if (!clk) {
+		clk = clk_round_rate(pdm->clk, PDM_SIGNOFF_CLK_RATE);
+		*clk_src = clk;
+	}
 	return clk;
 }
 
+static unsigned int get_pdm_ds_ratio(unsigned int sr)
+{
+	unsigned int i, count, ratio;
+
+	ratio = 0;
+	if (!sr)
+		return ratio;
+
+	count = ARRAY_SIZE(ds_ratio);
+	for (i = 0; i < count; i++) {
+		if (sr == ds_ratio[i].sr)
+			ratio = ds_ratio[i].ratio;
+	}
+	return ratio;
+}
+
 static inline struct rk_pdm_dev *to_info(struct snd_soc_dai *dai)
 {
 	return snd_soc_dai_get_drvdata(dai);
@@ -95,40 +158,52 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	struct rk_pdm_dev *pdm = to_info(dai);
 	unsigned int val = 0;
 	unsigned int clk_rate, clk_div, samplerate;
+	unsigned int clk_src, clk_out;
+	unsigned long m, n;
+	bool change;
 	int ret;
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
 	samplerate = params_rate(params);
-	clk_rate = get_pdm_clk(samplerate);
+	clk_rate = get_pdm_clk(pdm, samplerate, &clk_src, &clk_out);
 	if (!clk_rate)
 		return -EINVAL;
 
-	ret = clk_set_rate(pdm->clk, clk_rate);
+	ret = clk_set_rate(pdm->clk, clk_src);
 	if (ret)
 		return -EINVAL;
 
-	clk_div = DIV_ROUND_CLOSEST(clk_rate, samplerate);
-
-	switch (clk_div) {
-	case 320:
-		val = PDM_CLK_320FS;
-		break;
-	case 640:
-		val = PDM_CLK_640FS;
-		break;
-	case 1280:
-		val = PDM_CLK_1280FS;
-		break;
-	case 2560:
-		val = PDM_CLK_2560FS;
-		break;
-	case 5120:
-		val = PDM_CLK_5120FS;
-		break;
-	default:
-		dev_err(pdm->dev, "unsupported div: %d\n", clk_div);
-		return -EINVAL;
+	if (pdm->version == RK_PDM_RK3308) {
+		rational_best_approximation(clk_out, clk_src,
+					    GENMASK(16 - 1, 0),
+					    GENMASK(16 - 1, 0),
+					    &m, &n);
+
+		val = (m << PDM_FD_NUMERATOR_SFT) |
+			(n << PDM_FD_DENOMINATOR_SFT);
+		regmap_update_bits_check(pdm->regmap, PDM_CTRL1,
+					 PDM_FD_NUMERATOR_MSK |
+					 PDM_FD_DENOMINATOR_MSK,
+					 val, &change);
+		if (change) {
+			reset_control_assert(pdm->reset);
+			reset_control_deassert(pdm->reset);
+			rockchip_pdm_rxctrl(pdm, 0);
+		}
+		clk_div = n / m;
+		if (clk_div >= 40)
+			val = PDM_CLK_FD_RATIO_40;
+		else if (clk_div <= 35)
+			val = PDM_CLK_FD_RATIO_35;
+		else
+			return -EINVAL;
+		regmap_update_bits(pdm->regmap, PDM_CLK_CTRL,
+				   PDM_CLK_FD_RATIO_MSK,
+				   val);
 	}
-
+	val = get_pdm_ds_ratio(samplerate);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_DS_RATIO_MSK, val);
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_CF_MSK, PDM_HPF_60HZ);
@@ -177,13 +252,11 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		regmap_update_bits(pdm->regmap, PDM_CTRL0,
-				   PDM_PATH_MSK | PDM_VDW_MSK,
-				   val);
-		regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
-				   PDM_DMA_RDL(16));
-	}
+	regmap_update_bits(pdm->regmap, PDM_CTRL0,
+			   PDM_PATH_MSK | PDM_VDW_MSK,
+			   val);
+	regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
+			   PDM_DMA_RDL(16));
 
 	return 0;
 }
@@ -380,8 +453,19 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
+static const struct of_device_id rockchip_pdm_match[] = {
+	{ .compatible = "rockchip,pdm", },
+	{ .compatible = "rockchip,px30-pdm",
+	  .data = (void *)RK_PDM_RK3308 },
+	{ .compatible = "rockchip,rk3308-pdm",
+	  .data = (void *)RK_PDM_RK3308 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rockchip_pdm_match);
+
 static int rockchip_pdm_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct rk_pdm_dev *pdm;
 	struct resource *res;
 	void __iomem *regs;
@@ -391,6 +475,16 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 	if (!pdm)
 		return -ENOMEM;
 
+	match = of_match_device(rockchip_pdm_match, &pdev->dev);
+	if (match)
+		pdm->version = (enum rk_pdm_version)match->data;
+
+	if (pdm->version == RK_PDM_RK3308) {
+		pdm->reset = devm_reset_control_get(&pdev->dev, "pdm-m");
+		if (IS_ERR(pdm->reset))
+			return PTR_ERR(pdm->reset);
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(regs))
@@ -503,12 +597,6 @@ static const struct dev_pm_ops rockchip_pdm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(rockchip_pdm_suspend, rockchip_pdm_resume)
 };
 
-static const struct of_device_id rockchip_pdm_match[] = {
-	{ .compatible = "rockchip,pdm", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, rockchip_pdm_match);
-
 static struct platform_driver rockchip_pdm_driver = {
 	.probe  = rockchip_pdm_probe,
 	.remove = rockchip_pdm_remove,
diff --git a/sound/soc/rockchip/rockchip_pdm.h b/sound/soc/rockchip/rockchip_pdm.h
index 00a8fa187d22..ae88644aa334 100644
--- a/sound/soc/rockchip/rockchip_pdm.h
+++ b/sound/soc/rockchip/rockchip_pdm.h
@@ -53,7 +53,16 @@
 #define PDM_VDW_MSK		(0x1f << 0)
 #define PDM_VDW(X)		((X - 1) << 0)
 
+/* PDM CTRL1 */
+#define PDM_FD_NUMERATOR_SFT	16
+#define PDM_FD_NUMERATOR_MSK	GENMASK(31, 16)
+#define PDM_FD_DENOMINATOR_SFT	0
+#define PDM_FD_DENOMINATOR_MSK	GENMASK(15, 0)
+
 /* PDM CLK CTRL */
+#define PDM_CLK_FD_RATIO_MSK	BIT(6)
+#define PDM_CLK_FD_RATIO_40	(0X0 << 6)
+#define PDM_CLK_FD_RATIO_35	BIT(6)
 #define PDM_CLK_MSK		BIT(5)
 #define PDM_CLK_EN		BIT(5)
 #define PDM_CLK_DIS		(0x0 << 5)
-- 
2.20.1

