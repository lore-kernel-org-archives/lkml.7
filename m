Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DC7C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C50218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798182;
	bh=rms2M5SxuEn7/KfTAeXvbph+T4TGna77AobA6zsyTfE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=drRHttaRw7vZq0EKnNZ5aRBUMK31xXsNdkn/hAd85t/aamiDVSMC2GN+clZa9LKE3
	 p4m7z3LJuC8smH6oLUDhmbosU0cF2Zc/Z3Ao4gzcHx7J8wPa+sp4KpFfU3+zIV251w
	 OvkI9GGQ3YKWOe2Td6bHPPyvglMKAPBfBZiTPKnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfGVMXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:23:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58706 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfGVMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0z6U09rUZLECl28yvm3CexCUHnSb2sEGRkEG6GbfCPE=; b=dM9N4vrHnRKf
        plA2tnQIkv+7kDgMz7isQk0oLs+mHmOfGRVJVbghqAVSjK3ZLKq4qDDRwwl155fzafR7aM0sb/4pI
        F7LtADCLGCoWF4ibxFMuOaSwduO9R6arD+HzCmbboIlyqLRB7EAI0MvZ/cxDzgHwKy9RDFWMTo5aP
        jHHng=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKQ-0007c8-QT; Mon, 22 Jul 2019 12:22:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 95EA72742C1A; Mon, 22 Jul 2019 13:22:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     alsa-devel@alsa-project.org,
        Collabora Kernel ML <kernel@collabora.com>,
        cychiang@chromium.org, dianders@chromium.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "SoC: rockchip-max98090: Remove MICBIAS as supply of input pin IN34" to the asoc tree
In-Reply-To: <20190719180558.11459-1-enric.balletbo@collabora.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122205.95EA72742C1A@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   SoC: rockchip-max98090: Remove MICBIAS as supply of input pin IN34

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

From 03cc2c22a711080790c5dcb546dd073fe38add05 Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Fri, 19 Jul 2019 20:05:58 +0200
Subject: [PATCH] SoC: rockchip-max98090: Remove MICBIAS as supply of input pin
 IN34

Commit ec0d23b295b9 ("ASoC: rockchip-max98090: Fix the Headset Mic
route.") moved the MICBIAS widget to supply Headset Mic but forget to
remove the MICBIAS widget to supply IN34 which is not really needed, so
remove that path so we have:

   IN34 <==== Headset MIC <==== MICBIAS

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: https://lore.kernel.org/r/20190719180558.11459-1-enric.balletbo@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index c5fc24675a33..d1c907631c2d 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -45,7 +45,6 @@ static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route rk_audio_map[] = {
 	{"IN34", NULL, "Headset Mic"},
-	{"IN34", NULL, "MICBIAS"},
 	{"Headset Mic", NULL, "MICBIAS"},
 	{"DMICL", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPL"},
-- 
2.20.1

