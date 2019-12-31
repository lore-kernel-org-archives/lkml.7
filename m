Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DFC2D0D3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584B1206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577752246;
	bh=vsPS4RrjpH/WmuFp50fCqtim0YRuiLX1Kwdw7CpSG80=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=lmjI7N7ds6W/r2LI0gVLqZAQsuIkv0APXiWDuy6O30CqPLMooBdfSEDXN4zfQT2JG
	 7954bdcPOWCzbyS47mgdy51qwnrf8tgtGBqYZZbdCSD7FLKCiBkouWSMVCmqCASjvu
	 T7M2ikjImoiM/harSI0ScpyhTuqz6Tn1tRl/tim4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLaAap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:30:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46324 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfLaAao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=q9DgC2JorIRoqJhF31krGorwxtftpf4/q1uLy/wL7Rk=; b=tB/IfDFnF3Fh
        dMnBqp4+ZZmSaDOKLYo4X2z67JeplcAANmUjrQeNCKSiwjYlm2UZctXBCqeMqxpdmTP/ZR72gN0fE
        Fdyq9rbtfSWEIEab5wB2YRw0ZFs8E3pGLPtiise0oq1f1ZJczZF4TE5DeoZ1s444yjBO8UmqGfcz0
        7hPvQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1im5Qg-0002nr-Rs; Tue, 31 Dec 2019 00:30:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 62549D01A24; Tue, 31 Dec 2019 00:30:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, brian.austin@cirrus.com,
        broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
        ckeepax@opensource.cirrus.com, kernel-janitors@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Paul.Handrigan@cirrus.com, perex@perex.cz,
        rf@opensource.cirrus.com, tiwai@suse.com
Subject: Applied "ASoC: cs47l92: Simplify error handling code in 'cs47l92_probe()'" to the asoc tree
In-Reply-To: <20191226162907.9490-1-christophe.jaillet@wanadoo.fr>
Message-Id: <applied-20191226162907.9490-1-christophe.jaillet@wanadoo.fr>
X-Patchwork-Hint: ignore
Date:   Tue, 31 Dec 2019 00:30:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs47l92: Simplify error handling code in 'cs47l92_probe()'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 9ea7a991cc27e9af1099b7a628c0ab210dc70a69 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu, 26 Dec 2019 17:29:07 +0100
Subject: [PATCH] ASoC: cs47l92: Simplify error handling code in
 'cs47l92_probe()'

If 'madera_init_bus_error_irq()' fails,
'wm_adsp2_remove(&cs47l92->core.adsp[0])' will be called twice.
Once in the 'if' block, and once in the error handling path.
This is harmless, but one of this call can be axed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20191226162907.9490-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l92.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l92.c b/sound/soc/codecs/cs47l92.c
index d50f75f3b3e4..536b7d35d6b2 100644
--- a/sound/soc/codecs/cs47l92.c
+++ b/sound/soc/codecs/cs47l92.c
@@ -1959,10 +1959,8 @@ static int cs47l92_probe(struct platform_device *pdev)
 		goto error_dsp_irq;
 
 	ret = madera_init_bus_error_irq(&cs47l92->core, 0, wm_adsp2_bus_error);
-	if (ret != 0) {
-		wm_adsp2_remove(&cs47l92->core.adsp[0]);
+	if (ret != 0)
 		goto error_adsp;
-	}
 
 	madera_init_fll(madera, 1, MADERA_FLL1_CONTROL_1 - 1,
 			&cs47l92->fll[0]);
-- 
2.20.1

