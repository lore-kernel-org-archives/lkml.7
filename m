Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44726208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763507;
	bh=sMPhMPuD1Mj3n2jIswgvZWsEZM/ix9fCGK0kAThce+U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=no5YnNoKArsHMca7vIX8E0x9mUOycxawQg0LXbFvEdhSRCsDf3kkskiZQo2U6PN7Q
	 3req/roF1A/pRAyRYExPbfyGJwemS+pRu8D8oI1wbuNzHv2MW5keEzQRMS65ADnfYo
	 HONZsoo/f8ncPxqEwY8b/LfPNQTBxyc2aDevci/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEBCSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:18:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54792 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBCSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sDWuThU3xsEo4SgQTOzat0wz9Zc/a+PRsiFsYfLhmUE=; b=WYv+9b1SJiKI
        GYh1I3M03W+FsWQOrm2gPdMUKmBTls8GQ63brUZ2buaglD6KEQgSaQumt3AFfjiGQOzZmT30wbbM/
        iczEDCOJ6EUACi38bRmcMtm1uSmo50YHzxP43Rp9Tc1yCxxoRC+NxS9SWHYrHVP/xkOxdbmAW8px2
        yNkGE=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1IV-0005pt-75; Thu, 02 May 2019 02:18:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9926D441D56; Thu,  2 May 2019 03:18:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Logesh <logesh.kolandavel@timesys.com>
Cc:     Adam.Thomson.Opensource@diasemi.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, logesh.kolandavel@timesys.com,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        support.opensource@diasemi.com, tiwai@suse.com
Subject: Applied "ASoC: da7213: fix DAI_CLK_EN register bit overwrite" to the asoc tree
In-Reply-To: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021803.9926D441D56@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7213: fix DAI_CLK_EN register bit overwrite

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

From 414a7321d60bc0abced4a760e22b8187e2b4aecf Mon Sep 17 00:00:00 2001
From: Logesh <logesh.kolandavel@timesys.com>
Date: Wed, 1 May 2019 14:34:24 +0530
Subject: [PATCH] ASoC: da7213: fix DAI_CLK_EN register bit overwrite

If the da7213 codec is configured as Master with the DAPM power down
delay time set, 'snd_soc_component_write' function overwrites the
DAI_CLK_EN bit of DAI_CLK_MODE register which leads to audio play
only once until it re-initialize after codec power up.

Signed-off-by: Logesh <logesh.kolandavel@timesys.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 5 ++++-
 sound/soc/codecs/da7213.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 92d006a5283e..425c11d63e49 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1305,7 +1305,10 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* By default only 64 BCLK per WCLK is supported */
 	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_64;
 
-	snd_soc_component_write(component, DA7213_DAI_CLK_MODE, dai_clk_mode);
+	snd_soc_component_update_bits(component, DA7213_DAI_CLK_MODE,
+			    DA7213_DAI_BCLKS_PER_WCLK_MASK |
+			    DA7213_DAI_CLK_POL_MASK | DA7213_DAI_WCLK_POL_MASK,
+			    dai_clk_mode);
 	snd_soc_component_update_bits(component, DA7213_DAI_CTRL, DA7213_DAI_FORMAT_MASK,
 			    dai_ctrl);
 	snd_soc_component_write(component, DA7213_DAI_OFFSET, dai_offset);
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 5a78dba1dcb5..9d31efc3cfe5 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -181,7 +181,9 @@
 #define DA7213_DAI_BCLKS_PER_WCLK_256				(0x3 << 0)
 #define DA7213_DAI_BCLKS_PER_WCLK_MASK				(0x3 << 0)
 #define DA7213_DAI_CLK_POL_INV					(0x1 << 2)
+#define DA7213_DAI_CLK_POL_MASK					(0x1 << 2)
 #define DA7213_DAI_WCLK_POL_INV					(0x1 << 3)
+#define DA7213_DAI_WCLK_POL_MASK				(0x1 << 3)
 #define DA7213_DAI_CLK_EN_MASK					(0x1 << 7)
 
 /* DA7213_DAI_CTRL = 0x29 */
-- 
2.20.1

