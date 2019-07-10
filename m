Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F614C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EC420844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562772895;
	bh=GFFe1fN71gvI8U857vb83UKm3PaX39Jo1DxrXfcrMy8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=A6SwQIPp5cjkI82V7mFL4eDz4v5vPYzYVuG8ZxT6aVb/mVoiUyyX+oPNZo/qe0M99
	 ndeXa/n63q6BFpkIPrhq6uC6biDQ7txtgRK510IIVALWBgv3YfX2CPD+1BEVobjYRj
	 8vXEXsPH+ttc5AJagD9hqSXBCvnwgdw3Ay+wP8RA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfGJPey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:34:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45652 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGJPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V91pmBsf6kxdFHew84eBND8S52MilJzfqdSmspUhTJo=; b=jAd/Ps0/iZHi
        BE2144LdPYYIb3qiC4sqEAcaUL+ip753Mlxb04YZrQxVAXbKuAmAkhgAg/qlYuHUR9EF01UFhlwci
        LbgX+a/lK5m4Be37ykGiwQPiUjTxAFeOhKtjiLhry1bFf9wnD6sUMy2QYao5G2YDUOc0k65HQv0Gn
        D/Cj0=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEcB-00082j-6P; Wed, 10 Jul 2019 15:34:39 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 99AAED02D7C; Wed, 10 Jul 2019 16:34:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cheng.shengyu@zte.com.cn, jonathanh@nvidia.com,
        kuninori.morimoto.gx@renesas.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
Subject: Applied "ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()" to the asoc tree
In-Reply-To:  <1562743509-30496-5-git-send-email-wen.yang99@zte.com.cn>
X-Patchwork-Hint: ignore
Message-Id: <20190710153438.99AAED02D7C@fitzroy.sirena.org.uk>
Date:   Wed, 10 Jul 2019 16:34:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()

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

From c152f8491a8d9a4b25afd65a86eb5e55e2a8c380 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Wed, 10 Jul 2019 15:25:09 +0800
Subject: [PATCH] ASoC: audio-graph-card: fix an use-after-free in
 graph_get_dai_id()

After calling of_node_put() on the node variable, it is still being
used, which may result in use-after-free.
Fix this issue by calling of_node_put() after the last usage.

Fixes: a0c426fe1433 ("ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get_dai_id()")
Link: https://lore.kernel.org/r/1562743509-30496-5-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index bddfcfd7bedf..343ede8042c3 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -63,6 +63,7 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *endpoint;
 	struct of_endpoint info;
 	int i, id;
+	u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
@@ -83,8 +84,9 @@ static int graph_get_dai_id(struct device_node *ep)
 			return info.id;
 
 		node = of_get_parent(ep);
+		reg = of_get_property(node, "reg", NULL);
 		of_node_put(node);
-		if (of_get_property(node, "reg", NULL))
+		if (reg)
 			return info.port;
 	}
 	node = of_graph_get_port_parent(ep);
-- 
2.20.1

