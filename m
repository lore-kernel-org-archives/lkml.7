Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA14C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB34320873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891342;
	bh=NEoP2vHnlc2FjV5i7CiAlDXpdSAyBgLpWXJdgb87YfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CoSffvyP+A1ADqX8SEaZu30zSGsesQdZJv8ZeDpe/Ou4mporcRfovonBGsM4zDhUy
	 yMjvN0CpcJsarFkUR57PkOx+Qpf5Rrgc0ZISxReLjoUxH4njyFLJ0RlEmRv0F2cm8E
	 Ki9bDaQ520Droe1nNNNCntMBtQZZIbh1WdQF9ArM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfFRUzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:55:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbfFRUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cezNa+/SrJlGLyHHIrMODuEUH4YfnTfH3rjk4VDYllU=; b=PsM4OQLIXh8fE+L/j91lFtDhOe
        nQpHw+8RXwhIu1twQgZWCNzSndTXR/pYc3D9WngjUH2Hq2YBxA2aClInx2J/0oYxet76MZvirdwr7
        YUtI6SV3SGkxZZYIhmnyDk2ijRMmIP8rJwnFTKdtz8myiviPH1RJ/LRSbdTwT/375NWbgE8dExJqF
        SgLyhXWIj3ORCSJJRea/yZdXl1pvfkgenAO0GmLWZSOTSrKYr2br1Mr4JNgI1FeFOfzDTNuh4KQPw
        vHxSDbITLFeXH9WTE8KHtsrkJVZyvBl+1iJmtHSxe2P2N6ftHu2c65FuCo9LFBLqKKFbAM7Hj9Ukf
        m0mX4VNQ==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL73-0008N9-Oa; Tue, 18 Jun 2019 20:53:54 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL70-00020j-F4; Tue, 18 Jun 2019 17:53:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 29/29] docs: mmc: convert to ReST
Date:   Tue, 18 Jun 2019 17:53:47 -0300
Message-Id: <c2655e6f835a9082162cc22f7682dd9dcc6e0340.1560890801.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the mmc documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/mmc/index.rst                   | 13 +++++
 .../{mmc-async-req.txt => mmc-async-req.rst}  | 53 +++++++++++--------
 .../{mmc-dev-attrs.txt => mmc-dev-attrs.rst}  | 32 +++++++----
 .../{mmc-dev-parts.txt => mmc-dev-parts.rst}  | 13 ++---
 .../mmc/{mmc-tools.txt => mmc-tools.rst}      |  5 +-
 5 files changed, 79 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/mmc/index.rst
 rename Documentation/mmc/{mmc-async-req.txt => mmc-async-req.rst} (75%)
 rename Documentation/mmc/{mmc-dev-attrs.txt => mmc-dev-attrs.rst} (73%)
 rename Documentation/mmc/{mmc-dev-parts.txt => mmc-dev-parts.rst} (83%)
 rename Documentation/mmc/{mmc-tools.txt => mmc-tools.rst} (92%)

diff --git a/Documentation/mmc/index.rst b/Documentation/mmc/index.rst
new file mode 100644
index 000000000000..3305478ddadb
--- /dev/null
+++ b/Documentation/mmc/index.rst
@@ -0,0 +1,13 @@
+:orphan:
+
+========================
+MMC/SD/SDIO card support
+========================
+
+.. toctree::
+   :maxdepth: 1
+
+   mmc-dev-attrs
+   mmc-dev-parts
+   mmc-async-req
+   mmc-tools
diff --git a/Documentation/mmc/mmc-async-req.txt b/Documentation/mmc/mmc-async-req.rst
similarity index 75%
rename from Documentation/mmc/mmc-async-req.txt
rename to Documentation/mmc/mmc-async-req.rst
index ae1907b10e4a..0f7197c9c3b5 100644
--- a/Documentation/mmc/mmc-async-req.txt
+++ b/Documentation/mmc/mmc-async-req.rst
@@ -1,13 +1,20 @@
+========================
+MMC Asynchronous Request
+========================
+
 Rationale
 =========
 
 How significant is the cache maintenance overhead?
+
 It depends. Fast eMMC and multiple cache levels with speculative cache
 pre-fetch makes the cache overhead relatively significant. If the DMA
 preparations for the next request are done in parallel with the current
 transfer, the DMA preparation overhead would not affect the MMC performance.
+
 The intention of non-blocking (asynchronous) MMC requests is to minimize the
 time between when an MMC request ends and another MMC request begins.
+
 Using mmc_wait_for_req(), the MMC controller is idle while dma_map_sg and
 dma_unmap_sg are processing. Using non-blocking MMC requests makes it
 possible to prepare the caches for next job in parallel with an active
@@ -17,6 +24,7 @@ MMC block driver
 ================
 
 The mmc_blk_issue_rw_rq() in the MMC block driver is made non-blocking.
+
 The increase in throughput is proportional to the time it takes to
 prepare (major part of preparations are dma_map_sg() and dma_unmap_sg())
 a request and how fast the memory is. The faster the MMC/SD is the
@@ -35,6 +43,7 @@ MMC core API extension
 ======================
 
 There is one new public function mmc_start_req().
+
 It starts a new MMC command request for a host. The function isn't
 truly non-blocking. If there is an ongoing async request it waits
 for completion of that request and starts the new one and returns. It
@@ -47,6 +56,7 @@ MMC host extensions
 There are two optional members in the mmc_host_ops -- pre_req() and
 post_req() -- that the host driver may implement in order to move work
 to before and after the actual mmc_host_ops.request() function is called.
+
 In the DMA case pre_req() may do dma_map_sg() and prepare the DMA
 descriptor, and post_req() runs the dma_unmap_sg().
 
@@ -55,33 +65,34 @@ Optimize for the first request
 
 The first request in a series of requests can't be prepared in parallel
 with the previous transfer, since there is no previous request.
+
 The argument is_first_req in pre_req() indicates that there is no previous
 request. The host driver may optimize for this scenario to minimize
 the performance loss. A way to optimize for this is to split the current
 request in two chunks, prepare the first chunk and start the request,
 and finally prepare the second chunk and start the transfer.
 
-Pseudocode to handle is_first_req scenario with minimal prepare overhead:
+Pseudocode to handle is_first_req scenario with minimal prepare overhead::
 
-if (is_first_req && req->size > threshold)
-   /* start MMC transfer for the complete transfer size */
-   mmc_start_command(MMC_CMD_TRANSFER_FULL_SIZE);
+  if (is_first_req && req->size > threshold)
+     /* start MMC transfer for the complete transfer size */
+     mmc_start_command(MMC_CMD_TRANSFER_FULL_SIZE);
 
-   /*
-    * Begin to prepare DMA while cmd is being processed by MMC.
-    * The first chunk of the request should take the same time
-    * to prepare as the "MMC process command time".
-    * If prepare time exceeds MMC cmd time
-    * the transfer is delayed, guesstimate max 4k as first chunk size.
-    */
-    prepare_1st_chunk_for_dma(req);
-    /* flush pending desc to the DMAC (dmaengine.h) */
-    dma_issue_pending(req->dma_desc);
+     /*
+      * Begin to prepare DMA while cmd is being processed by MMC.
+      * The first chunk of the request should take the same time
+      * to prepare as the "MMC process command time".
+      * If prepare time exceeds MMC cmd time
+      * the transfer is delayed, guesstimate max 4k as first chunk size.
+      */
+      prepare_1st_chunk_for_dma(req);
+      /* flush pending desc to the DMAC (dmaengine.h) */
+      dma_issue_pending(req->dma_desc);
 
-    prepare_2nd_chunk_for_dma(req);
-    /*
-     * The second issue_pending should be called before MMC runs out
-     * of the first chunk. If the MMC runs out of the first data chunk
-     * before this call, the transfer is delayed.
-     */
-    dma_issue_pending(req->dma_desc);
+      prepare_2nd_chunk_for_dma(req);
+      /*
+       * The second issue_pending should be called before MMC runs out
+       * of the first chunk. If the MMC runs out of the first data chunk
+       * before this call, the transfer is delayed.
+       */
+      dma_issue_pending(req->dma_desc);
diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.rst
similarity index 73%
rename from Documentation/mmc/mmc-dev-attrs.txt
rename to Documentation/mmc/mmc-dev-attrs.rst
index 4ad0bb17f343..4f44b1b730d6 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.rst
@@ -1,3 +1,4 @@
+==================================
 SD and MMC Block Device Attributes
 ==================================
 
@@ -6,23 +7,29 @@ SD or MMC device.
 
 The following attributes are read/write.
 
-	force_ro		Enforce read-only access even if write protect switch is off.
+	========		===============================================
+	force_ro		Enforce read-only access even if write protect 					switch is off.
+	========		===============================================
 
 SD and MMC Device Attributes
 ============================
 
 All attributes are read-only.
 
+	======================	===============================================
 	cid			Card Identification Register
 	csd			Card Specific Data Register
 	scr			SD Card Configuration Register (SD only)
 	date			Manufacturing Date (from CID Register)
-	fwrev			Firmware/Product Revision (from CID Register) (SD and MMCv1 only)
-	hwrev			Hardware/Product Revision (from CID Register) (SD and MMCv1 only)
+	fwrev			Firmware/Product Revision (from CID Register)
+				(SD and MMCv1 only)
+	hwrev			Hardware/Product Revision (from CID Register)
+				(SD and MMCv1 only)
 	manfid			Manufacturer ID (from CID Register)
 	name			Product Name (from CID Register)
 	oemid			OEM/Application ID (from CID Register)
-	prv			Product Revision (from CID Register) (SD and MMCv4 only)
+	prv			Product Revision (from CID Register)
+				(SD and MMCv4 only)
 	serial			Product Serial Number (from CID Register)
 	erase_size		Erase group size
 	preferred_erase_size	Preferred erase size
@@ -30,7 +37,10 @@ All attributes are read-only.
 	rel_sectors		Reliable write sector count
 	ocr 			Operation Conditions Register
 	dsr			Driver Stage Register
-	cmdq_en			Command Queue enabled: 1 => enabled, 0 => not enabled
+	cmdq_en			Command Queue enabled:
+
+					1 => enabled, 0 => not enabled
+	======================	===============================================
 
 Note on Erase Size and Preferred Erase Size:
 
@@ -44,14 +54,15 @@ Note on Erase Size and Preferred Erase Size:
 	SD/MMC cards can erase an arbitrarily large area up to and
 	including the whole card.  When erasing a large area it may
 	be desirable to do it in smaller chunks for three reasons:
-		1. A single erase command will make all other I/O on
+
+	     1. A single erase command will make all other I/O on
 		the card wait.  This is not a problem if the whole card
 		is being erased, but erasing one partition will make
 		I/O for another partition on the same card wait for the
 		duration of the erase - which could be a several
 		minutes.
-		2. To be able to inform the user of erase progress.
-		3. The erase timeout becomes too large to be very
+	     2. To be able to inform the user of erase progress.
+	     3. The erase timeout becomes too large to be very
 		useful.  Because the erase timeout contains a margin
 		which is multiplied by the size of the erase area,
 		the value can end up being several minutes for large
@@ -72,6 +83,9 @@ Note on Erase Size and Preferred Erase Size:
 	"preferred_erase_size" is in bytes.
 
 Note on raw_rpmb_size_mult:
+
 	"raw_rpmb_size_mult" is a multiple of 128kB block.
+
 	RPMB size in byte is calculated by using the following equation:
-	RPMB partition size = 128kB x raw_rpmb_size_mult
+
+		RPMB partition size = 128kB x raw_rpmb_size_mult
diff --git a/Documentation/mmc/mmc-dev-parts.txt b/Documentation/mmc/mmc-dev-parts.rst
similarity index 83%
rename from Documentation/mmc/mmc-dev-parts.txt
rename to Documentation/mmc/mmc-dev-parts.rst
index f08d078d43cf..995922f1f744 100644
--- a/Documentation/mmc/mmc-dev-parts.txt
+++ b/Documentation/mmc/mmc-dev-parts.rst
@@ -1,3 +1,4 @@
+============================
 SD and MMC Device Partitions
 ============================
 
@@ -18,18 +19,18 @@ platform, write access is disabled by default to reduce the chance of
 accidental bricking.
 
 To enable write access to /dev/mmcblkXbootY, disable the forced read-only
-access with:
+access with::
 
-echo 0 > /sys/block/mmcblkXbootY/force_ro
+	echo 0 > /sys/block/mmcblkXbootY/force_ro
 
-To re-enable read-only access:
+To re-enable read-only access::
 
-echo 1 > /sys/block/mmcblkXbootY/force_ro
+	echo 1 > /sys/block/mmcblkXbootY/force_ro
 
 The boot partitions can also be locked read only until the next power on,
-with:
+with::
 
-echo 1 > /sys/block/mmcblkXbootY/ro_lock_until_next_power_on
+	echo 1 > /sys/block/mmcblkXbootY/ro_lock_until_next_power_on
 
 This is a feature of the card and not of the kernel. If the card does
 not support boot partition locking, the file will not exist. If the
diff --git a/Documentation/mmc/mmc-tools.txt b/Documentation/mmc/mmc-tools.rst
similarity index 92%
rename from Documentation/mmc/mmc-tools.txt
rename to Documentation/mmc/mmc-tools.rst
index 735509c165d5..54406093768b 100644
--- a/Documentation/mmc/mmc-tools.txt
+++ b/Documentation/mmc/mmc-tools.rst
@@ -1,14 +1,17 @@
+======================
 MMC tools introduction
 ======================
 
 There is one MMC test tools called mmc-utils, which is maintained by Chris Ball,
 you can find it at the below public git repository:
-http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
+
+	http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
 
 Functions
 =========
 
 The mmc-utils tools can do the following:
+
  - Print and parse extcsd data.
  - Determine the eMMC writeprotect status.
  - Set the eMMC writeprotect status.
-- 
2.21.0

