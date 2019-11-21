Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1809208CE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306424;
	bh=srdnebtzKEySU4A3SaqY8Gx5DAif6RUKvhzFQiZMlcs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1oShjjg2uIquXFK5KFcZ8VO36S6+Vay1Ph9mmGwenv+QDNSFBqefibGBQp7f60upA
	 0NALOBJ87hF0jyJ/h+BWOS4xaH8U6dttdAHULFprzpinSbNzgDaYTuYQDFHbwNmRmE
	 qqWV1yFwOp4gqt2qLtE0u4h99sX/V4369ouMe+Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKUDUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfKUDUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:20 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6368E20898;
        Thu, 21 Nov 2019 03:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306419;
        bh=srdnebtzKEySU4A3SaqY8Gx5DAif6RUKvhzFQiZMlcs=;
        h=From:To:Cc:Subject:Date:From;
        b=XaRPg600K2NA2y/DWZ4j1LaK5aD/YKEdc8VsvJltNeMoWhiYIcKWiUoZICn8gYZxN
         2LOd0hq9jZLk8fuUA8Ez5mpsAaVsqcmqY5hG70EfWw60uTZ3vJrNHiSgoantCz/ONT
         uJxm6vLBSvzVuZ+rVfSxWXAnsrpveQTOt23kWc/M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2] xen: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:16 +0100
Message-Id: <1574306416-22882-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/xen/Kconfig | 58 ++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b71f1ad1013c..61212fc7f0c7 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -106,27 +106,27 @@ config XENFS
 	  If in doubt, say yes.
 
 config XEN_COMPAT_XENFS
-       bool "Create compatibility mount point /proc/xen"
-       depends on XENFS
-       default y
-       help
-         The old xenstore userspace tools expect to find "xenbus"
-         under /proc/xen, but "xenbus" is now found at the root of the
-         xenfs filesystem.  Selecting this causes the kernel to create
-         the compatibility mount point /proc/xen if it is running on
-         a xen platform.
-         If in doubt, say yes.
+	bool "Create compatibility mount point /proc/xen"
+	depends on XENFS
+	default y
+	help
+	  The old xenstore userspace tools expect to find "xenbus"
+	  under /proc/xen, but "xenbus" is now found at the root of the
+	  xenfs filesystem.  Selecting this causes the kernel to create
+	  the compatibility mount point /proc/xen if it is running on
+	  a xen platform.
+	  If in doubt, say yes.
 
 config XEN_SYS_HYPERVISOR
-       bool "Create xen entries under /sys/hypervisor"
-       depends on SYSFS
-       select SYS_HYPERVISOR
-       default y
-       help
-         Create entries under /sys/hypervisor describing the Xen
-	 hypervisor environment.  When running native or in another
-	 virtual environment, /sys/hypervisor will still be present,
-	 but will have no xen contents.
+	bool "Create xen entries under /sys/hypervisor"
+	depends on SYSFS
+	select SYS_HYPERVISOR
+	default y
+	help
+	  Create entries under /sys/hypervisor describing the Xen
+	  hypervisor environment.  When running native or in another
+	  virtual environment, /sys/hypervisor will still be present,
+	  but will have no xen contents.
 
 config XEN_XENBUS_FRONTEND
 	tristate
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
 
@@ -292,7 +292,7 @@ config XEN_MCE_LOG
 	  converting it into Linux mcelog format for mcelog tools
 
 config XEN_HAVE_PVMMU
-       bool
+	bool
 
 config XEN_EFI
 	def_bool y
@@ -309,15 +309,15 @@ config XEN_ACPI
 	depends on X86 && ACPI
 
 config XEN_SYMS
-       bool "Xen symbols"
-       depends on X86 && XEN_DOM0 && XENFS
-       default y if KALLSYMS
-       help
-          Exports hypervisor symbols (along with their types and addresses) via
-          /proc/xen/xensyms file, similar to /proc/kallsyms
+	bool "Xen symbols"
+	depends on X86 && XEN_DOM0 && XENFS
+	default y if KALLSYMS
+	help
+	  Exports hypervisor symbols (along with their types and addresses) via
+	  /proc/xen/xensyms file, similar to /proc/kallsyms
 
 config XEN_HAVE_VPMU
-       bool
+	bool
 
 config XEN_FRONT_PGDIR_SHBUF
 	tristate
-- 
2.7.4

