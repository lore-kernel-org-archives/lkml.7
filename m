Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DD5C4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A1020896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404158AbfFKNky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:40:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403885AbfFKNky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:40:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D4B7443CC9D69D440122;
        Tue, 11 Jun 2019 21:40:50 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 21:40:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ima: Make arch_policy_entry static
Date:   Tue, 11 Jun 2019 21:40:32 +0800
Message-ID: <20190611134032.14656-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

security/integrity/ima/ima_policy.c:202:23: warning:
 symbol 'arch_policy_entry' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1cc822a..cd1b728 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -199,7 +199,7 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 };
 
 /* An array of architecture specific rules */
-struct ima_rule_entry *arch_policy_entry __ro_after_init;
+static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
-- 
2.7.4


