Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0B7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111F721738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfDWOaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:30:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39231 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfDWOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:30:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hIwQx-0004i0-E4; Tue, 23 Apr 2019 14:30:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: atheros: fix spelling mistake "underun" -> "underrun"
Date:   Tue, 23 Apr 2019 15:30:07 +0100
Message-Id: <20190423143007.5353-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in structure elements, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 4 ++--
 drivers/net/ethernet/atheros/atlx/atl1.h | 2 +-
 drivers/net/ethernet/atheros/atlx/atl2.c | 2 +-
 drivers/net/ethernet/atheros/atlx/atl2.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index f7583c5d9509..f35c9a75be50 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1721,7 +1721,7 @@ static void atl1_inc_smb(struct atl1_adapter *adapter)
 	adapter->soft_stats.scc += smb->tx_1_col;
 	adapter->soft_stats.mcc += smb->tx_2_col;
 	adapter->soft_stats.latecol += smb->tx_late_col;
-	adapter->soft_stats.tx_underun += smb->tx_underrun;
+	adapter->soft_stats.tx_underrun += smb->tx_underrun;
 	adapter->soft_stats.tx_trunc += smb->tx_trunc;
 	adapter->soft_stats.tx_pause += smb->tx_pause;
 
@@ -3178,7 +3178,7 @@ static struct atl1_stats atl1_gstrings_stats[] = {
 	{"tx_deferred_ok", ATL1_STAT(soft_stats.deffer)},
 	{"tx_single_coll_ok", ATL1_STAT(soft_stats.scc)},
 	{"tx_multi_coll_ok", ATL1_STAT(soft_stats.mcc)},
-	{"tx_underun", ATL1_STAT(soft_stats.tx_underun)},
+	{"tx_underrun", ATL1_STAT(soft_stats.tx_underrun)},
 	{"tx_trunc", ATL1_STAT(soft_stats.tx_trunc)},
 	{"tx_pause", ATL1_STAT(soft_stats.tx_pause)},
 	{"rx_pause", ATL1_STAT(soft_stats.rx_pause)},
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.h b/drivers/net/ethernet/atheros/atlx/atl1.h
index 34a58cd846a0..eacff19ea05b 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.h
+++ b/drivers/net/ethernet/atheros/atlx/atl1.h
@@ -681,7 +681,7 @@ struct atl1_sft_stats {
 	u64 scc;		/* packets TX after a single collision */
 	u64 mcc;		/* packets TX after multiple collisions */
 	u64 latecol;		/* TX packets w/ late collisions */
-	u64 tx_underun;		/* TX packets aborted due to TX FIFO underrun
+	u64 tx_underrun;	/* TX packets aborted due to TX FIFO underrun
 				 * or TRD FIFO underrun */
 	u64 tx_trunc;		/* TX packets truncated due to size > MTU */
 	u64 rx_pause;		/* num Pause packets received. */
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 1474cac7e892..dd81c5863111 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -553,7 +553,7 @@ static void atl2_intr_tx(struct atl2_adapter *adapter)
 			netdev->stats.tx_aborted_errors++;
 		if (txs->late_col)
 			netdev->stats.tx_window_errors++;
-		if (txs->underun)
+		if (txs->underrun)
 			netdev->stats.tx_fifo_errors++;
 	} while (1);
 
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.h b/drivers/net/ethernet/atheros/atlx/atl2.h
index c64a6bdfa7ae..25ec84cb4853 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.h
+++ b/drivers/net/ethernet/atheros/atlx/atl2.h
@@ -260,7 +260,7 @@ struct tx_pkt_status {
 	unsigned multi_col:1;
 	unsigned late_col:1;
 	unsigned abort_col:1;
-	unsigned underun:1;	/* current packet is aborted
+	unsigned underrun:1;	/* current packet is aborted
 				 * due to txram underrun */
 	unsigned:3;		/* reserved */
 	unsigned update:1;	/* always 1'b1 in tx_status_buf */
-- 
2.20.1

