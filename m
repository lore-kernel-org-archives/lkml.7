Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57286C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EBB20854
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCQSPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:15:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCQSPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:15:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5aJp-0001nQ-7K; Sun, 17 Mar 2019 18:15:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pm8001: clean up various indentation issues
Date:   Sun, 17 Mar 2019 18:15:32 +0000
Message-Id: <20190317181532.27477-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several lines of code where the indentation is
at an incorrect level; fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c |  8 +++---
 drivers/scsi/pm8001/pm8001_sas.c |  4 +--
 drivers/scsi/pm8001/pm80xx_hwi.c | 44 ++++++++++++++++----------------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index d0bb357034d8..e0fee3d91d23 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -960,9 +960,9 @@ pm8001_chip_soft_rst(struct pm8001_hba_info *pm8001_ha)
 		return -1;
 	}
 	regVal = pm8001_cr32(pm8001_ha, 2, GPIO_GPIO_0_0UTPUT_CTL_OFFSET);
-		PM8001_INIT_DBG(pm8001_ha,
-				pm8001_printk("GPIO Output Control Register:"
-				" = 0x%x\n", regVal));
+	PM8001_INIT_DBG(pm8001_ha,
+			pm8001_printk("GPIO Output Control Register:"
+			" = 0x%x\n", regVal));
 	/* set GPIO-0 output control to tri-state */
 	regVal &= 0xFFFFFFFC;
 	pm8001_cw32(pm8001_ha, 2, GPIO_GPIO_0_0UTPUT_CTL_OFFSET, regVal);
@@ -2928,7 +2928,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		PM8001_IO_DBG(pm8001_ha, pm8001_printk("IO_SUCCESS\n"));
 		ts->resp = SAS_TASK_COMPLETE;
 		ts->stat = SAM_STAT_GOOD;
-	if (pm8001_dev)
+		if (pm8001_dev)
 			pm8001_dev->running_req--;
 		break;
 	case IO_ABORTED:
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 084f2fcced0a..88eef3b18e41 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -740,8 +740,8 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 		wait_for_completion(&task->slow_task->completion);
 		if (pm8001_ha->chip_id != chip_8001) {
 			pm8001_dev->setds_completion = &completion_setstate;
-				PM8001_CHIP_DISP->set_dev_state_req(pm8001_ha,
-					pm8001_dev, 0x01);
+			PM8001_CHIP_DISP->set_dev_state_req(pm8001_ha,
+				pm8001_dev, 0x01);
 			wait_for_completion(&completion_setstate);
 		}
 		res = -TMF_RESP_FUNC_FAILED;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 63e4f7d34d6c..536d2b4384f8 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1316,7 +1316,7 @@ pm80xx_chip_soft_rst(struct pm8001_hba_info *pm8001_ha)
 
 static void pm80xx_hw_chip_rst(struct pm8001_hba_info *pm8001_ha)
 {
-	 u32 i;
+	u32 i;
 
 	PM8001_INIT_DBG(pm8001_ha,
 		pm8001_printk("chip reset start\n"));
@@ -4381,27 +4381,27 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 			sata_cmd.len = cpu_to_le32(task->total_xfer_len);
 			sata_cmd.esgl = 0;
 		}
-			/* scsi cdb */
-			sata_cmd.atapi_scsi_cdb[0] =
-				cpu_to_le32(((task->ata_task.atapi_packet[0]) |
-				(task->ata_task.atapi_packet[1] << 8) |
-				(task->ata_task.atapi_packet[2] << 16) |
-				(task->ata_task.atapi_packet[3] << 24)));
-			sata_cmd.atapi_scsi_cdb[1] =
-				cpu_to_le32(((task->ata_task.atapi_packet[4]) |
-				(task->ata_task.atapi_packet[5] << 8) |
-				(task->ata_task.atapi_packet[6] << 16) |
-				(task->ata_task.atapi_packet[7] << 24)));
-			sata_cmd.atapi_scsi_cdb[2] =
-				cpu_to_le32(((task->ata_task.atapi_packet[8]) |
-				(task->ata_task.atapi_packet[9] << 8) |
-				(task->ata_task.atapi_packet[10] << 16) |
-				(task->ata_task.atapi_packet[11] << 24)));
-			sata_cmd.atapi_scsi_cdb[3] =
-				cpu_to_le32(((task->ata_task.atapi_packet[12]) |
-				(task->ata_task.atapi_packet[13] << 8) |
-				(task->ata_task.atapi_packet[14] << 16) |
-				(task->ata_task.atapi_packet[15] << 24)));
+		/* scsi cdb */
+		sata_cmd.atapi_scsi_cdb[0] =
+			cpu_to_le32(((task->ata_task.atapi_packet[0]) |
+			(task->ata_task.atapi_packet[1] << 8) |
+			(task->ata_task.atapi_packet[2] << 16) |
+			(task->ata_task.atapi_packet[3] << 24)));
+		sata_cmd.atapi_scsi_cdb[1] =
+			cpu_to_le32(((task->ata_task.atapi_packet[4]) |
+			(task->ata_task.atapi_packet[5] << 8) |
+			(task->ata_task.atapi_packet[6] << 16) |
+			(task->ata_task.atapi_packet[7] << 24)));
+		sata_cmd.atapi_scsi_cdb[2] =
+			cpu_to_le32(((task->ata_task.atapi_packet[8]) |
+			(task->ata_task.atapi_packet[9] << 8) |
+			(task->ata_task.atapi_packet[10] << 16) |
+			(task->ata_task.atapi_packet[11] << 24)));
+		sata_cmd.atapi_scsi_cdb[3] =
+			cpu_to_le32(((task->ata_task.atapi_packet[12]) |
+			(task->ata_task.atapi_packet[13] << 8) |
+			(task->ata_task.atapi_packet[14] << 16) |
+			(task->ata_task.atapi_packet[15] << 24)));
 	}
 
 	/* Check for read log for failed drive and return */
-- 
2.20.1

