Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2E0217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899228;
	bh=ZAJqOrDhBHBp83a/oJE9iIyECieC5irdn0mW/fjHwh4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2eOP6UDnetee0icA5IRskZrWSyBZ5usDng/Wj3HWqSoxzzM0ZCeT5VTjVd7KOeb/l
	 hnBPurZ9aLsGIkjofe+5JnestbFG+HesSiHaUMGLxE6DSmQ2y+MR/ZDJLl5WdDigQ9
	 k4Oerf1/fFDNmV0M81iIO7I1IJWWCW/FZiRBZwAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfDJM1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:27:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfDJM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VAMvmJICjKWKfT17guS1YUpoidbalsLoC4YaYWsnKEs=; b=o/dAI5G6nQwk
        dnh5IG4dJ1bJEJsWSKAcSvNmQtsv2/dYPGu2gtB+pBjDeFLmyLWaWEi2gSyJO8bIqep8etbZNV1ds
        AGs37XvEhxHj+1GqZbD2cox1nUTDkHXhOfKZq23QZBXF0HGeOWK5Ze+fIfuQEuw2uClR3ItEV43iI
        lMxHU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hECJf-00007o-Rt; Wed, 10 Apr 2019 12:26:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3635D1128ED2; Wed, 10 Apr 2019 13:26:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        naga.sureshkumar.relli@xilinx.com
Subject: Applied "spi: spi-mem: Fix build error without CONFIG_SPI_MEM" to the spi tree
In-Reply-To:  <20190408143949.10688-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190410122659.3635D1128ED2@debutante.sirena.org.uk>
Date:   Wed, 10 Apr 2019 13:26:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: Fix build error without CONFIG_SPI_MEM

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

From 0e530e4eba5e9003af83c6afda833c64c7fcae08 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 8 Apr 2019 22:39:49 +0800
Subject: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM

When building with CONFIG_SPI_MEM is not set
gc warns this:

drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi-mem.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index c845cd6e22ba..1941b845aa15 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -295,6 +295,10 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
+
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
@@ -310,6 +314,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
+
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
@@ -341,9 +352,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
-bool spi_mem_default_supports_op(struct spi_mem *mem,
-				 const struct spi_mem_op *op);
-
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.20.1

