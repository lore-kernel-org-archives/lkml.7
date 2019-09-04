Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0CC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66731208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619623;
	bh=H5+rd+m1l2I4vg2UE8bUyffVx/2IpmLt64BPIBfCkkY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0m8ZsHk6lkOXIFzFBV0yHJIOk0VdbB9VR0NVZ21+b3hjVokJzJ1EikIjvm5l7iNIU
	 twNLQRPxJpKQX4XS1+sjAy6iuFVFWB3IP0WorBNPDMV5XUHcNRuMrYjqN/kvl69Sy9
	 ljVtY8EXddM+8ZKm1oi4/JltggCJpwDubKqQ38U8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbfIDRxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:53:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49738 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbfIDRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VCp+GINcdewaFZUB7P8VBjJ5Q+P6scN0GPbH/ZYlu7g=; b=lIUzyIf+Ndxz
        kAGCdJy6h5VNx3k/w/8/MIzj5BXPlw4K1V4lYvCpfSj68s0pbFh8JlS7qkNbruBjIFeeg2GUvywjL
        rom9pMG54jZfn3KbbZNssYtylHSzX+ZtZ1GSzb8H0/uSn6FaDgi5S63TzSKj2B6XCLvvT0SDfJABy
        l8HY4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5ZTC-0006hF-NW; Wed, 04 Sep 2019 17:53:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 365752742CDC; Wed,  4 Sep 2019 18:53:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     akshu.agrawal@amd.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, yuehaibing@huawei.com,
        yuzhao@google.com
Subject: Applied "ASoC: amd: use devm_platform_ioremap_resource() to simplify code" to the asoc tree
In-Reply-To: <20190904074833.23572-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190904175326.365752742CDC@ypsilon.sirena.org.uk>
Date:   Wed,  4 Sep 2019 18:53:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: use devm_platform_ioremap_resource() to simplify code

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

From dfafc1822f6826c9d250223f59ce8c3b227866a6 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 4 Sep 2019 15:48:33 +0800
Subject: [PATCH] ASoC: amd: use devm_platform_ioremap_resource() to simplify
 code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190904074833.23572-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index d26653f81416..52225b4b6382 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1251,8 +1251,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	if (!audio_drv_data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	audio_drv_data->acp_mmio = devm_ioremap_resource(&pdev->dev, res);
+	audio_drv_data->acp_mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(audio_drv_data->acp_mmio))
 		return PTR_ERR(audio_drv_data->acp_mmio);
 
-- 
2.20.1

