Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A7C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0A820693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563881365;
	bh=slMqp1LgotyTeWReNrP8gCLbmV/2HlG2DWxVySvHmTI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IOgA9XyE+XjxWHmqkueyTpZ7FGGSdT319FnVB2xvLgqP4e6PMc5WJqDyr01SwYCsN
	 uBeqmlY/K70oTTsesmT8CfQ0Yz8MX6b2tJP2RQGKfo4448SvyQiFBG2X6VVAe9i6l9
	 aFCfh9VUjeE1ycaJlWrTPukWMxulYS3lk5hWYgWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfGWL3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:29:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfGWL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=k6vcIEfHRK3aIZYZxABlz1lJXYGEXLTcf2MHrDJp5XM=; b=EMUh3Pn+F83i
        WdJ4EiR19wxhHfGRS+0JEod4mxjDezXWcD05n3Ux9385o4jdvJC2EiqXXFCIR8dENvxyj+cdBofI9
        51k5peVOmDXhHmWBu2LF7RRM8D80R4jHKQxMtGGY8G0yakX+fnMPdw6c840CSO8pPFCCp7fujRpHN
        a9IpY=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpsyl-0003IY-J8; Tue, 23 Jul 2019 11:29:11 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E55942742B60; Tue, 23 Jul 2019 12:29:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, bardliao@realtek.com,
        broonie@kernel.org, chiou@realtek.com,
        kernel-janitors@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: rt5665: Fix a typo in the name of a function" to the asoc tree
In-Reply-To: <20190722212639.26954-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190723112910.E55942742B60@ypsilon.sirena.org.uk>
Date:   Tue, 23 Jul 2019 12:29:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5665: Fix a typo in the name of a function

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

From f90aa354be7bffaec2b440eb1831c429ecb1a5e2 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 22 Jul 2019 23:26:39 +0200
Subject: [PATCH] ASoC: rt5665: Fix a typo in the name of a function

All function names start with rt5665_, except 'rt5655_set_verf()'.
It is likely a typo.

Fix it to be consistent.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190722212639.26954-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index c050d84a6916..68299ce26d3e 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2566,7 +2566,7 @@ static int set_dmic_power(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rt5655_set_verf(struct snd_soc_dapm_widget *w,
+static int rt5665_set_verf(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
@@ -2686,11 +2686,11 @@ static const struct snd_soc_dapm_widget rt5665_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mic Det Power", RT5665_PWR_VOL,
 		RT5665_PWR_MIC_DET_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Vref1", RT5665_PWR_ANLG_1, RT5665_PWR_VREF1_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("Vref2", RT5665_PWR_ANLG_1, RT5665_PWR_VREF2_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("Vref3", RT5665_PWR_ANLG_1, RT5665_PWR_VREF3_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
 	/* ASRC */
 	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5665_ASRC_1,
-- 
2.20.1

