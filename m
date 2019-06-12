Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53551C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127CA217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560355173;
	bh=Yb3cBYPdpKc+fHeJPm5Xe7u7WfOOC1XLozYsy0Hzpcc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dvBZMLH9Esc6Ze8bZV5EPMt1RwCBTE6yk610AW1pIVcoaFoaZ8morQ3o1h07WbE7T
	 Ju/Cedh9BxCua7zSeUtc3zpxytqKTacrdFWjMh7xoAqOSzWcS4iK/hF5O/U0m4SAIk
	 X7STAGAGQ0Z1vFNJ2niIKmhOlHERY0ostgawHr5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440356AbfFLP7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:59:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44130 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438038AbfFLP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YA2MYBNBMatcq9Mz5KnNb8V+dC8ifZ7eYiCOOwL6tbo=; b=lz9BXByn6KgX
        Eutanqm/JEhXdOmdzvZvsoooBh6ZUcu94QNmg8Ibi05s02nTg3zGQvw4lUNqzgfV5wnBoIaJMkYkY
        /DbaHmcGaONCxNJH4e21H6w6/bV0hroU40xOE6biJPyPjx6FqY4lwQqkBk1hTvG6F4uXkrGyWFvfm
        zsi70=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hb5ep-000366-NJ; Wed, 12 Jun 2019 15:59:27 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 04CC7440046; Wed, 12 Jun 2019 16:59:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, jsarha@ti.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        misael.lopez@ti.com, robh+dt@kernel.org
Subject: Applied "ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio" to the asoc tree
In-Reply-To: <20190611122941.10708-3-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190612155927.04CC7440046@finisterre.sirena.org.uk>
Date:   Wed, 12 Jun 2019 16:59:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 764958f2b5239cbf174e70cad4c3f19a8c1081ba Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 11 Jun 2019 15:29:41 +0300
Subject: [PATCH] ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio

When McASP is bus master and it's AUXCLK clock is not static, but it is
a multiple of the frame sync the constraint rules should take it account
when validating possible stream formats.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 52 ++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 9fbc759fdefe..a8378d223a9e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -100,6 +100,7 @@ struct davinci_mcasp {
 
 	int	sysclk_freq;
 	bool	bclk_master;
+	u32	auxclk_fs_ratio;
 
 	unsigned long pdir; /* Pin direction bitfield */
 
@@ -1064,13 +1065,13 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
 }
 
 static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
+				      unsigned int sysclk_freq,
 				      unsigned int bclk_freq, bool set)
 {
-	int error_ppm;
-	unsigned int sysclk_freq = mcasp->sysclk_freq;
 	u32 reg = mcasp_get_reg(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG);
 	int div = sysclk_freq / bclk_freq;
 	int rem = sysclk_freq % bclk_freq;
+	int error_ppm;
 	int aux_div = 1;
 
 	if (div > (ACLKXDIV_MASK + 1)) {
@@ -1175,7 +1176,8 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		if (mcasp->slot_width)
 			sbits = mcasp->slot_width;
 
-		davinci_mcasp_calc_clk_div(mcasp, rate * sbits * slots, true);
+		davinci_mcasp_calc_clk_div(mcasp, mcasp->sysclk_freq,
+					   rate * sbits * slots, true);
 	}
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
@@ -1282,12 +1284,19 @@ static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
 
 	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
 		if (snd_interval_test(ri, davinci_mcasp_dai_rates[i])) {
-			uint bclk_freq = sbits*slots*
-				davinci_mcasp_dai_rates[i];
+			uint bclk_freq = sbits * slots *
+					 davinci_mcasp_dai_rates[i];
+			unsigned int sysclk_freq;
 			int ppm;
 
-			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq,
-							 false);
+			if (rd->mcasp->auxclk_fs_ratio)
+				sysclk_freq =  davinci_mcasp_dai_rates[i] *
+					       rd->mcasp->auxclk_fs_ratio;
+			else
+				sysclk_freq = rd->mcasp->sysclk_freq;
+
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, sysclk_freq,
+							 bclk_freq, false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
 				if (range.empty) {
 					range.min = davinci_mcasp_dai_rates[i];
@@ -1321,12 +1330,19 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (snd_mask_test(fmt, i)) {
 			uint sbits = snd_pcm_format_width(i);
+			unsigned int sysclk_freq;
 			int ppm;
 
+			if (rd->mcasp->auxclk_fs_ratio)
+				sysclk_freq =  rate *
+					       rd->mcasp->auxclk_fs_ratio;
+			else
+				sysclk_freq = rd->mcasp->sysclk_freq;
+
 			if (rd->mcasp->slot_width)
 				sbits = rd->mcasp->slot_width;
 
-			ppm = davinci_mcasp_calc_clk_div(rd->mcasp,
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, sysclk_freq,
 							 sbits * slots * rate,
 							 false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
@@ -1991,6 +2007,22 @@ static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 }
 #endif /* CONFIG_GPIOLIB */
 
+static int davinci_mcasp_get_dt_params(struct davinci_mcasp *mcasp)
+{
+	struct device_node *np = mcasp->dev->of_node;
+	int ret;
+	u32 val;
+
+	if (!np)
+		return 0;
+
+	ret = of_property_read_u32(np, "auxclk-fs-ratio", &val);
+	if (ret >= 0)
+		mcasp->auxclk_fs_ratio = val;
+
+	return 0;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -2224,6 +2256,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	ret = davinci_mcasp_get_dt_params(mcasp);
+	if (ret)
+		return -EINVAL;
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
 					&davinci_mcasp_dai[pdata->op_mode], 1);
-- 
2.20.1

