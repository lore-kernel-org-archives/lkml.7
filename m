Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B70CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2972077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566997998;
	bh=NlRJddjwp+kqFrr2/XH9/yEstQ+TELIDIKKbDlOvsw8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XSQKjhhAdDa5+6ZsO8S0B986JaIy0G/hGRb8B3ZIrho5I+C6H87kqANGehwmeaxBG
	 TJfH9QLAuDd8oSpz6+HmHqHsSqc1Gq+QPhrULVv9M4xPL5L6JaOJGXk597uRkasNmH
	 UbSfDyj2Yix/aN9T0mRjupv4Cm5w1fBrjIghHEVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfH1NNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:13:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37058 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfH1NNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UEDsZQK3HqZ0rylQv4iF/RMc4uwH6ozIH2oEKlqihzM=; b=XzmRY8IkPIuf
        47zv9UA5XLQeAQRbgNJ+ILZZk2DixRG/eaBymuIJCD2uMBdWY8VZWDWzUvi5G0bZQF+g3tc/kJEYn
        YFcqAUM9NpXJbed+m2HTSGFnW3nszyGFb6YwZsZvGKCIdmLTJ5FHHDlRjsu1mlqGVBXscAou91w5W
        KOFOo=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i2xl6-0004Gm-BG; Wed, 28 Aug 2019 13:13:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CD9482742B9F; Wed, 28 Aug 2019 14:13:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vidyakumar Athota <vathota@codeaurora.org>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        bgoswami@codeaurora.org, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        plai@codeaurora.org, spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        tiwai@suse.de
Subject: Applied "ALSA: pcm: add support for 352.8KHz and 384KHz sample rate" to the asoc tree
In-Reply-To: <20190822095653.7200-2-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190828131306.CD9482742B9F@ypsilon.sirena.org.uk>
Date:   Wed, 28 Aug 2019 14:13:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ALSA: pcm: add support for 352.8KHz and 384KHz sample rate

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

From 4cc4531c310e592cf624148ae59c64f930f12e39 Mon Sep 17 00:00:00 2001
From: Vidyakumar Athota <vathota@codeaurora.org>
Date: Thu, 22 Aug 2019 10:56:50 +0100
Subject: [PATCH] ALSA: pcm: add support for 352.8KHz and 384KHz sample rate

Most of the modern codecs supports 352.8KHz and 384KHz sample rates.
Currenlty HW params fails to set 352.8Kz and 384KHz sample rate
as these are not in known rates list.
Add these new rates to known list to allow them.

This patch also adds defines in pcm.h so that drivers can use it.

Signed-off-by: Vidyakumar Athota <vathota@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20190822095653.7200-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/pcm.h     | 5 +++++
 sound/core/pcm_native.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1e9bb1c91770..bbe6eb1ff5d2 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -117,6 +117,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
 #define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
 #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
+#define SNDRV_PCM_RATE_352800		(1<<13)		/* 352800Hz */
+#define SNDRV_PCM_RATE_384000		(1<<14)		/* 384000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
@@ -129,6 +131,9 @@ struct snd_pcm_ops {
 					 SNDRV_PCM_RATE_88200|SNDRV_PCM_RATE_96000)
 #define SNDRV_PCM_RATE_8000_192000	(SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
 					 SNDRV_PCM_RATE_192000)
+#define SNDRV_PCM_RATE_8000_384000	(SNDRV_PCM_RATE_8000_192000|\
+					 SNDRV_PCM_RATE_352800|\
+					 SNDRV_PCM_RATE_384000)
 #define _SNDRV_PCM_FMTBIT(fmt)		(1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
 #define SNDRV_PCM_FMTBIT_S8		_SNDRV_PCM_FMTBIT(S8)
 #define SNDRV_PCM_FMTBIT_U8		_SNDRV_PCM_FMTBIT(U8)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 860543a4c840..34390be3fb0f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2168,7 +2168,7 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 
 static const unsigned int rates[] = {
 	5512, 8000, 11025, 16000, 22050, 32000, 44100,
-	48000, 64000, 88200, 96000, 176400, 192000
+	48000, 64000, 88200, 96000, 176400, 192000, 352800, 384000
 };
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
-- 
2.20.1

