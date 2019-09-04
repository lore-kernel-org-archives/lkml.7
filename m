Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249B5C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F2922CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619625;
	bh=EKC54s8Nwa8WTEzFg9SqPFjZUiAURMBeU9zDx5+QfiA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DtcmYk0ZgqOjVy1tKbrpR9P/ZWWKVPfr12mrzs9F1SHSIa2q2oi/7HBaSGP/FDUlK
	 nGOBUcuMgJWa6IWDl4V2OUke66ZTo6dgG041Pcmae2VXUijz+PVbTT+9HlDrVyH3TR
	 xHXIU45mfWdjJKfb67BlA+N8ylrgaiWoTP5PWE18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfIDRxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:53:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49742 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfIDRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Vad4mT+RpRm83DagHXSdfbCu0yANmHakAwjZP/ttn9s=; b=S5N2XJlZgWqd
        NMmxs5uW8p3g9iQT+u0fSfVvptiA+UkrkE/kPIGEHVhuffWZCUU3AYBR/8W95mAbZ0yp2yQi/qeaV
        L5zI1C6XMlR8o05irg8wmYODkvUPO+esvjN0YMS4i3GJQounsP5HvrdHcZxoLP1NJqnfzXZh1fRN8
        3lF+E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5ZTC-0006h8-IU; Wed, 04 Sep 2019 17:53:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id ED4822742D17; Wed,  4 Sep 2019 18:53:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alexander.sverdlin@gmail.com, alsa-devel@alsa-project.org,
        arnd@arndb.de, broonie@kernel.org, hsweeten@visionengravers.com,
        Hulk Robot <hulkci@huawei.com>, info@metux.net,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, olof@lixom.net,
        perex@perex.cz, tglx@linutronix.de, tiwai@suse.com,
        yuehaibing@huawei.com
Subject: Applied "ASoC: ep93xx: use devm_platform_ioremap_resource() to simplify code" to the asoc tree
In-Reply-To: <20190904082507.24300-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190904175325.ED4822742D17@ypsilon.sirena.org.uk>
Date:   Wed,  4 Sep 2019 18:53:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ep93xx: use devm_platform_ioremap_resource() to simplify code

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

From f295495ec657c5fb2cff355456c2a20c4c945d93 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 4 Sep 2019 16:25:07 +0800
Subject: [PATCH] ASoC: ep93xx: use devm_platform_ioremap_resource() to
 simplify code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190904082507.24300-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/cirrus/ep93xx-ac97.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index 84c967fcab6b..e21eaa1893d1 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -362,7 +362,6 @@ static const struct snd_soc_component_driver ep93xx_ac97_component = {
 static int ep93xx_ac97_probe(struct platform_device *pdev)
 {
 	struct ep93xx_ac97_info *info;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -370,8 +369,7 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_ioremap_resource(&pdev->dev, res);
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-- 
2.20.1

