Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E25C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA70C2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023647;
	bh=uqnhlmMJBnTR4u4VXY9M/SFJ0Vp2nbeKljgURp5COaU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2vf0fnYwl17Ql1ZsMS64YF2qvoqERxjHkya2B/kPmVlkG15xSMUV/EeSmcNmcLddd
	 TPr5sPvR4YzzRtdW7ViUnQK59z4+mJWo6n2dqEK1VfxF0DrMGLuqP/c7fWCDog2wef
	 cnLLxEYkwqwIvLy//S5AkQfJ3iJABwFbYJef1LVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390234AbfIIKH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:07:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfIIKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pgifkWS240+0IXtL8Cmh/xJGQiIwKppg9/fFNPpyMzA=; b=o+7g/kAVaukw
        y4CcDvi6FPdDWUfOsbTaPm6f+qq1ZOedWjEtn8vj3pl4MbVQh0/w5lBI8zsD+HKMPoubYQnVh7bKo
        bvUjTdBJW2O52gt1vcb9nFwA1JrgtML+K9TFhVcQnTqzXKjlB2NFKMrInhVVar9MY3WqWdBv/6WsN
        uzzsY=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7GZp-0001s1-U1; Mon, 09 Sep 2019 10:07:17 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 2EE5AD02D76; Mon,  9 Sep 2019 11:07:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: ignore 0Hz sysclk" to the asoc tree
In-Reply-To: <20190907174332.19586-1-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20190909100717.2EE5AD02D76@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 11:07:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: ignore 0Hz sysclk

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

From f1879d7b98dc9081cffc7718b644c6c41628cd18 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Sun, 8 Sep 2019 02:43:32 +0900
Subject: [PATCH] ASoC: rockchip: ignore 0Hz sysclk

This patch ignores sysclk setting if it is 0Hz.

Some codecs treat 0Hz sysclk as signal of applying no constraints.
This driver does not have such feature but current implementation
outputs 'Failed to set mclk' error message if machine driver sets
0Hz sysclk to this driver.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Link: https://lore.kernel.org/r/20190907174332.19586-1-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 88ebaf6e1880..af2d5a6124c8 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -419,6 +419,9 @@ static int rockchip_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 	struct rk_i2s_dev *i2s = to_info(cpu_dai);
 	int ret;
 
+	if (freq == 0)
+		return 0;
+
 	ret = clk_set_rate(i2s->mclk, freq);
 	if (ret)
 		dev_err(i2s->dev, "Fail to set mclk %d\n", ret);
-- 
2.20.1

