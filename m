Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749C7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EFA2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567705182;
	bh=9t0HTsc84SJjzsATytWKnYo8qqC+FTVJb+ITwm336Rk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FIL57MnumHohCAbwXMWWEN1j7SlEEAQfbMdC6NKTQZeDBx9VXP5IPOcFjvWQ+LtBq
	 iGKkrdIilnjEmxd2XmosNWIiekccCX6oAyeCXxmq52LMVbMeWKV9W6pPOFdh38dddK
	 765lUfMZiLKoZJOz4+UNEgPj6DHhjCFMvsr4ppds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbfIERjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:39:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfIERi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4gbe+e5abX7vIgA3PShfmFuRCDSiOubAI1f9VXvtZ3U=; b=wZy0UVg1tMCJ
        7mHw2mUsLSQrBuNZKA0n0hEvYduPG56kLdIpccjhXeEknoFTJGYDmqvm9xE/7P0T1jcSSnH0NrB9Z
        QPDg3pEvz55HQHgnRP9dKiy8WCppYX1GC7XQke2SC1cPwS9z/1sb1lNA3rGiXRrPTAGgQhRgROKZU
        UakUY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5vie-0005Gg-D1; Thu, 05 Sep 2019 17:38:52 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D62452742D1F; Thu,  5 Sep 2019 18:38:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-frddr: add sm1 support" to the asoc tree
In-Reply-To: <20190905120120.31752-7-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190905173851.D62452742D1F@ypsilon.sirena.org.uk>
Date:   Thu,  5 Sep 2019 18:38:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-frddr: add sm1 support

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

From 52dd80d8f7386483bc60b2b7470e47a2e6f61d7c Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 5 Sep 2019 14:01:18 +0200
Subject: [PATCH] ASoC: meson: axg-frddr: add sm1 support

On sm1, the output routing bits have moved to CTRL2 register

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190905120120.31752-7-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.c  |  2 +-
 sound/soc/meson/axg-fifo.h  |  1 +
 sound/soc/meson/axg-frddr.c | 73 +++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 80a3dde35b5c..5a3749938900 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -306,7 +306,7 @@ static const struct regmap_config axg_fifo_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= FIFO_INIT_ADDR,
+	.max_register	= FIFO_CTRL2,
 };
 
 int axg_fifo_probe(struct platform_device *pdev)
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index 5caf81241dfe..bb1e2ce50256 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -61,6 +61,7 @@ struct snd_soc_pcm_runtime;
 #define  STATUS1_INT_STS(x)		((x) << 0)
 #define FIFO_STATUS2			0x18
 #define FIFO_INIT_ADDR			0x24
+#define FIFO_CTRL2			0x28
 
 struct axg_fifo {
 	struct regmap *map;
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 0968e8375000..6ab111c31b28 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -23,6 +23,12 @@
 #define CTRL0_SEL3_SHIFT		8
 #define CTRL0_SEL3_EN_SHIFT		11
 #define CTRL1_FRDDR_FORCE_FINISH	BIT(12)
+#define CTRL2_SEL1_SHIFT		0
+#define CTRL2_SEL1_EN_SHIFT		4
+#define CTRL2_SEL2_SHIFT		8
+#define CTRL2_SEL2_EN_SHIFT		12
+#define CTRL2_SEL3_SHIFT		16
+#define CTRL2_SEL3_EN_SHIFT		20
 
 static int g12a_frddr_dai_prepare(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
@@ -269,6 +275,70 @@ static const struct axg_fifo_match_data g12a_frddr_match_data = {
 	.dai_drv	= &g12a_frddr_dai_drv
 };
 
+/* On SM1, the output selection in on CTRL2 */
+static const struct snd_kcontrol_new sm1_frddr_out1_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL2,
+				    CTRL2_SEL1_EN_SHIFT, 1, 0);
+static const struct snd_kcontrol_new sm1_frddr_out2_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL2,
+				    CTRL2_SEL2_EN_SHIFT, 1, 0);
+static const struct snd_kcontrol_new sm1_frddr_out3_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL2,
+				    CTRL2_SEL3_EN_SHIFT, 1, 0);
+
+static SOC_ENUM_SINGLE_DECL(sm1_frddr_sel1_enum, FIFO_CTRL2, CTRL2_SEL1_SHIFT,
+			    axg_frddr_sel_texts);
+static SOC_ENUM_SINGLE_DECL(sm1_frddr_sel2_enum, FIFO_CTRL2, CTRL2_SEL2_SHIFT,
+			    axg_frddr_sel_texts);
+static SOC_ENUM_SINGLE_DECL(sm1_frddr_sel3_enum, FIFO_CTRL2, CTRL2_SEL3_SHIFT,
+			    axg_frddr_sel_texts);
+
+static const struct snd_kcontrol_new sm1_frddr_out1_demux =
+	SOC_DAPM_ENUM("Output Src 1", sm1_frddr_sel1_enum);
+static const struct snd_kcontrol_new sm1_frddr_out2_demux =
+	SOC_DAPM_ENUM("Output Src 2", sm1_frddr_sel2_enum);
+static const struct snd_kcontrol_new sm1_frddr_out3_demux =
+	SOC_DAPM_ENUM("Output Src 3", sm1_frddr_sel3_enum);
+
+static const struct snd_soc_dapm_widget sm1_frddr_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("SRC 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SRC 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SRC 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SWITCH("SRC 1 EN", SND_SOC_NOPM, 0, 0,
+			    &sm1_frddr_out1_enable),
+	SND_SOC_DAPM_SWITCH("SRC 2 EN", SND_SOC_NOPM, 0, 0,
+			    &sm1_frddr_out2_enable),
+	SND_SOC_DAPM_SWITCH("SRC 3 EN", SND_SOC_NOPM, 0, 0,
+			    &sm1_frddr_out3_enable),
+	SND_SOC_DAPM_DEMUX("SINK 1 SEL", SND_SOC_NOPM, 0, 0,
+			   &sm1_frddr_out1_demux),
+	SND_SOC_DAPM_DEMUX("SINK 2 SEL", SND_SOC_NOPM, 0, 0,
+			   &sm1_frddr_out2_demux),
+	SND_SOC_DAPM_DEMUX("SINK 3 SEL", SND_SOC_NOPM, 0, 0,
+			   &sm1_frddr_out3_demux),
+	SND_SOC_DAPM_AIF_OUT("OUT 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 5", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 6", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 7", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_component_driver sm1_frddr_component_drv = {
+	.dapm_widgets		= sm1_frddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sm1_frddr_dapm_widgets),
+	.dapm_routes		= g12a_frddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(g12a_frddr_dapm_routes),
+	.ops			= &g12a_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data sm1_frddr_match_data = {
+	.component_drv	= &sm1_frddr_component_drv,
+	.dai_drv	= &g12a_frddr_dai_drv
+};
+
 static const struct of_device_id axg_frddr_of_match[] = {
 	{
 		.compatible = "amlogic,axg-frddr",
@@ -276,6 +346,9 @@ static const struct of_device_id axg_frddr_of_match[] = {
 	}, {
 		.compatible = "amlogic,g12a-frddr",
 		.data = &g12a_frddr_match_data,
+	}, {
+		.compatible = "amlogic,sm1-frddr",
+		.data = &sm1_frddr_match_data,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_frddr_of_match);
-- 
2.20.1

