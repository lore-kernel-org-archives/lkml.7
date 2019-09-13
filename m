Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB418C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7A520830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568367743;
	bh=m8RmtzyJAi2naLNa4WTzYmJ6gveKpUHOz0ME/j7/7SQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Q11SVJzxtnx1b7bV9rtLNMBupf/4yMiZedO+tsko6Arm4IH42S/iSGjOK8BJ/L3qY
	 0x60Pz8JVfK3dTkX6IaG4LrAcPUxnj/V8umj1RcsUdorhQXms0TQTpXvD2McMiQrlz
	 dk/9rUB31uYKvZ3OwBzK9CCQsvP4EXD64Urd+g1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfIMJmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:42:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39756 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIMJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lHumIoWHnfMgoly+K9KCOwt1FKK4j360M4fRV6UdXgg=; b=i7d56xHKmc5d
        HYJR1JpadvREqDSPUR8sLXqZRvcXnYGZPc26BQLDYR/N23x5rb7qeZzda0PyTeOwwPsIVVLwvfGy3
        pzZ1b1XOyM1rgUymbsFYkMJqtzJyWk86BfYLzC7OHary5Mbl3nwutB/D5ii0X5F8nuRiWSqgELJo7
        L6CrE=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8i5p-0003T7-8u; Fri, 13 Sep 2019 09:42:17 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A26C1D00DD9; Fri, 13 Sep 2019 10:42:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        nicoleotsuka@gmail.com, Nicolin Chen <nicoleotsuka@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, shengjiu.wang@nxp.com,
        timur@kernel.org, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_sai: Implement set_bclk_ratio" to the asoc tree
In-Reply-To: <20190830215910.31590-1-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190913094216.A26C1D00DD9@fitzroy.sirena.org.uk>
Date:   Fri, 13 Sep 2019 10:42:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_sai: Implement set_bclk_ratio

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

From 63d1a3488ff58e094a7f517cf93c0250f0a3f6be Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Sat, 31 Aug 2019 00:59:10 +0300
Subject: [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio

This is to allow machine drivers to set a certain bitclk rate
which might not be exactly rate * frame size.

Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20190830215910.31590-1-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 21 +++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 728307acab90..ef0b74693093 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -137,6 +137,16 @@ static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	return 0;
 }
 
+static int fsl_sai_set_dai_bclk_ratio(struct snd_soc_dai *dai,
+				      unsigned int ratio)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
+
+	sai->bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int fsl_dir)
 {
@@ -423,8 +433,14 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		slot_width = sai->slot_width;
 
 	if (!sai->is_slave_mode) {
-		ret = fsl_sai_set_bclk(cpu_dai, tx,
-				slots * slot_width * params_rate(params));
+		if (sai->bclk_ratio)
+			ret = fsl_sai_set_bclk(cpu_dai, tx,
+					       sai->bclk_ratio *
+					       params_rate(params));
+		else
+			ret = fsl_sai_set_bclk(cpu_dai, tx,
+					       slots * slot_width *
+					       params_rate(params));
 		if (ret)
 			return ret;
 
@@ -630,6 +646,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
+	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
 	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b89b0ca26053..b12cb578f6d0 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -176,6 +176,7 @@ struct fsl_sai {
 	unsigned int mclk_streams;
 	unsigned int slots;
 	unsigned int slot_width;
+	unsigned int bclk_ratio;
 
 	const struct fsl_sai_soc_data *soc_data;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-- 
2.20.1

