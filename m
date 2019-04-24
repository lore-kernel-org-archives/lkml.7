Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F56B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfDXWGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:06:41 -0400
Received: from anholt.net ([50.246.234.109]:41450 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731026AbfDXWGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:06:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 10DAC10A33B9;
        Wed, 24 Apr 2019 15:06:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DyRFna-OwtVM; Wed, 24 Apr 2019 15:06:39 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F33A210A33B6;
        Wed, 24 Apr 2019 15:06:38 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 71C232FE3AA9; Wed, 24 Apr 2019 15:06:38 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/2 v2] drm/doc: Allow new UAPI to be used once it's in drm-next/drm-misc-next.
Date:   Wed, 24 Apr 2019 15:06:38 -0700
Message-Id: <20190424220638.16222-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAPM=9tw59Z7FRM-7-_VChOO__1+ahNhSs6=AceV7biasHjWKqg@mail.gmail.com>
References: <CAPM=9tw59Z7FRM-7-_VChOO__1+ahNhSs6=AceV7biasHjWKqg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to figure out if it was permissible to merge the Mesa
side of V3D's CSD support yet while it's in drm-misc-next but not
drm-next, and developers on #dri-devel IRC had differing opinions of
what the requirement was.

v2: Restrict to just drm-next or drm-misc-next on airlied's request.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 Documentation/gpu/drm-uapi.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index c9fd23efd957..b7a96dc02d21 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -92,9 +92,9 @@ leads to a few additional requirements:
   requirements by doing a quick fork.
 
 - The kernel patch can only be merged after all the above requirements are met,
-  but it **must** be merged **before** the userspace patches land. uAPI always flows
-  from the kernel, doing things the other way round risks divergence of the uAPI
-  definitions and header files.
+  but it **must** be merged to either drm-next or drm-misc-next **before** the
+  userspace patches land. uAPI always flows from the kernel, doing things the
+  other way round risks divergence of the uAPI definitions and header files.
 
 These are fairly steep requirements, but have grown out from years of shared
 pain and experience with uAPI added hastily, and almost always regretted about
-- 
2.20.1

