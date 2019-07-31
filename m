Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EC2C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB52B206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564572612;
	bh=B4UbKNLuvaC2DO9wHUDQpLx3Q3KSE+sqA7ilC+7xDvs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kJV6xdP5IMS7HWDWdc7xlGGdswN5OsAFWZTCh+4NZ1hZXfQ1GLuj1mzcb8yJFW37h
	 s62lPHE4wjd5BSdvdB/jIUZwEQiNaWtnmyhKXbl2lgnyMmGZsFhRTY1e2M6jR65Mg9
	 3EHqQDDPrLLNx9Yh1PDo0tw5WBfvNGMkRV5Cd5fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfGaLaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:30:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34996 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbfGaLaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qdXfU6r5b5sdjGKJgeKuLM8z6fXd+57ECxKLYJefhRg=; b=h7mJvPV40UEw
        3KaRh1RriPGRhUPlrjB5eVR9O93+MYafPgo89J2bUWnqc2+GsMxE990Eqn+E6iBDJssbzl59fsgb6
        zB5KGcq4W2nywpYg857qEi0d6RNW65Waj0BGjY1rHdgeNloGTTXJxru0tC3ydVbakXreJAvTRhSDx
        +zz5k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsmno-0001pr-Br; Wed, 31 Jul 2019 11:29:52 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 80FD42742CDE; Wed, 31 Jul 2019 12:29:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     fengchunguo <chunguo.feng@amlogic.com>
Cc:     alsa-devel@alsa-project.org, bleung@chromium.org,
        broonie@kernel.org, chunguo.feng@amlogic.com,
        grundler@chromium.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        RyanS.Lee@maximintegrated.com, tiwai@suse.com
Subject: Applied "ASoC: max98373: add 88200 and 96000 sampling rate support" to the asoc tree
In-Reply-To: <20190731074156.5620-1-chunguo.feng@amlogic.com>
X-Patchwork-Hint: ignore
Message-Id: <20190731112951.80FD42742CDE@ypsilon.sirena.org.uk>
Date:   Wed, 31 Jul 2019 12:29:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98373: add 88200 and 96000 sampling rate support

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

From b9da500bde81ad820b5d95c6bf52fc33e1f490ee Mon Sep 17 00:00:00 2001
From: fengchunguo <chunguo.feng@amlogic.com>
Date: Wed, 31 Jul 2019 15:41:56 +0800
Subject: [PATCH] ASoC: max98373: add 88200 and 96000 sampling rate support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

88200 and 96000 sampling rate was not enabled on driver, so can't be played.

The error information:
max98373 3-0031：rate 96000 not supported
max98373 3-0031：ASoC: can't set max98373-aif1 hw params: -22

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
Link: https://lore.kernel.org/r/20190731074156.5620-1-chunguo.feng@amlogic.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 6 ++++++
 sound/soc/codecs/max98373.h | 2 ++
 2 files changed, 8 insertions(+)
 mode change 100644 => 100755 sound/soc/codecs/max98373.c
 mode change 100644 => 100755 sound/soc/codecs/max98373.h

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
old mode 100644
new mode 100755
index 528695cd6a1c..8c601a3ebc27
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -267,6 +267,12 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 	case 48000:
 		sampling_rate = MAX98373_PCM_SR_SET1_SR_48000;
 		break;
+	case 88200:
+		sampling_rate = MAX98373_PCM_SR_SET1_SR_88200;
+		break;
+	case 96000:
+		sampling_rate = MAX98373_PCM_SR_SET1_SR_96000;
+		break;
 	default:
 		dev_err(component->dev, "rate %d not supported\n",
 			params_rate(params));
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
old mode 100644
new mode 100755
index f6a37aa02f26..a59e51355a84
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -130,6 +130,8 @@
 #define MAX98373_PCM_SR_SET1_SR_32000 (0x6 << 0)
 #define MAX98373_PCM_SR_SET1_SR_44100 (0x7 << 0)
 #define MAX98373_PCM_SR_SET1_SR_48000 (0x8 << 0)
+#define MAX98373_PCM_SR_SET1_SR_88200 (0x9 << 0)
+#define MAX98373_PCM_SR_SET1_SR_96000 (0xA << 0)
 
 /* MAX98373_R2028_PCM_SR_SETUP_2 */
 #define MAX98373_PCM_SR_SET2_SR_MASK (0xF << 4)
-- 
2.20.1

