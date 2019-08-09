Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8059C32754
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7F02054F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405146AbfHICdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 22:33:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729418AbfHICdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 22:33:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0240CC3389DB528DC77B;
        Fri,  9 Aug 2019 10:33:32 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 10:33:25 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Guojia Liao <liaoguojia@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: refine some macro definitions
Date:   Fri, 9 Aug 2019 10:31:18 +0800
Message-ID: <1565317878-31806-13-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565317878-31806-1-git-send-email-tanhuazhong@huawei.com>
References: <1565317878-31806-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guojia Liao <liaoguojia@huawei.com>

Macro arguments should be enclosed in parentheses, in case of
expression argument, but parentheses of pure number in macro
definition should be removed for simplicity.

Signed-off-by: Guojia Liao <liaoguojia@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 43740ee..6c9fd58 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -58,10 +58,10 @@
 		BIT(HNAE3_DEV_SUPPORT_ROCE_B))
 
 #define hnae3_dev_roce_supported(hdev) \
-	hnae3_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_ROCE_B)
+	hnae3_get_bit((hdev)->ae_dev->flag, HNAE3_DEV_SUPPORT_ROCE_B)
 
 #define hnae3_dev_dcb_supported(hdev) \
-	hnae3_get_bit(hdev->ae_dev->flag, HNAE3_DEV_SUPPORT_DCB_B)
+	hnae3_get_bit((hdev)->ae_dev->flag, HNAE3_DEV_SUPPORT_DCB_B)
 
 #define hnae3_dev_fd_supported(hdev) \
 	hnae3_get_bit((hdev)->ae_dev->flag, HNAE3_DEV_SUPPORT_FD_B)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 4ccf107..bdde3af 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -125,7 +125,7 @@
 #define HCLGEVF_S_IP_BIT		BIT(3)
 #define HCLGEVF_V_TAG_BIT		BIT(4)
 
-#define HCLGEVF_STATS_TIMER_INTERVAL	(36)
+#define HCLGEVF_STATS_TIMER_INTERVAL	36U
 
 enum hclgevf_evt_cause {
 	HCLGEVF_VECTOR0_EVENT_RST,
-- 
2.7.4

