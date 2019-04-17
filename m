Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0325C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7855821773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfDQNPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:15:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37240 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfDQNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:15:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGkOz-0008UH-4D; Wed, 17 Apr 2019 13:15:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        John Hurley <john.hurley@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfp: abm: fix spelling mistake "offseting" -> "offsetting"
Date:   Wed, 17 Apr 2019 14:15:00 +0100
Message-Id: <20190417131500.4793-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in NL_SET_ERR_MSG_MOD error
messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/netronome/nfp/abm/cls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/cls.c b/drivers/net/ethernet/netronome/nfp/abm/cls.c
index 9852080cf454..ff3913085665 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/cls.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/cls.c
@@ -39,7 +39,7 @@ nfp_abm_u32_check_knode(struct nfp_abm *abm, struct tc_cls_u32_knode *knode,
 	}
 	if (knode->sel->off || knode->sel->offshift || knode->sel->offmask ||
 	    knode->sel->offoff || knode->fshift) {
-		NL_SET_ERR_MSG_MOD(extack, "variable offseting not supported");
+		NL_SET_ERR_MSG_MOD(extack, "variable offsetting not supported");
 		return false;
 	}
 	if (knode->sel->hoff || knode->sel->hmask) {
@@ -78,7 +78,7 @@ nfp_abm_u32_check_knode(struct nfp_abm *abm, struct tc_cls_u32_knode *knode,
 
 	k = &knode->sel->keys[0];
 	if (k->offmask) {
-		NL_SET_ERR_MSG_MOD(extack, "offset mask - variable offseting not supported");
+		NL_SET_ERR_MSG_MOD(extack, "offset mask - variable offsetting not supported");
 		return false;
 	}
 	if (k->off) {
-- 
2.20.1

