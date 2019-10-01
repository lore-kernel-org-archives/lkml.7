Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1B3ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9364F21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930095;
	bh=qxFFRP0Mz999C1Im2HZPNCL757Z/Di0jVeM6rw+guSo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nPeN01RklEXd2QcQUoOM5ohI6GyKrm1iQGwHjYJPETSPDUuJ6X8zJcudyYAHugASN
	 +OpfIbQvgf4KsKfgekOZFPsK/xoS39PYcWK4MwotlqxBCzOJUdv+EN9bDB7JB/kH4t
	 j0SLke5XMU9h+KgVXAxdzUSZyfg7QEL2BoJde4W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbfJALle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:41:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387652AbfJALlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v0/05wFK2YCFSSHAfKo2XXn6kgAZA94ncAdxzXief3k=; b=izjFGZlkdPFM
        0pxQZKFqpYpjVlIMBGjenYxcmBF/v1nvKfr9F2EJvIZfVgJNtqLv2HICgutojI9OIaVMX9zktZPBk
        UHGMHIWtT+3HYiNdXzZ5CCUFbcu1dgIHxtLgySi3sdTO/s+qR2HPQq7+32YDSEITwe23g0GssJ8JT
        Gk9/g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWg-0004Yl-Ng; Tue, 01 Oct 2019 11:41:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2FA1C2742A10; Tue,  1 Oct 2019 12:41:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Markus Elfring <elfring@users.sourceforge.net>
Cc:     kernel-janitors@vger.kernel.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Applied "spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_probe()" to the spi tree
In-Reply-To: <478e0df1-e800-8cf1-f9b3-d72f8e26aa0b@web.de>
X-Patchwork-Hint: ignore
Message-Id: <20191001114106.2FA1C2742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_probe()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 5dd381e71994ab554f711afe89b5a6157bdcd19d Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 14:45:40 +0200
Subject: [PATCH] spi: mediatek: Use devm_platform_ioremap_resource() in
 mtk_spi_probe()

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://lore.kernel.org/r/478e0df1-e800-8cf1-f9b3-d72f8e26aa0b@web.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6888a4dcff6d..25fe149a8d9a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -619,7 +619,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
-	struct resource *res;
 	int i, irq, ret, addr_bits;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
@@ -682,15 +681,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		goto err_put_master;
-	}
-
-	mdata->base = devm_ioremap_resource(&pdev->dev, res);
+	mdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdata->base)) {
 		ret = PTR_ERR(mdata->base);
 		goto err_put_master;
-- 
2.20.1

