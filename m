Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BCC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CC521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfDWOuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:50:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40187 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:50:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hIwkZ-0006sk-6y; Tue, 23 Apr 2019 14:50:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_h5: fix spelling mistake "sliped" -> "slipped"
Date:   Tue, 23 Apr 2019 15:50:22 +0100
Message-Id: <20190423145022.9821-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a BT_DBG debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/hci_h5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 069d1c8fde73..3f02ae560120 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -536,7 +536,7 @@ static void h5_unslip_one_byte(struct h5 *h5, unsigned char c)
 	skb_put_data(h5->rx_skb, byte, 1);
 	h5->rx_pending--;
 
-	BT_DBG("unsliped 0x%02hhx, rx_pending %zu", *byte, h5->rx_pending);
+	BT_DBG("unslipped 0x%02hhx, rx_pending %zu", *byte, h5->rx_pending);
 }
 
 static void h5_reset_rx(struct h5 *h5)
-- 
2.20.1

