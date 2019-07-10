Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8439C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4C721707
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562772905;
	bh=YnfFjXkhlqbxJ0DX9YBsuFoMoB8bhbw6v7js+FgEP0E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=lvhCYHFLTunSc2JYyxDuUUSdryaxHDHA5DQL4jhsib14SqntSgUnSv/C7gkBV2U5A
	 Eo4yVuWrfFKAI1ejueNVwtXXSSlIDwKcQxaM/GuX+ay79bCCzKau9sG4AIfLXbSPtV
	 88xD3Qn6U/O6XfWuMcLAvhVpqN5fjwJDuFceSo/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfGJPfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:35:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfGJPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=04bg+sZZrBLkWF8C3HZXbLA2LKxdV1o7NbMp6YnOpyI=; b=NoIcbsuh5J2G
        e0FqYiSHFqJgoQGAwpESZbchFX2i3XFm225TuM6vuD/920WswRZ0ryesnHu+M4Hj/Qm1bDzcMci0Y
        5iNCgo7CHd5NRgi66P94aFkXqWhs2G3ylO3H5c2YyBpaE8gnQYCv2gfBg1DD1yEovHAPc0b9PnJNw
        P5zN8=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEcL-00083A-CK; Wed, 10 Jul 2019 15:34:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 1B853D02D7C; Wed, 10 Jul 2019 16:34:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cheng.shengyu@zte.com.cn, jonathanh@nvidia.com,
        kuninori.morimoto.gx@renesas.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
Subject: Applied "ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()" to the asoc tree
In-Reply-To:  <1562743509-30496-2-git-send-email-wen.yang99@zte.com.cn>
X-Patchwork-Hint: ignore
Message-Id: <20190710153449.1B853D02D7C@fitzroy.sirena.org.uk>
Date:   Wed, 10 Jul 2019 16:34:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 724808ad556c15e9473418d082f8aae81dd267f6 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Wed, 10 Jul 2019 15:25:06 +0800
Subject: [PATCH] ASoC: simple-card: fix an use-after-free in
 simple_dai_link_of_dpcm()

The node variable is still being used after the of_node_put() call,
which may result in use-after-free.

Fixes: cfc652a73331 ("ASoC: simple-card: tidyup prefix for snd_soc_codec_conf")
Link: https://lore.kernel.org/r/1562743509-30496-2-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index e5cde0d5e63c..4117e54884e5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -124,8 +124,6 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	li->link++;
 
-	of_node_put(node);
-
 	/* For single DAI link & old style of DT node */
 	if (is_top)
 		prefix = PREFIX;
@@ -147,17 +145,17 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_cpu(np, dai_link, &is_single_links);
 		if (ret)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_cpu(dev, np, dai_link, dai);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "fe.%s",
 						   cpus->dai_name);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
 	} else {
@@ -180,17 +178,17 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_codec(np, dai_link);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_codec(dev, np, dai_link, dai);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "be.%s",
 						   codecs->dai_name);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		/* check "prefix" from top node */
 		snd_soc_of_parse_node_prefix(top, cconf, codecs->of_node,
@@ -208,19 +206,21 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	ret = asoc_simple_parse_tdm(np, dai);
 	if (ret)
-		return ret;
+		goto out_put_node;
 
 	ret = asoc_simple_parse_daifmt(dev, node, codec,
 				       prefix, &dai_link->dai_fmt);
 	if (ret < 0)
-		return ret;
+		goto out_put_node;
 
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &simple_ops;
 	dai_link->init			= asoc_simple_dai_init;
 
-	return 0;
+out_put_node:
+	of_node_put(node);
+	return ret;
 }
 
 static int simple_dai_link_of(struct asoc_simple_priv *priv,
-- 
2.20.1

