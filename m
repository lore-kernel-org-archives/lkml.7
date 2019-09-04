Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7B9C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36051208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619654;
	bh=78PTE6SRKbAXh40bNBVAtSefxo6kAOx86BCcOdYJ7U0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=04AEtpFAbjsqpJySvGe+J4dUBmPU9pfyHrAo5PkvVyq15sr33Y6O51aqUfrWrJ7i/
	 +f3fCLycI9trVABXNg/UstOs6/70pAoGW9dj2mxWlv7MpN2AkMIpsLU6+fFDM8JhgN
	 5rCb0b75Sii/0Y2rt6REfGyRnnUV25SGKOvD49uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbfIDRyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:54:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50758 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbfIDRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7ttXZOpkeg+FjvNQDWlFzQjkHjoEWkkwaMi5WFQGeEU=; b=GXaewmrgvV0n
        SjvhmA/OrINj8bCNtWzZA1Y/+cZgPwVluH+O48DcPUjfpLLKbNOVZtbRw5mFd574JsgEnlzZNpG5c
        DJ2RERbsDrwG1Ux4FEdb+EEGdKNFmg9xnVvxDnclSbHbI1cQxSL4ZvIz/khxSsnVRLhGZR5uJx+Vj
        zuwHM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5ZTC-0006h6-5A; Wed, 04 Sep 2019 17:53:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 74E7F2742CDC; Wed,  4 Sep 2019 18:53:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alexios.zavras@intel.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        Hulk Robot <hulkci@huawei.com>, jonathanh@nvidia.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, rfontana@redhat.com, tglx@linutronix.de,
        thierry.reding@gmail.com, tiwai@suse.com, yuehaibing@huawei.com
Subject: Applied "ASoC: tegra: use devm_platform_ioremap_resource() to simplify code" to the asoc tree
In-Reply-To: <20190904083909.18804-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190904175325.74E7F2742CDC@ypsilon.sirena.org.uk>
Date:   Wed,  4 Sep 2019 18:53:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tegra: use devm_platform_ioremap_resource() to simplify code

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

From a813d0e8884e514e6e1b28ad3b22f7658d446b16 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 4 Sep 2019 16:39:09 +0800
Subject: [PATCH] ASoC: tegra: use devm_platform_ioremap_resource() to simplify
 code

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190904083909.18804-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra30_ahub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 952381260dc3..635eacbd28d4 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -511,7 +511,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	const struct tegra30_ahub_soc_data *soc_data;
 	struct reset_control *rst;
 	int i;
-	struct resource *res0, *res1;
+	struct resource *res0;
 	void __iomem *regs_apbif, *regs_ahub;
 	int ret = 0;
 
@@ -587,8 +587,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	}
 	regcache_cache_only(ahub->regmap_apbif, true);
 
-	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	regs_ahub = devm_ioremap_resource(&pdev->dev, res1);
+	regs_ahub = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(regs_ahub))
 		return PTR_ERR(regs_ahub);
 
-- 
2.20.1

