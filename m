Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006FC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA3920848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfFQJPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:15:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbfFQJPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:15:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 73CD570A31DEC0659387;
        Mon, 17 Jun 2019 17:15:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 17:15:29 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next v2] coresight: replicator: Add terminate entry for acpi_device_id tables
Date:   Mon, 17 Jun 2019 09:22:53 +0000
Message-ID: <20190617092253.167231-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190615104440.94149-1-weiyongjun1@huawei.com>
References: <20190615104440.94149-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure acpi_device_id tables have terminate entry.

Fixes: fe446287ec9f ("coresight: acpi: Support for platform devices")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 542952759941..b7d6d59d56db 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -300,6 +300,7 @@ static const struct of_device_id static_replicator_match[] = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_replicator_acpi_ids[] = {
 	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
+	{}
 };
 #endif



