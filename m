Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B28C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3CD20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864611;
	bh=ADDKQJG5H3eYE/KcBeEOhA2qZ7l3VFolzxbFAjLYkmE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CkQ3kcSvvDvHNqJKidkK9Ub89NjYYODCxq+lxBy9RypovAaQhW1cAqYLax0I5Chsc
	 824aGfy8RP1hG9x7eMDTkH+DIRoR7uN6CHHsLusPPxgVKvAW+EaaCFSIkY+tqk7L6s
	 zb+c8YoWKpG5/+XeaMBFKdqcym8BFf48F5nT+g54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfECGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:23:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfECGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tdXXDwJac7tPdkzlB2OnCMedUY3PiqwtJOnXJSCSNbo=; b=Z9Yrmd3yylFP
        jTlNRZRjB2KRv7+2x71efacVAbSQmSLM3rp4LGWfJKo1xpjDJGVwjxcgchaEPlRH3OoRgs6/PTNk7
        cBRvt4Vifq9CpUv4jmwoxTaeFpE0Qm5/VYaWj4FyrFUxu96WaSyyxsdQ/WMA53wHHD3Ft64hoQN7E
        5msio=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRbB-0000co-EB; Fri, 03 May 2019 06:23:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2120C441D69; Fri,  3 May 2019 07:21:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: SOF: remove redundant null checks of dai" to the asoc tree
In-Reply-To: <20190502113340.8688-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062131.2120C441D69@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:21:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: remove redundant null checks of dai

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From c437ba0300cec1ca8758fdd71a3b2f8cd02c6e2a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 2 May 2019 12:33:40 +0100
Subject: [PATCH] ASoC: SOF: remove redundant null checks of dai

Currently there are two null checks of pointer dai in function
sof_connect_dai_widget and yet there is no null check of dai
at the end of the function when checking !dai->name.  The latter
would be a null pointer deference if dai is null (as picked up
by static analysis), however the function is only ever called
when dai is successfully allocated, so the null checks are
redundant. Clean up the code by removing the null checks.

Addresses-Coverity: ("Dereference after null check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 2b9de1b97447..1f71857298a9 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1127,15 +1127,13 @@ static int sof_connect_dai_widget(struct snd_soc_component *scomp,
 		switch (w->id) {
 		case snd_soc_dapm_dai_out:
 			rtd->cpu_dai->capture_widget = w;
-			if (dai)
-				dai->name = rtd->dai_link->name;
+			dai->name = rtd->dai_link->name;
 			dev_dbg(sdev->dev, "tplg: connected widget %s -> DAI link %s\n",
 				w->name, rtd->dai_link->name);
 			break;
 		case snd_soc_dapm_dai_in:
 			rtd->cpu_dai->playback_widget = w;
-			if (dai)
-				dai->name = rtd->dai_link->name;
+			dai->name = rtd->dai_link->name;
 			dev_dbg(sdev->dev, "tplg: connected widget %s -> DAI link %s\n",
 				w->name, rtd->dai_link->name);
 			break;
-- 
2.20.1

