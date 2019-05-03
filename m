Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B2C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED69208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864332;
	bh=RyclbqGtS6gvfBKvc8P5Iyp4BAt/bLNGMdZezLTsL3c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bwbL0MrZMmCqCBBYisS7HY/ck+sUUQTgyc+DS7ysWh8koyeY3PEUjN5+4aYp9dlGV
	 WVGj5ggR2bmvO1dOkUBTt2BvHa02PHm782z1VRD7Y7d5RAsjvpoZvb7vFm6wPRYX14
	 x10BQQFd44vdaYI5HrfF0JtC+h5PF6TUaH4ns1xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfECGSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:18:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v0HC/nVs3Jb9s28ZkKENRWvTIY8Iq2+d1nHoiE8oPto=; b=B2snec7OOP81
        0u+kN+S8RQWrQ+QiZwvfIS+Kvc/Wf73WNcQn58a1f1XYjpR9sfevnx3opMeibalS4QRRHMGnggxnd
        BtVJDqes/Z0X9NatBlXaUKF66lX2ZI4m/NhLfI9SxqQFDUynXWIfLzgRO9o0OAjjuwoe2TgTVxRPX
        MAvnI=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRWx-0000Wt-Fr; Fri, 03 May 2019 06:18:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 20A9D441D56; Fri,  3 May 2019 07:18:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: hdmi-codec: stream is already locked in hw_params" to the asoc tree
In-Reply-To: <20190429132943.16269-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503061843.20A9D441D56@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:18:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hdmi-codec: stream is already locked in hw_params

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

From 726fc60babe4a46e946e69a9dbd3e21aaec4d58e Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Apr 2019 15:29:40 +0200
Subject: [PATCH] ASoC: hdmi-codec: stream is already locked in hw_params

startup() should have run before hw_params() is called, so the
current_substream pointer should already be properly set. There
is no reason to call hdmi_codec_new_stream() again in the
hw_params() callback

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b9d9dde9fbaf..ef6d6959ecc5 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -492,10 +492,6 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = hdmi_codec_new_stream(substream, dai);
-	if (ret)
-		return ret;
-
 	hdmi_audio_infoframe_init(&hp.cea);
 	hp.cea.channels = params_channels(params);
 	hp.cea.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
-- 
2.20.1

