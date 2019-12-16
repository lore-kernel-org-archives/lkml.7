Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AFFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91229206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLPNnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:43:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfLPNnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:43:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6562513F75AAEF470C6;
        Mon, 16 Dec 2019 21:43:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 21:42:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <afd@ti.com>, <sumit.semwal@linaro.org>,
        <benjamin.gaignard@linaro.org>
CC:     <labbott@redhat.com>, <Brian.Starkey@arm.com>,
        <john.stultz@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH v2] dma-heap: Make the symbol 'dma_heap_ioctl_cmds' static
Date:   Mon, 16 Dec 2019 21:38:31 +0800
Message-ID: <1576503511-27500-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <c1244a5f-b82a-baee-262a-7241531036ad@ti.com>
References: <c1244a5f-b82a-baee-262a-7241531036ad@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning.

drivers/dma-buf/dma-heap.c:109:14: warning: symbol 'dma_heap_ioctl_cmds' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/dma-buf/dma-heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 4f04d10..da2090e 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -106,7 +106,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
 	return 0;
 }
 
-unsigned int dma_heap_ioctl_cmds[] = {
+static unsigned int dma_heap_ioctl_cmds[] = {
 	DMA_HEAP_IOC_ALLOC,
 };
 
-- 
1.7.12.4

