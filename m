Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF5220684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCGVwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:52:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48992 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCGVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:52:23 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 5B0E422C78; Thu,  7 Mar 2019 16:52:19 -0500 (EST)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <dd8814ad55ee7d86b1c7f5f47cd68ff0ff33f8d9.1551995342.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] scsi/NCR5380: Remove set but unused variable
Date:   Fri, 08 Mar 2019 08:49:02 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 01c23d27f290..7fed9bb72784 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -272,9 +272,8 @@ mrs[] = {
 static void NCR5380_print(struct Scsi_Host *instance)
 {
 	struct NCR5380_hostdata *hostdata = shost_priv(instance);
-	unsigned char status, data, basr, mr, icr, i;
+	unsigned char status, basr, mr, icr, i;
 
-	data = NCR5380_read(CURRENT_SCSI_DATA_REG);
 	status = NCR5380_read(STATUS_REG);
 	mr = NCR5380_read(MODE_REG);
 	icr = NCR5380_read(INITIATOR_COMMAND_REG);
-- 
2.19.2

