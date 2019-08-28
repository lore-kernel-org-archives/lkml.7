Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC13C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9B42070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566997995;
	bh=c86ge8RlnOhx7V3qXymX8smQe8YDAdPS05DxG4sHJTM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ms4NzSrvbgcPFDRJVQHp4ZW8V0UCfXIbfUwyRTV8PJ4GRcic5zcynt6A81Xsmra5Q
	 72sVAJgogbqQNjtAjwJDpBpQrqvUXaqdQLu9xZsIu1UeKkTC9aFSxvXoKHtEh/ibzN
	 KQ4jX9VdYnb2Ms3A0ejdSyPur0xd9Srs+lEqrkNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfH1NNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:13:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1NNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4yMUOUxgWj2lZBjlvoHQjM2lBLStqB07tRhlHPrCe0I=; b=oSjvIP5wOYL+
        kKdtYJTP67Q44LcBNovPVSxQe5tjC+T6szzaQ883WdjtIk8vCKF88aa46jqjmQGkqWCGnaby8hi6Y
        irCOTbp9vGKtqDBV1/oVp7qJbSVM/TaQpNfrMTUIg/S1AcrjbUVtemyeFrldrB+SQ1M68XapZRKqE
        dm9tY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i2xl5-0004Gk-Iw; Wed, 28 Aug 2019 13:13:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 99E842742B61; Wed, 28 Aug 2019 14:13:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        plai@codeaurora.org, spapothi@codeaurora.org, tiwai@suse.de
Subject: Applied "ASoC: wcd9335: Fix primary interpolator max rate" to the asoc tree
In-Reply-To: <20190822095653.7200-3-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190828131306.99E842742B61@ypsilon.sirena.org.uk>
Date:   Wed, 28 Aug 2019 14:13:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd9335: Fix primary interpolator max rate

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

From a8a652bfac7f4a60dfbe07a8c95c65506601b2e1 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 22 Aug 2019 10:56:51 +0100
Subject: [PATCH] ASoC: wcd9335: Fix primary interpolator max rate

On this codec SLIMBus RX path supports 384000 rate on primary interpolator.
Add this missing rate as supported rate.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20190822095653.7200-3-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 956602788d0e..03f8a94bba2f 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2071,9 +2071,10 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF1_PB,
 		.playback = {
 			.stream_name = "AIF1 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.rate_min = 8000,
 			.channels_min = 1,
 			.channels_max = 2,
@@ -2099,10 +2100,11 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF2_PB,
 		.playback = {
 			.stream_name = "AIF2 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.channels_min = 1,
 			.channels_max = 2,
 		},
@@ -2127,10 +2129,11 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF3_PB,
 		.playback = {
 			.stream_name = "AIF3 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.channels_min = 1,
 			.channels_max = 2,
 		},
@@ -2155,10 +2158,11 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 		.id = AIF4_PB,
 		.playback = {
 			.stream_name = "AIF4 Playback",
-			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK |
+				 SNDRV_PCM_RATE_384000,
 			.formats = WCD9335_FORMATS_S16_S24_LE,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 			.channels_min = 1,
 			.channels_max = 2,
 		},
-- 
2.20.1

