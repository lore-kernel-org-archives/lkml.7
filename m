Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F37C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC66F214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725047;
	bh=kf1GOI6foCeZoUlqcpX+tJ7TBpZADn5a2nmES3LCPp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KaGmaDIUzsC4Rd9YdEA9WLGphNUNe2me98tmMn6Qo7HHlSZgaGjhgCPAwhRgNVoOA
	 Gq8iU65VkpGf+VRDgnzWCc+15xJTeyoGLpgNJHDAiwzAMv/2Th8z7Go8kLuX7w18aG
	 /YKFCbdTtZYrTaqtu42yt0XR/eD1waucwPoXQVqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfF1Maq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:30:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfF1Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zII5lYqfAV6Dv/1vdlGrUpmQd0t8s5Xk0MQllo77src=; b=QMdyrqAceSryUV22cBi3MRrTgt
        3cFDKnoqsJ5dHJh9LoMDSwmwT3M6ZflEnYx+Hcerg4s1juteOOYv8V4X/nmVlQzRWxkSxtuWtySO7
        T4Fc9UJjN2gm7TRcJBz1RrjQF7iWirHg8uS3tEifEoPeg/EJ4RM8vzS3FA+/9CZKNuIIPSj9mUsMT
        3zkMBVtI2JsY3zbv2Dil0fejPzMpK00lIZrp18xYuOIGLFSn4Gx71h+FGtzFTXeICc/nSFaGSSwGt
        8bLpBSi33Q4C0ZuEdeiOXtGJbVD7yj8SPlR4M1CUcyH9MndxlG39MUsT13gZk6Ij1ItJn01gEY9So
        lEnWQTbQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055V-Jj; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Sg-Gl; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/39] docs: ocxl.rst: add it to the uAPI book
Date:   Fri, 28 Jun 2019 09:30:15 -0300
Message-Id: <ee63ec4412f2f8c87da877f67f693f2cd85c1a37.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The content of this file is user-faced.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/{ => userspace-api}/accelerators/ocxl.rst | 2 --
 Documentation/userspace-api/index.rst                   | 1 +
 MAINTAINERS                                             | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename Documentation/{ => userspace-api}/accelerators/ocxl.rst (99%)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/userspace-api/accelerators/ocxl.rst
similarity index 99%
rename from Documentation/accelerators/ocxl.rst
rename to Documentation/userspace-api/accelerators/ocxl.rst
index b1cea19a90f5..14cefc020e2d 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/userspace-api/accelerators/ocxl.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ========================================================
 OpenCAPI (Open Coherent Accelerator Processor Interface)
 ========================================================
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index a3233da7fa88..ad494da40009 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -20,6 +20,7 @@ place where this information is gathered.
    seccomp_filter
    unshare
    spec_ctrl
+   accelerators/ocxl
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 29d1498ad39d..f723371dccd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11483,7 +11483,7 @@ F:	arch/powerpc/include/asm/pnv-ocxl.h
 F:	drivers/misc/ocxl/
 F:	include/misc/ocxl*
 F:	include/uapi/misc/ocxl.h
-F:	Documentation/accelerators/ocxl.rst
+F:	Documentation/userspace-api/accelerators/ocxl.rst
 
 OMAP AUDIO SUPPORT
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
-- 
2.21.0

