Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124FAC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58CE2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbfJCTJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:09:39 -0400
Received: from ms.lwn.net ([45.79.88.28]:33710 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732733AbfJCTJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:09:31 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 5A7077C0;
        Thu,  3 Oct 2019 19:09:30 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: move botching-up-ioctls.rst to the process guide
Date:   Thu,  3 Oct 2019 13:09:20 -0600
Message-Id: <20191003190921.5141-2-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191003190921.5141-1-corbet@lwn.net>
References: <20191003190921.5141-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is overall information for kernel developers, and not part of the
user-space API.

Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/ioctl/index.rst                           | 1 -
 Documentation/{ioctl => process}/botching-up-ioctls.rst | 0
 Documentation/process/index.rst                         | 1 +
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ioctl => process}/botching-up-ioctls.rst (100%)

diff --git a/Documentation/ioctl/index.rst b/Documentation/ioctl/index.rst
index 0f0a857f6615..475675eae086 100644
--- a/Documentation/ioctl/index.rst
+++ b/Documentation/ioctl/index.rst
@@ -9,7 +9,6 @@ IOCTLs
 
    ioctl-number
 
-   botching-up-ioctls
    ioctl-decoding
 
    cdrom
diff --git a/Documentation/ioctl/botching-up-ioctls.rst b/Documentation/process/botching-up-ioctls.rst
similarity index 100%
rename from Documentation/ioctl/botching-up-ioctls.rst
rename to Documentation/process/botching-up-ioctls.rst
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index e2c9ffc682c5..e2c2cdaa93fa 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -57,6 +57,7 @@ lack of a better place.
    adding-syscalls
    magic-number
    volatile-considered-harmful
+   botching-up-ioctls
    clang-format
 
 .. only::  subproject and html
-- 
2.21.0

