Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54919C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9DF21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619627;
	bh=10eYb27Qj7YhNBvZcf4pewUKKO21gCl18za84AkSVbo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nzd2mpSDYk45X4CH7rVI5FEP9DmcePXmSyTEHBhwBThfwR15zind0Zk5NXIiY1bKL
	 YvT0jQ7ilEtkytteX651IFQnbyUJz0bS/zv139VvKtaD3RG/BjXKpMeknxo0M4wGbK
	 7xCP6tpH7Lr9PpgJNzEqAkHzScraJiBFiZL5knsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbfIDRxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:53:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfIDRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/sL2DCmUGJPlR66hzIWdV5il3VK8mgt+9vHWqn8XlBw=; b=UtPmvZ+CWci9
        F0vyuzTNzs5PLdD0wcRP6VRCNvcwjRuEfKWSUfmTTJu88ATlVciC27f7gYmkJVl9tEnVYX310ksYA
        alKmNzuIeUwDQ+rSDXMhCPIxb/GKMrcTn6HEmluwRO5+3VT+C3rHEM7iHZ6/I8uFcrLszo3FkyCf2
        cQSH4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5ZTC-0006h7-7t; Wed, 04 Sep 2019 17:53:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B218C2742D07; Wed,  4 Sep 2019 18:53:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     allison@lohutok.net, alsa-devel@alsa-project.org,
        baohua@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        Hulk Robot <hulkci@huawei.com>, kstewart@linuxfoundation.org,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        pakki001@umn.edu, perex@perex.cz, tglx@linutronix.de,
        tiwai@suse.com, yuehaibing@huawei.com
Subject: Applied "ASoC: sirf-audio: use devm_platform_ioremap_resource() to simplify code" to the asoc tree
In-Reply-To: <20190904083412.18700-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190904175325.B218C2742D07@ypsilon.sirena.org.uk>
Date:   Wed,  4 Sep 2019 18:53:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sirf-audio: use devm_platform_ioremap_resource() to simplify code

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

From 2f302d476c960fdf8481399a46b8df92408d06e2 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 4 Sep 2019 16:34:12 +0800
Subject: [PATCH] ASoC: sirf-audio: use devm_platform_ioremap_resource() to
 simplify code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190904083412.18700-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sirf-audio-codec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 9009a7407b7a..a061d78473ac 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -459,7 +459,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 	int ret;
 	struct sirf_audio_codec *sirf_audio_codec;
 	void __iomem *base;
-	struct resource *mem_res;
 
 	sirf_audio_codec = devm_kzalloc(&pdev->dev,
 		sizeof(struct sirf_audio_codec), GFP_KERNEL);
@@ -468,8 +467,7 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sirf_audio_codec);
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, mem_res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.20.1

