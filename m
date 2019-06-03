Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17AAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D522075B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559584944;
	bh=yZ45zoxTvTjNFQUCKYIFQhB+WCfoKkzJQtXTMYUqUow=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=K05YjH8WGbSmIaGqaN2Cuc8uQQZ6rr8dEXilU2MFZ6xq8aPsbNDDhx9yftsGJ/x/z
	 S/xJSwyfEYw3j6ZuqneGe29mkKkjAZr5qYnDVeJG+BpHpLHIzz36jW4yoEluJSSHRe
	 nV4BxZtBxTtQlRrwkm2FS84v04oSjHaWb2Hqmv0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFCSCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:02:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfFCSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UT0WlMnrjn93wF9k1eoMkng9Hqcae4T/R1b17iqUEyo=; b=xgNFhu4FNf+l
        rTQJgwiG3GAG7nW0pYQnG6AI5HzOjYl9SMT9iwfQ3C3HCX5zFCLHw+gGuUZtFMX1/7ZIP5cBsMS0j
        I1AaLjW2YPi83M9Kme0pMC1TheBZ3gs4DPgdwSTFeHJxfSN/ldcGMsU3IemfJktJVhcHjDv8KCHX1
        4FDwk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrHW-0003ZF-Tr; Mon, 03 Jun 2019 18:02:03 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 21C90440049; Mon,  3 Jun 2019 19:02:02 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: sai: manage identification registers" to the asoc tree
In-Reply-To: <1559549794-7246-1-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190603180202.21C90440049@finisterre.sirena.org.uk>
Date:   Mon,  3 Jun 2019 19:02:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: manage identification registers

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

From 1d9c95c1896256a64e3a8d825f9e78cc79d29ebb Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 3 Jun 2019 10:16:34 +0200
Subject: [PATCH] ASoC: stm32: sai: manage identification registers

Add support of identification registers in STM32 SAI.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c     | 44 ++++++++++++++++++++++++----
 sound/soc/stm/stm32_sai.h     | 54 ++++++++++++++++++++++++++---------
 sound/soc/stm/stm32_sai_sub.c | 14 +++++----
 3 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 7550d5f08be3..98b29f712831 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -30,13 +30,20 @@
 #include "stm32_sai.h"
 
 static const struct stm32_sai_conf stm32_sai_conf_f4 = {
-	.version = SAI_STM32F4,
-	.has_spdif = false,
+	.version = STM_SAI_STM32F4,
+	.fifo_size = 8,
+	.has_spdif_pdm = false,
 };
 
+/*
+ * Default settings for stm32 H7 socs and next.
+ * These default settings will be overridden if the soc provides
+ * support of hardware configuration registers.
+ */
 static const struct stm32_sai_conf stm32_sai_conf_h7 = {
-	.version = SAI_STM32H7,
-	.has_spdif = true,
+	.version = STM_SAI_STM32H7,
+	.fifo_size = 8,
+	.has_spdif_pdm = true,
 };
 
 static const struct of_device_id stm32_sai_ids[] = {
@@ -157,6 +164,8 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	struct reset_control *rst;
 	struct resource *res;
 	const struct of_device_id *of_id;
+	u32 val;
+	int ret;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
@@ -169,7 +178,8 @@ static int stm32_sai_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(stm32_sai_ids, &pdev->dev);
 	if (of_id)
-		sai->conf = (struct stm32_sai_conf *)of_id->data;
+		memcpy(&sai->conf, (const struct stm32_sai_conf *)of_id->data,
+		       sizeof(struct stm32_sai_conf));
 	else
 		return -EINVAL;
 
@@ -208,6 +218,30 @@ static int stm32_sai_probe(struct platform_device *pdev)
 		reset_control_deassert(rst);
 	}
 
+	/* Enable peripheral clock to allow register access */
+	ret = clk_prepare_enable(sai->pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	val = FIELD_GET(SAI_IDR_ID_MASK,
+			readl_relaxed(sai->base + STM_SAI_IDR));
+	if (val == SAI_IPIDR_NUMBER) {
+		val = readl_relaxed(sai->base + STM_SAI_HWCFGR);
+		sai->conf.fifo_size = FIELD_GET(SAI_HWCFGR_FIFO_SIZE, val);
+		sai->conf.has_spdif_pdm = !!FIELD_GET(SAI_HWCFGR_SPDIF_PDM,
+						      val);
+
+		val = readl_relaxed(sai->base + STM_SAI_VERR);
+		sai->conf.version = val;
+
+		dev_dbg(&pdev->dev, "SAI version: %lu.%lu registered\n",
+			FIELD_GET(SAI_VERR_MAJ_MASK, val),
+			FIELD_GET(SAI_VERR_MIN_MASK, val));
+	}
+	clk_disable_unprepare(sai->pclk);
+
 	sai->pdev = pdev;
 	sai->set_sync = &stm32_sai_set_sync;
 	platform_set_drvdata(pdev, sai);
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index 9c36a393ab7b..158c73f557f7 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -37,6 +37,12 @@
 #define STM_SAI_PDMCR_REGX	0x40
 #define STM_SAI_PDMLY_REGX	0x44
 
+/* Hardware configuration registers */
+#define STM_SAI_HWCFGR		0x3F0
+#define STM_SAI_VERR		0x3F4
+#define STM_SAI_IDR		0x3F8
+#define STM_SAI_SIDR		0x3FC
+
 /******************** Bit definition for SAI_GCR register *******************/
 #define SAI_GCR_SYNCIN_SHIFT	0
 #define SAI_GCR_SYNCIN_WDTH	2
@@ -82,7 +88,7 @@
 #define SAI_XCR1_NODIV		BIT(SAI_XCR1_NODIV_SHIFT)
 
 #define SAI_XCR1_MCKDIV_SHIFT	20
-#define SAI_XCR1_MCKDIV_WIDTH(x)	(((x) == SAI_STM32F4) ? 4 : 6)
+#define SAI_XCR1_MCKDIV_WIDTH(x)	(((x) == STM_SAI_STM32F4) ? 4 : 6)
 #define SAI_XCR1_MCKDIV_MASK(x) GENMASK((SAI_XCR1_MCKDIV_SHIFT + (x) - 1),\
 				SAI_XCR1_MCKDIV_SHIFT)
 #define SAI_XCR1_MCKDIV_SET(x)	((x) << SAI_XCR1_MCKDIV_SHIFT)
@@ -234,8 +240,33 @@
 #define SAI_PDMDLY_4R_MASK	GENMASK(30, SAI_PDMDLY_4R_SHIFT)
 #define SAI_PDMDLY_4R_WIDTH	3
 
-#define STM_SAI_IS_F4(ip)	((ip)->conf->version == SAI_STM32F4)
-#define STM_SAI_IS_H7(ip)	((ip)->conf->version == SAI_STM32H7)
+/* Registers below apply to SAI version 2.1 and more */
+
+/* Bit definition for SAI_HWCFGR register */
+#define SAI_HWCFGR_FIFO_SIZE	GENMASK(7, 0)
+#define SAI_HWCFGR_SPDIF_PDM	GENMASK(11, 8)
+#define SAI_HWCFGR_REGOUT	GENMASK(19, 12)
+
+/* Bit definition for SAI_VERR register */
+#define SAI_VERR_MIN_MASK	GENMASK(3, 0)
+#define SAI_VERR_MAJ_MASK	GENMASK(7, 4)
+
+/* Bit definition for SAI_IDR register */
+#define SAI_IDR_ID_MASK		GENMASK(31, 0)
+
+/* Bit definition for SAI_SIDR register */
+#define SAI_SIDR_ID_MASK	GENMASK(31, 0)
+
+#define SAI_IPIDR_NUMBER	0x00130031
+
+/* SAI version numbers are 1.x for F4. Major version number set to 1 for F4 */
+#define STM_SAI_STM32F4		BIT(4)
+/* Dummy version number for H7 socs and next */
+#define STM_SAI_STM32H7		0x0
+
+#define STM_SAI_IS_F4(ip)	((ip)->conf.version == STM_SAI_STM32F4)
+#define STM_SAI_HAS_SPDIF_PDM(ip)\
+				((ip)->pdata->conf.has_spdif_pdm)
 
 enum stm32_sai_syncout {
 	STM_SAI_SYNC_OUT_NONE,
@@ -243,19 +274,16 @@ enum stm32_sai_syncout {
 	STM_SAI_SYNC_OUT_B,
 };
 
-enum stm32_sai_version {
-	SAI_STM32F4,
-	SAI_STM32H7
-};
-
 /**
  * struct stm32_sai_conf - SAI configuration
  * @version: SAI version
- * @has_spdif: SAI S/PDIF support flag
+ * @fifo_size: SAI fifo size as words number
+ * @has_spdif_pdm: SAI S/PDIF and PDM features support flag
  */
 struct stm32_sai_conf {
-	int version;
-	bool has_spdif;
+	u32 version;
+	u32 fifo_size;
+	bool has_spdif_pdm;
 };
 
 /**
@@ -265,7 +293,7 @@ struct stm32_sai_conf {
  * @pclk: SAI bus clock
  * @clk_x8k: SAI parent clock for sampling frequencies multiple of 8kHz
  * @clk_x11k: SAI parent clock for sampling frequencies multiple of 11kHz
- * @version: SOC version
+ * @conf: SAI hardware capabitilites
  * @irq: SAI interrupt line
  * @set_sync: pointer to synchro mode configuration callback
  * @gcr: SAI Global Configuration Register
@@ -276,7 +304,7 @@ struct stm32_sai_data {
 	struct clk *pclk;
 	struct clk *clk_x8k;
 	struct clk *clk_x11k;
-	struct stm32_sai_conf *conf;
+	struct stm32_sai_conf conf;
 	int irq;
 	int (*set_sync)(struct stm32_sai_data *sai,
 			struct device_node *np_provider, int synco, int synci);
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 2a74ce7c9440..7d27efb19380 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -45,7 +45,6 @@
 #define SAI_DATASIZE_24		0x6
 #define SAI_DATASIZE_32		0x7
 
-#define STM_SAI_FIFO_SIZE	8
 #define STM_SAI_DAI_NAME_SIZE	15
 
 #define STM_SAI_IS_PLAYBACK(ip)	((ip)->dir == SNDRV_PCM_STREAM_PLAYBACK)
@@ -63,7 +62,8 @@
 #define SAI_SYNC_EXTERNAL	0x2
 
 #define STM_SAI_PROTOCOL_IS_SPDIF(ip)	((ip)->spdif)
-#define STM_SAI_HAS_SPDIF(x)	((x)->pdata->conf->has_spdif)
+#define STM_SAI_HAS_SPDIF(x)	((x)->pdata->conf.has_spdif_pdm)
+#define STM_SAI_HAS_PDM(x)	((x)->pdata->conf.has_spdif_pdm)
 #define STM_SAI_HAS_EXT_SYNC(x) (!STM_SAI_IS_F4(sai->pdata))
 
 #define SAI_IEC60958_BLOCK_FRAMES	192
@@ -274,7 +274,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 				 unsigned long input_rate,
 				 unsigned long output_rate)
 {
-	int version = sai->pdata->conf->version;
+	int version = sai->pdata->conf.version;
 	int div;
 
 	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
@@ -295,7 +295,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 static int stm32_sai_set_clk_div(struct stm32_sai_sub_data *sai,
 				 unsigned int div)
 {
-	int version = sai->pdata->conf->version;
+	int version = sai->pdata->conf.version;
 	int ret, cr1, mask;
 
 	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
@@ -1148,6 +1148,8 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	 * constraints).
 	 */
 	sai->dma_params.maxburst = 4;
+	if (sai->pdata->conf.fifo_size < 8)
+		sai->dma_params.maxburst = 1;
 	/* Buswidth will be set by framework at runtime */
 	sai->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
 
@@ -1315,8 +1317,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	sai->phys_addr = res->start;
 
 	sai->regmap_config = &stm32_sai_sub_regmap_config_f4;
-	/* Note: PDM registers not available for H7 sub-block B */
-	if (STM_SAI_IS_H7(sai->pdata) && STM_SAI_IS_SUB_A(sai))
+	/* Note: PDM registers not available for sub-block B */
+	if (STM_SAI_HAS_PDM(sai) && STM_SAI_IS_SUB_A(sai))
 		sai->regmap_config = &stm32_sai_sub_regmap_config_h7;
 
 	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "sai_ck",
-- 
2.20.1

