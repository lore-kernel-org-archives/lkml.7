Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E822075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553611406;
	bh=vC3eFnj4sDVZ2wRMBxKBBQIEAbqKTW71Or5X+BQFVrc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=l1IxWQ9IxdueinzQkUWfpiV9q7NM8yvY4BqfJ/zM2gbdl63amZfXGwFIEsBN3i9w+
	 nQ1857Eh4+Qhpp4+RZsIt5uYaKvPrtcSM7yQvsVHWvE2tjk88y7PZNfG2jQpVw65KO
	 B2dJxKNp7ySwOOAlKv3D2EcE3uLUkzJ6U/eFveUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfCZOnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36340 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfCZOnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4ighytQJon5HFPVt7oxSahUBPRk1+g+mM66kvVxarVE=; b=GgrenB19WKCW
        h+Te2vdTUJE1RZWlvgNllzErxeaw9oDdQb/GDU5eSlurWnzxOYxRfuLmXDPQlT1Z9BTZKPLIjCzGv
        OkV4fbTbbkozLmMqe+B3/URrqYBYXrv5Ch9O2e6mB2sDi5FvFTB9y16ynMc/fQ5dAuGoDsyhosCp+
        iJIGk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8nIG-0007jW-6T; Tue, 26 Mar 2019 14:43:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BF8841121B57; Tue, 26 Mar 2019 14:43:11 +0000 (GMT)
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
Subject: Applied "spi: stm32-qspi: add dma support" to the spi tree
In-Reply-To:  <1553533300-29999-3-git-send-email-ludovic.Barre@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190326144311.BF8841121B57@debutante.sirena.org.uk>
Date:   Tue, 26 Mar 2019 14:43:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32-qspi: add dma support

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

From 245308c6217027c0d7fc8c3cf2bf95858c704d7b Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Mon, 25 Mar 2019 18:01:40 +0100
Subject: [PATCH] spi: stm32-qspi: add dma support

This patch adds the dma support for the stm32-qspi hardware.
The memory buffer constraints (lowmem, vmalloc, kmap) are taken into
account by framework. In read mode, the memory map is preferred vs
dma (due to better throughput). If the dma transfer fails the buffer
is sent by polling.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 136 ++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 9875139ef0cf..11a89aa15d56 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -5,6 +5,8 @@
  */
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -84,6 +86,7 @@
 #define STM32_FIFO_TIMEOUT_US 30000
 #define STM32_BUSY_TIMEOUT_US 100000
 #define STM32_ABT_TIMEOUT_US 100000
+#define STM32_COMP_TIMEOUT_MS 1000
 
 struct stm32_qspi_flash {
 	struct stm32_qspi *qspi;
@@ -94,6 +97,7 @@ struct stm32_qspi_flash {
 struct stm32_qspi {
 	struct device *dev;
 	struct spi_controller *ctrl;
+	phys_addr_t phys_base;
 	void __iomem *io_base;
 	void __iomem *mm_base;
 	resource_size_t mm_size;
@@ -103,6 +107,10 @@ struct stm32_qspi {
 	struct completion data_completion;
 	u32 fmode;
 
+	struct dma_chan *dma_chtx;
+	struct dma_chan *dma_chrx;
+	struct completion dma_completion;
+
 	u32 cr_reg;
 	u32 dcr_reg;
 
@@ -181,6 +189,81 @@ static int stm32_qspi_tx_mm(struct stm32_qspi *qspi,
 	return 0;
 }
 
+static void stm32_qspi_dma_callback(void *arg)
+{
+	struct completion *dma_completion = arg;
+
+	complete(dma_completion);
+}
+
+static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
+			     const struct spi_mem_op *op)
+{
+	struct dma_async_tx_descriptor *desc;
+	enum dma_transfer_direction dma_dir;
+	struct dma_chan *dma_ch;
+	struct sg_table sgt;
+	dma_cookie_t cookie;
+	u32 cr, t_out;
+	int err;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dma_dir = DMA_DEV_TO_MEM;
+		dma_ch = qspi->dma_chrx;
+	} else {
+		dma_dir = DMA_MEM_TO_DEV;
+		dma_ch = qspi->dma_chtx;
+	}
+
+	/*
+	 * spi_map_buf return -EINVAL if the buffer is not DMA-able
+	 * (DMA-able: in vmalloc | kmap | virt_addr_valid)
+	 */
+	err = spi_controller_dma_map_mem_op_data(qspi->ctrl, op, &sgt);
+	if (err)
+		return err;
+
+	desc = dmaengine_prep_slave_sg(dma_ch, sgt.sgl, sgt.nents,
+				       dma_dir, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		err = -ENOMEM;
+		goto out_unmap;
+	}
+
+	cr = readl_relaxed(qspi->io_base + QSPI_CR);
+
+	reinit_completion(&qspi->dma_completion);
+	desc->callback = stm32_qspi_dma_callback;
+	desc->callback_param = &qspi->dma_completion;
+	cookie = dmaengine_submit(desc);
+	err = dma_submit_error(cookie);
+	if (err)
+		goto out;
+
+	dma_async_issue_pending(dma_ch);
+
+	writel_relaxed(cr | CR_DMAEN, qspi->io_base + QSPI_CR);
+
+	t_out = sgt.nents * STM32_COMP_TIMEOUT_MS;
+	if (!wait_for_completion_interruptible_timeout(&qspi->dma_completion,
+						       msecs_to_jiffies(t_out)))
+		err = -ETIMEDOUT;
+
+	if (dma_async_is_tx_complete(dma_ch, cookie,
+				     NULL, NULL) != DMA_COMPLETE)
+		err = -ETIMEDOUT;
+
+	if (err)
+		dmaengine_terminate_all(dma_ch);
+
+out:
+	writel_relaxed(cr & ~CR_DMAEN, qspi->io_base + QSPI_CR);
+out_unmap:
+	spi_controller_dma_unmap_mem_op_data(qspi->ctrl, op, &sgt);
+
+	return err;
+}
+
 static int stm32_qspi_tx(struct stm32_qspi *qspi, const struct spi_mem_op *op)
 {
 	if (!op->data.nbytes)
@@ -188,6 +271,10 @@ static int stm32_qspi_tx(struct stm32_qspi *qspi, const struct spi_mem_op *op)
 
 	if (qspi->fmode == CCR_FMODE_MM)
 		return stm32_qspi_tx_mm(qspi, op);
+	else if ((op->data.dir == SPI_MEM_DATA_IN && qspi->dma_chrx) ||
+		 (op->data.dir == SPI_MEM_DATA_OUT && qspi->dma_chtx))
+		if (!stm32_qspi_tx_dma(qspi, op))
+			return 0;
 
 	return stm32_qspi_tx_poll(qspi, op);
 }
@@ -218,7 +305,7 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 	writel_relaxed(cr | CR_TCIE | CR_TEIE, qspi->io_base + QSPI_CR);
 
 	if (!wait_for_completion_interruptible_timeout(&qspi->data_completion,
-						msecs_to_jiffies(1000))) {
+				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS))) {
 		err = -ETIMEDOUT;
 	} else {
 		sr = readl_relaxed(qspi->io_base + QSPI_SR);
@@ -387,6 +474,49 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
+{
+	struct dma_slave_config dma_cfg;
+	struct device *dev = qspi->dev;
+
+	memset(&dma_cfg, 0, sizeof(dma_cfg));
+
+	dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_cfg.src_addr = qspi->phys_base + QSPI_DR;
+	dma_cfg.dst_addr = qspi->phys_base + QSPI_DR;
+	dma_cfg.src_maxburst = 4;
+	dma_cfg.dst_maxburst = 4;
+
+	qspi->dma_chrx = dma_request_slave_channel(dev, "rx");
+	if (qspi->dma_chrx) {
+		if (dmaengine_slave_config(qspi->dma_chrx, &dma_cfg)) {
+			dev_err(dev, "dma rx config failed\n");
+			dma_release_channel(qspi->dma_chrx);
+			qspi->dma_chrx = NULL;
+		}
+	}
+
+	qspi->dma_chtx = dma_request_slave_channel(dev, "tx");
+	if (qspi->dma_chtx) {
+		if (dmaengine_slave_config(qspi->dma_chtx, &dma_cfg)) {
+			dev_err(dev, "dma tx config failed\n");
+			dma_release_channel(qspi->dma_chtx);
+			qspi->dma_chtx = NULL;
+		}
+	}
+
+	init_completion(&qspi->dma_completion);
+}
+
+static void stm32_qspi_dma_free(struct stm32_qspi *qspi)
+{
+	if (qspi->dma_chtx)
+		dma_release_channel(qspi->dma_chtx);
+	if (qspi->dma_chrx)
+		dma_release_channel(qspi->dma_chrx);
+}
+
 /*
  * no special host constraint, so use default spi_mem_default_supports_op
  * to check supported mode.
@@ -399,6 +529,7 @@ static void stm32_qspi_release(struct stm32_qspi *qspi)
 {
 	/* disable qspi */
 	writel_relaxed(0, qspi->io_base + QSPI_CR);
+	stm32_qspi_dma_free(qspi);
 	mutex_destroy(&qspi->lock);
 	clk_disable_unprepare(qspi->clk);
 	spi_master_put(qspi->ctrl);
@@ -427,6 +558,8 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	qspi->phys_base = res->start;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mm");
 	qspi->mm_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(qspi->mm_base)) {
@@ -477,6 +610,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 	qspi->dev = dev;
 	platform_set_drvdata(pdev, qspi);
+	stm32_qspi_dma_setup(qspi);
 	mutex_init(&qspi->lock);
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
-- 
2.20.1

