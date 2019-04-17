Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADADC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4846321773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfDQNnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:43:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37804 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQNnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:43:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGkq8-0002Gu-Ms; Wed, 17 Apr 2019 13:43:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedi: fix spelling mistake "oflload" -> "offload"
Date:   Wed, 17 Apr 2019 14:43:04 +0100
Message-Id: <20190417134304.10979-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in some kernel alert messages.
Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qedi/qedi_iscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 6d6d6013e35b..e4391ee2c27a 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -579,7 +579,7 @@ static int qedi_conn_start(struct iscsi_cls_conn *cls_conn)
 	rval = qedi_iscsi_update_conn(qedi, qedi_conn);
 	if (rval) {
 		iscsi_conn_printk(KERN_ALERT, conn,
-				  "conn_start: FW oflload conn failed.\n");
+				  "conn_start: FW offload conn failed.\n");
 		rval = -EINVAL;
 		goto start_err;
 	}
@@ -590,7 +590,7 @@ static int qedi_conn_start(struct iscsi_cls_conn *cls_conn)
 	rval = iscsi_conn_start(cls_conn);
 	if (rval) {
 		iscsi_conn_printk(KERN_ALERT, conn,
-				  "iscsi_conn_start: FW oflload conn failed!!\n");
+				  "iscsi_conn_start: FW offload conn failed!!\n");
 	}
 
 start_err:
-- 
2.20.1

