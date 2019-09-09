Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE721D82
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023645;
	bh=bxIOGnc3wrD7BmBl8YRpr6+qBSbdWvYAnvYbcoAOaZk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=n58hkRIhvG2r/uJVn0iiUNlLcvdYSGwh7OdYs7/koWPel7mAhN+2kCW9CnqcPmD6B
	 NvTU/Wh7x75N2S/lWCzbG52Q6u+IkqAE+XMGwslJC7I4TNejgRongYto8Vhe/ukWJY
	 h6BVYbzuhbH3vhu2DJus2YpjB4pml0vXYtQViAV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbfIIKHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:07:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfIIKHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=h7CwsGin/gAKd5MlPcygrl7rvGBDxjHcGgJA8rYLCjs=; b=jHXwY0XK8Lhz
        CgaFjd5BtuovqmeEF7YD6sb77Vvs6Fvb3fgM1h1NCG/dz2ePiox6NR/t8gZM8b+Nipd9+3KgLLGjZ
        MCqoJROXKVe4fxvxUA9OGEWx6dq0tzCP0Cyxz/kEi1uheBtSfTfSBWcIaKa6hBI+JefzGjHEme07L
        Of120=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7GZp-0001rk-Ne; Mon, 09 Sep 2019 10:07:17 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 1BBC2D02D74; Mon,  9 Sep 2019 11:07:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "SoC: simple-card-utils: set 0Hz to sysclk when shutdown" to the asoc tree
In-Reply-To: <20190907174501.19833-1-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20190909100717.1BBC2D02D74@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 11:07:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   SoC: simple-card-utils: set 0Hz to sysclk when shutdown

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

From 2458adb8f92ad4d07ef7ab27c5bafa1d3f4678d6 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Sun, 8 Sep 2019 02:45:01 +0900
Subject: [PATCH] SoC: simple-card-utils: set 0Hz to sysclk when shutdown

This patch set 0Hz to sysclk when shutdown the card.

Some codecs set rate constraints that derives from sysclk. This
mechanism works correctly if machine drivers give fixed frequency.

But simple-audio and audio-graph card set variable clock rate if
'mclk-fs' property exists. In this case, rate constraints will go
bad scenario. For example a codec accepts three limited rates
(mclk / 256, mclk / 384, mclk / 512).

Bad scenario as follows (mclk-fs = 256):
   - Initialize sysclk by correct value (Ex. 12.288MHz)
     - Codec set constraints of PCM rate by sysclk
       48kHz (1/256), 32kHz (1/384), 24kHz (1/512)
   - Play 48kHz sound, it's acceptable
   - Sysclk is not changed

   - Play 32kHz sound, it's acceptable
   - Set sysclk to 8.192MHz (= fs * mclk-fs = 32k * 256)
     - Codec set constraints of PCM rate by sysclk
       32kHz (1/256), 21.33kHz (1/384), 16kHz (1/512)

   - Play 48kHz again, but it's NOT acceptable because constraints
     do not allow 48kHz

So codecs treat 0Hz sysclk as signal of applying no constraints to
avoid this problem.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Link: https://lore.kernel.org/r/20190907174501.19833-1-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 556b1a789629..9b794775df53 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -213,10 +213,17 @@ EXPORT_SYMBOL_GPL(asoc_simple_startup);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
+	if (dai_props->mclk_fs) {
+		snd_soc_dai_set_sysclk(codec_dai, 0, 0, SND_SOC_CLOCK_IN);
+		snd_soc_dai_set_sysclk(cpu_dai, 0, 0, SND_SOC_CLOCK_OUT);
+	}
+
 	asoc_simple_clk_disable(dai_props->cpu_dai);
 
 	asoc_simple_clk_disable(dai_props->codec_dai);
-- 
2.20.1

