Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D00EC47E49
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958F21D7F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 02:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfJZCvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 22:51:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfJZCva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 22:51:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF52D9F0D7FC51A6691C;
        Sat, 26 Oct 2019 10:51:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Sat, 26 Oct 2019 10:51:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Egor Pomozov <epomozov@marvell.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: aquantia: remove unused including <linux/version.h>
Date:   Sat, 26 Oct 2019 02:51:09 +0000
Message-ID: <20191026025109.75721-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
index 3de4682f7c06..61486757c789 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
@@ -9,7 +9,6 @@
 #define AQ_PTP_H
 
 #include <linux/net_tstamp.h>
-#include <linux/version.h>
 
 /* Common functions */
 int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_vec);



