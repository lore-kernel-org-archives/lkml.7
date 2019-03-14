Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1D32184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfCNXPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:15:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfCNXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:15:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h4ZYw-0004kt-5o; Thu, 14 Mar 2019 23:14:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_serverworks: clean up misaligned indentation
Date:   Thu, 14 Mar 2019 23:14:57 +0000
Message-Id: <20190314231457.20966-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several lines that are indented by one space too
many; clean these up.  Also re-work comment block to clean
up cppcheck warnings

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/pata_serverworks.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 57de02123c4c..6083c7acfbca 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -432,10 +432,12 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
 
-		 /* If the returned btr is the newer revision then
-		    select the right info block */
-		 if (rc == 3)
-		 	ppi[0] = &info[3];
+		/*
+		 * If the returned btr is the newer revision then
+		 * select the right info block
+		 */
+		if (rc == 3)
+			ppi[0] = &info[3];
 
 		/* Is this the 3rd channel CSB6 IDE ? */
 		if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)
-- 
2.20.1

