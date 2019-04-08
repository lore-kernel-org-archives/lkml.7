Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDFC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07459213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDHNuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:50:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfDHNuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:50:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B0F491AF76B05D4274FD;
        Mon,  8 Apr 2019 21:50:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Mon, 8 Apr 2019 21:49:59 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <marc.zyngier@arm.com>, <linuxarm@huawei.com>,
        <yangyingliang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] irqchip/gicv3-its: fix some definitions of inner cacheability attributes
Date:   Mon, 8 Apr 2019 22:01:03 +0800
Message-ID: <20190408140103.131554-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some definitions of Inner Cacheability attibutes need to be corrected.

Fixes: 8c828a535e29f ("irqchip/gicv3-its: Restore all cacheability
attributes")

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 include/linux/irqchip/arm-gic-v3.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 95b69d3006ee..1f33daa5c674 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -165,7 +165,7 @@
 #define GICR_PROPBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, nCnB)
 #define GICR_PROPBASER_nC 	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, nC)
 #define GICR_PROPBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, RaWt)
-#define GICR_PROPBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, RaWt)
+#define GICR_PROPBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, RaWb)
 #define GICR_PROPBASER_WaWt	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, WaWt)
 #define GICR_PROPBASER_WaWb	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, WaWb)
 #define GICR_PROPBASER_RaWaWt	GIC_BASER_CACHEABILITY(GICR_PROPBASER, INNER, RaWaWt)
@@ -192,7 +192,7 @@
 #define GICR_PENDBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, nCnB)
 #define GICR_PENDBASER_nC 	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, nC)
 #define GICR_PENDBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, RaWt)
-#define GICR_PENDBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, RaWt)
+#define GICR_PENDBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, RaWb)
 #define GICR_PENDBASER_WaWt	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, WaWt)
 #define GICR_PENDBASER_WaWb	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, WaWb)
 #define GICR_PENDBASER_RaWaWt	GIC_BASER_CACHEABILITY(GICR_PENDBASER, INNER, RaWaWt)
@@ -251,7 +251,7 @@
 #define GICR_VPROPBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, nCnB)
 #define GICR_VPROPBASER_nC 	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, nC)
 #define GICR_VPROPBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWt)
-#define GICR_VPROPBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWt)
+#define GICR_VPROPBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWb)
 #define GICR_VPROPBASER_WaWt	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, WaWt)
 #define GICR_VPROPBASER_WaWb	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, WaWb)
 #define GICR_VPROPBASER_RaWaWt	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWaWt)
@@ -277,7 +277,7 @@
 #define GICR_VPENDBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nCnB)
 #define GICR_VPENDBASER_nC 	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nC)
 #define GICR_VPENDBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWt)
-#define GICR_VPENDBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWt)
+#define GICR_VPENDBASER_RaWb	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWb)
 #define GICR_VPENDBASER_WaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, WaWt)
 #define GICR_VPENDBASER_WaWb	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, WaWb)
 #define GICR_VPENDBASER_RaWaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWaWt)
@@ -351,7 +351,7 @@
 #define GITS_CBASER_nCnB	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, nCnB)
 #define GITS_CBASER_nC		GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, nC)
 #define GITS_CBASER_RaWt	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWt)
-#define GITS_CBASER_RaWb	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWt)
+#define GITS_CBASER_RaWb	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWb)
 #define GITS_CBASER_WaWt	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, WaWt)
 #define GITS_CBASER_WaWb	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, WaWb)
 #define GITS_CBASER_RaWaWt	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWaWt)
@@ -375,7 +375,7 @@
 #define GITS_BASER_nCnB		GIC_BASER_CACHEABILITY(GITS_BASER, INNER, nCnB)
 #define GITS_BASER_nC		GIC_BASER_CACHEABILITY(GITS_BASER, INNER, nC)
 #define GITS_BASER_RaWt		GIC_BASER_CACHEABILITY(GITS_BASER, INNER, RaWt)
-#define GITS_BASER_RaWb		GIC_BASER_CACHEABILITY(GITS_BASER, INNER, RaWt)
+#define GITS_BASER_RaWb		GIC_BASER_CACHEABILITY(GITS_BASER, INNER, RaWb)
 #define GITS_BASER_WaWt		GIC_BASER_CACHEABILITY(GITS_BASER, INNER, WaWt)
 #define GITS_BASER_WaWb		GIC_BASER_CACHEABILITY(GITS_BASER, INNER, WaWb)
 #define GITS_BASER_RaWaWt	GIC_BASER_CACHEABILITY(GITS_BASER, INNER, RaWaWt)
-- 
2.20.1

