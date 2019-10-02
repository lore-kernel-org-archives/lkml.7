Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93345C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725C021929
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfJBMDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:03:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJBMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:03:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1Ofr-1i9piT0TlL-012rXj; Wed, 02 Oct 2019 14:03:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dingchen Zhang <dingchen.zhang@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: [PATCH 5/6] [RESEND] drm/amd/display: hide an unused variable
Date:   Wed,  2 Oct 2019 14:01:26 +0200
Message-Id: <20191002120136.1777161-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1n5M6zZR4G8yBL9D3/PPSqfSjJLO9/wJ7CFXKkY1GhO9dfbJMYH
 BiSgOyk4TECZnA3BSyAneDEqnYgbFD97WeiIo4lGIG8gXruAgbG+OFz8JrMXpu4H9o9caks
 Np/4Fh8LpTmpmV6Xp3jiphnuOB/fVWxp/AAMAajPUx40WWakIcnYsfRjRKmzW5r6zab6tVy
 JE6I3T9syZxzU4/jUrblQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:naTv7zcdLbg=:K0DiYgcUAFUIvZNSJLnPhF
 TR8ONd0H5vlFNo9s+S173Y0i1yWRmEuEcfuiUtbDNfeQhxSN4qbsGQHKYowzOslPG4Xwm7iHh
 gLASVPq3d4YTmFVY590C6iuhoOJzAB5eYIIgr05Gqlx7CR668I669LA90dj/iyUKfUnzDrJar
 LZnab4p+nt4C4PfV897q0HFaPFLgvb4CmfyFymF3TvMXJiRpUBZ/RyI74KSi8LbvKSGujvfCO
 1XxJ7oH1mtw+Uf/jeyTxbL3aLzXfCQ+Q+eywDgTgJeZe3/r0Lz/5jR1N81AhAsov/jhUCgVo6
 G0CACRv6k5HfVXr+LnzU0RVPue/t4oSmm85X4QRjO0ycxRun1YW6GPKbjEwl6yUGrTUgmes5M
 CgZ0b57xUI4cr2Wlaqz5XI8wYnCPRsRr0gepZx+7vQWrBsqUQTgE5ON7U//qfRVQq1V1NIXk7
 WjCYrftUGzz3p28lAANIFZ4BngPJZ4u+GXqo4gKtFnoZvSgr21XuTwMH/A485jWmMFBJ4DaRh
 ukxFYBiYyuPHV2Tl6J1cZGw5HUNurtA9UsNc8Q74rboxhdw2enud8CsC9XRY7kGZA2msxsqPv
 H0gce7q61WH6+lviiLyAo1pFAzVRqZtO6m/awVb2gVLoqKkPV+MmqwTdK9A9eDVNGRzbb7/MH
 lK67JYsSZffsn0qHPiBDie2qQ8aZn+wGUas5aQQTxxx2XT67KtbTtz63FbJ13tyJMgyRViIR8
 YwFfXd6rCOs4ZuKJxz0nSW1QHEgR65YGVuNpb2rKl85o8Drf2xLESyWNx0lD6BXPq3KRSGCgQ
 O9STRSdwbZkJFO0E3wLP734Wopq5REw03eGLVciu1Uh0Xt3UtA0Fx7J17HWcsDzq/AWzmSv7N
 fu42zs35kwyPfqf/bz9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_DEBUG_FS, we get a warning for an unused
variable:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6020:33: error: unused variable 'source' [-Werror,-Wunused-variable]

Hide the variable in an #ifdef like its only users.

Fixes: 14b2584636c6 ("drm/amd/display: add functionality to grab DPRX CRC entries.")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This was a bugfix for a commit that landed in v5.4-rc1. The
fix was applied by Alex Deucher on Sep 19, but is still not
seen in linux-next.
Resending to make sure this makes it into v5.4-final, but
please ignore if this is already coming.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cab6da512a0..7516a6436822 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6019,7 +6019,9 @@ static void amdgpu_dm_enable_crtc_interrupts(struct drm_device *dev,
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	int i;
+#ifdef CONFIG_DEBUG_FS
 	enum amdgpu_dm_pipe_crc_source source;
+#endif
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
 				      new_crtc_state, i) {
-- 
2.20.0

