Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF24C4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEED321848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZSSV8tHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfIRA7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:59:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfIRA7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wpI/zt/hBAR9DDKQ+nNWpBeYgf9n8v8wZcdgnsntg8M=; b=ZSSV8tHkaGTK27lHI2DVzMSlq
        8TgmMUg46bKI6EmylMqhw2o3nQlEyukEpSk2PGOEYJfDO6TTusb92njizYrXStmmXrciD/+0anAcI
        jy+j8ZtpMZ4+8qhvTG3vAcH4S4R3eAfJ7C2jeM5MX1TmlsmyYH4NiNzX+iHJ8XoPPZGskThUjSKo6
        ps/e4OPTkgL+JDX0CSOj8Hgi6TROxth1+rJ83k49yjjk8moaivP1SB3hUTQoE2NlIi+4UbP3/TvO/
        VlOXKY5ZjaHFcphX4eIj8f25jwc5DcKTB6LMFP8nVyCnP+oZXadtFL+E9UJ8SkHo9E+5cAMi0wBCS
        UFBqlbJGQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAOJ7-00009T-IY; Wed, 18 Sep 2019 00:58:57 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] misc: MIC: drop all 'comment' lines from its Kconfig
Message-ID: <3aa90a0f-1576-d38b-8382-6ed623ed5466@infradead.org>
Date:   Tue, 17 Sep 2019 17:58:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

The "comment" Kconfig lines for the Intel MIC drivers are
redundant, and nowhere else do we use this kind of Kconfig
style, so remove them.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mic/Kconfig |   16 ----------------
 1 file changed, 16 deletions(-)

--- lnx-53.orig/drivers/misc/mic/Kconfig
+++ lnx-53/drivers/misc/mic/Kconfig
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Intel MIC & related support"
 
-comment "Intel MIC Bus Driver"
-
 config INTEL_MIC_BUS
 	tristate "Intel MIC Bus Driver"
 	depends on 64BIT && PCI && X86
@@ -18,8 +16,6 @@ config INTEL_MIC_BUS
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
 
-comment "SCIF Bus Driver"
-
 config SCIF_BUS
 	tristate "SCIF Bus Driver"
 	depends on 64BIT && PCI && X86
@@ -35,8 +31,6 @@ config SCIF_BUS
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
 
-comment "VOP Bus Driver"
-
 config VOP_BUS
 	tristate "VOP Bus Driver"
 	help
@@ -51,8 +45,6 @@ config VOP_BUS
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
 
-comment "Intel MIC Host Driver"
-
 config INTEL_MIC_HOST
 	tristate "Intel MIC Host Driver"
 	depends on 64BIT && PCI && X86
@@ -71,8 +63,6 @@ config INTEL_MIC_HOST
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
 
-comment "Intel MIC Card Driver"
-
 config INTEL_MIC_CARD
 	tristate "Intel MIC Card Driver"
 	depends on 64BIT && X86
@@ -90,8 +80,6 @@ config INTEL_MIC_CARD
 	  For more information see
 	  <http://software.intel.com/en-us/mic-developer>.
 
-comment "SCIF Driver"
-
 config SCIF
 	tristate "SCIF Driver"
 	depends on 64BIT && PCI && X86 && SCIF_BUS && IOMMU_SUPPORT
@@ -110,8 +98,6 @@ config SCIF
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
 
-comment "Intel MIC Coprocessor State Management (COSM) Drivers"
-
 config MIC_COSM
 	tristate "Intel MIC Coprocessor State Management (COSM) Drivers"
 	depends on 64BIT && PCI && X86 && SCIF
@@ -128,8 +114,6 @@ config MIC_COSM
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
 
-comment "VOP Driver"
-
 config VOP
 	tristate "VOP Driver"
 	depends on VOP_BUS

