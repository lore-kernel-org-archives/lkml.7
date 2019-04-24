Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821FFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2CA208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfDXS4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:56:21 -0400
Received: from anholt.net ([50.246.234.109]:40290 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfDXS4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:56:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DC17D10A33B8;
        Wed, 24 Apr 2019 11:56:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id LCYYf37ZcQIM; Wed, 24 Apr 2019 11:56:17 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CE40910A3399;
        Wed, 24 Apr 2019 11:56:17 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 3F1812FE3AA5; Wed, 24 Apr 2019 11:56:17 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/2] drm/doc: Document expectation that userspace review looks at kernel uAPI.
Date:   Wed, 24 Apr 2019 11:56:17 -0700
Message-Id: <20190424185617.16865-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424185617.16865-1-eric@anholt.net>
References: <20190424185617.16865-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The point of this review process is that userspace using the new uAPI
can actually live with the uAPI being provided, and it's hard to know
that without having actually looked into a kernel patch yourself.

Signed-off-by: Eric Anholt <eric@anholt.net>
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 Documentation/gpu/drm-uapi.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 8e5545dfbf82..298424b98d99 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -85,7 +85,9 @@ leads to a few additional requirements:
 - The userspace side must be fully reviewed and tested to the standards of that
   userspace project. For e.g. mesa this means piglit testcases and review on the
   mailing list. This is again to ensure that the new interface actually gets the
-  job done.
+  job done.  The userspace-side reviewer should also provide at least an
+  Acked-by on the kernel uAPI patch indicating that they've looked at how the
+  kernel side is implementing the new feature being used.
 
 - The userspace patches must be against the canonical upstream, not some vendor
   fork. This is to make sure that no one cheats on the review and testing
-- 
2.20.1

