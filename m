Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7EEC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E72218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbfGWOfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:35:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388162AbfGWOfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:35:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B598BF1B5B365C8F856F;
        Tue, 23 Jul 2019 22:35:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 22:34:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: megaraid_sas: Make some functions static
Date:   Tue, 23 Jul 2019 22:34:50 +0800
Message-ID: <20190723143450.33916-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/scsi/megaraid/megaraid_sas_fusion.c:541:1: warning: symbol 'megasas_alloc_cmdlist_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:580:1: warning: symbol 'megasas_alloc_request_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:661:1: warning: symbol 'megasas_alloc_reply_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:738:1: warning: symbol 'megasas_alloc_rdpq_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:920:1: warning: symbol 'megasas_alloc_cmds_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:1740:1: warning: symbol 'megasas_init_adapter_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:1966:1: warning: symbol 'map_cmd_status' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:2379:1: warning: symbol 'megasas_set_pd_lba' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:2718:1: warning: symbol 'megasas_build_ldio_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3215:1: warning: symbol 'megasas_build_io_fusion' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_sas_fusion.c:3328:6: warning: symbol 'megasas_prepare_secondRaid1_IO' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index a32b3f0..120e3c4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -537,7 +537,7 @@ static int megasas_create_sg_sense_fusion(struct megasas_instance *instance)
 	return 0;
 }
 
-int
+static int
 megasas_alloc_cmdlist_fusion(struct megasas_instance *instance)
 {
 	u32 max_mpt_cmd, i, j;
@@ -576,7 +576,8 @@ megasas_alloc_cmdlist_fusion(struct megasas_instance *instance)
 
 	return 0;
 }
-int
+
+static int
 megasas_alloc_request_fusion(struct megasas_instance *instance)
 {
 	struct fusion_context *fusion;
@@ -657,7 +658,7 @@ megasas_alloc_request_fusion(struct megasas_instance *instance)
 	return 0;
 }
 
-int
+static int
 megasas_alloc_reply_fusion(struct megasas_instance *instance)
 {
 	int i, count;
@@ -734,7 +735,7 @@ megasas_alloc_reply_fusion(struct megasas_instance *instance)
 	return 0;
 }
 
-int
+static int
 megasas_alloc_rdpq_fusion(struct megasas_instance *instance)
 {
 	int i, j, k, msix_count;
@@ -916,7 +917,7 @@ megasas_free_reply_fusion(struct megasas_instance *instance) {
  * and is used as SMID of the cmd.
  * SMID value range is from 1 to max_fw_cmds.
  */
-int
+static int
 megasas_alloc_cmds_fusion(struct megasas_instance *instance)
 {
 	int i;
@@ -1736,7 +1737,7 @@ static inline void megasas_free_ioc_init_cmd(struct megasas_instance *instance)
  *
  * This is the main function for initializing firmware.
  */
-u32
+static u32
 megasas_init_adapter_fusion(struct megasas_instance *instance)
 {
 	struct fusion_context *fusion;
@@ -1962,7 +1963,7 @@ megasas_fusion_stop_watchdog(struct megasas_instance *instance)
  * @ext_status :	ext status of cmd returned by FW
  */
 
-void
+static void
 map_cmd_status(struct fusion_context *fusion,
 		struct scsi_cmnd *scmd, u8 status, u8 ext_status,
 		u32 data_length, u8 *sense)
@@ -2375,7 +2376,7 @@ int megasas_make_sgl(struct megasas_instance *instance, struct scsi_cmnd *scp,
  *
  * Used to set the PD LBA in CDB for FP IOs
  */
-void
+static void
 megasas_set_pd_lba(struct MPI2_RAID_SCSI_IO_REQUEST *io_request, u8 cdb_len,
 		   struct IO_REQUEST_INFO *io_info, struct scsi_cmnd *scp,
 		   struct MR_DRV_RAID_MAP_ALL *local_map_ptr, u32 ref_tag)
@@ -2714,7 +2715,7 @@ megasas_set_raidflag_cpu_affinity(struct fusion_context *fusion,
  * Prepares the io_request and chain elements (sg_frame) for IO
  * The IO can be for PD (Fast Path) or LD
  */
-void
+static void
 megasas_build_ldio_fusion(struct megasas_instance *instance,
 			  struct scsi_cmnd *scp,
 			  struct megasas_cmd_fusion *cmd)
@@ -3211,7 +3212,7 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
  * Invokes helper functions to prepare request frames
  * and sets flags appropriate for IO/Non-IO cmd
  */
-int
+static int
 megasas_build_io_fusion(struct megasas_instance *instance,
 			struct scsi_cmnd *scp,
 			struct megasas_cmd_fusion *cmd)
@@ -3325,9 +3326,9 @@ megasas_get_request_descriptor(struct megasas_instance *instance, u16 index)
 /* megasas_prepate_secondRaid1_IO
  *  It prepares the raid 1 second IO
  */
-void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
-			    struct megasas_cmd_fusion *cmd,
-			    struct megasas_cmd_fusion *r1_cmd)
+static void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
+					   struct megasas_cmd_fusion *cmd,
+					   struct megasas_cmd_fusion *r1_cmd)
 {
 	union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc, *req_desc2 = NULL;
 	struct fusion_context *fusion;
-- 
2.7.4


