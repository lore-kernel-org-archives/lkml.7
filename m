Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA45C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E6D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383672;
	bh=cb+zDTPwlnfiZvpTaJtcxLOOzN7Bme9VJHDxjpMDdis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BH27/TncPzvcOY6bP5RJWsd4/IjwDT+AzdBS0EK22LzStTwPQBSw0YRYszw/xOpcY
	 f4d0ry0NXX9MlpshrYwnJ3gj2v6iKkZeUvQ1ncgOmc/cZvmX4168RdpSjCyCbgNPNL
	 kIM26x6sYthTFSSoTefIWOGtLDqh2a0OwpYonyYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfDPDBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:01:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfDPC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X6PCPujLe0yi/spbjWVARx7ojWRO7h18ZRnSHidvirE=; b=SR3H1Ti6Q2RqQ9OEWS4zWABVnm
        pw3Prl0FHTVvbCZ0D1Ovz1ikMaqSKgY4lU/hLitySZaWmJp7VH054wz7KogCBxRANJw17RqwHRV5y
        R96fo0rBaK0A3a4GOemOCtr/i1LYeqbkjklRT0C3lG5rcg+BUsOZzXGuMBWQw/4yffrwkGrnNhDZk
        sixwsRc4JGfGv41R8B5nNzWli6w3VbKcNQZI2lDzoysGdTxJLyDQhygg/8s8QHkajW7a8oKq8Qbbg
        6P+W5Lxo17gjOV+EfBrVmL2HWeE3DE/aX/TCHAdXLOfZNq8x/mPGutJ7f0IU2uCyEADBu+dcJbyJA
        z44KipsQ==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007aW-Cv; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001lz-8S; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org
Subject: [PATCH 14/57] docs: fpga: convert it to ReST
Date:   Mon, 15 Apr 2019 23:55:39 -0300
Message-Id: <b66aa91ff5b9b3477d21094d3111c1006c59bd42.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dfl.txt file is almost there. It needs just a few
adjustments to be properly parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/fpga/dfl.txt | 58 +++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
index 6df4621c3f2a..2f125abd777f 100644
--- a/Documentation/fpga/dfl.txt
+++ b/Documentation/fpga/dfl.txt
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
-- 
2.20.1

