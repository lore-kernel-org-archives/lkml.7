Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C6420879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920758;
	bh=Lxdy/wZTGeL6IW0M6+P5bA85Mq283HohX/YLCEaE/Uw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AK0NxoE7L9xW7FDxWuImwdlgaENE3DB7ur0IkYeLDHoAEhlUGarMGTr6kkGTaGyHh
	 WO5+GriTR/SoelZ6pChsqNknYA9IJx9MJWLjaRqo2oLCxL4u7jpXmL6s1suqjD9ehf
	 FVKfGLVmdyJNUHCrH92NNuG5qdSPH7tB5FQ2e5JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfCROwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfCROwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DbefiPwabZ65ca8HCmQW+hhuSq0vpNgn6OwkLKfDXP0=; b=bwcZaokogRPi
        Gt+NkKxnvpivmUcEj2cmCn2dyGQal4apWuD8r6OoSABPLgcqq816izcE0eNH15LGWz/0DDIAeJZ2q
        rl4VGG2cOx+CjNvS7JGLh9t6/m3a98pqlmWzKZUC3CMZKGsAcUkHucrUPm+bL7rp0zhKbkEhInuOh
        LU2LU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tcY-0005pw-Hq; Mon, 18 Mar 2019 14:52:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0F7171128874; Mon, 18 Mar 2019 14:52:10 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Fugang Duan <Fugang.duan@nxp.com>, Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: lpspi: add dma mode support" to the spi tree
In-Reply-To:  <20190306063020.793-7-xiaoning.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190318145210.0F7171128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:52:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: lpspi: add dma mode support

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

From 09c04466ce7ea494993c0635ba5edb6d2222a806 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Wed, 6 Mar 2019 06:30:45 +0000
Subject: [PATCH] spi: lpspi: add dma mode support

Add dma mode support for LPSPI. Any frame longer than half txfifosize will
be sent by dma mode.

For now, there are some limits:
1. The maximum transfer speed in master mode depends on the slave device,
   at least 40MHz(tested by spi-nor on 8qm-lpddr4-arm2 base board);
2. The maximum transfer speed in slave mode is 15MHz(imx7ulp),
   22MHz(8qm/qxp). In order to reach the maximum speed which is mentioned
   in datasheet, the load of connect wires between master and slave
   should be less than 15pF.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 312 ++++++++++++++++++++++++++++++++++--
 1 file changed, 301 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a25e0e03f058..9ff32fb67a29 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -8,6 +8,8 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
@@ -20,6 +22,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/spi-imx.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -31,6 +34,9 @@
 
 #define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
 
+/* The maximum bytes that edma can transfer once.*/
+#define FSL_LPSPI_MAX_EDMA_BYTES  ((1 << 15) - 1)
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -64,6 +70,8 @@
 #define IER_FCIE	BIT(9)
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
+#define DER_RDDE	BIT(1)
+#define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
@@ -91,6 +99,7 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
+	unsigned long base_phys;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
@@ -111,6 +120,11 @@ struct fsl_lpspi_data {
 
 	bool slave_aborted;
 
+	/* DMA */
+	bool usedma;
+	struct completion dma_rx_completion;
+	struct completion dma_tx_completion;
+
 	int chipselect[0];
 };
 
@@ -158,6 +172,35 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *fsl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
 
+static int fsl_lpspi_bytes_per_word(const int bpw)
+{
+	return DIV_ROUND_UP(bpw, BITS_PER_BYTE);
+}
+
+static bool fsl_lpspi_can_dma(struct spi_controller *controller,
+			      struct spi_device *spi,
+			      struct spi_transfer *transfer)
+{
+	unsigned int bytes_per_word;
+
+	if (!controller->dma_rx)
+		return false;
+
+	bytes_per_word = fsl_lpspi_bytes_per_word(transfer->bits_per_word);
+
+	switch (bytes_per_word)
+	{
+		case 1:
+		case 2:
+		case 4:
+			break;
+		default:
+			return false;
+	}
+
+	return true;
+}
+
 static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =
@@ -245,11 +288,13 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 		 * For the first transfer, clear TCR_CONTC to assert SS.
 		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
 		 */
-		temp |= TCR_CONT;
-		if (fsl_lpspi->is_first_byte)
-			temp &= ~TCR_CONTC;
-		else
-			temp |= TCR_CONTC;
+		if (!fsl_lpspi->usedma) {
+			temp |= TCR_CONT;
+			if (fsl_lpspi->is_first_byte)
+				temp &= ~TCR_CONTC;
+			else
+				temp |= TCR_CONTC;
+		}
 	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
 
@@ -260,7 +305,11 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
 
-	temp = fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
+	if (!fsl_lpspi->usedma)
+		temp = fsl_lpspi->watermark >> 1 |
+		       (fsl_lpspi->watermark >> 1) << 16;
+	else
+		temp = fsl_lpspi->watermark >> 1;
 
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
 
@@ -302,6 +351,53 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	return 0;
 }
 
+static int fsl_lpspi_dma_configure(struct spi_controller *controller)
+{
+	int ret;
+	enum dma_slave_buswidth buswidth;
+	struct dma_slave_config rx = {}, tx = {};
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
+
+	switch (fsl_lpspi_bytes_per_word(fsl_lpspi->config.bpw)) {
+	case 4:
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tx.direction = DMA_MEM_TO_DEV;
+	tx.dst_addr = fsl_lpspi->base_phys + IMX7ULP_TDR;
+	tx.dst_addr_width = buswidth;
+	tx.dst_maxburst = 1;
+	ret = dmaengine_slave_config(controller->dma_tx, &tx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "TX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	rx.direction = DMA_DEV_TO_MEM;
+	rx.src_addr = fsl_lpspi->base_phys + IMX7ULP_RDR;
+	rx.src_addr_width = buswidth;
+	rx.src_maxburst = 1;
+	ret = dmaengine_slave_config(controller->dma_rx, &rx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "RX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
@@ -327,10 +423,16 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	temp |= CR_RRF | CR_RTF | CR_MEN;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
 
+	temp = 0;
+	if (fsl_lpspi->usedma)
+		temp = DER_TDDE | DER_RDDE;
+	writel(temp, fsl_lpspi->base + IMX7ULP_DER);
+
 	return 0;
 }
 
-static int fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
+				     struct spi_device *spi,
 				     struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =
@@ -363,6 +465,11 @@ static int fsl_lpspi_setup_transfer(struct spi_device *spi,
 	else
 		fsl_lpspi->watermark = fsl_lpspi->txfifosize;
 
+	if (fsl_lpspi_can_dma(controller, spi, t))
+		fsl_lpspi->usedma = 1;
+	else
+		fsl_lpspi->usedma = 0;
+
 	return fsl_lpspi_config(fsl_lpspi);
 }
 
@@ -401,8 +508,10 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
 
-	/* Disable all interrupt */
-	fsl_lpspi_intctrl(fsl_lpspi, 0);
+	if (!fsl_lpspi->usedma) {
+		/* Disable all interrupt */
+		fsl_lpspi_intctrl(fsl_lpspi, 0);
+	}
 
 	/* W1C for all flags in SR */
 	temp = 0x3F << 8;
@@ -415,6 +524,176 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 	return 0;
 }
 
+static void fsl_lpspi_dma_rx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi = (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_rx_completion);
+}
+
+static void fsl_lpspi_dma_tx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi = (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_tx_completion);
+}
+
+static int fsl_lpspi_calculate_timeout(struct fsl_lpspi_data *fsl_lpspi,
+				       int size)
+{
+	unsigned long timeout = 0;
+
+	/* Time with actual data transfer and CS change delay related to HW */
+	timeout = (8 + 4) * size / fsl_lpspi->config.speed_hz;
+
+	/* Add extra second for scheduler related activities */
+	timeout += 1;
+
+	/* Double calculated timeout */
+	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+}
+
+static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
+				struct fsl_lpspi_data *fsl_lpspi,
+				struct spi_transfer *transfer)
+{
+	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
+	unsigned long transfer_timeout;
+	unsigned long timeout;
+	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
+	int ret;
+
+	ret = fsl_lpspi_dma_configure(controller);
+	if (ret)
+		return ret;
+
+	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
+				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_rx)
+		return -EINVAL;
+
+	desc_rx->callback = fsl_lpspi_dma_rx_callback;
+	desc_rx->callback_param = (void *)fsl_lpspi;
+	dmaengine_submit(desc_rx);
+	reinit_completion(&fsl_lpspi->dma_rx_completion);
+	dma_async_issue_pending(controller->dma_rx);
+
+	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
+				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_tx) {
+		dmaengine_terminate_all(controller->dma_tx);
+		return -EINVAL;
+	}
+
+	desc_tx->callback = fsl_lpspi_dma_tx_callback;
+	desc_tx->callback_param = (void *)fsl_lpspi;
+	dmaengine_submit(desc_tx);
+	reinit_completion(&fsl_lpspi->dma_tx_completion);
+	dma_async_issue_pending(controller->dma_tx);
+
+	fsl_lpspi->slave_aborted = false;
+
+	if (!fsl_lpspi->is_slave) {
+		transfer_timeout = fsl_lpspi_calculate_timeout(fsl_lpspi,
+							       transfer->len);
+
+		/* Wait eDMA to finish the data transfer.*/
+		timeout = wait_for_completion_timeout(&fsl_lpspi->dma_tx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+
+		timeout = wait_for_completion_timeout(&fsl_lpspi->dma_rx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+	} else {
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_tx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA TX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_rx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA RX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+	}
+
+	fsl_lpspi_reset(fsl_lpspi);
+
+	return 0;
+}
+
+static void fsl_lpspi_dma_exit(struct spi_controller *controller)
+{
+	if (controller->dma_rx) {
+		dma_release_channel(controller->dma_rx);
+		controller->dma_rx = NULL;
+	}
+
+	if (controller->dma_tx) {
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx = NULL;
+	}
+}
+
+static int fsl_lpspi_dma_init(struct device *dev,
+			      struct fsl_lpspi_data *fsl_lpspi,
+			      struct spi_controller *controller)
+{
+	int ret;
+
+	/* Prepare for TX DMA: */
+	controller->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret = PTR_ERR(controller->dma_tx);
+		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
+		controller->dma_tx = NULL;
+		goto err;
+	}
+
+	/* Prepare for RX DMA: */
+	controller->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret = PTR_ERR(controller->dma_rx);
+		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
+		controller->dma_rx = NULL;
+		goto err;
+	}
+
+	init_completion(&fsl_lpspi->dma_rx_completion);
+	init_completion(&fsl_lpspi->dma_tx_completion);
+	controller->can_dma = fsl_lpspi_can_dma;
+	controller->max_dma_len = FSL_LPSPI_MAX_EDMA_BYTES;
+
+	return 0;
+err:
+	fsl_lpspi_dma_exit(controller);
+	return ret;
+}
+
 static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 				  struct spi_transfer *t)
 {
@@ -449,14 +728,17 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 	int ret;
 
 	fsl_lpspi->is_first_byte = true;
-	ret = fsl_lpspi_setup_transfer(spi, t);
+	ret = fsl_lpspi_setup_transfer(controller, spi, t);
 	if (ret < 0)
 		return ret;
 
 	fsl_lpspi_set_cmd(fsl_lpspi);
 	fsl_lpspi->is_first_byte = false;
 
-	ret = fsl_lpspi_pio_transfer(controller, t);
+	if (fsl_lpspi->usedma)
+		ret = fsl_lpspi_dma_transfer(controller, fsl_lpspi, t);
+	else
+		ret = fsl_lpspi_pio_transfer(controller, t);
 	if (ret < 0)
 		return ret;
 
@@ -606,6 +888,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		ret = PTR_ERR(fsl_lpspi->base);
 		goto out_controller_put;
 	}
+	fsl_lpspi->base_phys = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -647,6 +930,13 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 
+	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
+	if (ret == -EPROBE_DEFER)
+		goto out_controller_put;
+
+	if (ret < 0)
+		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_controller error.\n");
-- 
2.20.1

