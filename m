Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA55C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB16E2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDBWQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:16:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:60183 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfDBWQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:16:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 15:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,302,1549958400"; 
   d="scan'208";a="158165271"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2019 15:16:17 -0700
From:   richard.gong@linux.intel.com
To:     atull@kernel.org, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] fpga: mgr: add FPGA configuration log
Date:   Tue,  2 Apr 2019 17:25:43 -0500
Message-Id: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add a log for user to know FPGA configuration is successful

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/fpga/fpga-mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c386681..559e046 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	}
 	mgr->state = FPGA_MGR_STATE_OPERATING;
 
+	dev_info(&mgr->dev, "Successfully programming FPGA\n");
 	return 0;
 }
 
-- 
2.7.4

