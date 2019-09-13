Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971ACC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687CE20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbfIMJID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:08:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49844 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387897AbfIMJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:08:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i8hYd-00021M-FF; Fri, 13 Sep 2019 09:07:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ariel Elior <aelior@marvell.com>, GR-everest-linux-l2@marvell.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix spelling mistake "fullill" -> "fulfill"
Date:   Fri, 13 Sep 2019 10:07:59 +0100
Message-Id: <20190913090759.3490-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a DP_VERBOSE debug message. Fix it.
(Using American English spelling as this is the most common way
to spell this in the kernel).

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 5dda547772c1..856051f50eb7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -231,7 +231,7 @@ static void qed_vf_pf_acquire_reduce_resc(struct qed_hwfn *p_hwfn,
 {
 	DP_VERBOSE(p_hwfn,
 		   QED_MSG_IOV,
-		   "PF unwilling to fullill resource request: rxq [%02x/%02x] txq [%02x/%02x] sbs [%02x/%02x] mac [%02x/%02x] vlan [%02x/%02x] mc [%02x/%02x] cids [%02x/%02x]. Try PF recommended amount\n",
+		   "PF unwilling to fulfill resource request: rxq [%02x/%02x] txq [%02x/%02x] sbs [%02x/%02x] mac [%02x/%02x] vlan [%02x/%02x] mc [%02x/%02x] cids [%02x/%02x]. Try PF recommended amount\n",
 		   p_req->num_rxqs,
 		   p_resp->num_rxqs,
 		   p_req->num_rxqs,
-- 
2.20.1

