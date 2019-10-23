Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D08CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C552086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571856974;
	bh=H07JzHAFIUf1gCLOH3uCDgii//4E4g5UyMZWFgnUkj0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ina2I4bh32W01nr+CNtDWDNAzyCPpT+NUGTglG5gzXMBnAyrd9ZeRGAlgyRqUQn5p
	 G02WXzIW1l03LwGrCyBx6beFFIM5Kr2+dZ16QF2Au1WmgbkemN5GC7mx49yXeMDdZj
	 LwT2m3dNAHLXE5uBONFfs8CNuQfasJY1ABYrUxwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404370AbfJWS4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:56:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388827AbfJWS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=52hnjhXNVROi4hAmQzIOnp9s1z1iJebZL+D1ztfofgY=; b=nlaCd52J51mg
        dQFzGc1CmiKVM8hLd5It0hvULjbIXUwun28h9fd9+tKeOUI9JGFrTXsMKqV/auLgB2SlwLanXwtd4
        NEOQA5WNa95NTI4peluTXNg+WNd0/CyWdTh5lGRpw/oZHfaRPOmzkKiZeGzm2ve2APvHuEQINHmPt
        9yoq8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLni-0001Ar-HS; Wed, 23 Oct 2019 18:56:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F01A9274326E; Wed, 23 Oct 2019 19:56:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Applied "ASoC: hdmi-codec: drop mutex locking again" to the asoc tree
In-Reply-To: <20191023161203.28955-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20191023185604.F01A9274326E@ypsilon.sirena.org.uk>
Date:   Wed, 23 Oct 2019 19:56:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hdmi-codec: drop mutex locking again

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

From 901af18b6baade6a327e532427cbb233f4945f5d Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 23 Oct 2019 18:12:02 +0200
Subject: [PATCH] ASoC: hdmi-codec: drop mutex locking again

This reverts commit eb1ecadb7f67dde94ef0efd3ddaed5cb6c9a65ed.

This fixes the following warning reported by lockdep and a potential
issue with hibernation

====================================
WARNING: pulseaudio/1297 still has locks held!
5.3.0+ #1826 Not tainted
------------------------------------
1 lock held by pulseaudio/1297:
 #0: ee815308 (&hcp->lock){....}, at: hdmi_codec_startup+0x20/0x130

stack backtrace:
CPU: 0 PID: 1297 Comm: pulseaudio Not tainted 5.3.0+ #1826
Hardware name: Marvell Dove (Cubox)
[<c0017b4c>] (unwind_backtrace) from [<c0014d10>] (show_stack+0x10/0x14)
[<c0014d10>] (show_stack) from [<c00a2d18>] (futex_wait_queue_me+0x13c/0x19c)
[<c00a2d18>] (futex_wait_queue_me) from [<c00a3630>] (futex_wait+0x184/0x24c)
[<c00a3630>] (futex_wait) from [<c00a5e1c>] (do_futex+0x334/0x598)
[<c00a5e1c>] (do_futex) from [<c00a62e8>] (sys_futex_time32+0x118/0x180)
[<c00a62e8>] (sys_futex_time32) from [<c0009000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xebd31fa8 to 0xebd31ff0)
1fa0:                   00000000 ffffffff 000c8748 00000189 00000001 00000000
1fc0: 00000000 ffffffff 00000000 000000f0 00000000 00000000 00000000 00056200
1fe0: 000000f0 beac03a8 b6d6c835 b6d6f456

Fixes: eb1ecadb7f67 ("ASoC: hdmi-codec: re-introduce mutex locking")
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20191023161203.28955-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b5fd8f08726e..f8b5b960e597 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -274,7 +274,7 @@ struct hdmi_codec_priv {
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
-	struct mutex lock;
+	unsigned long busy;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
 };
@@ -390,8 +390,8 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	ret = mutex_trylock(&hcp->lock);
-	if (!ret) {
+	ret = test_and_set_bit(0, &hcp->busy);
+	if (ret) {
 		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
 		return -EINVAL;
 	}
@@ -419,7 +419,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 
 err:
 	/* Release the exclusive lock on error */
-	mutex_unlock(&hcp->lock);
+	clear_bit(0, &hcp->busy);
 	return ret;
 }
 
@@ -431,7 +431,7 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	mutex_unlock(&hcp->lock);
+	clear_bit(0, &hcp->busy);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -811,8 +811,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	mutex_init(&hcp->lock);
-
 	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
 	if (!daidrv)
 		return -ENOMEM;
-- 
2.20.1

