Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65590C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A0C20673
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJIJjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:39:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50743 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfJIJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:38:59 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iI8Qm-00017g-NT; Wed, 09 Oct 2019 10:38:52 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iI8Qm-0002Kb-9t; Wed, 09 Oct 2019 10:38:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, airlied@linux.ie, sean@poorly.run,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/2] drm/fb-helper: include drm_crtc_helper_internal.h for drm_fb_helper_modinit
Date:   Wed,  9 Oct 2019 10:38:50 +0100
Message-Id: <20191009093850.8911-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009093850.8911-1-ben.dooks@codethink.co.uk>
References: <20191009093850.8911-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include drm_crtc_helper_internal.h for drm_fb_helper_modinit
definition to fix the following warning:

drivers/gpu/drm/drm_fb_helper.c:2410:12: warning: symbol 'drm_fb_helper_modinit' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/drm_fb_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 23e10075619f..f1359e3e676c 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -48,6 +48,7 @@
 #include <drm/drm_fb_cma_helper.h>
 
 #include "drm_internal.h"
+#include "drm_crtc_helper_internal.h"
 
 static bool drm_fbdev_emulation = true;
 module_param_named(fbdev_emulation, drm_fbdev_emulation, bool, 0600);
-- 
2.23.0

