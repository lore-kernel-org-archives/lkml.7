Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4812C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72CC206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864699;
	bh=RyclbqGtS6gvfBKvc8P5Iyp4BAt/bLNGMdZezLTsL3c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2ncdJkZguhsQzrnnfQWx4QbfTAKPVp7D/AeS26kQgY27Q13OnbC7BahccErpVdtQO
	 Ctbk/1CMKzgUAdCtnroilGnsPSTSXAfHtkXAGjgVBqRQpv0bGAoSKcbGYIHwRH8png
	 FADRJ6zGF8BWiB+6yj8ANYZ3kMYQBuJrn6sKvRHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfECGXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:23:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60302 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfECGXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v0HC/nVs3Jb9s28ZkKENRWvTIY8Iq2+d1nHoiE8oPto=; b=pzJnETXAmL2h
        Tc0yoPYtb2E6F4PMEfQEGQK/T1nvFVte0sJwFaSpPiJa3nvCLG5uSBGboFvksnzFyxeuT+7+QFubZ
        0YTsIvXmiQeFTWfEE/blOmhBSm8gQylKzw3bQatysGWR83WcSwOfq2UYPzClaogZXVaaERMeFpWwb
        0sToo=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRb7-0000bW-Tj; Fri, 03 May 2019 06:23:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 85F76441D68; Fri,  3 May 2019 07:21:30 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: hdmi-codec: stream is already locked in hw_params" to the asoc tree
In-Reply-To: <20190429132943.16269-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062130.85F76441D68@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:21:30 +0100 (BST)
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

