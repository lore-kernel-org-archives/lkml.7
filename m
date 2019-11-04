Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720BFCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2021D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfKDNUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:20:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfKDNUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:20:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85936DDBF7F52DD8DC5E;
        Mon,  4 Nov 2019 21:20:09 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 21:20:03 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
        <luben.tuikov@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 2/7] drm/amdgpu: add function parameter description in 'amdgpu_device_set_cg_state'
Date:   Mon, 4 Nov 2019 21:27:21 +0800
Message-ID: <1572874046-30996-3-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1954: warning: Function
parameter or member 'state' not described in 'amdgpu_device_set_cg_state'

Fixes: e3ecdffac9cc ("drm/amdgpu: add documentation for amdgpu_device.c")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b4fb6d8..26c43e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1941,6 +1941,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
  * amdgpu_device_set_cg_state - set clockgating for amdgpu device
  *
  * @adev: amdgpu_device pointer
+ * @state: clockgating state (gate or ungate)
  *
  * The list of all the hardware IPs that make up the asic is walked and the
  * set_clockgating_state callbacks are run.
-- 
2.7.4

