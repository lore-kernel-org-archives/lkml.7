Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0565FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3011120717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220306;
	bh=0VC3POMpamyfDyUqD+EWGGtVBFOxCNwz9mGQpbpgHOA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hg9aKhuaGP7nefw3/pEqr4DvCH/DBFV37qVE946Eens+NjTNFRCNo7pgYTvm7N5HE
	 31JU8KRbN/Bk0uNHZgW2bg7E70QBBMVsXDWsYsVMNGvHcE4xMHS4Taw4LKNb1LyUS3
	 ttkFVUzvwLxs7OFM4GsRzCuaD23XBKWYgmEuqbRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfDYTZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:25:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49654 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfDYTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ujin8fPqiBYO8fG0iJPxqJkdDmUEfnPunS2eRUnJRt4=; b=s1ihMDtquzaX
        y5REDM3DR8EnLtSD6RvB2HPa5BNhuneeTvCe5hWKSKKZSsl5627yGxE5VZsGOrFiV0/ldoRyZd5kI
        Ta29g9lg8BKdXGR+kC+/Od7QyWNDAV88b5jBU+qfDomtfceCO3bnoB86VB0x9K6Lis2s2Y3dG0rK+
        rEhK4=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjzA-0004a5-9b; Thu, 25 Apr 2019 19:24:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 11C2E441D3E; Thu, 25 Apr 2019 20:24:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org, dwmw2@infradead.org,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        Mark Brown <broonie@kernel.org>, michals@xilinx.com,
        nagasuresh12@gmail.com, richard@nod.at, vigneshr@ti.com
Subject: Applied "spi: spi-mem: zynq-qspi: Fix build error on architectures missing readsl/writesl" to the spi tree
In-Reply-To: <1555918009-13172-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192443.11C2E441D3E@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: zynq-qspi: Fix build error on architectures missing readsl/writesl

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From 2a2dd8cafc06d72a6ad12d9726c9e514839a82bf Mon Sep 17 00:00:00 2001
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Date: Mon, 22 Apr 2019 12:56:49 +0530
Subject: [PATCH] spi: spi-mem: zynq-qspi: Fix build error on architectures
 missing readsl/writesl

Alpha and some of the architectures are missing readsl/writesl functions.
so the zynq-qspi driver won't be able to build on these arches. hence use
ioread32_rep()/iowrite32_rep() instead of readsl()/writesl().

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 8079d0062d03..c6bee67decb5 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -407,8 +407,8 @@ static void zynq_qspi_write_op(struct zynq_qspi *xqspi, int txcount,
 		count = txcount;
 
 	if (xqspi->txbuf) {
-		writesl(xqspi->regs + ZYNQ_QSPI_TXD_00_00_OFFSET,
-			xqspi->txbuf, count);
+		iowrite32_rep(xqspi->regs + ZYNQ_QSPI_TXD_00_00_OFFSET,
+			      xqspi->txbuf, count);
 		xqspi->txbuf += count * 4;
 	} else {
 		for (k = 0; k < count; k++)
@@ -433,8 +433,8 @@ static void zynq_qspi_read_op(struct zynq_qspi *xqspi, int rxcount)
 	if (count > rxcount)
 		count = rxcount;
 	if (xqspi->rxbuf) {
-		readsl(xqspi->regs + ZYNQ_QSPI_RXD_OFFSET,
-		       xqspi->rxbuf, count);
+		ioread32_rep(xqspi->regs + ZYNQ_QSPI_RXD_OFFSET,
+			     xqspi->rxbuf, count);
 		xqspi->rxbuf += count * 4;
 	} else {
 		for (k = 0; k < count; k++)
-- 
2.20.1

