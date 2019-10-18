Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22C3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8097D2245A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422032;
	bh=utFmYwcbGuT2bwcOimZjkGDdSF8gOzIMBKV5zg5qv30=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DXmhDKvPppxWx/4NzIwrJu+lFWRFKFc/2E5XXpPD/XtkYaBX8Rf1+RdHpwm1AMzpg
	 q/31xfhADCE0otvxasap/HJ+5SxXJXa/GpyFp/bxNYA8mC95b+E2BpLy8K6BYz2Mah
	 j+EsDb7pV7Gfsf2JTYAlDxZwARqbognjOuPVGjWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505731AbfJRSHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:07:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505717AbfJRSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bmhg+/17g88lQSaN0+48g3/Zis9k7Udg88qlSS1o+MA=; b=WsrEodvRhBXE
        HYpwMKN35mSEhssW9zftk8eief4ZLz+Rs53Ri8erePRh6FWXNXHsQCcombxSTejhJS2mmMtOvVN4w
        P+7W+5KalXA5f0D6NEZDUlI8ECSQrg5WiXOVP26k3sHGxXDK3W7i/hRe7WIgwjammdTLJt0MLivsp
        KByxo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeR-0004Es-0T; Fri, 18 Oct 2019 18:06:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 691AA2741DEA; Fri, 18 Oct 2019 19:06:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     alsa-devel@alsa-project.org, "Cc:"@sirena.co.uk,
        "Cc:"@sirena.co.uk, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: tlv320aic32x4: add a check for devm_clk_get" to the asoc tree
In-Reply-To: <20191018081448.8486-1-hslester96@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180658.691AA2741DEA@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:06:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320aic32x4: add a check for devm_clk_get

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 1092b09708882e3c216f0b9c02e606b3c0942c5b Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Fri, 18 Oct 2019 16:14:49 +0800
Subject: [PATCH] ASoC: tlv320aic32x4: add a check for devm_clk_get

aic32x4_set_dai_sysclk misses a check for devm_clk_get and may miss the
failure.
Add a check to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191018081448.8486-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 68165de1c8de..b4e9a6c73f90 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -573,6 +573,9 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct clk *pll;
 
 	pll = devm_clk_get(component->dev, "pll");
+	if (IS_ERR(pll))
+		return PTR_ERR(pll);
+
 	mclk = clk_get_parent(pll);
 
 	return clk_set_rate(mclk, freq);
-- 
2.20.1

