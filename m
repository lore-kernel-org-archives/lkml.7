Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C37C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A9206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLPK24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:28:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfLPK2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:28:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9BD0E8B3E9572B3C1E39;
        Mon, 16 Dec 2019 18:28:53 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 18:28:45 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <sean@poorly.run>, <zhongjiang@huawei.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/udl: make the symbol 'udl_handle_damage' static
Date:   Mon, 16 Dec 2019 18:24:23 +0800
Message-ID: <1576491863-19009-1-git-send-email-zhongjiang@huawei.com>
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

drivers/gpu/drm/udl/udl_modeset.c:269:5: warning: symbol 'udl_handle_damage' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/udl/udl_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 22af179..82e0927 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -266,7 +266,7 @@ static int udl_aligned_damage_clip(struct drm_rect *clip, int x, int y,
 	return 0;
 }
 
-int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
+static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 		      int width, int height)
 {
 	struct drm_device *dev = fb->dev;
-- 
1.7.12.4

