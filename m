Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31220811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578896;
	bh=e/GGHQ5mHwp0DNbD7E7CEtBDaVOrWkrapBRjqOEDHGE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ON9CFMKTT2UF4Q7GmVPo81NShm/ii9vqQnH0IvWdiv0uY7iOwR2YKMOIjPIJJ+1y7
	 3AWqt8xAMLB1DJScNKalPggn7dbCtmMnxbgNX4EANW+Mk0LZB+rVV5E3AeKNprKepN
	 ypaY6GW2N17lP2rp7CoNrhGLYhHQMwZKydYvdG6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCNPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36932 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfCNPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CA1F94kA2URfqK2hxWf2nTYGSDQuAaGx2MuHdOUEU3A=; b=ajOAGEZe+RqU
        PM0t4yK+Py/KnqLu2fGEzFP3EgsKz/RU5lSCk2Au3/jlDq/p0AxOuLcqeBFFj2aMpU+mc+8lXs2hS
        nk5TIrfOEpDDKupSF+RDUgogli7AdcPVu1oNn4SnyH5NTz+/BhgxbDjc0ECr+YZn9771FcZ0XOaq7
        7w6OM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sgx-0002kK-JB; Thu, 14 Mar 2019 15:54:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 235511126E64; Thu, 14 Mar 2019 15:54:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Volker Haspel <volker.haspel@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        han.xu@nxp.com, volker.haspel@linutronix.de,
        john.ogness@linutronix.de, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-fsl-qspi: use devm_spi_register_controller" to the spi tree
In-Reply-To:  <20190312101203.14207-2-volker.haspel@linutronix.de>
X-Patchwork-Hint: ignore
Message-Id: <20190314155447.235511126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-qspi: use devm_spi_register_controller

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 8fcb830a00f0980ffe38d223cdd9a4d2d24da476 Mon Sep 17 00:00:00 2001
From: Volker Haspel <volker.haspel@linutronix.de>
Date: Tue, 12 Mar 2019 11:12:03 +0100
Subject: [PATCH] spi: spi-fsl-qspi: use devm_spi_register_controller

The driver does not clearly unregister the spi controller.
Therefore calling an unbind and bind again will end up in a
Kernel crash.

The function devm_spi_register_controller will automatically
be unregister the SPI device.

Signed-off-by: Volker Haspel <volker.haspel@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..41a49b93ca60 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -882,7 +882,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.20.1

