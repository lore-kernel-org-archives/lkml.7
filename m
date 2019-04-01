Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9293C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A829206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108891;
	bh=sufVEP/ZEsFu9Bj0Vhh2yh/rUwLNRMrB/ZuwxQrvLI8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=I5UrQnldni4iO41QhxCo1YdEyJgIKw1sdIBU7VZXpeN2SqIjN/smocl0ITcIDvkr8
	 bM67AdJ+aBx72u6zdA1tEZltdQkSmj/1GHtZEpK15iRNF+uAw+nzgPTMoSoIqEgqB7
	 jmO9OQMEkSr+FjGEBHkVaLESWJSBieVKJAfgHN8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfDAIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDAIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8c/z35CyCXqj2pAO7MW46R5AmKz/R2NXTNYG7r9iNpo=; b=Af2E5v3Rp5kS
        seCjCR+GvTk8xsdxWt3eh1ej46qx12iJhGAR9bAADQHI1yG6lNmAxaQiHL/9OewUCdOPdu1beD3PN
        ujqzVGHTag1O2d1eyq9qtmNY65T385RWU/y45vdBgjZW/ck0ALAMniVYFB+xd74Hec0rsM2jNE8oZ
        g9w7g=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsiJ-0008QT-DE; Mon, 01 Apr 2019 08:54:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B8359440082; Mon,  1 Apr 2019 09:54:40 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: fix for unpacked mode transfers" to the spi tree
In-Reply-To:  <1553666207-11414-3-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085440.B8359440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:40 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: fix for unpacked mode transfers

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

From 1a89ac5b91895127f7c586ec5075c3753ca25501 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:24 -0700
Subject: [PATCH] spi: tegra114: fix for unpacked mode transfers

Fixes: computation of actual bytes to fill/receive in/from FIFO in unpacked
mode when transfer length is not a multiple of requested bits per word.

unpacked mode transfers fails when the transfer includes partial bytes in
the last word.

Total words to be written/read to/from FIFO is computed based on transfer
length and bits per word. Unpacked mode includes 0 padding bytes for partial
words to align with bits per word and these extra bytes are also accounted
for calculating bytes left to transfer in the current driver.

This causes extra bytes access of tx/rx buffers along with buffer index
position crossing actual length where remain_len becomes negative and due to
unsigned type, negative value is a 32 bit representation of signed value
and transferred bytes never meets the actual transfer length resulting in
transfer timeout and a hang.

This patch fixes this with proper computation of the actual bytes to fill in
FIFO during transmit and the actual bytes to read from FIFO during receive
ignoring 0 padded bytes.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 43 +++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 1435792944c4..876eb2acdef1 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -307,10 +307,16 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
+
+		tspi->cur_tx_pos += written_words * tspi->bytes_per_word;
 	} else {
+		unsigned int write_bytes;
 		max_n_32bit = min(tspi->curr_dma_words,  tx_empty_count);
 		written_words = max_n_32bit;
 		nbytes = written_words * tspi->bytes_per_word;
+		if (nbytes > t->len - tspi->cur_pos)
+			nbytes = t->len - tspi->cur_pos;
+		write_bytes = nbytes;
 		for (count = 0; count < max_n_32bit; count++) {
 			u32 x = 0;
 
@@ -319,8 +325,10 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
+
+		tspi->cur_tx_pos += write_bytes;
 	}
-	tspi->cur_tx_pos += written_words * tspi->bytes_per_word;
+
 	return written_words;
 }
 
@@ -344,20 +352,27 @@ static unsigned int tegra_spi_read_rx_fifo_to_client_rxbuf(
 			for (i = 0; len && (i < 4); i++, len--)
 				*rx_buf++ = (x >> i*8) & 0xFF;
 		}
-		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 		read_words += tspi->curr_dma_words;
+		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 	} else {
 		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+		u8 bytes_per_word = tspi->bytes_per_word;
+		unsigned int read_bytes;
 
+		len = rx_full_count * bytes_per_word;
+		if (len > t->len - tspi->cur_pos)
+			len = t->len - tspi->cur_pos;
+		read_bytes = len;
 		for (count = 0; count < rx_full_count; count++) {
 			u32 x = tegra_spi_readl(tspi, SPI_RX_FIFO) & rx_mask;
 
-			for (i = 0; (i < tspi->bytes_per_word); i++)
+			for (i = 0; len && (i < bytes_per_word); i++, len--)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
-		tspi->cur_rx_pos += rx_full_count * tspi->bytes_per_word;
 		read_words += rx_full_count;
+		tspi->cur_rx_pos += read_bytes;
 	}
+
 	return read_words;
 }
 
@@ -372,12 +387,17 @@ static void tegra_spi_copy_client_txbuf_to_spi_txbuf(
 		unsigned len = tspi->curr_dma_words * tspi->bytes_per_word;
 
 		memcpy(tspi->tx_dma_buf, t->tx_buf + tspi->cur_pos, len);
+		tspi->cur_tx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 	} else {
 		unsigned int i;
 		unsigned int count;
 		u8 *tx_buf = (u8 *)t->tx_buf + tspi->cur_tx_pos;
 		unsigned consume = tspi->curr_dma_words * tspi->bytes_per_word;
+		unsigned int write_bytes;
 
+		if (consume > t->len - tspi->cur_pos)
+			consume = t->len - tspi->cur_pos;
+		write_bytes = consume;
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = 0;
 
@@ -386,8 +406,9 @@ static void tegra_spi_copy_client_txbuf_to_spi_txbuf(
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tspi->tx_dma_buf[count] = x;
 		}
+
+		tspi->cur_tx_pos += write_bytes;
 	}
-	tspi->cur_tx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 
 	/* Make the dma buffer to read by dma */
 	dma_sync_single_for_device(tspi->dev, tspi->tx_dma_phys,
@@ -405,20 +426,28 @@ static void tegra_spi_copy_spi_rxbuf_to_client_rxbuf(
 		unsigned len = tspi->curr_dma_words * tspi->bytes_per_word;
 
 		memcpy(t->rx_buf + tspi->cur_rx_pos, tspi->rx_dma_buf, len);
+		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 	} else {
 		unsigned int i;
 		unsigned int count;
 		unsigned char *rx_buf = t->rx_buf + tspi->cur_rx_pos;
 		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+		unsigned consume = tspi->curr_dma_words * tspi->bytes_per_word;
+		unsigned int read_bytes;
 
+		if (consume > t->len - tspi->cur_pos)
+			consume = t->len - tspi->cur_pos;
+		read_bytes = consume;
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = tspi->rx_dma_buf[count] & rx_mask;
 
-			for (i = 0; (i < tspi->bytes_per_word); i++)
+			for (i = 0; consume && (i < tspi->bytes_per_word);
+							i++, consume--)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
+
+		tspi->cur_rx_pos += read_bytes;
 	}
-	tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 
 	/* Make the dma buffer to read by dma */
 	dma_sync_single_for_device(tspi->dev, tspi->rx_dma_phys,
-- 
2.20.1

