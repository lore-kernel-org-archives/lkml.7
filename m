Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13213C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD447208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562772917;
	bh=ea2CnYZ3pJTmbi9a9Ns/TbFol/GOl0zrR3orFcaBEC0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=uzF1X4iHQs4b+x6l4r96snzBvfmNUqXExfKdNLyks4CeCaCIWZT9zMcEX3k0p1Vvr
	 0ftYVrDXf+Cxs+rlXd6YGTjwud2b9B+X2cLK3IHmVGY3kSJcqpMzUgajsoYJh6X+34
	 IEpJ3yeh75zulB1WSwRAZ0Lh/mOdpTiRMjI6FXz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfGJPfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:35:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfGJPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OJOmdq13zo6Dlox6R8w0maL9PomW9D3dvtCqc3uExQc=; b=Uv1gESDPPiCo
        lPtmbPmjX2y7Nie7E7zeXLbxWyxlbzrpfP4w0oixJ3/Zqlg2FvIFK8z6fGrvMBqFjZ0Z8+X0MmVno
        muBDH6DP8ngecW5Z1u8tR2AB8XQzu6nVOPXyibfEuYRa0JuncpO6LvvNfjnCeCFHpPlABQ0A42tud
        Raqcw=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEcG-00082w-Ir; Wed, 10 Jul 2019 15:34:44 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3A14AD02D7C; Wed, 10 Jul 2019 16:34:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cheng.shengyu@zte.com.cn, jonathanh@nvidia.com,
        kuninori.morimoto.gx@renesas.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
Subject: Applied "ASoC: simple-card: fix an use-after-free in simple_for_each_link()" to the asoc tree
In-Reply-To:  <1562743509-30496-3-git-send-email-wen.yang99@zte.com.cn>
X-Patchwork-Hint: ignore
Message-Id: <20190710153444.3A14AD02D7C@fitzroy.sirena.org.uk>
Date:   Wed, 10 Jul 2019 16:34:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: fix an use-after-free in simple_for_each_link()

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

From 27862d5a3325bc531ec15e3c607e44aa0fd57f6f Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Wed, 10 Jul 2019 15:25:07 +0800
Subject: [PATCH] ASoC: simple-card: fix an use-after-free in
 simple_for_each_link()

The codec variable is still being used after the of_node_put() call,
which may result in use-after-free.

Fixes: d947cdfd4be2 ("ASoC: simple-card: cleanup DAI link loop method - step1")
Link: https://lore.kernel.org/r/1562743509-30496-3-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4117e54884e5..ef849151ba56 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -364,8 +364,6 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 			goto error;
 		}
 
-		of_node_put(codec);
-
 		/* get convert-xxx property */
 		memset(&adata, 0, sizeof(adata));
 		for_each_child_of_node(node, np)
@@ -387,11 +385,13 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 				ret = func_noml(priv, np, codec, li, is_top);
 
 			if (ret < 0) {
+				of_node_put(codec);
 				of_node_put(np);
 				goto error;
 			}
 		}
 
+		of_node_put(codec);
 		node = of_get_next_child(top, node);
 	} while (!is_top && node);
 
-- 
2.20.1

