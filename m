Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51299C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2308120B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864335;
	bh=oM2IlqH7/UF6m9zFg0I3difBjdcLX7dz2uC+4E4GNaM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UCwZsMygc7VaOddMUSw9zm3lWC8wHjOHjzZSOCIC37ZS8mDk1VpmxNwvLdclm6ems
	 8BMLF8qfUqG53Y260dRhfGCLb5Ra4Ho0/x3XCxnnqwPalDF2UJTT/D2My8D6w+DdeM
	 thq6Ekdintx/kL9A899eAnSxGthdM6HIo7AHdxDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfECGSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:18:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfECGSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Fg9QrCpRCad16f0H55V9run4nG3IvYsKIRymL8V7ppI=; b=b/fH/uWGlaos
        7ziuJhy36LnX7aveB2dvBCMFlTudHaKoP9ln7RK847Eu7WUYlNkGl8sZTZayVbAGrDh4MkkzAiYbj
        /bnO/0RFVBs918ZKaM47N39qKOW94sQis1C9vrb84RBuT4yTGvFn835pMiRXZv62tc/1bUXz1VkOz
        hIuH8=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRWy-0000X2-5J; Fri, 03 May 2019 06:18:48 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5E073441D3C; Fri,  3 May 2019 07:18:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: skip hw_free on codec dai for which the stream is invalid" to the asoc tree
In-Reply-To: <20190429094750.1857-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503061844.5E073441D3C@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:18:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: skip hw_free on codec dai for which the stream is invalid

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

From f47b9ad927c6370b80922af434dda98764a43804 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Apr 2019 11:47:50 +0200
Subject: [PATCH] ASoC: skip hw_free on codec dai for which the stream is
 invalid

Like for hw_params, hw_free should not be called on codec dai for
which the current stream is invalid.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 57088bd69e5d..a810f6eeffee 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1031,6 +1031,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 codec_err:
 	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 		codec_dai->rate = 0;
@@ -1088,6 +1091,9 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	/* now free hw params for the DAIs  */
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 	}
-- 
2.20.1

