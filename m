Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848402133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbfB1OwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:52:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731586AbfB1Ov3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:51:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A38F2426C058B687E66D;
        Thu, 28 Feb 2019 22:51:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 22:51:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/6] hisi_sas: Some misc patches
Date:   Thu, 28 Feb 2019 22:50:56 +0800
Message-ID: <1551365462-128193-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains some misc patches for the driver, including:
- Workaround for acute scenario of SMP/internal IO timeout and reset racing
- Clear Affiliation for STP target port (from Luo Jiaxing and Xiang Chen)
- Fix PHY negotiated linkrate value for when PHY down
- Some init reg config changes
- Add support to coalesce and print PHY errors
- A tidy-up patch

John Garry (1):
  scsi: hisi_sas: Set PHY linkrate when disconnected

Xiang Chen (4):
  scsi: hisi_sas: Change return variable type in phy_up_v3_hw()
  scsi: hisi_sas: Fix a timeout race of driver internal and SMP IO
  scsi: hisi_sas: Send HARD RESET to clear the previous affiliation of
    STP target port
  scsi: hisi_sas: Change SERDES_CFG init value to increase reliability
    of HiLink

Xiaofei Tan (1):
  scsi: hisi_sas: print PHY RX errors count for later revision of v3 hw

 drivers/scsi/hisi_sas/hisi_sas.h       |  8 +++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 57 +++++++++++++++--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 89 ++++++++++++++++++--------
 4 files changed, 125 insertions(+), 30 deletions(-)

-- 
2.17.1

