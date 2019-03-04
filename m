Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5732C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A672120830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551657972;
	bh=vmM9GAzgfSke43zWaIHKxOMAgkbDQLdo28Fr0H9TmwQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=do4nIaUXz1rk5VeYb1q312046wGXGidfvFPLDndJcn9m85P47cVc2ynzE8ZUSB0oK
	 proXOdgWtOSDtilPZ+xoWIhz/oTunmjHnDaEOxWEjfs+nkN3WIpAh/B8Wp8Y/T5pM0
	 BTY8g1enNU8TDSNLOLscMQOFBkhTROe4i/oU+ZDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDAGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53130 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDAGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ESXILQAfTfwpf/2QlyTG4dCNJGuUnCFuCDAA0h5hZSE=; b=JiYGkU2LSUxP
        wX4HtgXfd/J1QbIgaxkzxI95O5FS5W8hvDpC4bYfWw/WDBdrnZ9wRgci1Aj8QJKZ9Jxn6Pd72tP6N
        Q4W0h9fdL3fYMJhExxXDbyChXmfw4PuwfwqWyK4K/d0N8+0W9MuKfXA6Gibj8TFUk3xwU7uyzZk1P
        ea0FY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7F-0007O0-QE; Mon, 04 Mar 2019 00:05:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F3B20440082; Mon,  4 Mar 2019 00:05:56 +0000 (GMT)
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
Subject: Applied "ASoC: stm32: sai: fix oversampling mode" to the asoc tree
In-Reply-To:  <1551359965-25228-5-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190304000556.F3B20440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:05:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: fix oversampling mode

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

From 71d9537fada47762a1a1b33a8a1f95a92d7edc11 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 28 Feb 2019 14:19:24 +0100
Subject: [PATCH] ASoC: stm32: sai: fix oversampling mode

Set OSR bit if mclk/fs ratio is 512.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cad415e03b5e..cb658463ccd1 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -913,7 +913,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 				     struct snd_pcm_hw_params *params)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	int div = 0;
+	int div = 0, cr1 = 0;
 	int sai_clk_rate, mclk_ratio, den;
 	unsigned int rate = params_rate(params);
 
@@ -958,13 +958,19 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 		} else {
 			if (sai->mclk_rate) {
 				mclk_ratio = sai->mclk_rate / rate;
-				if ((mclk_ratio != 512) &&
-				    (mclk_ratio != 256)) {
+				if (mclk_ratio == 512) {
+					cr1 = SAI_XCR1_OSR;
+				} else if (mclk_ratio != 256) {
 					dev_err(cpu_dai->dev,
 						"Wrong mclk ratio %d\n",
 						mclk_ratio);
 					return -EINVAL;
 				}
+
+				regmap_update_bits(sai->regmap,
+						   STM_SAI_CR1_REGX,
+						   SAI_XCR1_OSR, cr1);
+
 				div = stm32_sai_get_clk_div(sai, sai_clk_rate,
 							    sai->mclk_rate);
 				if (div < 0)
-- 
2.20.1

