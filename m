Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B748CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A6620989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920752;
	bh=q3jWXvBF39wHxjkiYeJ8r6OTbOVnZIZlwJpNudpNm3Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=A97iQdS6n0LWNemYpnfJ10zDGE6Y11jYaW66XmiJWmyz8HcciQUoi/eyV3JzJPaQF
	 A5VbPXZ+hk5xg2m4XPs0cSDXn14HF8jsNs5li29Y0SDVLJNwXNOAAO6nyPX12K2qAy
	 M7Nk12pb7ko71p3EixlemwXI00BoWXnQHgRTAQo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfCROwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfCROwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BGULrpZlNnf9DKhV4LOSYKFIid6YJo7PHYK00mfiQEI=; b=dot+u07YwR7V
        zYacqLCmkPtMq5KR32wJaMHTOnqATm+8xFZIIvyt/ffXlMARLl4WsEehHv4gIKLE6aKQTrh/TIGNN
        uJAAUJs5tYPaRJ5az8GumL7RoFFDC/8HmcqmptnEMYEHS05gVXzSkcNGSjBOIuPMTnymqW+jPkd1f
        n+Qng=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tcl-0005qX-8d; Mon, 18 Mar 2019 14:52:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DA4431128874; Mon, 18 Mar 2019 14:52:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Mark Brown <broonie@kernel.org>, pakki001@umn.edu, kjlu@umn.edu,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi : spi-topcliff-pch: Fix to handle empty DMA buffers" to the spi tree
In-Reply-To:  <20190313165541.22548-1-pakki001@umn.edu>
X-Patchwork-Hint: ignore
Message-Id: <20190318145222.DA4431128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:52:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi : spi-topcliff-pch: Fix to handle empty DMA buffers

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

From f37d8e67f39e6d3eaf4cc5471e8a3d21209843c6 Mon Sep 17 00:00:00 2001
From: Aditya Pakki <pakki001@umn.edu>
Date: Wed, 13 Mar 2019 11:55:41 -0500
Subject: [PATCH] spi : spi-topcliff-pch: Fix to handle empty DMA buffers

pch_alloc_dma_buf allocated tx, rx DMA buffers which can fail. Further,
these buffers are used without a check. The patch checks for these
failures and sends the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index e7e8ea1edcce..fa730a871d25 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1300,18 +1300,27 @@ static void pch_free_dma_buf(struct pch_spi_board_data *board_dat,
 				  dma->rx_buf_virt, dma->rx_buf_dma);
 }
 
-static void pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
+static int pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
 			      struct pch_spi_data *data)
 {
 	struct pch_spi_dma_ctrl *dma;
+	int ret;
 
 	dma = &data->dma;
+	ret = 0;
 	/* Get Consistent memory for Tx DMA */
 	dma->tx_buf_virt = dma_alloc_coherent(&board_dat->pdev->dev,
 				PCH_BUF_SIZE, &dma->tx_buf_dma, GFP_KERNEL);
+	if (!dma->tx_buf_virt)
+		ret = -ENOMEM;
+
 	/* Get Consistent memory for Rx DMA */
 	dma->rx_buf_virt = dma_alloc_coherent(&board_dat->pdev->dev,
 				PCH_BUF_SIZE, &dma->rx_buf_dma, GFP_KERNEL);
+	if (!dma->rx_buf_virt)
+		ret = -ENOMEM;
+
+	return ret;
 }
 
 static int pch_spi_pd_probe(struct platform_device *plat_dev)
@@ -1388,7 +1397,9 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 
 	if (use_dma) {
 		dev_info(&plat_dev->dev, "Use DMA for data transfers\n");
-		pch_alloc_dma_buf(board_dat, data);
+		ret = pch_alloc_dma_buf(board_dat, data);
+		if (ret)
+			goto err_spi_register_master;
 	}
 
 	ret = spi_register_master(master);
-- 
2.20.1

