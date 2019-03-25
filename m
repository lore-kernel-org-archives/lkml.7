Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C9220830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553516551;
	bh=9dlI9lNQZaqgvP4VBkAK1PiEdQb1gSB79AZDtIKB0d0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IAVPbfSGb4LuWif5B4VFmONmikMtZsRup9QKvNoQPEyf0G7eSypf4+s6JH8xVkPzT
	 vReq47bGFCpGl5gb0LXrzrVAhPMjzEpjJ7z+/Dqas8smJJL+5KUJinrWKRFqQ8I3xr
	 isqAIt59/1gSfT2yxqxz9CeYwIyOvVBNoCb2hMGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfCYMW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:22:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbfCYMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=t13H+F8f1pPqlTXdMmQQ1zC6HL/LgwA0o+E4wfIUazg=; b=fnSrNh0+i5F2
        mrvi7lgPif30EdpZJi21vJWwCELuLb9QzSxSnoJXi9Qrf4HYgHsLUXz/3Eo2SpmL94IpCoujp6pqb
        lgv/EdZKq9BQo7V/PEQywAKfyER7EFUb4+rN/iwaNtJPxs1n8PqPQR9dXtC1YsLpa9P3ytVIbXLf1
        2LRKQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8OcB-00023r-DW; Mon, 25 Mar 2019 12:22:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D241911288F1; Mon, 25 Mar 2019 12:22:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: sai: add power management" to the asoc tree
In-Reply-To:  <1553182496-25569-1-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190325122206.D241911288F1@debutante.sirena.org.uk>
Date:   Mon, 25 Mar 2019 12:22:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: add power management

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

From cf8817733d10c0147a01c97219dd0551bcf25e08 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 21 Mar 2019 16:34:56 +0100
Subject: [PATCH] ASoC: stm32: sai: add power management

Add support of low power modes to STM32 SAI driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c     | 80 +++++++++++++++++++++++++++++++----
 sound/soc/stm/stm32_sai.h     |  2 +
 sound/soc/stm/stm32_sai_sub.c | 45 +++++++++++++++-----
 3 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index d68d62f12df5..7550d5f08be3 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 
 #include <sound/dmaengine_pcm.h>
@@ -44,20 +45,41 @@ static const struct of_device_id stm32_sai_ids[] = {
 	{}
 };
 
-static int stm32_sai_sync_conf_client(struct stm32_sai_data *sai, int synci)
+static int stm32_sai_pclk_disable(struct device *dev)
+{
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(sai->pclk);
+
+	return 0;
+}
+
+static int stm32_sai_pclk_enable(struct device *dev)
 {
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
 	int ret;
 
-	/* Enable peripheral clock to allow GCR register access */
 	ret = clk_prepare_enable(sai->pclk);
 	if (ret) {
 		dev_err(&sai->pdev->dev, "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
+	return 0;
+}
+
+static int stm32_sai_sync_conf_client(struct stm32_sai_data *sai, int synci)
+{
+	int ret;
+
+	/* Enable peripheral clock to allow GCR register access */
+	ret = stm32_sai_pclk_enable(&sai->pdev->dev);
+	if (ret)
+		return ret;
+
 	writel_relaxed(FIELD_PREP(SAI_GCR_SYNCIN_MASK, (synci - 1)), sai->base);
 
-	clk_disable_unprepare(sai->pclk);
+	stm32_sai_pclk_disable(&sai->pdev->dev);
 
 	return 0;
 }
@@ -68,11 +90,9 @@ static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 	int ret;
 
 	/* Enable peripheral clock to allow GCR register access */
-	ret = clk_prepare_enable(sai->pclk);
-	if (ret) {
-		dev_err(&sai->pdev->dev, "failed to enable clock: %d\n", ret);
+	ret = stm32_sai_pclk_enable(&sai->pdev->dev);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(&sai->pdev->dev, "Set %pOFn%s as synchro provider\n",
 		sai->pdev->dev.of_node,
@@ -83,13 +103,13 @@ static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 		dev_err(&sai->pdev->dev, "%pOFn%s already set as sync provider\n",
 			sai->pdev->dev.of_node,
 			prev_synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
-		clk_disable_unprepare(sai->pclk);
+			stm32_sai_pclk_disable(&sai->pdev->dev);
 		return -EINVAL;
 	}
 
 	writel_relaxed(FIELD_PREP(SAI_GCR_SYNCOUT_MASK, synco), sai->base);
 
-	clk_disable_unprepare(sai->pclk);
+	stm32_sai_pclk_disable(&sai->pdev->dev);
 
 	return 0;
 }
@@ -195,12 +215,54 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	return devm_of_platform_populate(&pdev->dev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+/*
+ * When pins are shared by two sai sub instances, pins have to be defined
+ * in sai parent node. In this case, pins state is not managed by alsa fw.
+ * These pins are managed in suspend/resume callbacks.
+ */
+static int stm32_sai_suspend(struct device *dev)
+{
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
+	int ret;
+
+	ret = stm32_sai_pclk_enable(dev);
+	if (ret)
+		return ret;
+
+	sai->gcr = readl_relaxed(sai->base);
+	stm32_sai_pclk_disable(dev);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_sai_resume(struct device *dev)
+{
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
+	int ret;
+
+	ret = stm32_sai_pclk_enable(dev);
+	if (ret)
+		return ret;
+
+	writel_relaxed(sai->gcr, sai->base);
+	stm32_sai_pclk_disable(dev);
+
+	return pinctrl_pm_select_default_state(dev);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_sai_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_sai_suspend, stm32_sai_resume)
+};
+
 MODULE_DEVICE_TABLE(of, stm32_sai_ids);
 
 static struct platform_driver stm32_sai_driver = {
 	.driver = {
 		.name = "st,stm32-sai",
 		.of_match_table = stm32_sai_ids,
+		.pm = &stm32_sai_pm_ops,
 	},
 	.probe = stm32_sai_probe,
 };
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index 08de899c766b..9c36a393ab7b 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -268,6 +268,7 @@ struct stm32_sai_conf {
  * @version: SOC version
  * @irq: SAI interrupt line
  * @set_sync: pointer to synchro mode configuration callback
+ * @gcr: SAI Global Configuration Register
  */
 struct stm32_sai_data {
 	struct platform_device *pdev;
@@ -279,4 +280,5 @@ struct stm32_sai_data {
 	int irq;
 	int (*set_sync)(struct stm32_sai_data *sai,
 			struct device_node *np_provider, int synco, int synci);
+	u32 gcr;
 };
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 55d802f51c15..2a90641cf164 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -168,6 +168,7 @@ static bool stm32_sai_sub_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case STM_SAI_DR_REGX:
+	case STM_SAI_SR_REGX:
 		return true;
 	default:
 		return false;
@@ -182,7 +183,6 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 	case STM_SAI_FRCR_REGX:
 	case STM_SAI_SLOTR_REGX:
 	case STM_SAI_IMR_REGX:
-	case STM_SAI_SR_REGX:
 	case STM_SAI_CLRFR_REGX:
 	case STM_SAI_DR_REGX:
 	case STM_SAI_PDMCR_REGX:
@@ -202,6 +202,7 @@ static const struct regmap_config stm32_sai_sub_regmap_config_f4 = {
 	.volatile_reg = stm32_sai_sub_volatile_reg,
 	.writeable_reg = stm32_sai_sub_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static const struct regmap_config stm32_sai_sub_regmap_config_h7 = {
@@ -213,6 +214,7 @@ static const struct regmap_config stm32_sai_sub_regmap_config_h7 = {
 	.volatile_reg = stm32_sai_sub_volatile_reg,
 	.writeable_reg = stm32_sai_sub_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
@@ -441,8 +443,8 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 	if (!flags)
 		return IRQ_NONE;
 
-	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
-			   SAI_XCLRFR_MASK);
+	regmap_write_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
+			  SAI_XCLRFR_MASK);
 
 	if (!sai->substream) {
 		dev_err(&pdev->dev, "Device stopped. Spurious IRQ 0x%x\n", sr);
@@ -704,9 +706,8 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 	}
 
 	/* Enable ITs */
-
-	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX,
-			   SAI_XCLRFR_MASK, SAI_XCLRFR_MASK);
+	regmap_write_bits(sai->regmap, STM_SAI_CLRFR_REGX,
+			  SAI_XCLRFR_MASK, SAI_XCLRFR_MASK);
 
 	imr = SAI_XIMR_OVRUDRIE;
 	if (STM_SAI_IS_CAPTURE(sai)) {
@@ -738,10 +739,10 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 	 * SAI fifo threshold is set to half fifo, to keep enough space
 	 * for DMA incoming bursts.
 	 */
-	regmap_update_bits(sai->regmap, STM_SAI_CR2_REGX,
-			   SAI_XCR2_FFLUSH | SAI_XCR2_FTH_MASK,
-			   SAI_XCR2_FFLUSH |
-			   SAI_XCR2_FTH_SET(STM_SAI_FIFO_TH_HALF));
+	regmap_write_bits(sai->regmap, STM_SAI_CR2_REGX,
+			  SAI_XCR2_FFLUSH | SAI_XCR2_FTH_MASK,
+			  SAI_XCR2_FFLUSH |
+			  SAI_XCR2_FTH_SET(STM_SAI_FIFO_TH_HALF));
 
 	/* DS bits in CR1 not set for SPDIF (size forced to 24 bits).*/
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
@@ -1492,10 +1493,34 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_sai_sub_suspend(struct device *dev)
+{
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, true);
+	regcache_mark_dirty(sai->regmap);
+	return 0;
+}
+
+static int stm32_sai_sub_resume(struct device *dev)
+{
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, false);
+	return regcache_sync(sai->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_sai_sub_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_sai_sub_suspend, stm32_sai_sub_resume)
+};
+
 static struct platform_driver stm32_sai_sub_driver = {
 	.driver = {
 		.name = "st,stm32-sai-sub",
 		.of_match_table = stm32_sai_sub_ids,
+		.pm = &stm32_sai_sub_pm_ops,
 	},
 	.probe = stm32_sai_sub_probe,
 };
-- 
2.20.1

