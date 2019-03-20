Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C097206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCTOVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:21:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727144AbfCTOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:21:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03EA57C24FE0564231B4;
        Wed, 20 Mar 2019 22:08:25 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 22:08:18 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <dave.jiang@intel.com>, <jdmason@kudzu.us>, <allenbh@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
Date:   Wed, 20 Mar 2019 22:08:12 +0800
Message-ID: <20190320140812.5952-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/ntb/hw/intel/ntb_hw_gen3.c:535:5: warning:
 symbol 'intel_ntb3_peer_db_addr' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index f475b56..c339716 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -532,9 +532,9 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	return 0;
 }
 
-int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
-				resource_size_t *db_size,
-				u64 *db_data, int db_bit)
+static int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
+				   resource_size_t *db_size,
+				   u64 *db_data, int db_bit)
 {
 	phys_addr_t db_addr_base;
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
-- 
2.7.0


