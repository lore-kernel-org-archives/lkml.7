Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4497C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9592053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfEOLvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:51:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbfEOLUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:20:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0A139ED21B7C3B3FD36;
        Wed, 15 May 2019 19:20:53 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 May 2019 19:20:45 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <acme@kernel.org>, <acme@redhat.com>, <peterz@infradead.org>,
        <mingo@redhat.com>
CC:     <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <john.garry@huawei.com>,
        <wanghaibin.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] perf jevents: Remove unused variables
Date:   Wed, 15 May 2019 11:19:29 +0000
Message-ID: <1557919169-23972-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc warning:

pmu-events/jevents.c: In function ‘save_arch_std_events’:
pmu-events/jevents.c:417:15: warning: unused variable ‘sb’ [-Wunused-variable]
  struct stat *sb = data;
               ^~

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 68c92bb..92e60fd 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -414,7 +414,6 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *metric_name, char *metric_group)
 {
 	struct event_struct *es;
-	struct stat *sb = data;
 
 	es = malloc(sizeof(*es));
 	if (!es)
-- 
1.8.3.1


