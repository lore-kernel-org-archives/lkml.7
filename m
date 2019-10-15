Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9288218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfJOOFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:05:33 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49166 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732329AbfJOOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:05:33 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKNRx-00048s-07; Tue, 15 Oct 2019 15:05:21 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKNRw-00052K-IV; Tue, 15 Oct 2019 15:05:20 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: include <drm/drm_fb_cma_helper.h> for missing declarations
Date:   Tue, 15 Oct 2019 15:05:19 +0100
Message-Id: <20191015140519.19317-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <drm/drm_fb_cma_helper.h> to get the definitions of
drm_fb_cma_get_gem_{addr,obj} functions to fix the following
sparse warnings:

drivers/gpu/drm/drm_fb_cma_helper.c:38:27: warning: symbol 'drm_fb_cma_get_gem_obj' was not declared. Should it be static?
drivers/gpu/drm/drm_fb_cma_helper.c:62:12: warning: symbol 'drm_fb_cma_get_gem_addr' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/drm_fb_cma_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index c0b0f603af63..f4967cf14f99 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -11,6 +11,7 @@
 
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane.h>
-- 
2.23.0

