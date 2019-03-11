Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3E320857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfCKNW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfCKNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:43 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MbAYo-1gWU3p3Wo4-00basd for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:41 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 107/114] drivers: xen: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:59 +0100
Message-Id: <1552310346-7629-108-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:tQg7mSIN4D/yzP9rI0CXzZFLVsVb2VddHm2yaZWUyvcCGaQDpRp
 kIhnvuLk9Jxatp+dArOuysg59tR5r/ZqrO01Z4BCI9BvevIMG0yYdWlsG8kX6/iHpdSHzNf
 8pVUrCHitf1pOvoI85nLRaSt4h1/Srm8BYwxkUtwVw5eIrFIrNsJyFvj6owJomlZMDYQKrD
 pkEwKnenXfKsgGViIVwLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ObQ5vKofyro=:hvZdw+W4IY6zUBjhOO3dgi
 CD3p4r4Aki3n58Bnkwf2zP8a80Yxn7P9vXGKLFW/47BCflcouUi8IBhnE5eULG0ish2csPzZv
 sbYWMAGF0bYTtDC63oyYZwhqTR63So6DwFREJWdU/wq7O33ly2qcUKfrgl6RkmSYz9aWO23e/
 Uzo48LSFm9+qoXYsnfnPfK0i0BoTxJOf+dblrZLu1R+sIbOoP9C6JHMttcs4zUfr0bAxasEmI
 wETGfFQI0PHkSb6qhJxGQqiu5VDT2yKQtbpJxr2dEIFzH04A7RfnRhEMeskUuJxbVeJ1PKQoA
 QwHOVfT9IBUjPt9/I5VFICSg6VZ/l2r2Ts4nW3+8YGpjkvJGKlwZEcncm7BBK1/g0tKiVGF6w
 6cHHueeYAQ1NvpZXGeKzxYMvTiDNLBVVUdoGyPt/EjW53YG6NA5az9nrNTDCu9FgV+Kewj9Mi
 pAiUsm1IeVTkeHbnZBVttkhE7og6E+NV21lXbccolBPn9fEYup9sqy9vUnVIxcy/S0D98J2nc
 Er4nDZ87vIhRv1zDd6knzFuxCT8NNgTgmHJ0zunH84jkwC5779Rm8aVEVC6ZyUV7HAoIiTQkq
 GkJKAebat7K1UFy0cEWKtYZeiiv6UKnC4iRFNbLw3pk4R/T1iGjEDqa6FNmVDAY4uBpsFZHZC
 HMStVMuzA/GhFp0e7Xb5Dv3rbqRy9weIPdozin5FT2VCWHKjmGw/RNWd7ui6Ck1fVGvPKXncd
 oUvmBkZaZd39oTu90VMzX3o7Z9Md1Ek8JNazgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/xen/Kconfig | 62 ++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 838b66a..22a8a14 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -53,8 +53,8 @@ config XEN_BALLOON_MEMORY_HOTPLUG
 	  the newly added memory can be manually onlined in the target domain
 	  by doing the following:
 
-		for i in /sys/devices/system/memory/memory*/state; do \
-		  [ "`cat "$i"`" = offline ] && echo online > "$i"; done
+	        for i in /sys/devices/system/memory/memory*/state; do \
+	          [ "`cat "$i"`" = offline ] && echo online > "$i"; done
 
 	  or by adding the following line to udev rules:
 
@@ -120,27 +120,27 @@ config XENFS
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
@@ -292,7 +292,7 @@ config XEN_ACPI_PROCESSOR
 	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
-          This ACPI processor uploads Power Management information to the Xen
+	  This ACPI processor uploads Power Management information to the Xen
 	  hypervisor.
 
 	  To do that the driver parses the Power Management data and uploads
@@ -301,7 +301,7 @@ config XEN_ACPI_PROCESSOR
 	  SMM so that other drivers (such as ACPI cpufreq scaling driver) will
 	  not load.
 
-          To compile this driver as a module, choose M here: the module will be
+	  To compile this driver as a module, choose M here: the module will be
 	  called xen_acpi_processor  If you do not know what to choose, select
 	  M here. If the CPUFREQ drivers are built in, select Y here.
 
@@ -313,7 +313,7 @@ config XEN_MCE_LOG
 	  converting it into Linux mcelog format for mcelog tools
 
 config XEN_HAVE_PVMMU
-       bool
+	bool
 
 config XEN_EFI
 	def_bool y
@@ -330,15 +330,15 @@ config XEN_ACPI
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
1.9.1

