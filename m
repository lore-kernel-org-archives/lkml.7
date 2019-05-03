Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9581B2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864651;
	bh=0yshlF8Z5qQ/sFPepAZa00zh0E4/P64I5ypoqsqUDOg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CxM1lZOr0WGEOWo887/idAeogQUmNOi14xLNwwkVf73DrPhHByLO29wmFXCODBEvf
	 quE3cWLSeRzdv2teu3ND5c1TQ3CyBPt0Q8P18xhh/Rjl8Gpj7U2xUsG8xfOL7PM94u
	 +M/VoxlIOlAAZNnIte5EQ7dbFnAvSpXazttRzIO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfECGXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:23:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33728 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfECGXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tres0fURWXC1XDXgXF6x0O0qXSFQefHm7ghMswbgYJk=; b=ZaMWMnbmUq88
        Oi0jWH/uUwKYJJidU0WDJbT6p9xKWskdhZiA+f56iYgvOUorQtI/NJo4f5J+GHwQtMetpGmVVwMuA
        yWq2Per6rhtXe/hS2n0Gylf3cqgty9VoZbYSzek5Xi9MqFTt50PVhcJcHwLC4nO4W3f3aM5CugGvq
        0ASfw=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRbk-0000kh-1s; Fri, 03 May 2019 06:23:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 40FE3441D3C; Fri,  3 May 2019 07:23:35 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Applied "ASoC: hdmi-codec: unlock the device on startup errors" to the asoc tree
In-Reply-To: <20190429132943.16269-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062335.40FE3441D3C@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:23:35 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hdmi-codec: unlock the device on startup errors

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

From 30180e8436046344b12813dc954b2e01dfdcd22d Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Apr 2019 15:29:39 +0200
Subject: [PATCH] ASoC: hdmi-codec: unlock the device on startup errors

If the hdmi codec startup fails, it should clear the current_substream
pointer to free the device. This is properly done for the audio_startup()
callback but for snd_pcm_hw_constraint_eld().

Make sure the pointer cleared if an error is reported.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 35df73e42cbc..fb2f0ac1f16f 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -439,8 +439,12 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		if (!ret) {
 			ret = snd_pcm_hw_constraint_eld(substream->runtime,
 							hcp->eld);
-			if (ret)
+			if (ret) {
+				mutex_lock(&hcp->current_stream_lock);
+				hcp->current_stream = NULL;
+				mutex_unlock(&hcp->current_stream_lock);
 				return ret;
+			}
 		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
-- 
2.20.1

