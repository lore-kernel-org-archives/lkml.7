Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67384C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E0920823
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564143148;
	bh=yjbILkNCmED+MxiECFol1BQ3MM1CxagbaNmbFhe58mg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oVItb9TtdgCLGe9zE3yXchdAk/s91Qto2w8dw1HF6HJy37llXBEG2nebKeudePRS4
	 1zxdeiiqWGCaEQnTxo1P2mV4nhIf52qHi271Ey+n6Fs7x4yml5bQ3yGpNqG3kuTw6g
	 pTzVkhKu42N3m5bgY8CUXldVy20z0t+F3wWntLpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGZMM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:12:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfGZMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ppv6g71055dMnrkMQSdTZpzfu9QPlBAMNF035s+cREw=; b=uWg3gJmM5dtO
        6ZeuoYmRrchMwdzcw3uqtCJhzusDByr17UgU9Z9UNcSEI8LVj8RaraP1KVWGcL+cT7qMNqCdWVbuk
        ktvAxPC3zArscqgRJvUfBp0fPUtTo8wfqcbXawEA0GSQ4nE4rh5nqvDe+l1jypVH0Ju+sZxZ976Vg
        NVAS0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqz58-0001Zr-U7; Fri, 26 Jul 2019 12:12:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 543B02742B63; Fri, 26 Jul 2019 13:12:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     alsa-devel@alsa-project.org, dgreid@chromium.org,
        dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, mka@chromium.org,
        Takashi Iwai <tiwai@suse.com>, tzungbi@chromium.org
Subject: Applied "ASoC: rockchip: Fix mono capture" to the asoc tree
In-Reply-To: <20190726044202.26866-1-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190726121218.543B02742B63@ypsilon.sirena.org.uk>
Date:   Fri, 26 Jul 2019 13:12:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: Fix mono capture

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 789e162a6255325325bd321ab0cd51dc7e285054 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Fri, 26 Jul 2019 12:42:02 +0800
Subject: [PATCH] ASoC: rockchip: Fix mono capture

This reverts commit db51707b9c9aeedd310ebce60f15d5bb006567e0.
Revert "ASoC: rockchip: i2s: Support mono capture"

Previous discussion in

https://patchwork.kernel.org/patch/10147153/

explains the issue of the patch.
While device is configured as 1-ch, hardware is still
generating a 2-ch stream.
When user space reads the data and assumes it is a 1-ch stream,
the rate will be slower by 2x.

Revert the change so 1-ch is not supported.
User space can selectively take one channel data out of two channel
if 1-ch is preferred.
Currently, both channels record identical data.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Link: https://lore.kernel.org/r/20190726044202.26866-1-cychiang@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 0a34d0eb8dba..88ebaf6e1880 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -326,7 +326,6 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 		val |= I2S_CHN_4;
 		break;
 	case 2:
-	case 1:
 		val |= I2S_CHN_2;
 		break;
 	default:
@@ -459,7 +458,7 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 	},
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = (SNDRV_PCM_FMTBIT_S8 |
@@ -659,7 +658,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	}
 
 	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
-		if (val >= 1 && val <= 8)
+		if (val >= 2 && val <= 8)
 			soc_dai->capture.channels_max = val;
 	}
 
-- 
2.20.1

