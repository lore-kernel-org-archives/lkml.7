Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8785C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A780020835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519363;
	bh=J1DNXT26bVOCj2FpQYznb2VenJzkJYntMx1553W5VGA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=C6YhMoZal83+aIoVRN7OoBIsTp2s30gNP1JwoTnfRvTIoZkRkFdeEE7RXJJMI2afG
	 hxQ8xenuED3TYAY83ILzbt6zoEmFXH9hYIEsXz1yiYmBaFUzZ5CMFK2CJPsP6kd96L
	 VFRzy2CdSiZ9MA6WxeZO8LTuXw4OBOynWxt7GGsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfDQQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:42:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbfDQQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rKxO2gwv606fL0bOuQHR9JuVdkC0i3FrfCQSfHd28jg=; b=egSzsNga7L/S
        deOjP8Q7sUO771natnLcF5747XXwhsxH4fCAQm2GZLLspPq5ay4zSLhk17EtyldGbiMEU27rUVaTU
        m5KF1lCgHqhLD8QxlnkDspcFh0p5sQvcsu/P8UjmM+fi+iBMV0Spyjg6Z+tG4fLrHZd5dTQAXOic9
        WTVbI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGndW-000154-VD; Wed, 17 Apr 2019 16:42:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8336F1128FCB; Wed, 17 Apr 2019 17:42:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, nh6z@nh6z.net, perex@perex.cz,
        tiwai@suse.com
Subject: Applied "ASoC: tlv320aic32x4: Remove set but not used variable 'mclk_rate'" to the asoc tree
In-Reply-To: <20190417150157.24044-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190417164214.8336F1128FCB@debutante.sirena.org.uk>
Date:   Wed, 17 Apr 2019 17:42:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320aic32x4: Remove set but not used variable 'mclk_rate'

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

From 9f54872adbc2707b44eaf898defce60285aeca69 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 17 Apr 2019 23:01:57 +0800
Subject: [PATCH] ASoC: tlv320aic32x4: Remove set but not used variable
 'mclk_rate'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/codecs/tlv320aic32x4.c: In function 'aic32x4_setup_clocks':
sound/soc/codecs/tlv320aic32x4.c:669:16: warning: variable 'mclk_rate' set but not used [-Wunused-but-set-variable]

It is not used since introduction in
commit 96c3bb00239d ("ASoC: tlv320aic32x4: Dynamically Determine Clocking")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 6edee05ff9f0..83608f386aef 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -684,9 +684,8 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	u8 madc, nadc, mdac, ndac, max_nadc, min_mdac, max_ndac;
 	u8 dosr_increment;
 	u16 max_dosr, min_dosr;
-	unsigned long mclk_rate, adc_clock_rate, dac_clock_rate;
+	unsigned long adc_clock_rate, dac_clock_rate;
 	int ret;
-	struct clk *mclk;
 
 	struct clk_bulk_data clocks[] = {
 		{ .id = "pll" },
@@ -700,9 +699,6 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	mclk = clk_get_parent(clocks[1].clk);
-	mclk_rate = clk_get_rate(mclk);
-
 	if (sample_rate <= 48000) {
 		aosr = 128;
 		adc_resource_class = 6;
-- 
2.20.1

