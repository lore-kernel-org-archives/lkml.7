Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FAEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1273624AEC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559660378;
	bh=o7b0GYBiXMIAvaWRIdugq4d4ZCc9JmeV/unxfp/VrvU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ia1SelD2NVV2+sXNV0udzWLQuqKPJeo9xNmP8t2pWStPxO2a2eZb4C9P+/cmB+0tk
	 6+AhNK+BhZwFCKcb4AmnEuZk7Yd1NR48S2WE/Rxb2B/DE6iOoMIHq7qiFg8LizJjMK
	 MD+nYfv/oFPomvWtahC9gOe9ivL16goTSFShJQEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfFDO7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:59:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48776 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LmvDBFBaxX8IESNmPJ1qIhurOxBytWFJfTUlkeGLfyk=; b=PqJS5kV1PwRs
        7fINX6Dm6j3c5xOTv/jCLhat7cloSMMtpSC/CHYAD9BWbehf76Ssgk1II4UVQWTYiqL9GA9BRLQg3
        XC2RgjRfEswTaw6k4gCHJHVWcct1Eu0oKMH/qU9BGUSEnxaVTqjAZuPQdEqX4rfTeuofVJza0HGXY
        GKWDw=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAtu-0006EJ-1j; Tue, 04 Jun 2019 14:58:58 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 84383440049; Tue,  4 Jun 2019 15:58:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marcus Cooper <codekipper@gmail.com>
Cc:     alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        broonie@kernel.org, Chen-Yu Tsai <wens@csie.org>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mark Brown <broonie@kernel.org>,
        maxime.ripard@free-electrons.com,
        Maxime Ripard <maxime.ripard@bootlin.com>, wens@csie.org
Subject: Applied "ASoC: sun4i-i2s: Fix sun8i tx channel offset mask" to the asoc tree
In-Reply-To: <20190603174735.21002-2-codekipper@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190604145857.84383440049@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:58:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Fix sun8i tx channel offset mask

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

From 7e46169a5f35762f335898a75d1b8a242f2ae0f5 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Mon, 3 Jun 2019 19:47:27 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Fix sun8i tx channel offset mask

Although not causing any noticeable issues, the mask for the
channel offset is covering too many bits.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d5ec1a20499d..8162e107e50b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -110,7 +110,7 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
-- 
2.20.1

