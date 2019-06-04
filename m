Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BABC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B50524AB7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559660350;
	bh=4Hjp/ObF0DbD3WwrkMygRC2ARB8hifTb1xokdd9AbmI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Zj//G/fn+FUbTmeBJZbuddTXW6vzxu0tTaaA4s4VSeS0WLxNb1dR1ZcB1Cb5gveah
	 uCRi5rmrB3WEyR9yPqheHKkDlkNgPERGybWX4OlcBqN0hUHwmpjnCAsYSj1weohICE
	 igQ6ES3/qFERBCGFdspXjdTdL4bbxduEyN9MbNJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfFDO7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:59:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48664 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDO7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3fMg2snLMaK3DY6bsSoeVywpNNwk9adJU5UweamOHes=; b=jafoolg+yknl
        L7102yJp+Wua6W3SRTJPgRM7Dzke0Rdb3SDkl5fh+yBSdkgT6urtekcv13Hy3Bin8D+b8LPHovM41
        rSevjtXij3ksr1qf7S916N6CRH/vkKRNMxkzugc6fLgYappul757aAzaq29xhdQJ6NsJtpGqFe8+m
        ppQpQ=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAtt-0006EI-PR; Tue, 04 Jun 2019 14:58:57 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id F07A6440046; Tue,  4 Jun 2019 15:58:56 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marcus Cooper <codekipper@gmail.com>
Cc:     alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        broonie@kernel.org, Chen-Yu Tsai <wens@csie.org>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mark Brown <broonie@kernel.org>,
        maxime.ripard@free-electrons.com,
        Maxime Ripard <maxime.ripard@bootlin.com>, wens@csie.org
Subject: Applied "ASoC: sun4i-i2s: Add offset to RX channel select" to the asoc tree
In-Reply-To: <20190603174735.21002-3-codekipper@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190604145856.F07A6440046@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:58:56 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Add offset to RX channel select

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

From f9927000cb35f250051f0f1878db12ee2626eea1 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Mon, 3 Jun 2019 19:47:28 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Add offset to RX channel select

Whilst testing the capture functionality of the i2s on the newer
SoCs it was noticed that the recording was somewhat distorted.
This was due to the offset not being set correctly on the receiver
side.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8162e107e50b..bc128e2a6096 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -460,6 +460,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+
+		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
2.20.1

