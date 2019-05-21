Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28ACC18E7C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FD42182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558470780;
	bh=jBE/ry4iMymX9tKuvKKw+0A+2maJMMzE0moV2NmkP0M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2m/UhLHKaZWQvU/0gjYVeVlXl8hfOsYYoHCE4NFMCfo9L0+Drqb08+0Is5/nYDWk5
	 4diFYaCF6wFITmkW1lA0M7RNeLY6rXgOvIKw4eSDa3uVYfsB3oeTT8aHNVNTpL3xZi
	 cofERAcAYtPKTUhIG1S8q4OWZIBsVP5nogHk8Flk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfEUUdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:33:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfEUUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NroV3N1vJpd6DZ4DRQosf/gwRkeYD5eyKfv4NsTZWn0=; b=RPDaCjlCbz/v
        cUKM5iO9XPYzdRBGIj22IbikbB00PudC+BrqAz0xLKLvAyXLO1rxocbP3u8IhdvSjIfALlfybFDKn
        7ZLR5eFXTwFyzJaT5BqlBrcy/ou1yerLY5rtw9dxmo5dSiuwMlzyBzKz5A9U1N0W0oAPk30VRGeRf
        ATPkM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTBRI-0001yj-04; Tue, 21 May 2019 20:32:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B277E1126D1B; Tue, 21 May 2019 21:32:41 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: simple-card: Fix configuration of DAI format" to the asoc tree
In-Reply-To: <1558029086-18024-1-git-send-email-jonathanh@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190521203241.B277E1126D1B@debutante.sirena.org.uk>
Date:   Tue, 21 May 2019 21:32:41 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: Fix configuration of DAI format

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

From 069d037aea98ffa64c26d4b1dc958fb8f39f5c2b Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Thu, 16 May 2019 18:51:26 +0100
Subject: [PATCH] ASoC: simple-card: Fix configuration of DAI format

When configuring a codec to be both bit-clock and frame-master, it was
found that the codec was always configured as bit-clock and frame-slave.
Looking at the simple_dai_link_of() function there appears to be two
problems with the configuration of the DAI format, which are ...

1. The function asoc_simple_parse_daifmt() is called before the function
   asoc_simple_parse_codec() and this means that the device-tree node
   for the codec has not been parsed yet, which is needed by the
   function asoc_simple_parse_daifmt() to determine who is the codec.
2. The phandle passed to asoc_simple_parse_daifmt() is the phandle to
   the 'codec' node and not the phandle of the actual codec defined by
   the 'sound-dai' property under the 'codec' node.

Fix the above by moving the call to asoc_simple_parse_daifmt() after the
the call to asoc_simple_parse_codec() and pass the phandle for the codec
to asoc_simple_parse_daifmt().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 9b568f578bcd..c2c8dcbcf795 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -283,11 +283,6 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	codec_dai		=
 	dai_props->codec_dai	= &priv->dais[li->dais++];
 
-	ret = asoc_simple_parse_daifmt(dev, node, codec,
-				       prefix, &dai_link->dai_fmt);
-	if (ret < 0)
-		goto dai_link_of_err;
-
 	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
 
 	ret = asoc_simple_parse_cpu(cpu, dai_link, &single_cpu);
@@ -298,6 +293,11 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		goto dai_link_of_err;
 
+	ret = asoc_simple_parse_daifmt(dev, node, dai_link->codecs->of_node,
+				       prefix, &dai_link->dai_fmt);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	ret = asoc_simple_parse_platform(plat, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
-- 
2.20.1

