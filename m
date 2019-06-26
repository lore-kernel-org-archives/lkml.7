Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479FDC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE51208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Zrqk4VTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfFZHfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:35:15 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:46729 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfFZHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:35:15 -0400
Received: from mx-exchlnx-2.rrze.uni-erlangen.de (mx-exchlnx-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::38])
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZYr4Y3yzPktY;
        Wed, 26 Jun 2019 09:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534512; bh=1Kr1vTS7bkUulunP0f8NCnH0zV9KWrstAVXXQNj0QW8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Zrqk4VTna1rS/wHi0cQkP4xofQDeXW1GA7sc2yrq8bZ/iHD+M/7lHAjVl+240g9ip
         FPeadTqTGmiZU1Xno0KR3vovU2qNbbk4+KZl5+/DzmdyuiPjn1Pzbyz587ROwmscF6
         ylOLUcMtdS2XQRX0MDP7stpYQsxjVmGGKbKs2Hz5w33TsS8iIXZvurQYz3/FrRAA57
         dcNne1FIS8wKlexalKkaC4e6FIvV5qeVJ3Y/oQfWQIVxMOgrQrcUxAB6u4V9pDz4xm
         2fAuk/zHm6Zc8K4FZIG3OGhHysSbfMq8pyCdJiKupGZMeMGYExfbIGUa1bklfVl94F
         R18igrOPSY+gA==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-2.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZYp2QQgzPkv3;
        Wed, 26 Jun 2019 09:35:10 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:34:46 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:34:46 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] staging: kpc2000: add line breaks
Date:   Wed, 26 Jun 2019 09:35:19 +0200
Message-ID: <20190626073531.8946-2-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626073531.8946-1-fabian.krueger@fau.de>
References: <20190625115251.GA28859@kadam>
 <20190626073531.8946-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.90.221.207]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix some checkpatch-warnings some lines of this module had to be
shortened so that they do not exceed 80 characters per line.
This refactoring makes the code more readable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 34 +++++++++++++++++----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index c3e5c1848f53..b0b5c9b4d35a 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -36,6 +36,7 @@ static struct mtd_partition p2kr0_spi0_parts[] = {
 	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
 	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
 };
+
 static struct mtd_partition p2kr0_spi1_parts[] = {
 	{ .name = "SLOT_4",	.size = 7798784,		.offset = 0,                },
 	{ .name = "SLOT_5",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
@@ -182,7 +183,8 @@ kp_spi_write_reg(struct kp_spi_controller_state *cs, int idx, u64 val)
 }
 
 	static int
-kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx, unsigned long bit)
+kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx,
+			unsigned long bit)
 {
 	unsigned long timeout;
 	timeout = jiffies + msecs_to_jiffies(1000);
@@ -207,6 +209,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 	unsigned int c = count;
 
 	int i;
+	int res;
 	u8 *rx       = transfer->rx_buf;
 	const u8 *tx = transfer->tx_buf;
 	int processed = 0;
@@ -215,9 +218,10 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 		for (i = 0 ; i < c ; i++) {
 			char val = *tx++;
 
-			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_TXS) < 0) {
+			res = kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
+						      KP_SPI_REG_STATUS_TXS);
+			if (res < 0)
 				goto out;
-			}
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
@@ -228,10 +232,10 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			char test=0;
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, 0x00);
-
-			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_RXS) < 0) {
+			res = kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
+						      KP_SPI_REG_STATUS_RXS);
+			if (res < 0)
 				goto out;
-			}
 
 			test = kp_spi_read_reg(cs, KP_SPI_REG_RXDATA);
 			*rx++ = test;
@@ -239,8 +243,10 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 		}
 	}
 
-	if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_EOT) < 0) {
-		//TODO: Figure out how to abort transaction??  This has never happened in practice though...
+	if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
+				    KP_SPI_REG_STATUS_EOT) < 0) {
+		//TODO: Figure out how to abort transaction??
+		//Ths has never happened in practice though...
 	}
 
 out:
@@ -307,7 +313,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 		void       *rx_buf = transfer->rx_buf;
 		unsigned    len = transfer->len;
 
-		if (transfer->speed_hz > KP_SPI_CLK || (len && !(rx_buf || tx_buf))) {
+		if (transfer->speed_hz > KP_SPI_CLK ||
+		    (len && !(rx_buf || tx_buf))) {
 			dev_dbg(kpspi->dev, "  transfer: %d Hz, %d %s%s, %d bpw\n",
 					transfer->speed_hz,
 					len,
@@ -317,7 +324,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
 			return -EINVAL;
 		}
-		if (transfer->speed_hz && (transfer->speed_hz < (KP_SPI_CLK >> 15))) {
+		if (transfer->speed_hz &&
+		    transfer->speed_hz < (KP_SPI_CLK >> 15)) {
 			dev_dbg(kpspi->dev, "speed_hz %d below minimum %d Hz\n",
 					transfer->speed_hz,
 					KP_SPI_CLK >> 15);
@@ -332,14 +340,16 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 	kp_spi_write_reg(cs, KP_SPI_REG_CONFIG, sc.reg);
 
 	/* work */
-	if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_EOT) < 0) {
+	if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
+				    KP_SPI_REG_STATUS_EOT) < 0) {
 		dev_info(kpspi->dev, "EOT timed out\n");
 		goto out;
 	}
 
 	/* do the transfers for this message */
 	list_for_each_entry(transfer, &m->transfers, transfer_list) {
-		if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
+		if (!transfer->tx_buf && !transfer->rx_buf &&
+		    transfer->len) {
 			status = -EINVAL;
 			goto error;
 		}
-- 
2.17.1

