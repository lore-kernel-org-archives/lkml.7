Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366F620644
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563881394;
	bh=nPSpGJSvFRFa4jNc9eKMIQqzR3BmZynrDO+Y4g/S4lQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wm8WVUSXy1Z0sZ3gf/+Pqc1JWBx2aZy2HlS0QNRQuhnaCbfkXuWP3fOok5ZuOF520
	 a2OTMHoOSyZqxwXR7UEawG5M6SA55pvaekYac2Kc22+c2GwXIhs+BeMp++/2XfK/Gk
	 joG+bp0CdfpmbdiyOl8r56OtW2Xs8ur76PbVT/4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbfGWL3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:29:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfGWL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+rP4xJ7fb2Ndj2T4454RAtAqX2l9+soqUIaqsvpd2WA=; b=LG9Y3uD3AblJ
        j31b0dDP2FeJ7pigaZMHQfeddOeYUxuv9sXm5HeIgnnhkzbGS32F5ycqLUtwhEzlGADJHmWl+7kPU
        iLQkZ23DeG4i+XIEoEqv2wDTYTQG163qrCeuJ/tEvYy0vkk+53uAQiZZBRpZUiX5zJp9ZoPbP5Utz
        eDSQE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpsym-0003Id-4M; Tue, 23 Jul 2019 11:29:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 843C42742B59; Tue, 23 Jul 2019 12:29:11 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        festevam@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        Nicolin Chen <nicoleotsuka@gmail.com>, perex@perex.cz,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_esai: recover the channel swap after xrun" to the asoc tree
In-Reply-To: <326035cb99975361699d9ed748054b08bc06a341.1562842206.git.shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190723112911.843C42742B59@ypsilon.sirena.org.uk>
Date:   Tue, 23 Jul 2019 12:29:11 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_esai: recover the channel swap after xrun

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 7ccafa2b3879612ab9ed88bb6664bd4085957186 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Thu, 11 Jul 2019 18:49:46 +0800
Subject: [PATCH] ASoC: fsl_esai: recover the channel swap after xrun

There is chip errata ERR008000, the reference doc is
(https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf),

The issue is "While using ESAI transmit or receive and
an underrun/overrun happens, channel swap may occur.
The only recovery mechanism is to reset the ESAI."

This issue exist in imx3/imx5/imx6(partial) series.

In this commit add a tasklet to handle reset of ESAI
after xrun happens to recover the channel swap.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/326035cb99975361699d9ed748054b08bc06a341.1562842206.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index ab460d6d7432..4ce8ac769244 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -32,6 +32,7 @@
  * @extalclk: esai clock source to derive HCK, SCK and FS
  * @fsysclk: system clock source to derive HCK, SCK and FS
  * @spbaclk: SPBA clock (optional, depending on SoC design)
+ * @task: tasklet to handle the reset operation
  * @fifo_depth: depth of tx/rx FIFO
  * @slot_width: width of each DAI slot
  * @slots: number of slots
@@ -42,6 +43,7 @@
  * @sck_div: if using PSR/PM dividers for SCKx clock
  * @slave_mode: if fully using DAI slave mode
  * @synchronous: if using tx/rx synchronous mode
+ * @reset_at_xrun: flags for enable reset operaton
  * @name: driver name
  */
 struct fsl_esai {
@@ -53,6 +55,7 @@ struct fsl_esai {
 	struct clk *extalclk;
 	struct clk *fsysclk;
 	struct clk *spbaclk;
+	struct tasklet_struct task;
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
@@ -65,6 +68,7 @@ struct fsl_esai {
 	bool sck_div[2];
 	bool slave_mode;
 	bool synchronous;
+	bool reset_at_xrun;
 	char name[32];
 };
 
@@ -73,8 +77,16 @@ static irqreturn_t esai_isr(int irq, void *devid)
 	struct fsl_esai *esai_priv = (struct fsl_esai *)devid;
 	struct platform_device *pdev = esai_priv->pdev;
 	u32 esr;
+	u32 saisr;
 
 	regmap_read(esai_priv->regmap, REG_ESAI_ESR, &esr);
+	regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);
+
+	if ((saisr & (ESAI_SAISR_TUE | ESAI_SAISR_ROE)) &&
+	    esai_priv->reset_at_xrun) {
+		dev_dbg(&pdev->dev, "reset module for xrun\n");
+		tasklet_schedule(&esai_priv->task);
+	}
 
 	if (esr & ESAI_ESR_TINIT_MASK)
 		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
@@ -635,10 +647,17 @@ static void fsl_esai_trigger_start(struct fsl_esai *esai_priv, bool tx)
 			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(mask));
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
 			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
+
+	/* Enable Exception interrupt */
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
+			   ESAI_xCR_xEIE_MASK, ESAI_xCR_xEIE);
 }
 
 static void fsl_esai_trigger_stop(struct fsl_esai *esai_priv, bool tx)
 {
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
+			   ESAI_xCR_xEIE_MASK, 0);
+
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 			   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK, 0);
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
@@ -653,6 +672,51 @@ static void fsl_esai_trigger_stop(struct fsl_esai *esai_priv, bool tx)
 			   ESAI_xFCR_xFR, 0);
 }
 
+static void fsl_esai_hw_reset(unsigned long arg)
+{
+	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
+	bool tx = true, rx = false, enabled[2];
+	u32 tfcr, rfcr;
+
+	/* Save the registers */
+	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
+	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
+	enabled[tx] = tfcr & ESAI_xFCR_xFEN;
+	enabled[rx] = rfcr & ESAI_xFCR_xFEN;
+
+	/* Stop the tx & rx */
+	fsl_esai_trigger_stop(esai_priv, tx);
+	fsl_esai_trigger_stop(esai_priv, rx);
+
+	/* Reset the esai, and ignore return value */
+	fsl_esai_hw_init(esai_priv);
+
+	/* Enforce ESAI personal resets for both TX and RX */
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+			   ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+			   ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);
+
+	/* Restore registers by regcache_sync, and ignore return value */
+	fsl_esai_register_restore(esai_priv);
+
+	/* Remove ESAI personal resets by configuring PCRC and PRRC also */
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+			   ESAI_xCR_xPR_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+			   ESAI_xCR_xPR_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
+			   ESAI_PRRC_PDC_MASK, ESAI_PRRC_PDC(ESAI_GPIO));
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
+			   ESAI_PCRC_PC_MASK, ESAI_PCRC_PC(ESAI_GPIO));
+
+	/* Restart tx / rx, if they already enabled */
+	if (enabled[tx])
+		fsl_esai_trigger_start(esai_priv, tx);
+	if (enabled[rx])
+		fsl_esai_trigger_start(esai_priv, rx);
+}
+
 static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 			    struct snd_soc_dai *dai)
 {
@@ -857,6 +921,10 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	esai_priv->pdev = pdev;
 	snprintf(esai_priv->name, sizeof(esai_priv->name), "%pOFn", np);
 
+	if (of_device_is_compatible(np, "fsl,vf610-esai") ||
+	    of_device_is_compatible(np, "fsl,imx35-esai"))
+		esai_priv->reset_at_xrun = true;
+
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
@@ -956,6 +1024,9 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	tasklet_init(&esai_priv->task, fsl_esai_hw_reset,
+		     (unsigned long)esai_priv);
+
 	pm_runtime_enable(&pdev->dev);
 
 	regcache_cache_only(esai_priv->regmap, true);
@@ -969,7 +1040,10 @@ static int fsl_esai_probe(struct platform_device *pdev)
 
 static int fsl_esai_remove(struct platform_device *pdev)
 {
+	struct fsl_esai *esai_priv = platform_get_drvdata(pdev);
+
 	pm_runtime_disable(&pdev->dev);
+	tasklet_kill(&esai_priv->task);
 
 	return 0;
 }
-- 
2.20.1

