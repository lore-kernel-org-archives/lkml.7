Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01931C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD5120879
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEHCEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:04:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfEHCEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:04:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 694E77B2E798C414775F;
        Wed,  8 May 2019 10:04:37 +0800 (CST)
Received: from huawei.com (10.184.227.228) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 May 2019
 10:04:29 +0800
From:   Wang Hai <wanghai26@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <wanghai26@huawei.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/events/amd/iommu: Make symbol 'amd_iommu_attr_groups' static
Date:   Wed, 8 May 2019 10:04:18 +0800
Message-ID: <20190508020418.19568-1-wanghai26@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

arch/x86/events/amd/iommu.c:396:30: warning:
 symbol 'amd_iommu_attr_groups' was not declared. Should it be static?

Fixes: 51686546304f (x86/events/amd/iommu: Fix sysfs perf attribute groups)
Signed-off-by: Wang Hai <wanghai26@huawei.com>
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 7635c23f7d82..58a6993d7eb3 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -393,7 +393,7 @@ static __init int _init_events_attrs(void)
 	return 0;
 }
 
-const struct attribute_group *amd_iommu_attr_groups[] = {
+static const struct attribute_group *amd_iommu_attr_groups[] = {
 	&amd_iommu_format_group,
 	&amd_iommu_cpumask_group,
 	&amd_iommu_events_group,
-- 
2.17.1


