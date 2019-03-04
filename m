Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E34920835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCDA60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:58:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbfCDA60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:58:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 18EB9D78DBBB1B8C13A0;
        Mon,  4 Mar 2019 08:58:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Mon, 4 Mar 2019 08:58:17 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-nvdimm@lists.01.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] device-dax: Make function 'dev_dax_kmem_probe' static
Date:   Mon, 4 Mar 2019 01:11:21 +0000
Message-ID: <20190304011121.64398-1-weiyongjun1@huawei.com>
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

Fixes the following sparse warning:

drivers/dax/kmem.c:17:5: warning:
 symbol 'dev_dax_kmem_probe' was not declared. Should it be static?

Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/dax/kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a02318c6d28a..e5cbbe22a19b 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -14,7 +14,7 @@
 #include "dax-private.h"
 #include "bus.h"
 
-int dev_dax_kmem_probe(struct device *dev)
+static int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct resource *res = &dev_dax->region->res;



