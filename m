Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCCCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC30D2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554386325;
	bh=SHrpVj+0R/3pUfr4J1NypX6m5CVE1NFlNqtBx4+GniY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bgYnTwuYe8ec/fzmywusJm0DQA5MCfyUydc9ZV30UXtNH1gOuUVrAC3TZYLf0+/e+
	 bq6JMD6ksUJwnQSjF3uYgMa7drxfYdlusBbWSPbGHnaZpDnoY3vQ0LXK+0Dp6SirWm
	 NVtxYdZCVw7tX3ZUPOi2imHWjR0Y6w9ouKcmxO8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfDDN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:58:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60202 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfDDN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gVLBOYDOnx5v7xVqd9CBm/4fpaLMQvOErhvcTwEV7K0=; b=CVQAACfG5cSN
        TRhc7cZYnO5lIbsHc697cV77/hevHen2wJ5IWsUBU/SGXQX2GBjWEl9TMcdQxsa+yeTwinKx76y97
        2ylivsCxCiEmLJcaURqWrWf5YxFc201LmfScUFkhmqgBs5Y0/ulp5mMaYun42H4Z8JYRPdBT5xfmZ
        sIcAw=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hC2ss-0006d0-8M; Thu, 04 Apr 2019 13:58:26 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 715FD441D3B; Thu,  4 Apr 2019 20:58:23 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        apatard@mandriva.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs42l51: add support of master mode" to the asoc tree
In-Reply-To:  <1554297817-14154-5-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404135823.715FD441D3B@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 20:58:23 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: add support of master mode

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

From 2f7c4ce09a43457666592f36e18a5db58cca86a0 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:34 +0200
Subject: [PATCH] ASoC: cs42l51: add support of master mode

Add support of master mode for cs42l51 cirrus audio codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 9b3ffa16b204..397b68901d1c 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -340,6 +340,19 @@ static struct cs42l51_ratios slave_auto_ratios[] = {
 	{  256, CS42L51_DSM_MODE, 1 }, {  384, CS42L51_DSM_MODE, 1 },
 };
 
+/*
+ * Master mode mclk/fs ratios.
+ * Recommended configurations are SSM for 4-50khz and DSM for 50-100kHz ranges
+ * The table below provides support of following ratios:
+ * 128: SSM (%128) with div2 disabled
+ * 256: SSM (%128) with div2 enabled
+ * In both cases, if sampling rate is above 50kHz, SSM is overridden
+ * with DSM (%128) configuration
+ */
+static struct cs42l51_ratios master_ratios[] = {
+	{ 128, CS42L51_SSM_MODE, 0 }, { 256, CS42L51_SSM_MODE, 1 },
+};
+
 static int cs42l51_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
@@ -362,11 +375,13 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	unsigned int ratio;
 	struct cs42l51_ratios *ratios = NULL;
 	int nr_ratios = 0;
-	int intf_ctl, power_ctl, fmt;
+	int intf_ctl, power_ctl, fmt, mode;
 
 	switch (cs42l51->func) {
 	case MODE_MASTER:
-		return -EINVAL;
+		ratios = master_ratios;
+		nr_ratios = ARRAY_SIZE(master_ratios);
+		break;
 	case MODE_SLAVE:
 		ratios = slave_ratios;
 		nr_ratios = ARRAY_SIZE(slave_ratios);
@@ -402,7 +417,16 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	switch (cs42l51->func) {
 	case MODE_MASTER:
 		intf_ctl |= CS42L51_INTF_CTL_MASTER;
-		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
+		mode = ratios[i].speed_mode;
+		/* Force DSM mode if sampling rate is above 50kHz */
+		if (rate > 50000)
+			mode = CS42L51_DSM_MODE;
+		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(mode);
+		/*
+		 * Auto detect mode is not applicable for master mode and has to
+		 * be disabled. Otherwise SPEED[1:0] bits will be ignored.
+		 */
+		power_ctl &= ~CS42L51_MIC_POWER_CTL_AUTO;
 		break;
 	case MODE_SLAVE:
 		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
-- 
2.20.1

