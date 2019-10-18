Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07170CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C5222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422098;
	bh=xjCew2fyAMJ/kTeMgSUul3MJEuYKt90pfdYZoa0tzM4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Z1UKzm2gOKuext1/Ld6ji6pzXv3xnowWTSorcfE67D7WkJBDDEPAEPZyis09AnPQA
	 fnbZC/TvA87kamdAfeCL/M6pNhtEMCp1JgQD4Yez63xDfZADEip80MrxnxwymXf1WC
	 IY3xIgU5YAwq4U/AHN4qtHz5w88WBnONHwgN0nYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505809AbfJRSIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:08:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45318 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505756AbfJRSHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3hcMcor/FN+8Ad96YbO9u/6CZToK6CJA7ZrtqwtS/rc=; b=jyusJVGaSS2W
        TsynWLOOKgiRRyo961YezP6/4Q0uwa7yA2HkIiCqH/NzO1NasX4a/bbr6lgOkjyG6JSnrPRXuok5J
        y4TWUJMfwDFRf5dPlrLmKMjI289EsVP+nfIAXv1TrIzNKZJLDlq+uEQ5cFRDmvBvJ/mKXepSP1Sl+
        qTtX8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeS-0004Fh-QU; Fri, 18 Oct 2019 18:07:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4E8672743273; Fri, 18 Oct 2019 19:07:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     alsa-devel@alsa-project.org, "Cc:"@sirena.co.uk,
        "Cc:"@sirena.co.uk, Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Intel: sof-rt5682: add a check for devm_clk_get" to the asoc tree
In-Reply-To: <20191017025044.31474-1-hslester96@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180700.4E8672743273@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:07:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: sof-rt5682: add a check for devm_clk_get

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

From e5f0d490fb718254a884453e47fcd48493cd67ea Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Thu, 17 Oct 2019 10:50:44 +0800
Subject: [PATCH] ASoC: Intel: sof-rt5682: add a check for devm_clk_get

sof_audio_probe misses a check for devm_clk_get and may cause problems.
Add a check for it to fix the bug.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191017025044.31474-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 5ce643d62faf..4f6e58c3954a 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -603,6 +603,15 @@ static int sof_audio_probe(struct platform_device *pdev)
 	/* need to get main clock from pmc */
 	if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
 		ctx->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		if (IS_ERR(ctx->mclk)) {
+			ret = PTR_ERR(ctx->mclk);
+
+			dev_err(&pdev->dev,
+				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
+				ret);
+			return ret;
+		}
+
 		ret = clk_prepare_enable(ctx->mclk);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
-- 
2.20.1

