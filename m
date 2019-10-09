Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38777ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F6F20673
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfJIJi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:38:58 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50741 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:38:58 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iI8Qm-00017c-3X; Wed, 09 Oct 2019 10:38:52 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iI8Ql-0002KY-Ng; Wed, 09 Oct 2019 10:38:51 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, airlied@linux.ie, sean@poorly.run,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] drm/fb-helper: include drm/drm_fb_cma_helper.h for missing declarations
Date:   Wed,  9 Oct 2019 10:38:49 +0100
Message-Id: <20191009093850.8911-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <drm/drm_fb_cma_helper.h> to fix the following warnings
from missing declarations:

drivers/gpu/drm/drm_fb_cma_helper.c:38:27: warning: symbol 'drm_fb_cma_get_gem_obj' was not declared. Should it be static?
drivers/gpu/drm/drm_fb_cma_helper.c:62:12: warning: symbol 'drm_fb_cma_get_gem_addr' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/drm_fb_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index a7ba5b4902d6..23e10075619f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -45,6 +45,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_fb_cma_helper.h>
 
 #include "drm_internal.h"
 
-- 
2.23.0

