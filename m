Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBE7C48BD9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CE720656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="dyRR3pfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfFYLfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:35:15 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:42357 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730674AbfFYLfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:35:00 -0400
Received: from mx-exchlnx-1.rrze.uni-erlangen.de (mx-exchlnx-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::37])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3nj17yRz8tXs;
        Tue, 25 Jun 2019 13:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561462121; bh=kgWFSR8rkjVj9cEPlrBhB4nyGNXIUE7w4pj8HnzBCN8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=dyRR3pfXBKSQUnYwhUklKFF3Pu1CxgDjEl90bQX7r6Vv94az7a/X18BovnOrEiMJ4
         YvNkMeX0fAgJlwJbbuQpLDYmUL5u71+WXbBiTuZOjDAYng7TTS4UVjxfIjI5xeQmnM
         lzrRljTG5z22C+BHDaKC8hDdykP/IKe+WF9LY6ACbRPvE8TzVBP3tyKBzczQLOZoCB
         QNpdhI2PhB7Z+hM6zMRBShE6wDjR4HxZTKxY9BLMeh1J3r/WDiRr+6cKiM5u1YWmQ5
         OtnIo8N+M9E7OY764/8Y265tHZBDGq3bUOFB7x/p4cYrRCeYMCET7zDQU4OxYhby8b
         1v+JeYAVYtwBQ==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3nf64mPz8sZG;
        Tue, 25 Jun 2019 13:28:38 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 13:27:55 +0200
Received: from TroubleWorld.pool.uni-erlangen.de (10.21.22.37) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 25 Jun 2019 13:27:53 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] staging: kpc2000: remove unnecessary brackets
Date:   Tue, 25 Jun 2019 13:27:16 +0200
Message-ID: <20190625112725.10154-6-fabian.krueger@fau.de>
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

Removed brackets on around one-lined if-cases.
This refactoring makes the code more readable.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 8f56886f4673..79d7c44315e8 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -218,11 +218,10 @@ kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx,
 	timeout = jiffies + msecs_to_jiffies(1000);
 	while (!(kp_spi_read_reg(cs, idx) & bit)) {
 		if (time_after(jiffies, timeout)) {
-			if (!(kp_spi_read_reg(cs, idx) & bit)) {
+			if (!(kp_spi_read_reg(cs, idx) & bit))
 				return -ETIMEDOUT;
-			} else {
+			else
 				return 0;
-			}
 		}
 		cpu_relax();
 	}
@@ -331,9 +330,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 	cs = spidev->controller_state;
 
 	/* reject invalid messages and transfers */
-	if (list_empty(&m->transfers)) {
+	if (list_empty(&m->transfers))
 		return -EINVAL;
-	}
 
 	/* validate input */
 	list_for_each_entry(transfer, &m->transfers, transfer_list) {
@@ -391,17 +389,14 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			sc.reg = kp_spi_read_reg(cs, KP_SPI_REG_CONFIG);
 
 			/* ...direction */
-			if (transfer->tx_buf) {
+			if (transfer->tx_buf)
 				sc.bitfield.trm = KP_SPI_REG_CONFIG_TRM_TX;
-			}
-			else if (transfer->rx_buf) {
+			else if (transfer->rx_buf)
 				sc.bitfield.trm = KP_SPI_REG_CONFIG_TRM_RX;
-			}
 
 			/* ...word length */
-			if (transfer->bits_per_word) {
+			if (transfer->bits_per_word)
 				word_len = transfer->bits_per_word;
-			}
 			sc.bitfield.wl = word_len-1;
 
 			/* ...chip select */
@@ -420,9 +415,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			}
 		}
 
-		if (transfer->delay_usecs) {
+		if (transfer->delay_usecs)
 			udelay(transfer->delay_usecs);
-		}
 	}
 
 	/* de-assert chip select to end the sequence */
@@ -445,9 +439,7 @@ kp_spi_cleanup(struct spi_device *spidev)
 {
 	struct kp_spi_controller_state *cs = spidev->controller_state;
 
-	if (cs) {
-		kfree(cs);
-	}
+	kfree(cs);
 }
 
 /******************
@@ -489,9 +481,8 @@ kp_spi_probe(struct platform_device *pldev)
 	kpspi->dev = &pldev->dev;
 
 	master->num_chipselect = 4;
-	if (pldev->id != -1) {
+	if (pldev->id != -1)
 		master->bus_num = pldev->id;
-	}
 
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
-- 
2.17.1

