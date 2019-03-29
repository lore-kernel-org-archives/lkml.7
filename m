Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9405C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9129E21850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfC2DYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:24:54 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:12760 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2DYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:24:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5c9d9000cc4-76a40; Fri, 29 Mar 2019 11:24:48 +0800 (CST)
X-RM-TRANSID: 2eeb5c9d9000cc4-76a40
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from dxhost1.openstacklocal (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5c9d8fffa72-4dfee;
        Fri, 29 Mar 2019 11:24:48 +0800 (CST)
X-RM-TRANSID: 2eea5c9d8fffa72-4dfee
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     QLogic-Storage-Upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2fc: remove unneeded variable
Date:   Fri, 29 Mar 2019 11:24:12 +0800
Message-Id: <1553829852-16525-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"rc" is unneeded,just return SUCCESS

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index bc9f2a2..8def63c 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -1083,7 +1083,6 @@ int bnx2fc_eh_device_reset(struct scsi_cmnd *sc_cmd)
 static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
 {
 	struct bnx2fc_rport *tgt = io_req->tgt;
-	int rc = SUCCESS;
 	unsigned int time_left;
 
 	io_req->wait_for_comp = 1;
@@ -1110,7 +1109,7 @@ static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
 	kref_put(&io_req->refcount, bnx2fc_cmd_release);
 
 	spin_lock_bh(&tgt->tgt_lock);
-	return rc;
+	return SUCCESS;
 }
 
 /**
-- 
1.9.1



