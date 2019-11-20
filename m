Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91092C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C70224DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257111;
	bh=uTjDaWFJYh6hi5k79CP31dyZfxkghCwHxEwUNKSa3Uk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2WQ3KBOAFmFFw/ql9BSSkyetJyr7wHyFSvWcwmVRIlP2+kmZYGkhP+uVeCQ9MneuH
	 v99xLLphOn1RqqqVNw1y+NioJ+/xeMDfJV3K49X8VgdGgkb8JRa8qvbYOR/skOkBCg
	 Ehyzx5PNOAhwRnipVqLCbc+3ML0p69WXoV0AW9CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfKTNia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfKTNi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:26 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E2CA2252E;
        Wed, 20 Nov 2019 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257106;
        bh=uTjDaWFJYh6hi5k79CP31dyZfxkghCwHxEwUNKSa3Uk=;
        h=From:To:Cc:Subject:Date:From;
        b=iIAWTsICtE2jOMyxoINtE81zTJeetE0xdx7tVc3xTNWkqXBbATs7z0MInC/0/U3XO
         AvDejgMwdjDzfwjdw9aWX28ZXsFqR0sFGdsUQQMuFIU+qYjDQMx3Rhr+nfJNBvBd8M
         XxhqOAlxz9A16g1tx2A/oqe5smvPzNnaUDdkylmw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] xen: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:22 +0800
Message-Id: <20191120133822.12909-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/xen/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b71f1ad1013c..cba949c0f8b3 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -110,12 +110,12 @@ config XEN_COMPAT_XENFS
        depends on XENFS
        default y
        help
-         The old xenstore userspace tools expect to find "xenbus"
-         under /proc/xen, but "xenbus" is now found at the root of the
-         xenfs filesystem.  Selecting this causes the kernel to create
-         the compatibility mount point /proc/xen if it is running on
-         a xen platform.
-         If in doubt, say yes.
+	 The old xenstore userspace tools expect to find "xenbus"
+	 under /proc/xen, but "xenbus" is now found at the root of the
+	 xenfs filesystem.  Selecting this causes the kernel to create
+	 the compatibility mount point /proc/xen if it is running on
+	 a xen platform.
+	 If in doubt, say yes.
 
 config XEN_SYS_HYPERVISOR
        bool "Create xen entries under /sys/hypervisor"
@@ -123,7 +123,7 @@ config XEN_SYS_HYPERVISOR
        select SYS_HYPERVISOR
        default y
        help
-         Create entries under /sys/hypervisor describing the Xen
+	 Create entries under /sys/hypervisor describing the Xen
 	 hypervisor environment.  When running native or in another
 	 virtual environment, /sys/hypervisor will still be present,
 	 but will have no xen contents.
@@ -271,7 +271,7 @@ config XEN_ACPI_PROCESSOR
 	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
-          This ACPI processor uploads Power Management information to the Xen
+	  This ACPI processor uploads Power Management information to the Xen
 	  hypervisor.
 
 	  To do that the driver parses the Power Management data and uploads
@@ -280,7 +280,7 @@ config XEN_ACPI_PROCESSOR
 	  SMM so that other drivers (such as ACPI cpufreq scaling driver) will
 	  not load.
 
-          To compile this driver as a module, choose M here: the module will be
+	  To compile this driver as a module, choose M here: the module will be
 	  called xen_acpi_processor  If you do not know what to choose, select
 	  M here. If the CPUFREQ drivers are built in, select Y here.
 
@@ -313,8 +313,8 @@ config XEN_SYMS
        depends on X86 && XEN_DOM0 && XENFS
        default y if KALLSYMS
        help
-          Exports hypervisor symbols (along with their types and addresses) via
-          /proc/xen/xensyms file, similar to /proc/kallsyms
+	  Exports hypervisor symbols (along with their types and addresses) via
+	  /proc/xen/xensyms file, similar to /proc/kallsyms
 
 config XEN_HAVE_VPMU
        bool
-- 
2.17.1

