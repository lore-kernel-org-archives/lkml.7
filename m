Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22066C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB84421872
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558699973;
	bh=L9CanpSZDv0uNP5T2onbvMs66pNwY33FdYckjnTHo7Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kgZHYFsDdTYrSa0xyz2EakIyiGjQ0yFARuV5zrrOzPhmZYcaPq4CLDpkYGior5Er/
	 0A/I8vMR0ZRa0hDlovwa2IIPrr8NwTFHMPhx83oa02PCtF8bp3UMuNq4wS2AXl/xQg
	 u5zo8qy2pnI9bgm2psy4k3Z13YAEif3AcpjEF7T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391506AbfEXMMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:12:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43346 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391462AbfEXMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AvMpC7Jz5X1XI3BJzxwbegp9Vy5WFXCNZ3EH9Hh+SNM=; b=aFHsGJCgf2iV
        df4A+dqMywe9Q+gYMIVBeLEduaAznTZhJSwUc6mYB3lZGLz+5b5oXbR1T7EZYzX42GvsQAJmTP4EQ
        w1L/ddmB3gwBesAuwjcDNDmcKGyNebPnZICYAID61AkUS/p22U/P1Kph8MIUACMiKfkSmeEJryuM7
        bKegg=;
Received: from [176.12.107.140] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hU93v-0003Ct-3q; Fri, 24 May 2019 12:12:39 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 0163B440049; Fri, 24 May 2019 13:12:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: simple-card: Restore original configuration of DAI format" to the asoc tree
In-Reply-To: <1558688044-22025-1-git-send-email-jonathanh@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190524121238.0163B440049@finisterre.sirena.org.uk>
Date:   Fri, 24 May 2019 13:12:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: Restore original configuration of DAI format

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

From 4819d06292c9b57eabdd6d1603e49a27baf183be Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Fri, 24 May 2019 09:54:04 +0100
Subject: [PATCH] ASoC: simple-card: Restore original configuration of DAI
 format

Revert commit 069d037aea98 ("ASoC: simple-card: Fix configuration of
DAI format"). During further review, it turns out that the actual issue
was caused by an incorrectly formatted device-tree node describing the
soundcard.

The following is incorrect because the simple-audio-card
'bitclock-master' and 'frame-master' properties should not reference the
actual codec phandle ...

	sound {
		compatible = "simple-audio-card";
		...
	=>	simple-audio-card,bitclock-master = <&codec>;
	=>	simple-audio-card,frame-master = <&codec>;
		...

		simple-audio-card,cpu {
			sound-dai = <&xxx>;
		};

		simple-audio-card,codec {
	=>		sound-dai = <&codec>;
		};
	};

Rather, these properties should reference the phandle to the
'simple-audio-card,codec' property as shown below ...

	sound {
		compatible = "simple-audio-card";
		...
	=>	simple-audio-card,bitclock-master = <&codec>;
	=>	simple-audio-card,frame-master = <&codec>;
		...

		simple-audio-card,cpu {
			sound-dai = <&xxx>;
		};

	=>	codec: simple-audio-card,codec { /* simple-card wants here */
			sound-dai = <&xxx>;	 /* not here */
		};
	};

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c2c8dcbcf795..9b568f578bcd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -283,6 +283,11 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	codec_dai		=
 	dai_props->codec_dai	= &priv->dais[li->dais++];
 
+	ret = asoc_simple_parse_daifmt(dev, node, codec,
+				       prefix, &dai_link->dai_fmt);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
 
 	ret = asoc_simple_parse_cpu(cpu, dai_link, &single_cpu);
@@ -293,11 +298,6 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_parse_daifmt(dev, node, dai_link->codecs->of_node,
-				       prefix, &dai_link->dai_fmt);
-	if (ret < 0)
-		goto dai_link_of_err;
-
 	ret = asoc_simple_parse_platform(plat, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
-- 
2.20.1

