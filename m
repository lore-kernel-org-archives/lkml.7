Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C0C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32E9208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE2KAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:00:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfE2KAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:00:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C6B763B3647AD9D5A2D;
        Wed, 29 May 2019 18:00:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 29 May 2019 18:00:10 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/6] hisi_sas: Some misc patches
Date:   Wed, 29 May 2019 17:58:41 +0800
Message-ID: <1559123927-160502-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces some misc patches for the driver. Nothing
particularly stands out, maybe apart from a patch to delete a PHY's
timer when necessary.

John Garry (1):
  scsi: hisi_sas: Reduce HISI_SAS_SGE_PAGE_CNT in size

Luo Jiaxing (1):
  scsi: hisi_sas: Ignore the error code between phy down to phy up

Xiang Chen (3):
  scsi: hisi_sas: Delete PHYs' timer when rmmod or probe failed
  scsi: hisi_sas: Change the type of some numbers to unsigned
  scsi: hisi_sas: Disable stash for v3 hw

Xiaofei Tan (1):
  scsi: hisi_sas: Fix the issue of argument mismatch of printing ecc
    errors

 drivers/scsi/hisi_sas/hisi_sas.h       |  4 +--
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  8 +++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 46 ++++++++++++++------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 46 ++++++++++++++++++--------
 4 files changed, 66 insertions(+), 38 deletions(-)

-- 
2.17.1

