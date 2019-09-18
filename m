Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5887FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302842242D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfIRTyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:54:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfIRTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:54:32 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MdeSn-1hbcGC3xB3-00ZgA4; Wed, 18 Sep 2019 21:54:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dingchen Zhang <dingchen.zhang@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: hide an unused variable
Date:   Wed, 18 Sep 2019 21:53:58 +0200
Message-Id: <20190918195418.2042610-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e6RffvOmDj1nBJMeY+rrjixyu4FDdjpSMSkcA7dDa86QdgX8VAy
 vXJqdQHJ2VyuGNpIZmusNm/tmO6LSPOHGvbK29dNEXgwRjzOWBgH3zzgBys0a78d4gFJvgo
 po/+E1JWRhHgORmC1rtGZTv2ShsBdo79xTDlO7Eo10j0iqPbRuIQyj+h2JOyNBiQ1YeSiXh
 LEyb/3BeWh7FWoIm+goxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SHiyb5ey+ic=:V8Ia1QvLm+87GxeewHaNIj
 +MQq8F2/vjHgW/LvBnX+bhxFxBSm4ML23WPlTYZ0wjJB1nIdj1VkZ0LTPaIgMCdDygijEKJmJ
 CLTRQ/9/A4fdswCadvZxgZVt38EeaHzpNJ/AnGsWJ7hSgB6qnqhXOZVxknwraLTdxbt65Ec9e
 mEdMKNYWaRiD3FisIkIq/8n8NlMTcJwRBdqJGTZDcqKQyZzVtdsdAay8FTq3IPMvyy9KHXm4V
 EVzTuO2vv+5jQHw4HMfICR9cdfGrfHzjAD9MmiiI8ZNvtHHfWw3qyhluD2f99sGP8AkxHx+6N
 FrBdNc0APae8lL9NbzPNZ752lVbZlDM5EZHCt8HLhB9TRbMtB/EMJc+37GhkZx0PQ3eZBqgUg
 blPHdXp2XrbYBkuBJ40E/KJY1End+dyZtDT9HxCxazHooVlQfE18+RFSrtsV6psQ5XDvJq6aZ
 eWDNopJAleGAhBWPw+cLhRwo1fBxC5UvpAL3D3x6fuCW/nKQaatIEc/B2pAmZ04MI6KxYgGbi
 LR6nmsfDosZobbLs3rrupbrYoXkoGi/lhtAVuIbZmgvqVhAmmr3Fi6v7IKaB2cbdHRdwhI+1u
 kfmlfOnQ/i5aK3GkNrwIJRMymQI3N5LYg1TL8DoquPj34rGvs3dZkdgSwp0n2ufKiYP0qgrqE
 N37X5BrJ4OPDim6fEiwKDnPX6DJxzeQjWp2tJoIR3Kmb/xK3o1cZer+q3b1JZHEnDO0r9gmUE
 Fb9dWjayXMttGo7QBlt7rfkpZ7Rv/b/JFwxP42F0f8GTrYtTQ56kAQ4czEeIU6hQBIoG9tYIE
 /tzOM9tFEfF88iR558bdS8BwGR5e7jslFmDy/Fq6f2DasJMIS0GYKdWUQlnv4CszXzYehBDCE
 D26Smq1Ru9yEUHCzXu/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_DEBUG_FS, we get a warning for an unused
variable:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6020:33: error: unused variable 'source' [-Werror,-Wunused-variable]

Hide the variable in an #ifdef like its only users.

Fixes: 14b2584636c6 ("drm/amd/display: add functionality to grab DPRX CRC entries.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1b09bb432bd..74252f57bafb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6017,7 +6017,9 @@ static void amdgpu_dm_enable_crtc_interrupts(struct drm_device *dev,
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

