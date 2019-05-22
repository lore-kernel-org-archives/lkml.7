Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EFBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15AA20821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfEVUvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:51:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:49324 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbfEVUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:59 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id B83CA130D;
        Wed, 22 May 2019 20:50:58 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/8] docs/gpu: fix a documentation build break in i915.rst
Date:   Wed, 22 May 2019 14:50:32 -0600
Message-Id: <20190522205034.25724-7-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/gpu/i915.rst is not included in the TOC tree, but newer
versions of sphinx parse it anyway.  That leads to this hard build failure:

> Global GTT Fence Handling
> ~~~~~~~~~~~~~~~~~~~~~~~~~
>
> reST markup error:
> /stuff/k/git/kernel/Documentation/gpu/i915.rst:403: (SEVERE/4) Title level inconsistent:

Make the underlining consistent and restore a working docs build.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/gpu/i915.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 055df45596c1..cf9ff64753cc 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -401,13 +401,13 @@ GTT Fences and Swizzling
    :internal:
 
 Global GTT Fence Handling
-~~~~~~~~~~~~~~~~~~~~~~~~~
+-------------------------
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_gem_fence_reg.c
    :doc: fence register handling
 
 Hardware Tiling and Swizzling Details
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-------------------------------------
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_gem_fence_reg.c
    :doc: tiling swizzling details
-- 
2.21.0

