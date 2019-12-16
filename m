Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D543C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D92206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLPKWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:22:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfLPKWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:22:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A996CD52E4933C156759;
        Mon, 16 Dec 2019 18:22:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 18:21:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH] drm/dp_mst: make the symbol 'drm_dp_send_clear_payload_id_table' static
Date:   Mon, 16 Dec 2019 18:17:32 +0800
Message-ID: <1576491452-18591-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning.

drivers/gpu/drm/drm_dp_mst_topology.c:2897:6: warning: symbol 'drm_dp_send_clear_payload_id_table' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index e68d230..c4976de 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2894,7 +2894,7 @@ static int drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	return ret < 0 ? ret : changed;
 }
 
-void drm_dp_send_clear_payload_id_table(struct drm_dp_mst_topology_mgr *mgr,
+static void drm_dp_send_clear_payload_id_table(struct drm_dp_mst_topology_mgr *mgr,
 					struct drm_dp_mst_branch *mstb)
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
-- 
1.7.12.4

