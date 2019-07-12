Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF1CC742B1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8B02064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGLJld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:41:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfGLJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:41:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDy9C-1heCYe1wgO-00A0cZ; Fri, 12 Jul 2019 11:41:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/amdgpu: hide #warning for missing DC config
Date:   Fri, 12 Jul 2019 11:40:49 +0200
Message-Id: <20190712094118.1559434-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ttmzMtAGFGv3mR5H495wgmiwrDzBZya2VZW2Xzjw9gDc0C+MN53
 5UB0PXB44DnG+8HS0DE9WF9L/shoFZYhub56pMwP4rt06cG75xyeDrvTK/GtGzEPDV7u+K3
 xNqZcPP9uY+gVpnbPafE4oEfbDJ1k/Mn+EIwxpnjBhdF6t5p9jYAqlpVDXdWtxytRR43xo7
 Ddm6kup5fX/5TnKSwk6/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7sYK4wnPxhY=:GhHlrFRq70LCK1koeRxlA4
 +PuyZDl1N8PyHeDbmmjhQiTm+D5xuSBzeN8Z3Yui90ycSTtMNoWJlEO2UPjfSL5o4HXLeAU9+
 UZw8b2wlDWDUUJ+MXiuy9/rI2igr36QvP+h716zOp4zBODU0SSe0xdJQWXTLa6SngXUiMpT9A
 Ljhnoea/IcX0ty482kc5OyxlKt7SkL3wAmy52VaGEbT66vK3ooVJYrz59zHHd6jWoah9BhrRi
 uK+RrlEF5hd8X3WJxC0ZJipTGuqyNZdwlOGWWMreXC4X4TWdgFPVZjCVYh4RIP3b90hK6Nlmh
 fBV5Rx+tPp2Y8iWbvF6pgo9NWhwuqQy14+RGNXTHIsVFHTPG51gYgJ/u3jLBFPDanY2KTFfIG
 UVGg6LnF7/P1ShA8Z1fr4nbQh/PhmcEeOWLbqRnFHyyAeLIGM8czEjfWGrWJaKLT01NWG6//i
 WY8T1InyTTiCLyCw7q/Alubp0S4EcVHFOyVapZm+aSAcVrROTh1XtsoNXoq5T567gFk+qMJzV
 tBr2Z4jPQcfKY6qXalZqFm9dYAtflVzsQmk0b3Jv0Ov4Ly7tApkaf7+DQVu11NrJAPO14wEUk
 IzQVkrzY70RfovcShLm/R+DZnm2U2NeDZpKkAFZA3JqdVUtWWUY/rXbWYemgXU2dL6WKx520H
 DDjc6ms+z7DXRhk7bQASWB2Rro17RbsIwMDTnkwaOl7/pGYOPiEtxchSyu1Qgtyl/o7mGtZEC
 BH4yrhvZU7hwtKrgyUc+6hmh+wm65DU/XDF72w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is annoying to have #warnings that trigger in randconfig
builds like

drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: "Enable CONFIG_DRM_AMD_DC for display support on navi."

Remove these and rely on the users to turn these on.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9253c03d387a..10ec0e81ee58 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -396,8 +396,6 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#else
-#	warning "Enable CONFIG_DRM_AMD_DC for display support on navi."
 #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 87152d8ef0df..90fb0149fbea 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -649,8 +649,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#else
-#	warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
 #endif
 		if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev))) {
 			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
@@ -671,8 +669,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#else
-#	warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
 #endif
 		amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
 		break;
-- 
2.20.0

