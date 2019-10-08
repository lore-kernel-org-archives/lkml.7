Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CBCC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C966F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJHLHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:07:44 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51057 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:07:44 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iHnLC-0006Y6-HO; Tue, 08 Oct 2019 12:07:42 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iHnLB-0003ag-Pb; Tue, 08 Oct 2019 12:07:41 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/3] drm/nouveau/kms/nv50-: make base917c_format static
Date:   Tue,  8 Oct 2019 12:07:37 +0100
Message-Id: <20191008110739.13757-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The base917c_format isn't exported, so make it static to
avoid the following warning:

drivers/gpu/drm/nouveau/dispnv50/base917c.c:26:1: warning: symbol 'base917c_format' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/nouveau/dispnv50/base917c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/base917c.c b/drivers/gpu/drm/nouveau/dispnv50/base917c.c
index a1baed4fe0e9..ca260509a4f1 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/base917c.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/base917c.c
@@ -22,7 +22,7 @@
 #include "base.h"
 #include "atom.h"
 
-const u32
+static const u32
 base917c_format[] = {
 	DRM_FORMAT_C8,
 	DRM_FORMAT_XRGB8888,
-- 
2.23.0

