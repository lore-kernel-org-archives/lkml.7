Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEDDC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A99E206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575917970;
	bh=V60pYPrKjZfeaB7V4ppkx//CAhtwJRjoT17F2ZOIcNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=rKKySFQ/3VTLWdvzFWZO724aic6Z4LBQKn90wsyF+z2pAy6F42r330V/S6JbeC2Nf
	 3+Q6wriJpjn16ChvLXVCodo5viB3jyYY2+l6OoqNZESdkVRs3/NJf/7dyIlyDTdXan
	 VV1BfEx1fg1FgUfgqovpfX2pVkGJxnxKH0Bp+q1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLIS73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:59:29 -0500
Received: from foss.arm.com ([217.140.110.172]:42416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLIS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:59:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83963328;
        Mon,  9 Dec 2019 10:59:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04BB93F6CF;
        Mon,  9 Dec 2019 10:59:27 -0800 (PST)
Date:   Mon, 09 Dec 2019 18:59:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Subject: Applied "ASoC: fsl_sai: add IRQF_SHARED" to the asoc tree
In-Reply-To: <20191128223802.18228-1-michael@walle.cc>
Message-Id: <applied-20191128223802.18228-1-michael@walle.cc>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_sai: add IRQF_SHARED

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

From 2eb2d314a80eb8bb1a6faf2a74321d4497e1687d Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Thu, 28 Nov 2019 23:38:02 +0100
Subject: [PATCH] ASoC: fsl_sai: add IRQF_SHARED

The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
IRQF_SHARED to be able to use these SAIs simultaneously.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20191128223802.18228-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index b517e4bc1b87..8c3ea7300972 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -958,7 +958,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, 0, np->name, sai);
+	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, IRQF_SHARED,
+			       np->name, sai);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to claim irq %u\n", irq);
 		return ret;
-- 
2.20.1

