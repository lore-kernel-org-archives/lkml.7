Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9927C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD456206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564572611;
	bh=pSfzN1x9ZDg+OdnL70kOof5qWXkYWBVD1RS97in1f6s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Audhh/n4kU/A/J1jTY3LCsWe05WRLeWzHVnxUHeyRZbHKpl9z6KPc5MRpNNImCJcg
	 ebPl9PvITawDgH03lar5BHPT2bNqMIEZJqX5zpBNGP8R+LM08XWIBQK8uajBOWQxEo
	 miGgOCmz5cofUk7HEAqlpvx2jsmvtiCIxlVx0m78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfGaLaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:30:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34756 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbfGaLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EuMvAIGvSkhxULaHrIEoiNbtfGrsx8DySGa7iFH7bOg=; b=Sqo0C8Xc5ocS
        /7GLENBLdPeEqcBb1A5xfC3JtU1fBoNS6/7W0x/uKp0VJdMkfS793SxyDH2W/yMko45ysDTpcQdy5
        kjG2LaCfX4BreOLL9+/aX4h+qeIoCjoLxK8rKzYnPsKzq8KGYSFo6hzKlxPDImBcxQALDyJ1ycFq8
        YFsbs=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsmnq-0001qM-2z; Wed, 31 Jul 2019 11:29:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7BAE72742D57; Wed, 31 Jul 2019 12:29:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: codec2codec: fix missing return of error return code" to the asoc tree
In-Reply-To: <20190726123327.10467-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190731112952.7BAE72742D57@ypsilon.sirena.org.uk>
Date:   Wed, 31 Jul 2019 12:29:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codec2codec: fix missing return of error return code

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

From c8415833ec242b9ddf73bf9e1057e12f9b0fcd16 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 26 Jul 2019 13:33:27 +0100
Subject: [PATCH] ASoC: codec2codec: fix missing return of error return code

Currently in function snd_soc_dai_link_event_pre_pmu the error return
code in variable err is being set but this is not actually being returned,
the function just returns zero even when there are failures. Fix this by
returning the error return code.

Addresses-Coverity: ("Unused value")
Fixes: 3dcfb397dad2 ("ASoC: codec2codec: deal with params when necessary")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190726123327.10467-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index be9bb05b0165..2d183e2d23de 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3776,7 +3776,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	struct snd_pcm_hw_params *params = NULL;
 	const struct snd_soc_pcm_stream *config = NULL;
 	unsigned int fmt;
-	int ret;
+	int ret = 0;
 
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
@@ -3865,7 +3865,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 
 out:
 	kfree(params);
-	return 0;
+	return ret;
 }
 
 static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
-- 
2.20.1

