Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E218AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43A2207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576497940;
	bh=rMI46GURD0nRQIXZae38p2McxD98ldeKeo0MnFGFEQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=EEXcJ5BoCOLGp45TRBBT4/tpBVSu9vBgiv/4CgGRkhxAnyqjnjRMgs7JlnYwT64/z
	 hYjdqVZK4Ud8du3sO08lJ4zDEPtp9EwQt7gzYHfmCJSUEUG3dZpy/lR4CoqZS5wOZG
	 FsANp15BpPnMqAT3CDFq73jEqYLn4FKHfDf5e59A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfLPMFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:05:39 -0500
Received: from foss.arm.com ([217.140.110.172]:52386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfLPMFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:05:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E4051045;
        Mon, 16 Dec 2019 04:05:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4E93F719;
        Mon, 16 Dec 2019 04:05:37 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:05:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     allison@lohutok.net, alsa-devel@alsa-project.org,
        broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
        gregkh@linuxfoundation.org, guennadi.liakhovetski@linux.intel.com,
        kstewart@linuxfoundation.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com, perex@perex.cz,
        shengjiu.wang@nxp.com, tglx@linutronix.de, tiwai@suse.com
Subject: Applied "ASoC: wm8962: fix lambda value" to the asoc tree
In-Reply-To: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
Message-Id: <applied-1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8962: fix lambda value

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

From 556672d75ff486e0b6786056da624131679e0576 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Wed, 11 Dec 2019 19:57:22 +0800
Subject: [PATCH] ASoC: wm8962: fix lambda value

According to user manual, it is required that FLL_LAMBDA > 0
in all cases (Integer and Franctional modes).

Fixes: 9a76f1ff6e29 ("ASoC: Add initial WM8962 CODEC driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 3e5c69fbc33a..d9d59f45833f 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2788,7 +2788,7 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 
 	if (target % Fref == 0) {
 		fll_div->theta = 0;
-		fll_div->lambda = 0;
+		fll_div->lambda = 1;
 	} else {
 		gcd_fll = gcd(target, fratio * Fref);
 
@@ -2858,7 +2858,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 		return -EINVAL;
 	}
 
-	if (fll_div.theta || fll_div.lambda)
+	if (fll_div.theta)
 		fll1 |= WM8962_FLL_FRAC;
 
 	/* Stop the FLL while we reconfigure */
-- 
2.20.1

