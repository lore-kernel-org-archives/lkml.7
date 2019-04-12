Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C7CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FF82083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfDLI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfDLI6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B98F4B5540F6B384E2AE;
        Fri, 12 Apr 2019 16:58:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 16:58:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/6] libsas: Some minor improvements and tidy-up
Date:   Fri, 12 Apr 2019 16:57:51 +0800
Message-ID: <1555059478-36224-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces some minor improvements and tidy-up, including:
- fix PHY info in sysfs for PHY events
- min pathway rate programming improvement
- some other tidy-up and neatening

John Garry (6):
  scsi: libsas: Stop hardcoding SAS address length
  scsi: libsas: Try to retain programmed min linkrate for SATA min
    pathway unmatch fixing
  scsi: libsas: Improve vague log in SAS rediscovery
  scsi: libsas: Inject revalidate event for root port event
  scsi: libsas: Do discovery on empty PHY to update PHY info
  scsi: libsas: Print expander PHY indexes in decimal

 drivers/scsi/libsas/sas_ata.c      |  2 +-
 drivers/scsi/libsas/sas_expander.c | 83 ++++++++++++++++++------------
 drivers/scsi/libsas/sas_init.c     | 42 ++++++++-------
 drivers/scsi/libsas/sas_phy.c      |  7 ++-
 drivers/scsi/libsas/sas_port.c     | 24 +++++++--
 include/scsi/libsas.h              | 13 +++--
 6 files changed, 108 insertions(+), 63 deletions(-)

-- 
2.17.1

