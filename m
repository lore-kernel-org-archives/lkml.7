Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE2C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C979221479
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763507;
	bh=g4DgSLnxQUp37XINiryGrlJ7kTFqOE0hfmdCLys/4fE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=NWjJHh3WmabfTllCGhW77D1mvrGyRuPcCvegtXqsM+8vxk/z5yEghjOR4Jhzrr31U
	 tO8bMP+qzgb3GYwzjzZW+bwfm1PbfLmFdE3WuLBNPKZREDf8syR2jw0dp3+qwWreTx
	 6oYkxm5lTg8amkangcJ0dFUzDGJMfvRh54NaveSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEBCSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:18:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBCST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tSRP9AREY1phAztSLdhpxjCCxjAVr/6vVxlS8p739D8=; b=ulRALQv+WaEZ
        dWAzFCLY+CxW6k6PgY3Y8PFjrGSd3H7DCO491Tl3E05IMZiuViUgwAlR4nmwo6GZgtZqKiPUxLFxl
        uxoNGF6k89EDqMqzlE+I96cwLemX7HXY6YehuuhQdwAKu6kauZrd3N6VoGnzGwnKyhG9dze4qa13Y
        5CEiU=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1IV-0005ps-20; Thu, 02 May 2019 02:18:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0F5F9441D41; Thu,  2 May 2019 03:18:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     alsa-devel@alsa-project.org, Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: sprd: Fix return value check in sprd_mcdt_probe()" to the asoc tree
In-Reply-To: <20190429122512.59242-1-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021803.0F5F9441D41@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Fix return value check in sprd_mcdt_probe()

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

From 7c88b92816dfe5eab224b96577b50ac00b4be68a Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 29 Apr 2019 12:25:12 +0000
Subject: [PATCH] ASoC: sprd: Fix return value check in sprd_mcdt_probe()

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: d7bff893e04f ("ASoC: sprd: Add Spreadtrum multi-channel data transfer support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-mcdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index 28f5e649733d..e9318d7a4810 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -951,8 +951,8 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mcdt->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!mcdt->base)
-		return -ENOMEM;
+	if (IS_ERR(mcdt->base))
+		return PTR_ERR(mcdt->base);
 
 	mcdt->dev = &pdev->dev;
 	spin_lock_init(&mcdt->lock);
-- 
2.20.1

