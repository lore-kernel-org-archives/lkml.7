Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255CEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08AF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfDPOoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:44:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729694AbfDPOoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:44:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 896F2A5FF494A81594A5;
        Tue, 16 Apr 2019 22:44:11 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 22:44:02 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <yuq825@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <lima@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/lima: Make lima_sched_ops static
Date:   Tue, 16 Apr 2019 22:43:53 +0800
Message-ID: <20190416144353.34024-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/gpu/drm/lima/lima_sched.c:356:36: warning:
 symbol 'lima_sched_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 97bd9c1..569f0a95 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -353,7 +353,7 @@ static void lima_sched_free_job(struct drm_sched_job *job)
 	kmem_cache_free(pipe->task_slab, task);
 }
 
-const struct drm_sched_backend_ops lima_sched_ops = {
+static const struct drm_sched_backend_ops lima_sched_ops = {
 	.dependency = lima_sched_dependency,
 	.run_job = lima_sched_run_job,
 	.timedout_job = lima_sched_timedout_job,
-- 
2.7.4


