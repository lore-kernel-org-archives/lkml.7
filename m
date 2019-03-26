Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27FD20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611405;
	bh=yt3UbbLCK6yGuhkhB2670XVCvabCkEIiIXIwtbtG6d8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HpAv8/8ilH2hUnnyClpC2YsxrLecVeJ2cWAv54jPQGVjSIDpTxR0unnjjNnnLCupB
	 3rkpmAcpRck8x7mnb2lcnqLdcGboLwzApmFXCobQKH7EOaohcYOR0118GJRIgJNJoc
	 HARc0DN0ql1x4a1euEKodwTMKSntyZOkHHhJgJVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfCZOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbfCZOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Euy4kP34EVSo3uJa1rD2WsYUcr5nsGPI8u55e7tdHdE=; b=gCmOkw+0CmQ8
        EJ+Rsrwuix9g6DG/RpGPL3EPY+90H5H1nPuXn6K6CHl8LYgPYH7M9w8gVK8ae0/U+lGpIRwRPDOQy
        o2DTj5kwlPKM1hJiCGpd167vJr7+WGncearXulyXoGIdNA6drp1RskY090LtimNvLeF8/EOcdy1OL
        s8I5g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8nII-0007jb-F2; Tue, 26 Mar 2019 14:43:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E58A41121B57; Tue, 26 Mar 2019 14:43:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: stm32-qspi: add spi_master_put in release function" to the spi tree
In-Reply-To:  <1553533300-29999-2-git-send-email-ludovic.Barre@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190326144313.E58A41121B57@debutante.sirena.org.uk>
Date:   Tue, 26 Mar 2019 14:43:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32-qspi: add spi_master_put in release function

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

From a88eceb17ac7e8dc4ad9995681af61c8371668f4 Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Mon, 25 Mar 2019 18:01:39 +0100
Subject: [PATCH] spi: stm32-qspi: add spi_master_put in release function

This patch adds spi_master_put in release function
to drop the controller's refcount.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 46 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 7879a523583c..9875139ef0cf 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -93,6 +93,7 @@ struct stm32_qspi_flash {
 
 struct stm32_qspi {
 	struct device *dev;
+	struct spi_controller *ctrl;
 	void __iomem *io_base;
 	void __iomem *mm_base;
 	resource_size_t mm_size;
@@ -400,6 +401,7 @@ static void stm32_qspi_release(struct stm32_qspi *qspi)
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
 	mutex_destroy(&qspi->lock);
 	clk_disable_unprepare(qspi->clk);
+	spi_master_put(qspi->ctrl);
 }
 
 static int stm32_qspi_probe(struct platform_device *pdev)
@@ -416,43 +418,54 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qspi = spi_controller_get_devdata(ctrl);
+	qspi->ctrl = ctrl;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi");
 	qspi->io_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(qspi->io_base))
-		return PTR_ERR(qspi->io_base);
+	if (IS_ERR(qspi->io_base)) {
+		ret = PTR_ERR(qspi->io_base);
+		goto err;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mm");
 	qspi->mm_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(qspi->mm_base))
-		return PTR_ERR(qspi->mm_base);
+	if (IS_ERR(qspi->mm_base)) {
+		ret = PTR_ERR(qspi->mm_base);
+		goto err;
+	}
 
 	qspi->mm_size = resource_size(res);
-	if (qspi->mm_size > STM32_QSPI_MAX_MMAP_SZ)
-		return -EINVAL;
+	if (qspi->mm_size > STM32_QSPI_MAX_MMAP_SZ) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
 			       dev_name(dev), qspi);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		return ret;
+		goto err;
 	}
 
 	init_completion(&qspi->data_completion);
 
 	qspi->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(qspi->clk))
-		return PTR_ERR(qspi->clk);
+	if (IS_ERR(qspi->clk)) {
+		ret = PTR_ERR(qspi->clk);
+		goto err;
+	}
 
 	qspi->clk_rate = clk_get_rate(qspi->clk);
-	if (!qspi->clk_rate)
-		return -EINVAL;
+	if (!qspi->clk_rate) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = clk_prepare_enable(qspi->clk);
 	if (ret) {
 		dev_err(dev, "can not enable the clock\n");
-		return ret;
+		goto err;
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
@@ -475,14 +488,11 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	ctrl->dev.of_node = dev->of_node;
 
 	ret = devm_spi_register_master(dev, ctrl);
-	if (ret)
-		goto err_spi_register;
-
-	return 0;
+	if (!ret)
+		return 0;
 
-err_spi_register:
+err:
 	stm32_qspi_release(qspi);
-
 	return ret;
 }
 
-- 
2.20.1

