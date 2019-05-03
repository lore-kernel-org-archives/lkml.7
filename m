Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9099C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE272075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864646;
	bh=bjCfOxNAkvhf2D0t5nz8hSTbvooFd0JRo0iksvchE70=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Af+r8uSz4XiyZYg4+V5kBe3F2ZIyh+Xmh+/DtzAmONPKAn7PK8f60Id9zghTKh36I
	 F+2eiQ7eAqAc4cBurG4iPdFLNWBdm+1OHL9RcId0K8lpYinbG4ZcM1owZGeLjNvmP2
	 hScpxM7CduPn0itvYyHgraohsIdyFcmjoA3pmfGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfECGYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:24:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33878 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfECGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rZq5sizDQmDuNZ2W+O82havtkELQLuBDvFjiM74WSfM=; b=UpEJLzjtujOG
        4uY45EIku3WztyXAkwzOiPPOYOLtNM9o8zmWByZRjA3TCTIfLiu5AwBOmrgmvLHztNFf3W+S8ZprP
        sRzz8RO64N1MBQ+r/IqbjJ/U6UWjRsJ4cHO1b/GWVXrOIyRjFA/EiBRO+ZdVqTukn3PL+bZgdFR7C
        o8ODQ=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRbj-0000kF-6Y; Fri, 03 May 2019 06:23:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9B15D441D41; Fri,  3 May 2019 07:23:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: fix valid stream condition" to the asoc tree
In-Reply-To: <20190429094750.1857-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062334.9B15D441D41@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:23:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fix valid stream condition

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

From 6a7c59c6d9f3b280e81d7a04bbe4e55e90152dce Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Apr 2019 11:47:49 +0200
Subject: [PATCH] ASoC: fix valid stream condition

A stream may specify a rate range using 'rate_min' and 'rate_max', so a
stream may be valid and not specify any rates. However, as stream cannot
be valid and not have any channel. Let's use this condition instead to
determine if a stream is valid or not.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d21247546f7f..57088bd69e5d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -43,8 +43,8 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
 	else
 		codec_stream = &dai->driver->capture;
 
-	/* If the codec specifies any rate at all, it supports the stream. */
-	return codec_stream->rates;
+	/* If the codec specifies any channels at all, it supports the stream */
+	return codec_stream->channels_min;
 }
 
 /**
-- 
2.20.1

