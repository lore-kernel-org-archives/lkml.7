Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B979C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE10206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364802;
	bh=fgMUwdmccO8CbPSCyq4+351L/yFCJnVNyCn0I21ac3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1mKzBgxHLDLlS/E/XCV7bSRt8tseH6HyfMqc1ewdIsXtqG5OOWCtBawsST/PqOycn
	 MxZ/GgV5B1QTobvvthbhn6oC7uu+Gtcb19nwpWs8WP3RL5WzDhcSG4vdRAHjbdCmjo
	 ksCp+NXFi9kAIUHmma1/78DCiNrIViOV/1rmL/3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfFLSkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:40:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfFLSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8jckVuamXKfyKhesJHgCXD0pnMqhYEi9iRqind49j08=; b=S0UgHQpue0r2TE8gvDbsQcltTC
        axYVY8GMm39nmhD5relJjLGp0JsU4hXi+f/8sonB9xIVOgqRN4EYiApEagF4gwsN13CuAbAfbB2hq
        FbiCEmK1jfpLunkzkvEVbyeA2oazESgcL/8Zm5Y+Dn3zeig61GUHf3ldYDvRBJglVOWgZN9aQTtRa
        vXBSkOb2ydqKRuu6aBlMCvuxzBeSEAHUK0Ue1NZTZA8DWn9pMguNFKWCdhj4lcFUmEO2nWSAFQ6tU
        a3p+22TYK1Wm2GFHphb+FfKdwaKIDKWqq6y406zVbRV7pRQPKdSRB2zpej9zhYjTMX5KUZkTMCJbk
        1l67DhpA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88t-0006YY-1T; Wed, 12 Jun 2019 18:38:40 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002C7-IR; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH v1 29/31] docs: nvdimm: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:32 -0300
Message-Id: <075d5879142ff1b7ad16f5eccf4759d35ca02fd4.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the mtd documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/nvdimm/{btt.txt => btt.rst}     | 140 ++---
 Documentation/nvdimm/index.rst                |  12 +
 .../nvdimm/{nvdimm.txt => nvdimm.rst}         | 518 ++++++++++--------
 .../nvdimm/{security.txt => security.rst}     |   4 +-
 drivers/nvdimm/Kconfig                        |   2 +-
 5 files changed, 387 insertions(+), 289 deletions(-)
 rename Documentation/nvdimm/{btt.txt => btt.rst} (71%)
 create mode 100644 Documentation/nvdimm/index.rst
 rename Documentation/nvdimm/{nvdimm.txt => nvdimm.rst} (60%)
 rename Documentation/nvdimm/{security.txt => security.rst} (99%)

diff --git a/Documentation/nvdimm/btt.txt b/Documentation/nvdimm/btt.rst
similarity index 71%
rename from Documentation/nvdimm/btt.txt
rename to Documentation/nvdimm/btt.rst
index e293fb664924..2d8269f834bd 100644
--- a/Documentation/nvdimm/btt.txt
+++ b/Documentation/nvdimm/btt.rst
@@ -1,9 +1,10 @@
+=============================
 BTT - Block Translation Table
 =============================
 
 
 1. Introduction
----------------
+===============
 
 Persistent memory based storage is able to perform IO at byte (or more
 accurately, cache line) granularity. However, we often want to expose such
@@ -25,7 +26,7 @@ provides atomic sector updates.
 
 
 2. Static Layout
-----------------
+================
 
 The underlying storage on which a BTT can be laid out is not limited in any way.
 The BTT, however, splits the available space into chunks of up to 512 GiB,
@@ -33,43 +34,43 @@ called "Arenas".
 
 Each arena follows the same layout for its metadata, and all references in an
 arena are internal to it (with the exception of one field that points to the
-next arena). The following depicts the "On-disk" metadata layout:
+next arena). The following depicts the "On-disk" metadata layout::
 
 
-  Backing Store     +------->  Arena
-+---------------+   |   +------------------+
-|               |   |   | Arena info block |
-|    Arena 0    +---+   |       4K         |
-|     512G      |       +------------------+
-|               |       |                  |
-+---------------+       |                  |
-|               |       |                  |
-|    Arena 1    |       |   Data Blocks    |
-|     512G      |       |                  |
-|               |       |                  |
-+---------------+       |                  |
-|       .       |       |                  |
-|       .       |       |                  |
-|       .       |       |                  |
-|               |       |                  |
-|               |       |                  |
-+---------------+       +------------------+
-                        |                  |
-                        |     BTT Map      |
-                        |                  |
-                        |                  |
-                        +------------------+
-                        |                  |
-                        |     BTT Flog     |
-                        |                  |
-                        +------------------+
-                        | Info block copy  |
-                        |       4K         |
-                        +------------------+
+    Backing Store     +------->  Arena
+  +---------------+   |   +------------------+
+  |               |   |   | Arena info block |
+  |    Arena 0    +---+   |       4K         |
+  |     512G      |       +------------------+
+  |               |       |                  |
+  +---------------+       |                  |
+  |               |       |                  |
+  |    Arena 1    |       |   Data Blocks    |
+  |     512G      |       |                  |
+  |               |       |                  |
+  +---------------+       |                  |
+  |       .       |       |                  |
+  |       .       |       |                  |
+  |       .       |       |                  |
+  |               |       |                  |
+  |               |       |                  |
+  +---------------+       +------------------+
+                          |                  |
+                          |     BTT Map      |
+                          |                  |
+                          |                  |
+                          +------------------+
+                          |                  |
+                          |     BTT Flog     |
+                          |                  |
+                          +------------------+
+                          | Info block copy  |
+                          |       4K         |
+                          +------------------+
 
 
 3. Theory of Operation
-----------------------
+======================
 
 
 a. The BTT Map
@@ -79,31 +80,37 @@ The map is a simple lookup/indirection table that maps an LBA to an internal
 block. Each map entry is 32 bits. The two most significant bits are special
 flags, and the remaining form the internal block number.
 
+======== =============================================================
 Bit      Description
-31 - 30	: Error and Zero flags - Used in the following way:
-	 Bit		      Description
-	31 30
-	-----------------------------------------------------------------------
-	 00	Initial state. Reads return zeroes; Premap = Postmap
-	 01	Zero state: Reads return zeroes
-	 10	Error state: Reads fail; Writes clear 'E' bit
-	 11	Normal Block – has valid postmap
+======== =============================================================
+31 - 30	 Error and Zero flags - Used in the following way:
 
+	   == ==  ====================================================
+	   31 30  Description
+	   == ==  ====================================================
+	   0  0	  Initial state. Reads return zeroes; Premap = Postmap
+	   0  1	  Zero state: Reads return zeroes
+	   1  0	  Error state: Reads fail; Writes clear 'E' bit
+	   1  1	  Normal Block – has valid postmap
+	   == ==  ====================================================
 
-29 - 0	: Mappings to internal 'postmap' blocks
+29 - 0	 Mappings to internal 'postmap' blocks
+======== =============================================================
 
 
 Some of the terminology that will be subsequently used:
 
-External LBA  : LBA as made visible to upper layers.
-ABA           : Arena Block Address - Block offset/number within an arena
-Premap ABA    : The block offset into an arena, which was decided upon by range
+============	================================================================
+External LBA	LBA as made visible to upper layers.
+ABA		Arena Block Address - Block offset/number within an arena
+Premap ABA	The block offset into an arena, which was decided upon by range
 		checking the External LBA
-Postmap ABA   : The block number in the "Data Blocks" area obtained after
+Postmap ABA	The block number in the "Data Blocks" area obtained after
 		indirection from the map
-nfree	      : The number of free blocks that are maintained at any given time.
+nfree		The number of free blocks that are maintained at any given time.
 		This is the number of concurrent writes that can happen to the
 		arena.
+============	================================================================
 
 
 For example, after adding a BTT, we surface a disk of 1024G. We get a read for
@@ -121,19 +128,21 @@ i.e. Every write goes to a "free" block. A running list of free blocks is
 maintained in the form of the BTT flog. 'Flog' is a combination of the words
 "free list" and "log". The flog contains 'nfree' entries, and an entry contains:
 
-lba     : The premap ABA that is being written to
-old_map : The old postmap ABA - after 'this' write completes, this will be a
+========  =====================================================================
+lba       The premap ABA that is being written to
+old_map   The old postmap ABA - after 'this' write completes, this will be a
 	  free block.
-new_map : The new postmap ABA. The map will up updated to reflect this
+new_map   The new postmap ABA. The map will up updated to reflect this
 	  lba->postmap_aba mapping, but we log it here in case we have to
 	  recover.
-seq	: Sequence number to mark which of the 2 sections of this flog entry is
+seq	  Sequence number to mark which of the 2 sections of this flog entry is
 	  valid/newest. It cycles between 01->10->11->01 (binary) under normal
 	  operation, with 00 indicating an uninitialized state.
-lba'	: alternate lba entry
-old_map': alternate old postmap entry
-new_map': alternate new postmap entry
-seq'	: alternate sequence number.
+lba'	  alternate lba entry
+old_map'  alternate old postmap entry
+new_map'  alternate new postmap entry
+seq'	  alternate sequence number.
+========  =====================================================================
 
 Each of the above fields is 32-bit, making one entry 32 bytes. Entries are also
 padded to 64 bytes to avoid cache line sharing or aliasing. Flog updates are
@@ -147,8 +156,10 @@ c. The concept of lanes
 
 While 'nfree' describes the number of concurrent IOs an arena can process
 concurrently, 'nlanes' is the number of IOs the BTT device as a whole can
-process.
- nlanes = min(nfree, num_cpus)
+process::
+
+	nlanes = min(nfree, num_cpus)
+
 A lane number is obtained at the start of any IO, and is used for indexing into
 all the on-disk and in-memory data structures for the duration of the IO. If
 there are more CPUs than the max number of available lanes, than lanes are
@@ -180,10 +191,10 @@ e. In-memory data structure: map locks
 --------------------------------------
 
 Consider a case where two writer threads are writing to the same LBA. There can
-be a race in the following sequence of steps:
+be a race in the following sequence of steps::
 
-free[lane] = map[premap_aba]
-map[premap_aba] = postmap_aba
+	free[lane] = map[premap_aba]
+	map[premap_aba] = postmap_aba
 
 Both threads can update their respective free[lane] with the same old, freed
 postmap_aba. This has made the layout inconsistent by losing a free entry, and
@@ -202,6 +213,7 @@ On startup, we analyze the BTT flog to create our list of free blocks. We walk
 through all the entries, and for each lane, of the set of two possible
 'sections', we always look at the most recent one only (based on the sequence
 number). The reconstruction rules/steps are simple:
+
 - Read map[log_entry.lba].
 - If log_entry.new matches the map entry, then log_entry.old is free.
 - If log_entry.new does not match the map entry, then log_entry.new is free.
@@ -228,7 +240,7 @@ Write:
 1.  Convert external LBA to Arena number + pre-map ABA
 2.  Get a lane (and take lane_lock)
 3.  Use lane to index into in-memory free list and obtain a new block, next flog
-        index, next sequence number
+    index, next sequence number
 4.  Scan the RTT to check if free block is present, and spin/wait if it is.
 5.  Write data to this free block
 6.  Read map to get the existing post-map ABA entry for this pre-map ABA
@@ -245,6 +257,7 @@ Write:
 An arena would be in an error state if any of the metadata is corrupted
 irrecoverably, either due to a bug or a media error. The following conditions
 indicate an error:
+
 - Info block checksum does not match (and recovering from the copy also fails)
 - All internal available blocks are not uniquely and entirely addressed by the
   sum of mapped blocks and free blocks (from the BTT flog).
@@ -263,11 +276,10 @@ The BTT can be set up on any disk (namespace) exposed by the libnvdimm subsystem
 (pmem, or blk mode). The easiest way to set up such a namespace is using the
 'ndctl' utility [1]:
 
-For example, the ndctl command line to setup a btt with a 4k sector size is:
+For example, the ndctl command line to setup a btt with a 4k sector size is::
 
     ndctl create-namespace -f -e namespace0.0 -m sector -l 4k
 
 See ndctl create-namespace --help for more options.
 
 [1]: https://github.com/pmem/ndctl
-
diff --git a/Documentation/nvdimm/index.rst b/Documentation/nvdimm/index.rst
new file mode 100644
index 000000000000..1a3402d3775e
--- /dev/null
+++ b/Documentation/nvdimm/index.rst
@@ -0,0 +1,12 @@
+:orphan:
+
+===================================
+Non-Volatile Memory Device (NVDIMM)
+===================================
+
+.. toctree::
+   :maxdepth: 1
+
+   nvdimm
+   btt
+   security
diff --git a/Documentation/nvdimm/nvdimm.txt b/Documentation/nvdimm/nvdimm.rst
similarity index 60%
rename from Documentation/nvdimm/nvdimm.txt
rename to Documentation/nvdimm/nvdimm.rst
index 1669f626b037..08f855cbb4e6 100644
--- a/Documentation/nvdimm/nvdimm.txt
+++ b/Documentation/nvdimm/nvdimm.rst
@@ -1,8 +1,14 @@
-			  LIBNVDIMM: Non-Volatile Devices
-	      libnvdimm - kernel / libndctl - userspace helper library
-			   linux-nvdimm@lists.01.org
-				      v13
+===============================
+LIBNVDIMM: Non-Volatile Devices
+===============================
 
+libnvdimm - kernel / libndctl - userspace helper library
+
+linux-nvdimm@lists.01.org
+
+Version 13
+
+.. contents:
 
 	Glossary
 	Overview
@@ -40,49 +46,57 @@
 
 
 Glossary
---------
-
-PMEM: A system-physical-address range where writes are persistent.  A
-block device composed of PMEM is capable of DAX.  A PMEM address range
-may span an interleave of several DIMMs.
-
-BLK: A set of one or more programmable memory mapped apertures provided
-by a DIMM to access its media.  This indirection precludes the
-performance benefit of interleaving, but enables DIMM-bounded failure
-modes.
-
-DPA: DIMM Physical Address, is a DIMM-relative offset.  With one DIMM in
-the system there would be a 1:1 system-physical-address:DPA association.
-Once more DIMMs are added a memory controller interleave must be
-decoded to determine the DPA associated with a given
-system-physical-address.  BLK capacity always has a 1:1 relationship
-with a single-DIMM's DPA range.
-
-DAX: File system extensions to bypass the page cache and block layer to
-mmap persistent memory, from a PMEM block device, directly into a
-process address space.
-
-DSM: Device Specific Method: ACPI method to to control specific
-device - in this case the firmware.
-
-DCR: NVDIMM Control Region Structure defined in ACPI 6 Section 5.2.25.5.
-It defines a vendor-id, device-id, and interface format for a given DIMM.
-
-BTT: Block Translation Table: Persistent memory is byte addressable.
-Existing software may have an expectation that the power-fail-atomicity
-of writes is at least one sector, 512 bytes.  The BTT is an indirection
-table with atomic update semantics to front a PMEM/BLK block device
-driver and present arbitrary atomic sector sizes.
-
-LABEL: Metadata stored on a DIMM device that partitions and identifies
-(persistently names) storage between PMEM and BLK.  It also partitions
-BLK storage to host BTTs with different parameters per BLK-partition.
-Note that traditional partition tables, GPT/MBR, are layered on top of a
-BLK or PMEM device.
+========
+
+PMEM:
+  A system-physical-address range where writes are persistent.  A
+  block device composed of PMEM is capable of DAX.  A PMEM address range
+  may span an interleave of several DIMMs.
+
+BLK:
+  A set of one or more programmable memory mapped apertures provided
+  by a DIMM to access its media.  This indirection precludes the
+  performance benefit of interleaving, but enables DIMM-bounded failure
+  modes.
+
+DPA:
+  DIMM Physical Address, is a DIMM-relative offset.  With one DIMM in
+  the system there would be a 1:1 system-physical-address:DPA association.
+  Once more DIMMs are added a memory controller interleave must be
+  decoded to determine the DPA associated with a given
+  system-physical-address.  BLK capacity always has a 1:1 relationship
+  with a single-DIMM's DPA range.
+
+DAX:
+  File system extensions to bypass the page cache and block layer to
+  mmap persistent memory, from a PMEM block device, directly into a
+  process address space.
+
+DSM:
+  Device Specific Method: ACPI method to to control specific
+  device - in this case the firmware.
+
+DCR:
+  NVDIMM Control Region Structure defined in ACPI 6 Section 5.2.25.5.
+  It defines a vendor-id, device-id, and interface format for a given DIMM.
+
+BTT:
+  Block Translation Table: Persistent memory is byte addressable.
+  Existing software may have an expectation that the power-fail-atomicity
+  of writes is at least one sector, 512 bytes.  The BTT is an indirection
+  table with atomic update semantics to front a PMEM/BLK block device
+  driver and present arbitrary atomic sector sizes.
+
+LABEL:
+  Metadata stored on a DIMM device that partitions and identifies
+  (persistently names) storage between PMEM and BLK.  It also partitions
+  BLK storage to host BTTs with different parameters per BLK-partition.
+  Note that traditional partition tables, GPT/MBR, are layered on top of a
+  BLK or PMEM device.
 
 
 Overview
---------
+========
 
 The LIBNVDIMM subsystem provides support for three types of NVDIMMs, namely,
 PMEM, BLK, and NVDIMM devices that can simultaneously support both PMEM
@@ -96,19 +110,30 @@ accessible via BLK.  When that occurs a LABEL is needed to reserve DPA
 for exclusive access via one mode a time.
 
 Supporting Documents
-ACPI 6: http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
-NVDIMM Namespace: http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
-DSM Interface Example: http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
-Driver Writer's Guide: http://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
+--------------------
+
+ACPI 6:
+	http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
+NVDIMM Namespace:
+	http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
+DSM Interface Example:
+	http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
+Driver Writer's Guide:
+	http://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
 
 Git Trees
-LIBNVDIMM: https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git
-LIBNDCTL: https://github.com/pmem/ndctl.git
-PMEM: https://github.com/01org/prd
+---------
+
+LIBNVDIMM:
+	https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git
+LIBNDCTL:
+	https://github.com/pmem/ndctl.git
+PMEM:
+	https://github.com/01org/prd
 
 
 LIBNVDIMM PMEM and BLK
-------------------
+======================
 
 Prior to the arrival of the NFIT, non-volatile memory was described to a
 system in various ad-hoc ways.  Usually only the bare minimum was
@@ -122,38 +147,39 @@ For each NVDIMM access method (PMEM, BLK), LIBNVDIMM provides a block
 device driver:
 
     1. PMEM (nd_pmem.ko): Drives a system-physical-address range.  This
-    range is contiguous in system memory and may be interleaved (hardware
-    memory controller striped) across multiple DIMMs.  When interleaved the
-    platform may optionally provide details of which DIMMs are participating
-    in the interleave.
+       range is contiguous in system memory and may be interleaved (hardware
+       memory controller striped) across multiple DIMMs.  When interleaved the
+       platform may optionally provide details of which DIMMs are participating
+       in the interleave.
 
-    Note that while LIBNVDIMM describes system-physical-address ranges that may
-    alias with BLK access as ND_NAMESPACE_PMEM ranges and those without
-    alias as ND_NAMESPACE_IO ranges, to the nd_pmem driver there is no
-    distinction.  The different device-types are an implementation detail
-    that userspace can exploit to implement policies like "only interface
-    with address ranges from certain DIMMs".  It is worth noting that when
-    aliasing is present and a DIMM lacks a label, then no block device can
-    be created by default as userspace needs to do at least one allocation
-    of DPA to the PMEM range.  In contrast ND_NAMESPACE_IO ranges, once
-    registered, can be immediately attached to nd_pmem.
+       Note that while LIBNVDIMM describes system-physical-address ranges that may
+       alias with BLK access as ND_NAMESPACE_PMEM ranges and those without
+       alias as ND_NAMESPACE_IO ranges, to the nd_pmem driver there is no
+       distinction.  The different device-types are an implementation detail
+       that userspace can exploit to implement policies like "only interface
+       with address ranges from certain DIMMs".  It is worth noting that when
+       aliasing is present and a DIMM lacks a label, then no block device can
+       be created by default as userspace needs to do at least one allocation
+       of DPA to the PMEM range.  In contrast ND_NAMESPACE_IO ranges, once
+       registered, can be immediately attached to nd_pmem.
 
     2. BLK (nd_blk.ko): This driver performs I/O using a set of platform
-    defined apertures.  A set of apertures will access just one DIMM.
-    Multiple windows (apertures) allow multiple concurrent accesses, much like
-    tagged-command-queuing, and would likely be used by different threads or
-    different CPUs.
+       defined apertures.  A set of apertures will access just one DIMM.
+       Multiple windows (apertures) allow multiple concurrent accesses, much like
+       tagged-command-queuing, and would likely be used by different threads or
+       different CPUs.
 
-    The NFIT specification defines a standard format for a BLK-aperture, but
-    the spec also allows for vendor specific layouts, and non-NFIT BLK
-    implementations may have other designs for BLK I/O.  For this reason
-    "nd_blk" calls back into platform-specific code to perform the I/O.
-    One such implementation is defined in the "Driver Writer's Guide" and "DSM
-    Interface Example".
+       The NFIT specification defines a standard format for a BLK-aperture, but
+       the spec also allows for vendor specific layouts, and non-NFIT BLK
+       implementations may have other designs for BLK I/O.  For this reason
+       "nd_blk" calls back into platform-specific code to perform the I/O.
+
+       One such implementation is defined in the "Driver Writer's Guide" and "DSM
+       Interface Example".
 
 
 Why BLK?
---------
+========
 
 While PMEM provides direct byte-addressable CPU-load/store access to
 NVDIMM storage, it does not provide the best system RAS (recovery,
@@ -162,12 +188,15 @@ system-physical-address address causes a CPU exception while an access
 to a corrupted address through an BLK-aperture causes that block window
 to raise an error status in a register.  The latter is more aligned with
 the standard error model that host-bus-adapter attached disks present.
+
 Also, if an administrator ever wants to replace a memory it is easier to
 service a system at DIMM module boundaries.  Compare this to PMEM where
 data could be interleaved in an opaque hardware specific manner across
 several DIMMs.
 
 PMEM vs BLK
+-----------
+
 BLK-apertures solve these RAS problems, but their presence is also the
 major contributing factor to the complexity of the ND subsystem.  They
 complicate the implementation because PMEM and BLK alias in DPA space.
@@ -185,13 +214,14 @@ carved into an arbitrary number of BLK devices with discontiguous
 extents.
 
 BLK-REGIONs, PMEM-REGIONs, Atomic Sectors, and DAX
---------------------------------------------------
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 One of the few
 reasons to allow multiple BLK namespaces per REGION is so that each
 BLK-namespace can be configured with a BTT with unique atomic sector
 sizes.  While a PMEM device can host a BTT the LABEL specification does
 not provide for a sector size to be specified for a PMEM namespace.
+
 This is due to the expectation that the primary usage model for PMEM is
 via DAX, and the BTT is incompatible with DAX.  However, for the cases
 where an application or filesystem still needs atomic sector update
@@ -200,52 +230,52 @@ LIBNVDIMM/NDCTL: Block Translation Table "btt"
 
 
 Example NVDIMM Platform
------------------------
+=======================
 
 For the remainder of this document the following diagram will be
-referenced for any example sysfs layouts.
+referenced for any example sysfs layouts::
 
 
-                             (a)               (b)           DIMM   BLK-REGION
-          +-------------------+--------+--------+--------+
-+------+  |       pm0.0       | blk2.0 | pm1.0  | blk2.1 |    0      region2
-| imc0 +--+- - - region0- - - +--------+        +--------+
-+--+---+  |       pm0.0       | blk3.0 | pm1.0  | blk3.1 |    1      region3
-   |      +-------------------+--------v        v--------+
-+--+---+                               |                 |
-| cpu0 |                                     region1
-+--+---+                               |                 |
-   |      +----------------------------^        ^--------+
-+--+---+  |           blk4.0           | pm1.0  | blk4.0 |    2      region4
-| imc1 +--+----------------------------|        +--------+
-+------+  |           blk5.0           | pm1.0  | blk5.0 |    3      region5
-          +----------------------------+--------+--------+
+                               (a)               (b)           DIMM   BLK-REGION
+            +-------------------+--------+--------+--------+
+  +------+  |       pm0.0       | blk2.0 | pm1.0  | blk2.1 |    0      region2
+  | imc0 +--+- - - region0- - - +--------+        +--------+
+  +--+---+  |       pm0.0       | blk3.0 | pm1.0  | blk3.1 |    1      region3
+     |      +-------------------+--------v        v--------+
+  +--+---+                               |                 |
+  | cpu0 |                                     region1
+  +--+---+                               |                 |
+     |      +----------------------------^        ^--------+
+  +--+---+  |           blk4.0           | pm1.0  | blk4.0 |    2      region4
+  | imc1 +--+----------------------------|        +--------+
+  +------+  |           blk5.0           | pm1.0  | blk5.0 |    3      region5
+            +----------------------------+--------+--------+
 
 In this platform we have four DIMMs and two memory controllers in one
 socket.  Each unique interface (BLK or PMEM) to DPA space is identified
 by a region device with a dynamically assigned id (REGION0 - REGION5).
 
     1. The first portion of DIMM0 and DIMM1 are interleaved as REGION0. A
-    single PMEM namespace is created in the REGION0-SPA-range that spans most
-    of DIMM0 and DIMM1 with a user-specified name of "pm0.0". Some of that
-    interleaved system-physical-address range is reclaimed as BLK-aperture
-    accessed space starting at DPA-offset (a) into each DIMM.  In that
-    reclaimed space we create two BLK-aperture "namespaces" from REGION2 and
-    REGION3 where "blk2.0" and "blk3.0" are just human readable names that
-    could be set to any user-desired name in the LABEL.
+       single PMEM namespace is created in the REGION0-SPA-range that spans most
+       of DIMM0 and DIMM1 with a user-specified name of "pm0.0". Some of that
+       interleaved system-physical-address range is reclaimed as BLK-aperture
+       accessed space starting at DPA-offset (a) into each DIMM.  In that
+       reclaimed space we create two BLK-aperture "namespaces" from REGION2 and
+       REGION3 where "blk2.0" and "blk3.0" are just human readable names that
+       could be set to any user-desired name in the LABEL.
 
     2. In the last portion of DIMM0 and DIMM1 we have an interleaved
-    system-physical-address range, REGION1, that spans those two DIMMs as
-    well as DIMM2 and DIMM3.  Some of REGION1 is allocated to a PMEM namespace
-    named "pm1.0", the rest is reclaimed in 4 BLK-aperture namespaces (for
-    each DIMM in the interleave set), "blk2.1", "blk3.1", "blk4.0", and
-    "blk5.0".
+       system-physical-address range, REGION1, that spans those two DIMMs as
+       well as DIMM2 and DIMM3.  Some of REGION1 is allocated to a PMEM namespace
+       named "pm1.0", the rest is reclaimed in 4 BLK-aperture namespaces (for
+       each DIMM in the interleave set), "blk2.1", "blk3.1", "blk4.0", and
+       "blk5.0".
 
     3. The portion of DIMM2 and DIMM3 that do not participate in the REGION1
-    interleaved system-physical-address range (i.e. the DPA address past
-    offset (b) are also included in the "blk4.0" and "blk5.0" namespaces.
-    Note, that this example shows that BLK-aperture namespaces don't need to
-    be contiguous in DPA-space.
+       interleaved system-physical-address range (i.e. the DPA address past
+       offset (b) are also included in the "blk4.0" and "blk5.0" namespaces.
+       Note, that this example shows that BLK-aperture namespaces don't need to
+       be contiguous in DPA-space.
 
     This bus is provided by the kernel under the device
     /sys/devices/platform/nfit_test.0 when CONFIG_NFIT_TEST is enabled and
@@ -254,7 +284,7 @@ by a region device with a dynamically assigned id (REGION0 - REGION5).
 
 
 LIBNVDIMM Kernel Device Model and LIBNDCTL Userspace API
-----------------------------------------------------
+========================================================
 
 What follows is a description of the LIBNVDIMM sysfs layout and a
 corresponding object hierarchy diagram as viewed through the LIBNDCTL
@@ -263,12 +293,18 @@ NVDIMM Platform which is also the LIBNVDIMM bus used in the LIBNDCTL unit
 test.
 
 LIBNDCTL: Context
+-----------------
+
 Every API call in the LIBNDCTL library requires a context that holds the
 logging parameters and other library instance state.  The library is
 based on the libabc template:
-https://git.kernel.org/cgit/linux/kernel/git/kay/libabc.git
+
+	https://git.kernel.org/cgit/linux/kernel/git/kay/libabc.git
 
 LIBNDCTL: instantiate a new library context example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
 
 	struct ndctl_ctx *ctx;
 
@@ -278,7 +314,7 @@ LIBNDCTL: instantiate a new library context example
 		return NULL;
 
 LIBNVDIMM/LIBNDCTL: Bus
--------------------
+-----------------------
 
 A bus has a 1:1 relationship with an NFIT.  The current expectation for
 ACPI based systems is that there is only ever one platform-global NFIT.
@@ -288,9 +324,10 @@ we use this capability to test multiple NFIT configurations in the unit
 test.
 
 LIBNVDIMM: control class device in /sys/class
+---------------------------------------------
 
 This character device accepts DSM messages to be passed to DIMM
-identified by its NFIT handle.
+identified by its NFIT handle::
 
 	/sys/class/nd/ndctl0
 	|-- dev
@@ -300,10 +337,15 @@ identified by its NFIT handle.
 
 
 LIBNVDIMM: bus
+--------------
+
+::
 
 	struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	       struct nvdimm_bus_descriptor *nfit_desc);
 
+::
+
 	/sys/devices/platform/nfit_test.0/ndbus0
 	|-- commands
 	|-- nd
@@ -324,7 +366,9 @@ LIBNVDIMM: bus
 	`-- wait_probe
 
 LIBNDCTL: bus enumeration example
-Find the bus handle that describes the bus from Example NVDIMM Platform
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Find the bus handle that describes the bus from Example NVDIMM Platform::
 
 	static struct ndctl_bus *get_bus_by_provider(struct ndctl_ctx *ctx,
 			const char *provider)
@@ -342,7 +386,7 @@ Find the bus handle that describes the bus from Example NVDIMM Platform
 
 
 LIBNVDIMM/LIBNDCTL: DIMM (NMEM)
----------------------------
+-------------------------------
 
 The DIMM device provides a character device for sending commands to
 hardware, and it is a container for LABELs.  If the DIMM is defined by
@@ -355,11 +399,16 @@ Range Mapping Structure", and there is no requirement that they actually
 be physical DIMMs, so we use a more generic name.
 
 LIBNVDIMM: DIMM (NMEM)
+^^^^^^^^^^^^^^^^^^^^^^
+
+::
 
 	struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
 			const struct attribute_group **groups, unsigned long flags,
 			unsigned long *dsm_mask);
 
+::
+
 	/sys/devices/platform/nfit_test.0/ndbus0
 	|-- nmem0
 	|   |-- available_slots
@@ -384,15 +433,20 @@ LIBNVDIMM: DIMM (NMEM)
 
 
 LIBNDCTL: DIMM enumeration example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Note, in this example we are assuming NFIT-defined DIMMs which are
 identified by an "nfit_handle" a 32-bit value where:
-Bit 3:0 DIMM number within the memory channel
-Bit 7:4 memory channel number
-Bit 11:8 memory controller ID
-Bit 15:12 socket ID (within scope of a Node controller if node controller is present)
-Bit 27:16 Node Controller ID
-Bit 31:28 Reserved
+
+   - Bit 3:0 DIMM number within the memory channel
+   - Bit 7:4 memory channel number
+   - Bit 11:8 memory controller ID
+   - Bit 15:12 socket ID (within scope of a Node controller if node
+     controller is present)
+   - Bit 27:16 Node Controller ID
+   - Bit 31:28 Reserved
+
+::
 
 	static struct ndctl_dimm *get_dimm_by_handle(struct ndctl_bus *bus,
 	       unsigned int handle)
@@ -413,7 +467,7 @@ Bit 31:28 Reserved
 	dimm = get_dimm_by_handle(bus, DIMM_HANDLE(0, 0, 0, 0, 0));
 
 LIBNVDIMM/LIBNDCTL: Region
-----------------------
+--------------------------
 
 A generic REGION device is registered for each PMEM range or BLK-aperture
 set.  Per the example there are 6 regions: 2 PMEM and 4 BLK-aperture
@@ -435,13 +489,15 @@ emits, "devtype" duplicates the DEVTYPE variable stored by udev at the
 at the 'add' event, and finally, the optional "spa_index" is provided in
 the case where the region is defined by a SPA.
 
-LIBNVDIMM: region
+LIBNVDIMM: region::
 
 	struct nd_region *nvdimm_pmem_region_create(struct nvdimm_bus *nvdimm_bus,
 			struct nd_region_desc *ndr_desc);
 	struct nd_region *nvdimm_blk_region_create(struct nvdimm_bus *nvdimm_bus,
 			struct nd_region_desc *ndr_desc);
 
+::
+
 	/sys/devices/platform/nfit_test.0/ndbus0
 	|-- region0
 	|   |-- available_size
@@ -468,10 +524,11 @@ LIBNVDIMM: region
 	[..]
 
 LIBNDCTL: region enumeration example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Sample region retrieval routines based on NFIT-unique data like
 "spa_index" (interleave set id) for PMEM and "nfit_handle" (dimm id) for
-BLK.
+BLK::
 
 	static struct ndctl_region *get_pmem_region_by_spa_index(struct ndctl_bus *bus,
 			unsigned int spa_index)
@@ -518,33 +575,33 @@ REGION name generic and expects userspace to always consider the
 region-attributes for four reasons:
 
     1. There are already more than two REGION and "namespace" types.  For
-    PMEM there are two subtypes.  As mentioned previously we have PMEM where
-    the constituent DIMM devices are known and anonymous PMEM.  For BLK
-    regions the NFIT specification already anticipates vendor specific
-    implementations.  The exact distinction of what a region contains is in
-    the region-attributes not the region-name or the region-devtype.
+       PMEM there are two subtypes.  As mentioned previously we have PMEM where
+       the constituent DIMM devices are known and anonymous PMEM.  For BLK
+       regions the NFIT specification already anticipates vendor specific
+       implementations.  The exact distinction of what a region contains is in
+       the region-attributes not the region-name or the region-devtype.
 
     2. A region with zero child-namespaces is a possible configuration.  For
-    example, the NFIT allows for a DCR to be published without a
-    corresponding BLK-aperture.  This equates to a DIMM that can only accept
-    control/configuration messages, but no i/o through a descendant block
-    device.  Again, this "type" is advertised in the attributes ('mappings'
-    == 0) and the name does not tell you much.
+       example, the NFIT allows for a DCR to be published without a
+       corresponding BLK-aperture.  This equates to a DIMM that can only accept
+       control/configuration messages, but no i/o through a descendant block
+       device.  Again, this "type" is advertised in the attributes ('mappings'
+       == 0) and the name does not tell you much.
 
     3. What if a third major interface type arises in the future?  Outside
-    of vendor specific implementations, it's not difficult to envision a
-    third class of interface type beyond BLK and PMEM.  With a generic name
-    for the REGION level of the device-hierarchy old userspace
-    implementations can still make sense of new kernel advertised
-    region-types.  Userspace can always rely on the generic region
-    attributes like "mappings", "size", etc and the expected child devices
-    named "namespace".  This generic format of the device-model hierarchy
-    allows the LIBNVDIMM and LIBNDCTL implementations to be more uniform and
-    future-proof.
+       of vendor specific implementations, it's not difficult to envision a
+       third class of interface type beyond BLK and PMEM.  With a generic name
+       for the REGION level of the device-hierarchy old userspace
+       implementations can still make sense of new kernel advertised
+       region-types.  Userspace can always rely on the generic region
+       attributes like "mappings", "size", etc and the expected child devices
+       named "namespace".  This generic format of the device-model hierarchy
+       allows the LIBNVDIMM and LIBNDCTL implementations to be more uniform and
+       future-proof.
 
     4. There are more robust mechanisms for determining the major type of a
-    region than a device name.  See the next section, How Do I Determine the
-    Major Type of a Region?
+       region than a device name.  See the next section, How Do I Determine the
+       Major Type of a Region?
 
 How Do I Determine the Major Type of a Region?
 ----------------------------------------------
@@ -553,7 +610,8 @@ Outside of the blanket recommendation of "use libndctl", or simply
 looking at the kernel header (/usr/include/linux/ndctl.h) to decode the
 "nstype" integer attribute, here are some other options.
 
-    1. module alias lookup:
+1. module alias lookup
+^^^^^^^^^^^^^^^^^^^^^^
 
     The whole point of region/namespace device type differentiation is to
     decide which block-device driver will attach to a given LIBNVDIMM namespace.
@@ -569,28 +627,31 @@ looking at the kernel header (/usr/include/linux/ndctl.h) to decode the
     the resulting namespaces.  The output from module resolution is more
     accurate than a region-name or region-devtype.
 
-    2. udev:
+2. udev
+^^^^^^^
 
-    The kernel "devtype" is registered in the udev database
-    # udevadm info --path=/devices/platform/nfit_test.0/ndbus0/region0
-    P: /devices/platform/nfit_test.0/ndbus0/region0
-    E: DEVPATH=/devices/platform/nfit_test.0/ndbus0/region0
-    E: DEVTYPE=nd_pmem
-    E: MODALIAS=nd:t2
-    E: SUBSYSTEM=nd
+    The kernel "devtype" is registered in the udev database::
 
-    # udevadm info --path=/devices/platform/nfit_test.0/ndbus0/region4
-    P: /devices/platform/nfit_test.0/ndbus0/region4
-    E: DEVPATH=/devices/platform/nfit_test.0/ndbus0/region4
-    E: DEVTYPE=nd_blk
-    E: MODALIAS=nd:t3
-    E: SUBSYSTEM=nd
+	# udevadm info --path=/devices/platform/nfit_test.0/ndbus0/region0
+	P: /devices/platform/nfit_test.0/ndbus0/region0
+	E: DEVPATH=/devices/platform/nfit_test.0/ndbus0/region0
+	E: DEVTYPE=nd_pmem
+	E: MODALIAS=nd:t2
+	E: SUBSYSTEM=nd
+
+	# udevadm info --path=/devices/platform/nfit_test.0/ndbus0/region4
+	P: /devices/platform/nfit_test.0/ndbus0/region4
+	E: DEVPATH=/devices/platform/nfit_test.0/ndbus0/region4
+	E: DEVTYPE=nd_blk
+	E: MODALIAS=nd:t3
+	E: SUBSYSTEM=nd
 
     ...and is available as a region attribute, but keep in mind that the
     "devtype" does not indicate sub-type variations and scripts should
     really be understanding the other attributes.
 
-    3. type specific attributes:
+3. type specific attributes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
     As it currently stands a BLK-aperture region will never have a
     "nfit/spa_index" attribute, but neither will a non-NFIT PMEM region.  A
@@ -600,7 +661,7 @@ looking at the kernel header (/usr/include/linux/ndctl.h) to decode the
 
 
 LIBNVDIMM/LIBNDCTL: Namespace
--------------------------
+-----------------------------
 
 A REGION, after resolving DPA aliasing and LABEL specified boundaries,
 surfaces one or more "namespace" devices.  The arrival of a "namespace"
@@ -608,12 +669,14 @@ device currently triggers either the nd_blk or nd_pmem driver to load
 and register a disk/block device.
 
 LIBNVDIMM: namespace
+^^^^^^^^^^^^^^^^^^^^
+
 Here is a sample layout from the three major types of NAMESPACE where
 namespace0.0 represents DIMM-info-backed PMEM (note that it has a 'uuid'
 attribute), namespace2.0 represents a BLK namespace (note it has a
 'sector_size' attribute) that, and namespace6.0 represents an anonymous
 PMEM namespace (note that has no 'uuid' attribute due to not support a
-LABEL).
+LABEL)::
 
 	/sys/devices/platform/nfit_test.0/ndbus0/region0/namespace0.0
 	|-- alt_name
@@ -656,76 +719,84 @@ LABEL).
 	`-- uevent
 
 LIBNDCTL: namespace enumeration example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Namespaces are indexed relative to their parent region, example below.
 These indexes are mostly static from boot to boot, but subsystem makes
 no guarantees in this regard.  For a static namespace identifier use its
 'uuid' attribute.
 
-static struct ndctl_namespace *get_namespace_by_id(struct ndctl_region *region,
-                unsigned int id)
-{
-        struct ndctl_namespace *ndns;
+::
 
-        ndctl_namespace_foreach(region, ndns)
-                if (ndctl_namespace_get_id(ndns) == id)
-                        return ndns;
+  static struct ndctl_namespace
+  *get_namespace_by_id(struct ndctl_region *region, unsigned int id)
+  {
+          struct ndctl_namespace *ndns;
 
-        return NULL;
-}
+          ndctl_namespace_foreach(region, ndns)
+                  if (ndctl_namespace_get_id(ndns) == id)
+                          return ndns;
+
+          return NULL;
+  }
 
 LIBNDCTL: namespace creation example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
 Idle namespaces are automatically created by the kernel if a given
 region has enough available capacity to create a new namespace.
 Namespace instantiation involves finding an idle namespace and
 configuring it.  For the most part the setting of namespace attributes
 can occur in any order, the only constraint is that 'uuid' must be set
 before 'size'.  This enables the kernel to track DPA allocations
-internally with a static identifier.
+internally with a static identifier::
 
-static int configure_namespace(struct ndctl_region *region,
-                struct ndctl_namespace *ndns,
-                struct namespace_parameters *parameters)
-{
-        char devname[50];
+  static int configure_namespace(struct ndctl_region *region,
+                  struct ndctl_namespace *ndns,
+                  struct namespace_parameters *parameters)
+  {
+          char devname[50];
 
-        snprintf(devname, sizeof(devname), "namespace%d.%d",
-                        ndctl_region_get_id(region), paramaters->id);
+          snprintf(devname, sizeof(devname), "namespace%d.%d",
+                          ndctl_region_get_id(region), paramaters->id);
 
-        ndctl_namespace_set_alt_name(ndns, devname);
-        /* 'uuid' must be set prior to setting size! */
-        ndctl_namespace_set_uuid(ndns, paramaters->uuid);
-        ndctl_namespace_set_size(ndns, paramaters->size);
-        /* unlike pmem namespaces, blk namespaces have a sector size */
-        if (parameters->lbasize)
-                ndctl_namespace_set_sector_size(ndns, parameters->lbasize);
-        ndctl_namespace_enable(ndns);
-}
+          ndctl_namespace_set_alt_name(ndns, devname);
+          /* 'uuid' must be set prior to setting size! */
+          ndctl_namespace_set_uuid(ndns, paramaters->uuid);
+          ndctl_namespace_set_size(ndns, paramaters->size);
+          /* unlike pmem namespaces, blk namespaces have a sector size */
+          if (parameters->lbasize)
+                  ndctl_namespace_set_sector_size(ndns, parameters->lbasize);
+          ndctl_namespace_enable(ndns);
+  }
 
 
 Why the Term "namespace"?
+^^^^^^^^^^^^^^^^^^^^^^^^^
 
     1. Why not "volume" for instance?  "volume" ran the risk of confusing
-    ND (libnvdimm subsystem) to a volume manager like device-mapper.
+       ND (libnvdimm subsystem) to a volume manager like device-mapper.
 
     2. The term originated to describe the sub-devices that can be created
-    within a NVME controller (see the nvme specification:
-    http://www.nvmexpress.org/specifications/), and NFIT namespaces are
-    meant to parallel the capabilities and configurability of
-    NVME-namespaces.
+       within a NVME controller (see the nvme specification:
+       http://www.nvmexpress.org/specifications/), and NFIT namespaces are
+       meant to parallel the capabilities and configurability of
+       NVME-namespaces.
 
 
 LIBNVDIMM/LIBNDCTL: Block Translation Table "btt"
----------------------------------------------
+-------------------------------------------------
 
 A BTT (design document: http://pmem.io/2014/09/23/btt.html) is a stacked
 block device driver that fronts either the whole block device or a
 partition of a block device emitted by either a PMEM or BLK NAMESPACE.
 
 LIBNVDIMM: btt layout
+^^^^^^^^^^^^^^^^^^^^^
+
 Every region will start out with at least one BTT device which is the
 seed device.  To activate it set the "namespace", "uuid", and
 "sector_size" attributes and then bind the device to the nd_pmem or
-nd_blk driver depending on the region type.
+nd_blk driver depending on the region type::
 
 	/sys/devices/platform/nfit_test.1/ndbus0/region0/btt0/
 	|-- namespace
@@ -739,10 +810,12 @@ nd_blk driver depending on the region type.
 	`-- uuid
 
 LIBNDCTL: btt creation example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
 Similar to namespaces an idle BTT device is automatically created per
 region.  Each time this "seed" btt device is configured and enabled a new
 seed is created.  Creating a BTT configuration involves two steps of
-finding and idle BTT and assigning it to consume a PMEM or BLK namespace.
+finding and idle BTT and assigning it to consume a PMEM or BLK namespace::
 
 	static struct ndctl_btt *get_idle_btt(struct ndctl_region *region)
 	{
@@ -787,29 +860,28 @@ Summary LIBNDCTL Diagram
 ------------------------
 
 For the given example above, here is the view of the objects as seen by the
-LIBNDCTL API:
-            +---+
-            |CTX|    +---------+   +--------------+  +---------------+
-            +-+-+  +-> REGION0 +---> NAMESPACE0.0 +--> PMEM8 "pm0.0" |
-              |    | +---------+   +--------------+  +---------------+
-+-------+     |    | +---------+   +--------------+  +---------------+
-| DIMM0 <-+   |    +-> REGION1 +---> NAMESPACE1.0 +--> PMEM6 "pm1.0" |
-+-------+ |   |    | +---------+   +--------------+  +---------------+
-| DIMM1 <-+ +-v--+ | +---------+   +--------------+  +---------------+
-+-------+ +-+BUS0+---> REGION2 +-+-> NAMESPACE2.0 +--> ND6  "blk2.0" |
-| DIMM2 <-+ +----+ | +---------+ | +--------------+  +----------------------+
-+-------+ |        |             +-> NAMESPACE2.1 +--> ND5  "blk2.1" | BTT2 |
-| DIMM3 <-+        |               +--------------+  +----------------------+
-+-------+          | +---------+   +--------------+  +---------------+
-                   +-> REGION3 +-+-> NAMESPACE3.0 +--> ND4  "blk3.0" |
-                   | +---------+ | +--------------+  +----------------------+
-                   |             +-> NAMESPACE3.1 +--> ND3  "blk3.1" | BTT1 |
-                   |               +--------------+  +----------------------+
-                   | +---------+   +--------------+  +---------------+
-                   +-> REGION4 +---> NAMESPACE4.0 +--> ND2  "blk4.0" |
-                   | +---------+   +--------------+  +---------------+
-                   | +---------+   +--------------+  +----------------------+
-                   +-> REGION5 +---> NAMESPACE5.0 +--> ND1  "blk5.0" | BTT0 |
-                     +---------+   +--------------+  +---------------+------+
-
+LIBNDCTL API::
 
+              +---+
+              |CTX|    +---------+   +--------------+  +---------------+
+              +-+-+  +-> REGION0 +---> NAMESPACE0.0 +--> PMEM8 "pm0.0" |
+                |    | +---------+   +--------------+  +---------------+
+  +-------+     |    | +---------+   +--------------+  +---------------+
+  | DIMM0 <-+   |    +-> REGION1 +---> NAMESPACE1.0 +--> PMEM6 "pm1.0" |
+  +-------+ |   |    | +---------+   +--------------+  +---------------+
+  | DIMM1 <-+ +-v--+ | +---------+   +--------------+  +---------------+
+  +-------+ +-+BUS0+---> REGION2 +-+-> NAMESPACE2.0 +--> ND6  "blk2.0" |
+  | DIMM2 <-+ +----+ | +---------+ | +--------------+  +----------------------+
+  +-------+ |        |             +-> NAMESPACE2.1 +--> ND5  "blk2.1" | BTT2 |
+  | DIMM3 <-+        |               +--------------+  +----------------------+
+  +-------+          | +---------+   +--------------+  +---------------+
+                     +-> REGION3 +-+-> NAMESPACE3.0 +--> ND4  "blk3.0" |
+                     | +---------+ | +--------------+  +----------------------+
+                     |             +-> NAMESPACE3.1 +--> ND3  "blk3.1" | BTT1 |
+                     |               +--------------+  +----------------------+
+                     | +---------+   +--------------+  +---------------+
+                     +-> REGION4 +---> NAMESPACE4.0 +--> ND2  "blk4.0" |
+                     | +---------+   +--------------+  +---------------+
+                     | +---------+   +--------------+  +----------------------+
+                     +-> REGION5 +---> NAMESPACE5.0 +--> ND1  "blk5.0" | BTT0 |
+                       +---------+   +--------------+  +---------------+------+
diff --git a/Documentation/nvdimm/security.txt b/Documentation/nvdimm/security.rst
similarity index 99%
rename from Documentation/nvdimm/security.txt
rename to Documentation/nvdimm/security.rst
index 4c36c05ca98e..ad9dea099b34 100644
--- a/Documentation/nvdimm/security.txt
+++ b/Documentation/nvdimm/security.rst
@@ -1,4 +1,5 @@
-NVDIMM SECURITY
+===============
+NVDIMM Security
 ===============
 
 1. Introduction
@@ -138,4 +139,5 @@ This command is only available when the master security is enabled, indicated
 by the extended security status.
 
 [1]: http://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
+
 [2]: http://www.t13.org/documents/UploadedDocuments/docs2006/e05179r4-ACS-SecurityClarifications.pdf
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 54500798f23a..e89c1c332407 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -33,7 +33,7 @@ config BLK_DEV_PMEM
 	  Documentation/admin-guide/kernel-parameters.rst).  This driver converts
 	  these persistent memory ranges into block devices that are
 	  capable of DAX (direct-access) file system mappings.  See
-	  Documentation/nvdimm/nvdimm.txt for more details.
+	  Documentation/nvdimm/nvdimm.rst for more details.
 
 	  Say Y if you want to use an NVDIMM
 
-- 
2.21.0

