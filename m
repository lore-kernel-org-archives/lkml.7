Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62EEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE522251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfKTMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:54:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728470AbfKTMyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:54:21 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F512BC4B6B6A5AB39FE;
        Wed, 20 Nov 2019 20:54:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 20:54:11 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
        <luben.tuikov@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 1/2] drm/amd/display: remove set but not used variable 'dc_fixpt_e' and 'dc_fixpt_pi'
Date:   Wed, 20 Nov 2019 21:15:32 +0800
Message-ID: <20191120131533.12720-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191120131533.12720-1-yukuai3@huawei.com>
References: <20191120131533.12720-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dc_fixpt_e' and 'dc_fixpt_pi' are set in 'fixed31_32.h'. However, they
are never used and so can be removed.

Fixes: eb0e515464e4 ("drm/amd/display: get rid of 32.32 unsigned fixed point")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/display/include/fixed31_32.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 89ef9f6860e5..291215362e3f 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -69,9 +69,7 @@ static const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
 static const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
 static const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
 
-static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
 static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
-static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
 static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
 static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
 
-- 
2.17.2

