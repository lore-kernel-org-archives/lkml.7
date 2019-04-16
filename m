Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158DEC10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22A120656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383577;
	bh=cAGGJ49HCUzqq2Pe1PM7DqxJ7jBcatCCiTC4f7oEQVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5bnlFnd+tqW4x4RImSOSChAFddHFi+Z0HKQHZyid1HY/lUzzKpyBAjRii30tFZaO
	 6QfYUydOL7d6+EYbtYYOchxmLfnTpbwJXRSE53KbuF7K3cICi/Lhvo+zl0kQsP0JwZ
	 LSKOLlEpGBcrXSGz/DEYRoWpkNx6ITUvTWrAFN64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfDPC7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfDPC4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/VzG0YXdXHJ9ZtCcrpIi7oaW0f0a2ODYrm0DVq0JNz0=; b=GgmpuiroACiuMBFGQXRT7GWNk3
        OZpuxooHmfNptvaOku3k/yGKwPL4F5Kk38gRRuG4jY++CV6uS/EuE3WokNRaNSa6g/UCtq/7m6/qf
        496EhYvzVpOHwvtUflbHn1W7cIAvx+clV3VRisCeg1MttJM/kVON6JkIeh1jTFAixnzautOMlMTZH
        96cIFd2XoqKsl5AiUF0wKXdeE19QKZLhO1EuX4Sz++7Z9isVkihiIyH1V2BygRHnrnAEDWNQ0yWSL
        K2gqUqxkb0whShxWwwF1CKoGdPK0VrvsotS+gVHPVYZBeCpg90FPd+rPqIcBq1wmi1ONti1cWFv2F
        MxwXWSCA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007aZ-Fj; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001mE-B2; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 17/57] docs: infiniband: convert it to ReST format
Date:   Mon, 15 Apr 2019 23:55:42 -0300
Message-Id: <e970a98fd804de0cf1663ad3e3b9144027e29eb6.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The InfiniBand docs are plain text with no markups.
So, all we needed to do were to add the title markups and
some markup sequences in order to properly parse tables,
lists and literal blocks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/infiniband/core_locking.txt |  64 +++++++------
 Documentation/infiniband/ipoib.txt        |  24 +++--
 Documentation/infiniband/opa_vnic.txt     | 108 ++++++++++++----------
 Documentation/infiniband/sysfs.txt        |   4 +-
 Documentation/infiniband/tag_matching.txt |   5 +
 Documentation/infiniband/user_mad.txt     |  33 +++++--
 Documentation/infiniband/user_verbs.txt   |  12 ++-
 7 files changed, 149 insertions(+), 101 deletions(-)

diff --git a/Documentation/infiniband/core_locking.txt b/Documentation/infiniband/core_locking.txt
index 4b1f36b6ada0..f34669beb4fe 100644
--- a/Documentation/infiniband/core_locking.txt
+++ b/Documentation/infiniband/core_locking.txt
@@ -1,4 +1,6 @@
-INFINIBAND MIDLAYER LOCKING
+===========================
+InfiniBand Midlayer Locking
+===========================
 
   This guide is an attempt to make explicit the locking assumptions
   made by the InfiniBand midlayer.  It describes the requirements on
@@ -6,45 +8,47 @@ INFINIBAND MIDLAYER LOCKING
   protocols that use the midlayer.
 
 Sleeping and interrupt context
+==============================
 
   With the following exceptions, a low-level driver implementation of
   all of the methods in struct ib_device may sleep.  The exceptions
   are any methods from the list:
 
-    create_ah
-    modify_ah
-    query_ah
-    destroy_ah
-    post_send
-    post_recv
-    poll_cq
-    req_notify_cq
-    map_phys_fmr
+    - create_ah
+    - modify_ah
+    - query_ah
+    - destroy_ah
+    - post_send
+    - post_recv
+    - poll_cq
+    - req_notify_cq
+    - map_phys_fmr
 
   which may not sleep and must be callable from any context.
 
   The corresponding functions exported to upper level protocol
   consumers:
 
-    ib_create_ah
-    ib_modify_ah
-    ib_query_ah
-    ib_destroy_ah
-    ib_post_send
-    ib_post_recv
-    ib_req_notify_cq
-    ib_map_phys_fmr
+    - ib_create_ah
+    - ib_modify_ah
+    - ib_query_ah
+    - ib_destroy_ah
+    - ib_post_send
+    - ib_post_recv
+    - ib_req_notify_cq
+    - ib_map_phys_fmr
 
   are therefore safe to call from any context.
 
   In addition, the function
 
-    ib_dispatch_event
+    - ib_dispatch_event
 
   used by low-level drivers to dispatch asynchronous events through
   the midlayer is also safe to call from any context.
 
 Reentrancy
+----------
 
   All of the methods in struct ib_device exported by a low-level
   driver must be fully reentrant.  The low-level driver is required to
@@ -62,6 +66,7 @@ Reentrancy
   information between different calls of ib_poll_cq() is not defined.
 
 Callbacks
+---------
 
   A low-level driver must not perform a callback directly from the
   same callchain as an ib_device method call.  For example, it is not
@@ -74,18 +79,18 @@ Callbacks
   completion event handlers for the same CQ are not called
   simultaneously.  The driver must guarantee that only one CQ event
   handler for a given CQ is running at a time.  In other words, the
-  following situation is not allowed:
+  following situation is not allowed::
 
-        CPU1                                    CPU2
+          CPU1                                    CPU2
 
-  low-level driver ->
-    consumer CQ event callback:
-      /* ... */
-      ib_req_notify_cq(cq, ...);
-                                        low-level driver ->
-      /* ... */                           consumer CQ event callback:
-                                            /* ... */
-      return from CQ event handler
+    low-level driver ->
+      consumer CQ event callback:
+        /* ... */
+        ib_req_notify_cq(cq, ...);
+                                          low-level driver ->
+        /* ... */                           consumer CQ event callback:
+                                              /* ... */
+        return from CQ event handler
 
   The context in which completion event and asynchronous event
   callbacks run is not defined.  Depending on the low-level driver, it
@@ -93,6 +98,7 @@ Callbacks
   Upper level protocol consumers may not sleep in a callback.
 
 Hot-plug
+--------
 
   A low-level driver announces that a device is ready for use by
   consumers when it calls ib_register_device(), all initialization
diff --git a/Documentation/infiniband/ipoib.txt b/Documentation/infiniband/ipoib.txt
index 47c1dd9818f2..0dd36154c0c9 100644
--- a/Documentation/infiniband/ipoib.txt
+++ b/Documentation/infiniband/ipoib.txt
@@ -1,4 +1,6 @@
-IP OVER INFINIBAND
+==================
+IP over InfiniBand
+==================
 
   The ib_ipoib driver is an implementation of the IP over InfiniBand
   protocol as specified by RFC 4391 and 4392, issued by the IETF ipoib
@@ -8,16 +10,17 @@ IP OVER INFINIBAND
   masqueraded to the kernel as ethernet interfaces).
 
 Partitions and P_Keys
+=====================
 
   When the IPoIB driver is loaded, it creates one interface for each
   port using the P_Key at index 0.  To create an interface with a
   different P_Key, write the desired P_Key into the main interface's
-  /sys/class/net/<intf name>/create_child file.  For example:
+  /sys/class/net/<intf name>/create_child file.  For example::
 
     echo 0x8001 > /sys/class/net/ib0/create_child
 
   This will create an interface named ib0.8001 with P_Key 0x8001.  To
-  remove a subinterface, use the "delete_child" file:
+  remove a subinterface, use the "delete_child" file::
 
     echo 0x8001 > /sys/class/net/ib0/delete_child
 
@@ -28,6 +31,7 @@ Partitions and P_Keys
   rtnl_link_ops, where children created using either way behave the same.
 
 Datagram vs Connected modes
+===========================
 
   The IPoIB driver supports two modes of operation: datagram and
   connected.  The mode is set and read through an interface's
@@ -51,6 +55,7 @@ Datagram vs Connected modes
   networking stack to use the smaller UD MTU for these neighbours.
 
 Stateless offloads
+==================
 
   If the IB HW supports IPoIB stateless offloads, IPoIB advertises
   TCP/IP checksum and/or Large Send (LSO) offloading capability to the
@@ -60,9 +65,10 @@ Stateless offloads
   on/off using ethtool calls.  Currently LRO is supported only for
   checksum offload capable devices.
 
-  Stateless offloads are supported only in datagram mode.  
+  Stateless offloads are supported only in datagram mode.
 
 Interrupt moderation
+====================
 
   If the underlying IB device supports CQ event moderation, one can
   use ethtool to set interrupt mitigation parameters and thus reduce
@@ -71,6 +77,7 @@ Interrupt moderation
   moderation is supported.
 
 Debugging Information
+=====================
 
   By compiling the IPoIB driver with CONFIG_INFINIBAND_IPOIB_DEBUG set
   to 'y', tracing messages are compiled into the driver.  They are
@@ -79,7 +86,7 @@ Debugging Information
   runtime through files in /sys/module/ib_ipoib/.
 
   CONFIG_INFINIBAND_IPOIB_DEBUG also enables files in the debugfs
-  virtual filesystem.  By mounting this filesystem, for example with
+  virtual filesystem.  By mounting this filesystem, for example with::
 
     mount -t debugfs none /sys/kernel/debug
 
@@ -96,10 +103,13 @@ Debugging Information
   performance, because it adds tests to the fast path.
 
 References
+==========
 
   Transmission of IP over InfiniBand (IPoIB) (RFC 4391)
-    http://ietf.org/rfc/rfc4391.txt 
+    http://ietf.org/rfc/rfc4391.txt
+
   IP over InfiniBand (IPoIB) Architecture (RFC 4392)
-    http://ietf.org/rfc/rfc4392.txt 
+    http://ietf.org/rfc/rfc4392.txt
+
   IP over InfiniBand: Connected Mode (RFC 4755)
     http://ietf.org/rfc/rfc4755.txt
diff --git a/Documentation/infiniband/opa_vnic.txt b/Documentation/infiniband/opa_vnic.txt
index 282e17be798a..2f888d9ffec0 100644
--- a/Documentation/infiniband/opa_vnic.txt
+++ b/Documentation/infiniband/opa_vnic.txt
@@ -1,3 +1,7 @@
+=================================================================
+Intel Omni-Path (OPA) Virtual Network Interface Controller (VNIC)
+=================================================================
+
 Intel Omni-Path (OPA) Virtual Network Interface Controller (VNIC) feature
 supports Ethernet functionality over Omni-Path fabric by encapsulating
 the Ethernet packets between HFI nodes.
@@ -17,70 +21,72 @@ an independent Ethernet network. The configuration is performed by an
 Ethernet Manager (EM) which is part of the trusted Fabric Manager (FM)
 application. HFI nodes can have multiple VNICs each connected to a
 different virtual Ethernet switch. The below diagram presents a case
-of two virtual Ethernet switches with two HFI nodes.
+of two virtual Ethernet switches with two HFI nodes::
 
-                             +-------------------+
-                             |      Subnet/      |
-                             |     Ethernet      |
-                             |      Manager      |
-                             +-------------------+
-                                /          /
-                              /           /
-                            /            /
-                          /             /
-+-----------------------------+  +------------------------------+
-|  Virtual Ethernet Switch    |  |  Virtual Ethernet Switch     |
-|  +---------+    +---------+ |  | +---------+    +---------+   |
-|  | VPORT   |    |  VPORT  | |  | |  VPORT  |    |  VPORT  |   |
-+--+---------+----+---------+-+  +-+---------+----+---------+---+
-         |                 \        /                 |
-         |                   \    /                   |
-         |                     \/                     |
-         |                    /  \                    |
-         |                  /      \                  |
-     +-----------+------------+  +-----------+------------+
-     |   VNIC    |    VNIC    |  |    VNIC   |    VNIC    |
-     +-----------+------------+  +-----------+------------+
-     |          HFI           |  |          HFI           |
-     +------------------------+  +------------------------+
+                               +-------------------+
+                               |      Subnet/      |
+                               |     Ethernet      |
+                               |      Manager      |
+                               +-------------------+
+                                  /          /
+                                /           /
+                              /            /
+                            /             /
+  +-----------------------------+  +------------------------------+
+  |  Virtual Ethernet Switch    |  |  Virtual Ethernet Switch     |
+  |  +---------+    +---------+ |  | +---------+    +---------+   |
+  |  | VPORT   |    |  VPORT  | |  | |  VPORT  |    |  VPORT  |   |
+  +--+---------+----+---------+-+  +-+---------+----+---------+---+
+           |                 \        /                 |
+           |                   \    /                   |
+           |                     \/                     |
+           |                    /  \                    |
+           |                  /      \                  |
+       +-----------+------------+  +-----------+------------+
+       |   VNIC    |    VNIC    |  |    VNIC   |    VNIC    |
+       +-----------+------------+  +-----------+------------+
+       |          HFI           |  |          HFI           |
+       +------------------------+  +------------------------+
 
 
 The Omni-Path encapsulated Ethernet packet format is as described below.
 
-Bits          Field
-------------------------------------
+==================== ================================
+Bits                 Field
+==================== ================================
 Quad Word 0:
-0-19      SLID (lower 20 bits)
-20-30     Length (in Quad Words)
-31        BECN bit
-32-51     DLID (lower 20 bits)
-52-56     SC (Service Class)
-57-59     RC (Routing Control)
-60        FECN bit
-61-62     L2 (=10, 16B format)
-63        LT (=1, Link Transfer Head Flit)
+0-19                 SLID (lower 20 bits)
+20-30                Length (in Quad Words)
+31                   BECN bit
+32-51                DLID (lower 20 bits)
+52-56                SC (Service Class)
+57-59                RC (Routing Control)
+60                   FECN bit
+61-62                L2 (=10, 16B format)
+63                   LT (=1, Link Transfer Head Flit)
 
 Quad Word 1:
-0-7       L4 type (=0x78 ETHERNET)
-8-11      SLID[23:20]
-12-15     DLID[23:20]
-16-31     PKEY
-32-47     Entropy
-48-63     Reserved
+0-7                  L4 type (=0x78 ETHERNET)
+8-11                 SLID[23:20]
+12-15                DLID[23:20]
+16-31                PKEY
+32-47                Entropy
+48-63                Reserved
 
 Quad Word 2:
-0-15      Reserved
-16-31     L4 header
-32-63     Ethernet Packet
+0-15                 Reserved
+16-31                L4 header
+32-63                Ethernet Packet
 
 Quad Words 3 to N-1:
-0-63      Ethernet packet (pad extended)
+0-63                 Ethernet packet (pad extended)
 
 Quad Word N (last):
-0-23      Ethernet packet (pad extended)
-24-55     ICRC
-56-61     Tail
-62-63     LT (=01, Link Transfer Tail Flit)
+0-23                 Ethernet packet (pad extended)
+24-55                ICRC
+56-61                Tail
+62-63                LT (=01, Link Transfer Tail Flit)
+==================== ================================
 
 Ethernet packet is padded on the transmit side to ensure that the VNIC OPA
 packet is quad word aligned. The 'Tail' field contains the number of bytes
@@ -123,7 +129,7 @@ operation. It also handles the encapsulation of Ethernet packets with an
 Omni-Path header in the transmit path. For each VNIC interface, the
 information required for encapsulation is configured by the EM via VEMA MAD
 interface. It also passes any control information to the HW dependent driver
-by invoking the RDMA netdev control operations.
+by invoking the RDMA netdev control operations::
 
         +-------------------+ +----------------------+
         |                   | |       Linux          |
diff --git a/Documentation/infiniband/sysfs.txt b/Documentation/infiniband/sysfs.txt
index 9fab5062f84b..f0abd6fa48f4 100644
--- a/Documentation/infiniband/sysfs.txt
+++ b/Documentation/infiniband/sysfs.txt
@@ -1,4 +1,6 @@
-SYSFS FILES
+===========
+Sysfs files
+===========
 
 The sysfs interface has moved to
 Documentation/ABI/stable/sysfs-class-infiniband.
diff --git a/Documentation/infiniband/tag_matching.txt b/Documentation/infiniband/tag_matching.txt
index d2a3bf819226..ef56ea585f92 100644
--- a/Documentation/infiniband/tag_matching.txt
+++ b/Documentation/infiniband/tag_matching.txt
@@ -1,12 +1,16 @@
+==================
 Tag matching logic
+==================
 
 The MPI standard defines a set of rules, known as tag-matching, for matching
 source send operations to destination receives.  The following parameters must
 match the following source and destination parameters:
+
 *	Communicator
 *	User tag - wild card may be specified by the receiver
 *	Source rank – wild car may be specified by the receiver
 *	Destination rank – wild
+
 The ordering rules require that when more than one pair of send and receive
 message envelopes may match, the pair that includes the earliest posted-send
 and the earliest posted-receive is the pair that must be used to satisfy the
@@ -35,6 +39,7 @@ the header to initiate an RDMA READ operation directly to the matching buffer.
 A fin message needs to be received in order for the buffer to be reused.
 
 Tag matching implementation
+===========================
 
 There are two types of matching objects used, the posted receive list and the
 unexpected message list. The application posts receive buffers through calls
diff --git a/Documentation/infiniband/user_mad.txt b/Documentation/infiniband/user_mad.txt
index 7aca13a54a3a..d88abfc0e370 100644
--- a/Documentation/infiniband/user_mad.txt
+++ b/Documentation/infiniband/user_mad.txt
@@ -1,6 +1,9 @@
-USERSPACE MAD ACCESS
+====================
+Userspace MAD access
+====================
 
 Device files
+============
 
   Each port of each InfiniBand device has a "umad" device and an
   "issm" device attached.  For example, a two-port HCA will have two
@@ -8,12 +11,13 @@ Device files
   device of each type (for switch port 0).
 
 Creating MAD agents
+===================
 
   A MAD agent can be created by filling in a struct ib_user_mad_reg_req
   and then calling the IB_USER_MAD_REGISTER_AGENT ioctl on a file
   descriptor for the appropriate device file.  If the registration
   request succeeds, a 32-bit id will be returned in the structure.
-  For example:
+  For example::
 
 	struct ib_user_mad_reg_req req = { /* ... */ };
 	ret = ioctl(fd, IB_USER_MAD_REGISTER_AGENT, (char *) &req);
@@ -26,12 +30,14 @@ Creating MAD agents
   ioctl.  Also, all agents registered through a file descriptor will
   be unregistered when the descriptor is closed.
 
-  2014 -- a new registration ioctl is now provided which allows additional
+  2014
+       a new registration ioctl is now provided which allows additional
        fields to be provided during registration.
        Users of this registration call are implicitly setting the use of
        pkey_index (see below).
 
 Receiving MADs
+==============
 
   MADs are received using read().  The receive side now supports
   RMPP. The buffer passed to read() must be at least one
@@ -41,7 +47,8 @@ Receiving MADs
   MAD (RMPP), the errno is set to ENOSPC and the length of the
   buffer needed is set in mad.length.
 
-  Example for normal MAD (non RMPP) reads:
+  Example for normal MAD (non RMPP) reads::
+
 	struct ib_user_mad *mad;
 	mad = malloc(sizeof *mad + 256);
 	ret = read(fd, mad, sizeof *mad + 256);
@@ -50,7 +57,8 @@ Receiving MADs
 		free(mad);
 	}
 
-  Example for RMPP reads:
+  Example for RMPP reads::
+
 	struct ib_user_mad *mad;
 	mad = malloc(sizeof *mad + 256);
 	ret = read(fd, mad, sizeof *mad + 256);
@@ -76,11 +84,12 @@ Receiving MADs
   poll()/select() may be used to wait until a MAD can be read.
 
 Sending MADs
+============
 
   MADs are sent using write().  The agent ID for sending should be
   filled into the id field of the MAD, the destination LID should be
   filled into the lid field, and so on.  The send side does support
-  RMPP so arbitrary length MAD can be sent. For example:
+  RMPP so arbitrary length MAD can be sent. For example::
 
 	struct ib_user_mad *mad;
 
@@ -97,6 +106,7 @@ Sending MADs
 		perror("write");
 
 Transaction IDs
+===============
 
   Users of the umad devices can use the lower 32 bits of the
   transaction ID field (that is, the least significant half of the
@@ -105,6 +115,7 @@ Transaction IDs
   the kernel and will be overwritten before a MAD is sent.
 
 P_Key Index Handling
+====================
 
   The old ib_umad interface did not allow setting the P_Key index for
   MADs that are sent and did not provide a way for obtaining the P_Key
@@ -119,6 +130,7 @@ P_Key Index Handling
   default, and the IB_USER_MAD_ENABLE_PKEY ioctl will be removed.
 
 Setting IsSM Capability Bit
+===========================
 
   To set the IsSM capability bit for a port, simply open the
   corresponding issm device file.  If the IsSM bit is already set,
@@ -129,25 +141,26 @@ Setting IsSM Capability Bit
   the issm file.
 
 /dev files
+==========
 
   To create the appropriate character device files automatically with
-  udev, a rule like
+  udev, a rule like::
 
     KERNEL=="umad*", NAME="infiniband/%k"
     KERNEL=="issm*", NAME="infiniband/%k"
 
-  can be used.  This will create device nodes named
+  can be used.  This will create device nodes named::
 
     /dev/infiniband/umad0
     /dev/infiniband/issm0
 
   for the first port, and so on.  The InfiniBand device and port
-  associated with these devices can be determined from the files
+  associated with these devices can be determined from the files::
 
     /sys/class/infiniband_mad/umad0/ibdev
     /sys/class/infiniband_mad/umad0/port
 
-  and
+  and::
 
     /sys/class/infiniband_mad/issm0/ibdev
     /sys/class/infiniband_mad/issm0/port
diff --git a/Documentation/infiniband/user_verbs.txt b/Documentation/infiniband/user_verbs.txt
index 47ebf2f80b2b..8ddc4b1cfef2 100644
--- a/Documentation/infiniband/user_verbs.txt
+++ b/Documentation/infiniband/user_verbs.txt
@@ -1,4 +1,6 @@
-USERSPACE VERBS ACCESS
+======================
+Userspace verbs access
+======================
 
   The ib_uverbs module, built by enabling CONFIG_INFINIBAND_USER_VERBS,
   enables direct userspace access to IB hardware via "verbs," as
@@ -13,6 +15,7 @@ USERSPACE VERBS ACCESS
   libmthca userspace driver be installed.
 
 User-kernel communication
+=========================
 
   Userspace communicates with the kernel for slow path, resource
   management operations via the /dev/infiniband/uverbsN character
@@ -28,6 +31,7 @@ User-kernel communication
   system call.
 
 Resource management
+===================
 
   Since creation and destruction of all IB resources is done by
   commands passed through a file descriptor, the kernel can keep track
@@ -41,6 +45,7 @@ Resource management
   prevent one process from touching another process's resources.
 
 Memory pinning
+==============
 
   Direct userspace I/O requires that memory regions that are potential
   I/O targets be kept resident at the same physical address.  The
@@ -54,13 +59,14 @@ Memory pinning
   number of pages pinned by a process.
 
 /dev files
+==========
 
   To create the appropriate character device files automatically with
-  udev, a rule like
+  udev, a rule like::
 
     KERNEL=="uverbs*", NAME="infiniband/%k"
 
-  can be used.  This will create device nodes named
+  can be used.  This will create device nodes named::
 
     /dev/infiniband/uverbs0
 
-- 
2.20.1

