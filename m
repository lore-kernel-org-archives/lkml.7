Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24FEC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFF1206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfECQzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:55:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48971 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfECQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:55:41 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1hMbTG-0007oH-Gq
        for linux-kernel@vger.kernel.org; Fri, 03 May 2019 16:55:38 +0000
Received: by mail-wr1-f71.google.com with SMTP id z7so5263888wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 09:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v4PB/KtJcj+jKsWtMsEZdsEqYpm/3dtqF+jc9qu4DtM=;
        b=eQF2timhhyfSdORa82UuYTS131sVUbrlJgPH+kLMzKe5hghmNQVJKjcU0CQi/Vpsp2
         L4v+kGxL4alPJ+rRokthIHfO7epYR4EEfv+68A/OHS3Z87jEeGGoPaNzugczqYIW6fr/
         cxxnptbdL+2dbOXf/P6a5/9PcaJvhv0iyYuJs4/XDZBiPsGaVnvsw3lmFIP2bxxjlOAm
         3KHtID1ppS69Ogn20Ndnme9KhmsUgeLUFMzgTncdze2KQ1zYc3JlBEslljAS5PSGhHU9
         xt00iBTWccbQLeHjc7WbyUDjl/gBZDGHy5yWvkfs3aRMPZSi2j1F/wAa6b40DlyW83Dl
         K7Uw==
X-Gm-Message-State: APjAAAUiYRghfJUsx3cQOcCWODjFl5f4xdSl4El3lQTmSEW/70m3hJNf
        4Sjl263rYKVVqiz46mr4mV1wMALUyJT70QiQr4fR9fb2d3NLL4QgFdheduJ2u/+bWFozAkOwQgg
        6LbcvACkeyPzjU51GTJPo0830KWIKZA1CIZ+3/Z9AgA==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr7038471wma.147.1556902537637;
        Fri, 03 May 2019 09:55:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1hZPUfBF839e9/ajKvR7uUiiGy0H+zfXnNTReDtbv/nwRnFlaRLq+sseA7vIDfEU3Jz+7Tw==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr7038460wma.147.1556902537442;
        Fri, 03 May 2019 09:55:37 -0700 (PDT)
Received: from localhost (host28-131-dynamic.22-79-r.retail.telecomitalia.it. [79.22.131.28])
        by smtp.gmail.com with ESMTPSA id h131sm4571434wmh.44.2019.05.03.09.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 09:55:36 -0700 (PDT)
Date:   Fri, 3 May 2019 18:55:35 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, hersen wu <hersenxs.wu@amd.com>,
        Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: remove spurious semicolon
Message-ID: <20190503165535.GA30964@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary semicolons at the end of line.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c         | 8 ++++----
 drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 3f73f7cd18b9..1052f5119087 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1304,7 +1304,7 @@ static int pp_notify_smu_enable_pwe(void *handle)
 
 	if (hwmgr->hwmgr_func->smus_notify_pwe == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return -EINVAL;;
+		return -EINVAL;
 	}
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -1341,7 +1341,7 @@ static int pp_set_min_deep_sleep_dcefclk(void *handle, uint32_t clock)
 
 	if (hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk == NULL) {
 		pr_debug("%s was not implemented.\n", __func__);
-		return -EINVAL;;
+		return -EINVAL;
 	}
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -1360,7 +1360,7 @@ static int pp_set_hard_min_dcefclk_by_freq(void *handle, uint32_t clock)
 
 	if (hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq == NULL) {
 		pr_debug("%s was not implemented.\n", __func__);
-		return -EINVAL;;
+		return -EINVAL;
 	}
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -1379,7 +1379,7 @@ static int pp_set_hard_min_fclk_by_freq(void *handle, uint32_t clock)
 
 	if (hwmgr->hwmgr_func->set_hard_min_fclk_by_freq == NULL) {
 		pr_debug("%s was not implemented.\n", __func__);
-		return -EINVAL;;
+		return -EINVAL;
 	}
 
 	mutex_lock(&hwmgr->smu_lock);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index c1c51c115e57..70f7f47a2fcf 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -76,7 +76,7 @@ int phm_set_power_state(struct pp_hwmgr *hwmgr,
 int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = NULL;
-	int ret = -EINVAL;;
+	int ret = -EINVAL;
 	PHM_FUNC_CHECK(hwmgr);
 	adev = hwmgr->adev;
 
-- 
2.20.1

