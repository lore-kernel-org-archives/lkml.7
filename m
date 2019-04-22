Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD8FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5520652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940233;
	bh=QJ6lssFqJar1EFUnx6U/ciqrhc1uDs13MOQeDaCFHuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AzHaAhfHnJwLsr9nutLKbuCAKiTp3Z0a/lF4fa3a3aNuPrImS9c+GJ++uE4RMIvOT
	 zXWUs/EENA1r55LP04cmwsQyrryMv+YdPAaMpgeJ3U+mbKGswQ0bsrfypnRSMOEXLU
	 5Mddd+b+xMPIZr1WyP7PbpdxgsqSadZoNntYSJMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfDVNhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:37:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfDVN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KvPPUKTEpOxvb76aHCKt6md1PVNE4eyXh3HPI1BClCU=; b=L3S4JG071WOCo99myo48JGHsOr
        lZITH7S76mj+e0moT8ZSpl5nsrf2xSTGCMtFBbQmZMVTokF2EYw5nBNwRqHmjivaJLUXcW3VWGads
        5ktCSEFrfbv9NedhwYw6ZdgAYQx72UYFpYY4GdoJumTLY6VdU7agO69QedLommiClvDi5AJyLJZbc
        MkqgztqQOrmB6uThq5h63BC/AVzS1qldBoHP9AksCgP74vJ0lfkQWzWKmUrQ9jPNEW82k6KbR5CPc
        sTVD0cvSJmTESZO6dlPdpKij8q3GCFuos2z9XCeKVJQ9F8jFD2fXzhWS7K2cleWe3jRC3UsVGdXPe
        VEcSWBFA==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzU-0005Hg-OR; Mon, 22 Apr 2019 13:28:13 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzS-0005kW-LX; Mon, 22 Apr 2019 10:28:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Subject: [PATCH v2 14/79] docs: fpga: convert docs to ReST and rename to *.rst
Date:   Mon, 22 Apr 2019 10:27:03 -0300
Message-Id: <902793a6738ce31b384e71cfeca27a9b9080000d.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dfl.txt file is almost there. It needs just a few
adjustments to be properly parsed.

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/fpga/{dfl.txt => dfl.rst} | 58 ++++++++++++++-----------
 Documentation/fpga/index.rst            | 17 ++++++++
 MAINTAINERS                             |  2 +-
 3 files changed, 50 insertions(+), 27 deletions(-)
 rename Documentation/fpga/{dfl.txt => dfl.rst} (89%)
 create mode 100644 Documentation/fpga/index.rst

diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.rst
similarity index 89%
rename from Documentation/fpga/dfl.txt
rename to Documentation/fpga/dfl.rst
index 6df4621c3f2a..2f125abd777f 100644
--- a/Documentation/fpga/dfl.txt
+++ b/Documentation/fpga/dfl.rst
@@ -1,9 +1,12 @@
-===============================================================================
-              FPGA Device Feature List (DFL) Framework Overview
--------------------------------------------------------------------------------
-                Enno Luebbers <enno.luebbers@intel.com>
-                Xiao Guangrong <guangrong.xiao@linux.intel.com>
-                Wu Hao <hao.wu@intel.com>
+=================================================
+FPGA Device Feature List (DFL) Framework Overview
+=================================================
+
+Authors:
+
+- Enno Luebbers <enno.luebbers@intel.com>
+- Xiao Guangrong <guangrong.xiao@linux.intel.com>
+- Wu Hao <hao.wu@intel.com>
 
 The Device Feature List (DFL) FPGA framework (and drivers according to this
 this framework) hides the very details of low layer hardwares and provides
@@ -19,7 +22,7 @@ Device Feature List (DFL) defines a linked list of feature headers within the
 device MMIO space to provide an extensible way of adding features. Software can
 walk through these predefined data structures to enumerate FPGA features:
 FPGA Interface Unit (FIU), Accelerated Function Unit (AFU) and Private Features,
-as illustrated below:
+as illustrated below::
 
     Header            Header            Header            Header
  +----------+  +-->+----------+  +-->+----------+  +-->+----------+
@@ -81,9 +84,9 @@ and release it using close().
 
 The following functions are exposed through ioctls:
 
- Get driver API version (DFL_FPGA_GET_API_VERSION)
- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
- Program bitstream (DFL_FPGA_FME_PORT_PR)
+- Get driver API version (DFL_FPGA_GET_API_VERSION)
+- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
+- Program bitstream (DFL_FPGA_FME_PORT_PR)
 
 More functions are exposed through sysfs
 (/sys/class/fpga_region/regionX/dfl-fme.n/):
@@ -118,18 +121,19 @@ port by using open() on the port device node and release it using close().
 
 The following functions are exposed through ioctls:
 
- Get driver API version (DFL_FPGA_GET_API_VERSION)
- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
- Get port info (DFL_FPGA_PORT_GET_INFO)
- Get MMIO region info (DFL_FPGA_PORT_GET_REGION_INFO)
- Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
- Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
- Reset AFU (*DFL_FPGA_PORT_RESET)
+- Get driver API version (DFL_FPGA_GET_API_VERSION)
+- Check for extensions (DFL_FPGA_CHECK_EXTENSION)
+- Get port info (DFL_FPGA_PORT_GET_INFO)
+- Get MMIO region info (DFL_FPGA_PORT_GET_REGION_INFO)
+- Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
+- Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
+- Reset AFU (DFL_FPGA_PORT_RESET)
 
-*DFL_FPGA_PORT_RESET: reset the FPGA Port and its AFU. Userspace can do Port
-reset at any time, e.g. during DMA or Partial Reconfiguration. But it should
-never cause any system level issue, only functional failure (e.g. DMA or PR
-operation failure) and be recoverable from the failure.
+DFL_FPGA_PORT_RESET:
+  reset the FPGA Port and its AFU. Userspace can do Port
+  reset at any time, e.g. during DMA or Partial Reconfiguration. But it should
+  never cause any system level issue, only functional failure (e.g. DMA or PR
+  operation failure) and be recoverable from the failure.
 
 User-space applications can also mmap() accelerator MMIO regions.
 
@@ -143,6 +147,8 @@ More functions are exposed through sysfs:
 DFL Framework Overview
 ======================
 
+::
+
          +----------+    +--------+ +--------+ +--------+
          |   FME    |    |  AFU   | |  AFU   | |  AFU   |
          |  Module  |    | Module | | Module | | Module |
@@ -151,7 +157,7 @@ DFL Framework Overview
                  | FPGA Container Device |    Device Feature List
                  |  (FPGA Base Region)   |         Framework
                  +-----------------------+
---------------------------------------------------------------------
+  ------------------------------------------------------------------
                +----------------------------+
                |   FPGA DFL Device Module   |
                | (e.g. PCIE/Platform Device)|
@@ -220,7 +226,7 @@ the sysfs hierarchy under /sys/class/fpga_region.
 In the example below, two DFL based FPGA devices are installed in the host. Each
 fpga device has one FME and two ports (AFUs).
 
-FPGA regions are created under /sys/class/fpga_region/
+FPGA regions are created under /sys/class/fpga_region/::
 
 	/sys/class/fpga_region/region0
 	/sys/class/fpga_region/region1
@@ -231,7 +237,7 @@ Application needs to search each regionX folder, if feature device is found,
 (e.g. "dfl-port.n" or "dfl-fme.m" is found), then it's the base
 fpga region which represents the FPGA device.
 
-Each base region has one FME and two ports (AFUs) as child devices:
+Each base region has one FME and two ports (AFUs) as child devices::
 
 	/sys/class/fpga_region/region0/dfl-fme.0
 	/sys/class/fpga_region/region0/dfl-port.0
@@ -243,7 +249,7 @@ Each base region has one FME and two ports (AFUs) as child devices:
 	/sys/class/fpga_region/region3/dfl-port.3
 	...
 
-In general, the FME/AFU sysfs interfaces are named as follows:
+In general, the FME/AFU sysfs interfaces are named as follows::
 
 	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/
 	/sys/class/fpga_region/<regionX>/<dfl-port.m>/
@@ -251,7 +257,7 @@ In general, the FME/AFU sysfs interfaces are named as follows:
 with 'n' consecutively numbering all FMEs and 'm' consecutively numbering all
 ports.
 
-The device nodes used for ioctl() or mmap() can be referenced through:
+The device nodes used for ioctl() or mmap() can be referenced through::
 
 	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
 	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
new file mode 100644
index 000000000000..2c87d1ea084f
--- /dev/null
+++ b/Documentation/fpga/index.rst
@@ -0,0 +1,17 @@
+:orphan:
+
+====
+fpga
+====
+
+.. toctree::
+    :maxdepth: 1
+
+    dfl
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/MAINTAINERS b/MAINTAINERS
index fac4490d2a00..3dd988519a11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6186,7 +6186,7 @@ FPGA DFL DRIVERS
 M:	Wu Hao <hao.wu@intel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-F:	Documentation/fpga/dfl.txt
+F:	Documentation/fpga/dfl.rst
 F:	include/uapi/linux/fpga-dfl.h
 F:	drivers/fpga/dfl*
 
-- 
2.20.1

