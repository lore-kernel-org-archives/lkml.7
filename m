Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0136C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BB020656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383561;
	bh=V1hQ9wwOL1kMw/OMDhJfDaj+NBIwL7APnlBk22YsRNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VS1W6KbeRTU+VPPS2+4GEiFLsvvZW1fyi+C265RPMaWGANql1m7jyhTI11wDDYCnM
	 bYhP1r0QltYud51cy7C+BtehgdWKbmlraDZiE0hBcdQsWcrpmRGVH5LTct5yfdu2Ra
	 ZBxZNuigmzZOw4OYxh/CvuYOJ8eZavEutZ94TQb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfDPC7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfDPC4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kcb7E1tqPyZTcZaFa0FQOtnRkKhYW7nxx751EV3FLOY=; b=fECzn5Aen25iWvaaXa6/M+PsCc
        QCzZkpybN0sj4gIS0c3VeRPNG9w7On526sVOOqWPiIdw5cOYTwlCjQ1WivKncXPDIaj2RD+Yn2SkS
        VRFKC4YtbEaFVvF0BXtuj1tbnZcKzqJBe4NmKvUg3COqnYJFH1hIz5dcKEn/Hdxe3L7UWhHqEOBG0
        0c/jmJ7UP7i+YAh32izXbDC0nS8wlblzVrwcvq1xoRhFrIdVxKOGBUvjviKpA8vS2vtrAlpM6Xrhz
        EIhTa31F2+JixR8nQGmKr1Si9+CRhP6w+kMXGa4Xc2w2nNaDvSbUzHsnd1wIZblmcNnGCydOJsoTw
        oua4EpGA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007aQ-PJ; Tue, 16 Apr 2019 02:56:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001qT-H7; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 57/57] docs: Prepare files to be renamed to *.rst
Date:   Mon, 15 Apr 2019 23:56:22 -0300
Message-Id: <bdcce3a5ab96fa2393f0e38d336844a36dfd35ef.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some blank spaces at the end of the lines.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/bt8xxgpio.txt             |  1 -
 Documentation/bus-virt-phys-mapping.txt | 50 ++++++++++++------------
 Documentation/highuid.txt               |  2 +-
 Documentation/kobject.txt               |  2 +-
 Documentation/ldm.txt                   |  3 +-
 Documentation/memory-barriers.txt       |  2 +-
 Documentation/numastat.txt              |  1 -
 Documentation/pnp.txt                   | 11 +++---
 Documentation/preempt-locking.txt       |  2 +-
 Documentation/rbtree.txt                | 52 ++++++++++++-------------
 Documentation/rtc.txt                   |  6 +--
 Documentation/zorro.txt                 |  5 +--
 12 files changed, 66 insertions(+), 71 deletions(-)

diff --git a/Documentation/bt8xxgpio.txt b/Documentation/bt8xxgpio.txt
index a845feb074de..4f937bead52c 100644
--- a/Documentation/bt8xxgpio.txt
+++ b/Documentation/bt8xxgpio.txt
@@ -59,4 +59,3 @@ The GPIO pins are marked with G00-G23::
            | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
            ^
            This is pin 1
-
diff --git a/Documentation/bus-virt-phys-mapping.txt b/Documentation/bus-virt-phys-mapping.txt
index 4bb07c2f3e7d..0d45d6cf0fcb 100644
--- a/Documentation/bus-virt-phys-mapping.txt
+++ b/Documentation/bus-virt-phys-mapping.txt
@@ -19,35 +19,35 @@ How to access I/O mapped memory from within device drivers
 
 The AHA-1542 is a bus-master device, and your patch makes the driver give the
 controller the physical address of the buffers, which is correct on x86
-(because all bus master devices see the physical memory mappings directly). 
+(because all bus master devices see the physical memory mappings directly).
 
 However, on many setups, there are actually **three** different ways of looking
 at memory addresses, and in this case we actually want the third, the
-so-called "bus address". 
+so-called "bus address".
 
 Essentially, the three ways of addressing memory are (this is "real memory",
-that is, normal RAM--see later about other details): 
+that is, normal RAM--see later about other details):
 
- - CPU untranslated.  This is the "physical" address.  Physical address 
+ - CPU untranslated.  This is the "physical" address.  Physical address
    0 is what the CPU sees when it drives zeroes on the memory bus.
 
- - CPU translated address. This is the "virtual" address, and is 
+ - CPU translated address. This is the "virtual" address, and is
    completely internal to the CPU itself with the CPU doing the appropriate
-   translations into "CPU untranslated". 
+   translations into "CPU untranslated".
 
- - bus address. This is the address of memory as seen by OTHER devices, 
-   not the CPU. Now, in theory there could be many different bus 
+ - bus address. This is the address of memory as seen by OTHER devices,
+   not the CPU. Now, in theory there could be many different bus
    addresses, with each device seeing memory in some device-specific way, but
    happily most hardware designers aren't actually actively trying to make
-   things any more complex than necessary, so you can assume that all 
-   external hardware sees the memory the same way. 
+   things any more complex than necessary, so you can assume that all
+   external hardware sees the memory the same way.
 
 Now, on normal PCs the bus address is exactly the same as the physical
 address, and things are very simple indeed. However, they are that simple
 because the memory and the devices share the same address space, and that is
-not generally necessarily true on other PCI/ISA setups. 
+not generally necessarily true on other PCI/ISA setups.
 
-Now, just as an example, on the PReP (PowerPC Reference Platform), the 
+Now, just as an example, on the PReP (PowerPC Reference Platform), the
 CPU sees a memory map something like this (this is from memory)::
 
 	0-2 GB		"real memory"
@@ -58,17 +58,17 @@ Now, that looks simple enough. However, when you look at the same thing from
 the viewpoint of the devices, you have the reverse, and the physical memory
 address 0 actually shows up as address 2 GB for any IO master.
 
-So when the CPU wants any bus master to write to physical memory 0, it 
+So when the CPU wants any bus master to write to physical memory 0, it
 has to give the master address 0x80000000 as the memory address.
 
-So, for example, depending on how the kernel is actually mapped on the 
+So, for example, depending on how the kernel is actually mapped on the
 PPC, you can end up with a setup like this::
 
  physical address:	0
  virtual address:	0xC0000000
  bus address:		0x80000000
 
-where all the addresses actually point to the same thing.  It's just seen 
+where all the addresses actually point to the same thing.  It's just seen
 through different translations..
 
 Similarly, on the Alpha, the normal translation is::
@@ -78,7 +78,7 @@ Similarly, on the Alpha, the normal translation is::
  bus address:		0x40000000
 
 (but there are also Alphas where the physical address and the bus address
-are the same). 
+are the same).
 
 Anyway, the way to look up all these translations, you do::
 
@@ -113,7 +113,7 @@ pointer from the kernel. So you can have something like this::
 			case STATUS_OK:
 				...
 
-on the other hand, you want the bus address when you have a buffer that 
+on the other hand, you want the bus address when you have a buffer that
 you want to give to the controller::
 
 	/* ask the controller to read the sense status into "sense_buffer" */
@@ -124,7 +124,7 @@ you want to give to the controller::
 
 And you generally **never** want to use the physical address, because you can't
 use that from the CPU (the CPU only uses translated virtual addresses), and
-you can't use it from the bus master. 
+you can't use it from the bus master.
 
 So why do we care about the physical address at all? We do need the physical
 address in some cases, it's just not very often in normal code.  The physical
@@ -142,7 +142,7 @@ shouldn't need to know about "bus addresses" etc).
 There is a completely different type of memory too, and that's the "shared
 memory" on the PCI or ISA bus. That's generally not RAM (although in the case
 of a video graphics card it can be normal DRAM that is just used for a frame
-buffer), but can be things like a packet buffer in a network card etc. 
+buffer), but can be things like a packet buffer in a network card etc.
 
 This memory is called "PCI memory" or "shared memory" or "IO memory" or
 whatever, and there is only one way to access it: the readb/writeb and
@@ -151,7 +151,7 @@ there is really nothing you can do with such an address: it's not
 conceptually in the same memory space as "real memory" at all, so you cannot
 just dereference a pointer. (Sadly, on x86 it **is** in the same memory space,
 so on x86 it actually works to just deference a pointer, but it's not
-portable). 
+portable).
 
 For such memory, you can do things like:
 
@@ -197,19 +197,19 @@ Note that kernel versions 2.0.x (and earlier) mistakenly called the
 ioremap() function "vremap()".  ioremap() is the proper name, but I
 didn't think straight when I wrote it originally.  People who have to
 support both can do something like::
- 
+
 	/* support old naming silliness */
 	#if LINUX_VERSION_CODE < 0x020100
 	#define ioremap vremap
-	#define iounmap vfree                                                     
+	#define iounmap vfree
 	#endif
- 
+
 at the top of their source files, and then they can use the right names
-even on 2.0.x systems. 
+even on 2.0.x systems.
 
 And the above sounds worse than it really is.  Most real drivers really
 don't do all that complex things (or rather: the complexity is not so
-much in the actual IO accesses as in error handling and timeouts etc). 
+much in the actual IO accesses as in error handling and timeouts etc).
 It's generally not hard to fix drivers, and in many cases the code
 actually looks better afterwards::
 
diff --git a/Documentation/highuid.txt b/Documentation/highuid.txt
index 6ee70465c0ea..1ab59d7807d1 100644
--- a/Documentation/highuid.txt
+++ b/Documentation/highuid.txt
@@ -19,7 +19,7 @@ What's left to be done for 32-bit UIDs on all Linux architectures:
   underlying filesystem, because quota records are written at offsets
   corresponding to the UID in question.
   Further investigation is needed to see if the quota system can cope
-  properly with huge UIDs. If it can deal with 64-bit file offsets on all 
+  properly with huge UIDs. If it can deal with 64-bit file offsets on all
   architectures, this should not be a problem.
 
 - Decide whether or not to keep backwards compatibility with the system
diff --git a/Documentation/kobject.txt b/Documentation/kobject.txt
index ff4c25098119..fa0009ca0bc7 100644
--- a/Documentation/kobject.txt
+++ b/Documentation/kobject.txt
@@ -270,7 +270,7 @@ such a method has a form like::
 
     void my_object_release(struct kobject *kobj)
     {
-    	    struct my_object *mine = container_of(kobj, struct my_object, kobj);
+	    struct my_object *mine = container_of(kobj, struct my_object, kobj);
 
 	    /* Perform any additional cleanup on this object, then... */
 	    kfree(mine);
diff --git a/Documentation/ldm.txt b/Documentation/ldm.txt
index 12c571368e73..90ccf24ebfdd 100644
--- a/Documentation/ldm.txt
+++ b/Documentation/ldm.txt
@@ -75,7 +75,7 @@ When Linux boots, you will see something like::
 Compiling LDM Support
 ---------------------
 
-To enable LDM, choose the following two options: 
+To enable LDM, choose the following two options:
 
   - "Advanced partition selection" CONFIG_PARTITION_ADVANCED
   - "Windows Logical Disk Manager (Dynamic Disk) support" CONFIG_LDM_PARTITION
@@ -118,4 +118,3 @@ me.
 Cheers,
     FlatCap - Richard Russon
     ldm@flatcap.org
-
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 4e0446230205..f585022aed8f 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -334,7 +334,7 @@ And there are anti-guarantees:
      of the standard containing this guarantee is Section 3.14, which
      defines "memory location" as follows:
 
-     	memory location
+	memory location
 		either an object of scalar type, or a maximal sequence
 		of adjacent bit-fields all having nonzero width
 
diff --git a/Documentation/numastat.txt b/Documentation/numastat.txt
index aaf1667489f8..d6f07ca00c27 100644
--- a/Documentation/numastat.txt
+++ b/Documentation/numastat.txt
@@ -27,4 +27,3 @@ interleave_hit 	Interleaving wanted to allocate from this node
 For easier reading you can use the numastat utility from the numactl package
 (http://oss.sgi.com/projects/libnuma/). Note that it only works
 well right now on machines with a small number of CPUs.
-
diff --git a/Documentation/pnp.txt b/Documentation/pnp.txt
index bab2d10631f0..c103acb9ad99 100644
--- a/Documentation/pnp.txt
+++ b/Documentation/pnp.txt
@@ -10,7 +10,7 @@ Overview
 --------
 
 Plug and Play provides a means of detecting and setting resources for legacy or
-otherwise unconfigurable devices.  The Linux Plug and Play Layer provides these 
+otherwise unconfigurable devices.  The Linux Plug and Play Layer provides these
 services to compatible drivers.
 
 
@@ -18,7 +18,7 @@ The User Interface
 ------------------
 
 The Linux Plug and Play user interface provides a means to activate PnP devices
-for legacy and user level drivers that do not support Linux Plug and Play.  The 
+for legacy and user level drivers that do not support Linux Plug and Play.  The
 user interface is integrated into sysfs.
 
 In addition to the standard sysfs file the following are created in each
@@ -113,9 +113,9 @@ The Unified Plug and Play Layer
 -------------------------------
 
 All Plug and Play drivers, protocols, and services meet at a central location
-called the Plug and Play Layer.  This layer is responsible for the exchange of 
-information between PnP drivers and PnP protocols.  Thus it automatically 
-forwards commands to the proper protocol.  This makes writing PnP drivers 
+called the Plug and Play Layer.  This layer is responsible for the exchange of
+information between PnP drivers and PnP protocols.  Thus it automatically
+forwards commands to the proper protocol.  This makes writing PnP drivers
 significantly easier.
 
 The following functions are available from the Plug and Play Layer:
@@ -289,4 +289,3 @@ They are as follows::
 				     unsigned short vendor,
 				     unsigned short function,
 				     struct pnp_dev *from)
-
diff --git a/Documentation/preempt-locking.txt b/Documentation/preempt-locking.txt
index 509f5a422d57..47ad9688dc11 100644
--- a/Documentation/preempt-locking.txt
+++ b/Documentation/preempt-locking.txt
@@ -16,7 +16,7 @@ requires explicit additional locking for very few additional situations.
 
 This document is for all kernel hackers.  Developing code in the kernel
 requires protecting these situations.
- 
+
 
 RULE #1: Per-CPU data structures need explicit protection
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/Documentation/rbtree.txt b/Documentation/rbtree.txt
index c42a21b99046..f2bea06b471b 100644
--- a/Documentation/rbtree.txt
+++ b/Documentation/rbtree.txt
@@ -62,8 +62,8 @@ Creating a new rbtree
 Data nodes in an rbtree tree are structures containing a struct rb_node member::
 
   struct mytype {
-  	struct rb_node node;
-  	char *keystring;
+	struct rb_node node;
+	char *keystring;
   };
 
 When dealing with a pointer to the embedded struct rb_node, the containing data
@@ -85,20 +85,20 @@ Example::
 
   struct mytype *my_search(struct rb_root *root, char *string)
   {
-  	struct rb_node *node = root->rb_node;
+	struct rb_node *node = root->rb_node;
 
-  	while (node) {
-  		struct mytype *data = container_of(node, struct mytype, node);
+	while (node) {
+		struct mytype *data = container_of(node, struct mytype, node);
 		int result;
 
 		result = strcmp(string, data->keystring);
 
 		if (result < 0)
-  			node = node->rb_left;
+			node = node->rb_left;
 		else if (result > 0)
-  			node = node->rb_right;
+			node = node->rb_right;
 		else
-  			return data;
+			return data;
 	}
 	return NULL;
   }
@@ -117,25 +117,25 @@ Example::
 
   int my_insert(struct rb_root *root, struct mytype *data)
   {
-  	struct rb_node **new = &(root->rb_node), *parent = NULL;
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
 
-  	/* Figure out where to put new node */
-  	while (*new) {
-  		struct mytype *this = container_of(*new, struct mytype, node);
-  		int result = strcmp(data->keystring, this->keystring);
+	/* Figure out where to put new node */
+	while (*new) {
+		struct mytype *this = container_of(*new, struct mytype, node);
+		int result = strcmp(data->keystring, this->keystring);
 
 		parent = *new;
-  		if (result < 0)
-  			new = &((*new)->rb_left);
-  		else if (result > 0)
-  			new = &((*new)->rb_right);
-  		else
-  			return FALSE;
-  	}
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0)
+			new = &((*new)->rb_right);
+		else
+			return FALSE;
+	}
 
-  	/* Add new node and rebalance tree. */
-  	rb_link_node(&data->node, parent, new);
-  	rb_insert_color(&data->node, root);
+	/* Add new node and rebalance tree. */
+	rb_link_node(&data->node, parent, new);
+	rb_insert_color(&data->node, root);
 
 	return TRUE;
   }
@@ -152,14 +152,14 @@ Example::
   struct mytype *data = mysearch(&mytree, "walrus");
 
   if (data) {
-  	rb_erase(&data->node, &mytree);
-  	myfree(data);
+	rb_erase(&data->node, &mytree);
+	myfree(data);
   }
 
 To replace an existing node in a tree with a new one with the same key, call::
 
   void rb_replace_node(struct rb_node *old, struct rb_node *new,
-  			struct rb_root *tree);
+			struct rb_root *tree);
 
 Replacing a node this way does not re-sort the tree: If the new node doesn't
 have the same key as the old node, the rbtree will probably become corrupted.
diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
index 688c95b11919..c7647de33c69 100644
--- a/Documentation/rtc.txt
+++ b/Documentation/rtc.txt
@@ -86,9 +86,9 @@ a different value to /proc/sys/dev/rtc/max-user-freq. Note that the
 interrupt handler is only a few lines of code to minimize any possibility
 of this effect.
 
-Also, if the kernel time is synchronized with an external source, the 
-kernel will write the time back to the CMOS clock every 11 minutes. In 
-the process of doing this, the kernel briefly turns off RTC periodic 
+Also, if the kernel time is synchronized with an external source, the
+kernel will write the time back to the CMOS clock every 11 minutes. In
+the process of doing this, the kernel briefly turns off RTC periodic
 interrupts, so be aware of this if you are doing serious work. If you
 don't synchronize the kernel time with an external source (via ntp or
 whatever) then the kernel will keep its hands off the RTC, allowing you
diff --git a/Documentation/zorro.txt b/Documentation/zorro.txt
index 664072b017e3..59fb1634d903 100644
--- a/Documentation/zorro.txt
+++ b/Documentation/zorro.txt
@@ -77,7 +77,7 @@ The treatment of these regions depends on the type of Zorro space:
 
   - Zorro II address space is always mapped and does not have to be mapped
     explicitly using z_ioremap().
-    
+
     Conversion from bus/physical Zorro II addresses to kernel virtual addresses
     and vice versa is done using::
 
@@ -86,7 +86,7 @@ The treatment of these regions depends on the type of Zorro space:
 
   - Zorro III address space must be mapped explicitly using z_ioremap() first
     before it can be accessed::
- 
+
 	virt_addr = z_ioremap(bus_addr, size);
 	...
 	z_iounmap(virt_addr);
@@ -101,4 +101,3 @@ References
 #. linux/arch/m68k/include/asm/zorro.h
 #. linux/drivers/zorro
 #. /proc/bus/zorro
-
-- 
2.20.1

