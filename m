Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D717CC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B995A216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390356AbfGHPoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:44:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403850AbfGHPoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:44:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6BBE1516;
        Mon,  8 Jul 2019 08:44:11 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CACB43F59C;
        Mon,  8 Jul 2019 08:44:10 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 4/6] firmware: arm_scmi: Fix few trivial typos in comments
Date:   Mon,  8 Jul 2019 16:43:56 +0100
Message-Id: <20190708154358.16227-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154358.16227-1-sudeep.holla@arm.com>
References: <20190708154358.16227-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While adding new comments found couple of typos that are better fixed.

s/informfation/information/
s/statues/status/

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6ef652940099..cac255c418b2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -86,7 +86,7 @@ struct scmi_desc {
 };
 
 /**
- * struct scmi_chan_info - Structure representing a SCMI channel informfation
+ * struct scmi_chan_info - Structure representing a SCMI channel information
  *
  * @cl: Mailbox Client
  * @chan: Transmit/Receive mailbox channel
@@ -190,7 +190,7 @@ static void scmi_fetch_response(struct scmi_xfer *xfer,
 				struct scmi_shared_mem __iomem *mem)
 {
 	xfer->hdr.status = ioread32(mem->msg_payload);
-	/* Skip the length of header and statues in payload area i.e 8 bytes*/
+	/* Skip the length of header and status in payload area i.e 8 bytes */
 	xfer->rx.len = min_t(size_t, xfer->rx.len, ioread32(&mem->length) - 8);
 
 	/* Take a copy to the rx buffer.. */
-- 
2.17.1

