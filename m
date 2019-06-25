Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D1C48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DDF2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="JN1NdBt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfFYLfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:35:07 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:53121 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730866AbfFYLfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:35:01 -0400
Received: from mx-exchlnx-1.rrze.uni-erlangen.de (mx-exchlnx-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::37])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3m856Dnz8tqN;
        Tue, 25 Jun 2019 13:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561462040; bh=VQBXyRCiODRhz3i/IrsbpgZ+c5pWRNN6VXUE0acvz60=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=JN1NdBt4a9hZFnS2krns1oD6X4sVPyayOY2bFme24RswsabDwLRY0vfUaifpC1AeZ
         sq+nJ4I1hiIaL9LLmCS6HrUfopD4sKtgpfdtqiV6NXJuhesxCq1uu2DnSJwg9IPeZ8
         yiK08+iy/qdfyYxYSlf5YO2pBLY2oMzwpkmpfvN+jtQLfQEIJFrxH2T+b7z45ZsjxU
         rtDaP4MjWQhaUszg9jdYK86Ey+ArE6tpUPMnb7iUuaAnB+aW3XKZj0X/mcysVAKkmQ
         kqzuzqG1gH/6s4F7O4LMs74YL3CWeJdC5BptBVDDgZjGOrYBNanTmSEqanJFgC3pF6
         DCY77rqbKN4Zw==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3m62YMZz8tSk;
        Tue, 25 Jun 2019 13:27:18 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 13:26:42 +0200
Received: from TroubleWorld.pool.uni-erlangen.de (10.21.22.37) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 25 Jun 2019 13:26:40 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] staging: kpc2000: add line breaks
Date:   Tue, 25 Jun 2019 13:27:12 +0200
Message-ID: <20190625112725.10154-2-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625112725.10154-1-fabian.krueger@fau.de>
References: <20190625112725.10154-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.22.37]
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
 drivers/staging/kpc2000/kpc2000_spi.c | 77 ++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index c3e5c1848f53..7ed0fb6b4abb 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -30,18 +30,46 @@
 #include "kpc.h"
 
 static struct mtd_partition p2kr0_spi0_parts[] = {
-	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{.name = "SLOT_0",
+	 .size = 7798784,
+	 .offset = 0,},
+
+	{.name = "SLOT_1",
+	 .size = 7798784,
+	 .offset = MTDPART_OFS_NXTBLK},
+
+	{.name = "SLOT_2",
+	 .size = 7798784,
+	 .offset = MTDPART_OFS_NXTBLK},
+
+	{.name = "SLOT_3",
+	 .size = 7798784,
+	 .offset = MTDPART_OFS_NXTBLK},
+
+	{.name = "CS0_EXTRA",
+	 .size = MTDPART_SIZ_FULL,
+	 .offset = MTDPART_OFS_NXTBLK},
 };
 static struct mtd_partition p2kr0_spi1_parts[] = {
-	{ .name = "SLOT_4",	.size = 7798784,		.offset = 0,                },
-	{ .name = "SLOT_5",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_6",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "SLOT_7",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
-	{ .name = "CS1_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
+	{.name = "SLOT_4",
+	 .size = 7798784,
+	 .offset = 0,},
+
+	{.name = "SLOT_5",
+	 .size = 7798784,
+	 .offset = MTDPART_OFS_NXTBLK},
+
+	{.name = "SLOT_6",
+	 .size = 7798784,
+	 .offset = MTDPART_OFS_NXTBLK},
+
+	{.name = "SLOT_7",
+	 .size = 7798784,
+	 .offset = MTDPART_OFS_NXTBLK},
+
+	{.name = "CS1_EXTRA",
+	 .size = MTDPART_SIZ_FULL,
+	 .offset = MTDPART_OFS_NXTBLK},
 };
 
 static struct flash_platform_data p2kr0_spi0_pdata = {
@@ -182,7 +210,8 @@ kp_spi_write_reg(struct kp_spi_controller_state *cs, int idx, u64 val)
 }
 
 	static int
-kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx, unsigned long bit)
+kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx,
+			unsigned long bit)
 {
 	unsigned long timeout;
 	timeout = jiffies + msecs_to_jiffies(1000);
@@ -215,7 +244,9 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 		for (i = 0 ; i < c ; i++) {
 			char val = *tx++;
 
-			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_TXS) < 0) {
+			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
+						    KP_SPI_REG_STATUS_TXS)
+			    < 0) {
 				goto out;
 			}
 
@@ -229,7 +260,9 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, 0x00);
 
-			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_RXS) < 0) {
+			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
+						    KP_SPI_REG_STATUS_RXS)
+			    < 0) {
 				goto out;
 			}
 
@@ -239,8 +272,10 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
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
@@ -307,7 +342,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 		void       *rx_buf = transfer->rx_buf;
 		unsigned    len = transfer->len;
 
-		if (transfer->speed_hz > KP_SPI_CLK || (len && !(rx_buf || tx_buf))) {
+		if (transfer->speed_hz > KP_SPI_CLK ||
+		    (len && !(rx_buf || tx_buf))) {
 			dev_dbg(kpspi->dev, "  transfer: %d Hz, %d %s%s, %d bpw\n",
 					transfer->speed_hz,
 					len,
@@ -317,7 +353,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
 			return -EINVAL;
 		}
-		if (transfer->speed_hz && (transfer->speed_hz < (KP_SPI_CLK >> 15))) {
+		if (transfer->speed_hz && (transfer->speed_hz <
+					   (KP_SPI_CLK >> 15))) {
 			dev_dbg(kpspi->dev, "speed_hz %d below minimum %d Hz\n",
 					transfer->speed_hz,
 					KP_SPI_CLK >> 15);
@@ -332,14 +369,16 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
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

