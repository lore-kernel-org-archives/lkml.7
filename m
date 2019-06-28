Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1FDC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABB5208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724487;
	bh=JmcZ02uY9rxp0iFoli16yZu4Q78XvwDWlwWO/VSK7OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z7aDou2hCIYn+G+Nby65Y7ZRy9xgJf1vOgwyAVhegVwPk6RKdB12wpkjSWqoRyfyl
	 difJMuPIKTI9pMSMG40KqovUpE3gcrXLFnwVtHHWKaUZ5NlW2DBpl19x/vVYGFXfxm
	 uzg7eu/OKrnsFnKW3/ATk7yUGq1jHUGrr1c1kGRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfF1MVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:21:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF1MUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DHPSjQ+HoIShXMbkhwJBk20OWdRkmx3mqQo8iDsjpC8=; b=FGWoIAARysFgFLaHy2hSpUiaXW
        bZwaRCeTvQZXYzMk0ocf+qTAX3LHtuGhNu+mpF2w0xEnYVKxSI1ZnVryehS8lGX0CqGyNONMPozUk
        X5Rr6bgdepxDp/LA035PjdsIi0hhvnLczYoi7kJ7XkLmbaQnFuMDbFyLFrApEE4DTwC1UoHyInk2R
        DiJFigeeBBN3MFa3lS6qq+BjjCyZAEt6/DvC/ltjyWIPK+bs0HSolSImQd0lWUDxQMuW3dd1cbLon
        LNMbLiRAU+r0gjo9SjLeG9fj2OV/zTn9cZj8x6m+FoLHHu2WYHbNUhB0P6WFv2lONgIe1bBMUqKf1
        x9vHPhaA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-0000AO-VI; Fri, 28 Jun 2019 12:20:44 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpru-00059h-27; Fri, 28 Jun 2019 09:20:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH 36/43] docs: rapidio: convert to ReST
Date:   Fri, 28 Jun 2019 09:20:32 -0300
Message-Id: <3b95213f24b2796402e1efda42c32f8d5d6e10f2.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the rapidio documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/rapidio/index.rst               | 15 +++++
 .../{mport_cdev.txt => mport_cdev.rst}        | 47 ++++++-------
 .../rapidio/{rapidio.txt => rapidio.rst}      | 39 +++++++----
 .../rapidio/{rio_cm.txt => rio_cm.rst}        | 66 ++++++++++++-------
 .../rapidio/{sysfs.txt => sysfs.rst}          |  4 ++
 .../rapidio/{tsi721.txt => tsi721.rst}        | 45 ++++++++-----
 drivers/rapidio/Kconfig                       |  2 +-
 7 files changed, 141 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/rapidio/index.rst
 rename Documentation/rapidio/{mport_cdev.txt => mport_cdev.rst} (84%)
 rename Documentation/rapidio/{rapidio.txt => rapidio.rst} (97%)
 rename Documentation/rapidio/{rio_cm.txt => rio_cm.rst} (76%)
 rename Documentation/rapidio/{sysfs.txt => sysfs.rst} (75%)
 rename Documentation/rapidio/{tsi721.txt => tsi721.rst} (79%)

diff --git a/Documentation/rapidio/index.rst b/Documentation/rapidio/index.rst
new file mode 100644
index 000000000000..ab7b5541b346
--- /dev/null
+++ b/Documentation/rapidio/index.rst
@@ -0,0 +1,15 @@
+:orphan:
+
+===========================
+The Linux RapidIO Subsystem
+===========================
+
+.. toctree::
+   :maxdepth: 1
+
+   rapidio
+   sysfs
+
+   tsi721
+   mport_cdev
+   rio_cm
diff --git a/Documentation/rapidio/mport_cdev.txt b/Documentation/rapidio/mport_cdev.rst
similarity index 84%
rename from Documentation/rapidio/mport_cdev.txt
rename to Documentation/rapidio/mport_cdev.rst
index a53f786ee2e9..df77a7f7be7d 100644
--- a/Documentation/rapidio/mport_cdev.txt
+++ b/Documentation/rapidio/mport_cdev.rst
@@ -1,13 +1,9 @@
+==================================================================
 RapidIO subsystem mport character device driver (rio_mport_cdev.c)
 ==================================================================
 
-Version History:
-----------------
-  1.0.0 - Initial driver release.
-
-==================================================================
-
-I. Overview
+1. Overview
+===========
 
 This device driver is the result of collaboration within the RapidIO.org
 Software Task Group (STG) between Texas Instruments, Freescale,
@@ -29,40 +25,41 @@ Using available set of ioctl commands user-space applications can perform
 following RapidIO bus and subsystem operations:
 
 - Reads and writes from/to configuration registers of mport devices
-    (RIO_MPORT_MAINT_READ_LOCAL/RIO_MPORT_MAINT_WRITE_LOCAL)
+  (RIO_MPORT_MAINT_READ_LOCAL/RIO_MPORT_MAINT_WRITE_LOCAL)
 - Reads and writes from/to configuration registers of remote RapidIO devices.
   This operations are defined as RapidIO Maintenance reads/writes in RIO spec.
-    (RIO_MPORT_MAINT_READ_REMOTE/RIO_MPORT_MAINT_WRITE_REMOTE)
+  (RIO_MPORT_MAINT_READ_REMOTE/RIO_MPORT_MAINT_WRITE_REMOTE)
 - Set RapidIO Destination ID for mport devices (RIO_MPORT_MAINT_HDID_SET)
 - Set RapidIO Component Tag for mport devices (RIO_MPORT_MAINT_COMPTAG_SET)
 - Query logical index of mport devices (RIO_MPORT_MAINT_PORT_IDX_GET)
 - Query capabilities and RapidIO link configuration of mport devices
-    (RIO_MPORT_GET_PROPERTIES)
+  (RIO_MPORT_GET_PROPERTIES)
 - Enable/Disable reporting of RapidIO doorbell events to user-space applications
-    (RIO_ENABLE_DOORBELL_RANGE/RIO_DISABLE_DOORBELL_RANGE)
+  (RIO_ENABLE_DOORBELL_RANGE/RIO_DISABLE_DOORBELL_RANGE)
 - Enable/Disable reporting of RIO port-write events to user-space applications
-    (RIO_ENABLE_PORTWRITE_RANGE/RIO_DISABLE_PORTWRITE_RANGE)
+  (RIO_ENABLE_PORTWRITE_RANGE/RIO_DISABLE_PORTWRITE_RANGE)
 - Query/Control type of events reported through this driver: doorbells,
   port-writes or both (RIO_SET_EVENT_MASK/RIO_GET_EVENT_MASK)
 - Configure/Map mport's outbound requests window(s) for specific size,
   RapidIO destination ID, hopcount and request type
-    (RIO_MAP_OUTBOUND/RIO_UNMAP_OUTBOUND)
+  (RIO_MAP_OUTBOUND/RIO_UNMAP_OUTBOUND)
 - Configure/Map mport's inbound requests window(s) for specific size,
   RapidIO base address and local memory base address
-    (RIO_MAP_INBOUND/RIO_UNMAP_INBOUND)
+  (RIO_MAP_INBOUND/RIO_UNMAP_INBOUND)
 - Allocate/Free contiguous DMA coherent memory buffer for DMA data transfers
   to/from remote RapidIO devices (RIO_ALLOC_DMA/RIO_FREE_DMA)
 - Initiate DMA data transfers to/from remote RapidIO devices (RIO_TRANSFER).
   Supports blocking, asynchronous and posted (a.k.a 'fire-and-forget') data
   transfer modes.
 - Check/Wait for completion of asynchronous DMA data transfer
-    (RIO_WAIT_FOR_ASYNC)
+  (RIO_WAIT_FOR_ASYNC)
 - Manage device objects supported by RapidIO subsystem (RIO_DEV_ADD/RIO_DEV_DEL).
   This allows implementation of various RapidIO fabric enumeration algorithms
   as user-space applications while using remaining functionality provided by
   kernel RapidIO subsystem.
 
-II. Hardware Compatibility
+2. Hardware Compatibility
+=========================
 
 This device driver uses standard interfaces defined by kernel RapidIO subsystem
 and therefore it can be used with any mport device driver registered by RapidIO
@@ -78,29 +75,35 @@ functionality of their platform when planning to use this driver:
   specific DMA engine support and therefore DMA data transfers mport_cdev driver
   are not available.
 
-III. Module parameters
+3. Module parameters
+====================
 
-- 'dma_timeout' - DMA transfer completion timeout (in msec, default value 3000).
+- 'dma_timeout'
+      - DMA transfer completion timeout (in msec, default value 3000).
         This parameter set a maximum completion wait time for SYNC mode DMA
         transfer requests and for RIO_WAIT_FOR_ASYNC ioctl requests.
 
-- 'dbg_level' - This parameter allows to control amount of debug information
+- 'dbg_level'
+      - This parameter allows to control amount of debug information
         generated by this device driver. This parameter is formed by set of
         bit masks that correspond to the specific functional blocks.
         For mask definitions see 'drivers/rapidio/devices/rio_mport_cdev.c'
         This parameter can be changed dynamically.
         Use CONFIG_RAPIDIO_DEBUG=y to enable debug output at the top level.
 
-IV. Known problems
+4. Known problems
+=================
 
   None.
 
-V. User-space Applications and API
+5. User-space Applications and API
+==================================
 
 API library and applications that use this device driver are available from
 RapidIO.org.
 
-VI. TODO List
+6. TODO List
+============
 
 - Add support for sending/receiving "raw" RapidIO messaging packets.
 - Add memory mapped DMA data transfers as an option when RapidIO-specific DMA
diff --git a/Documentation/rapidio/rapidio.txt b/Documentation/rapidio/rapidio.rst
similarity index 97%
rename from Documentation/rapidio/rapidio.txt
rename to Documentation/rapidio/rapidio.rst
index 28fbd877f85a..fb8942d3ba85 100644
--- a/Documentation/rapidio/rapidio.txt
+++ b/Documentation/rapidio/rapidio.rst
@@ -1,6 +1,6 @@
-                          The Linux RapidIO Subsystem
-
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+============
+Introduction
+============
 
 The RapidIO standard is a packet-based fabric interconnect standard designed for
 use in embedded systems. Development of the RapidIO standard is directed by the
@@ -11,7 +11,7 @@ This document describes the basics of the Linux RapidIO subsystem and provides
 information on its major components.
 
 1 Overview
-----------
+==========
 
 Because the RapidIO subsystem follows the Linux device model it is integrated
 into the kernel similarly to other buses by defining RapidIO-specific device and
@@ -22,7 +22,7 @@ architecture-specific interfaces that provide support for common RapidIO
 subsystem operations.
 
 2. Core Components
-------------------
+==================
 
 A typical RapidIO network is a combination of endpoints and switches.
 Each of these components is represented in the subsystem by an associated data
@@ -30,6 +30,7 @@ structure. The core logical components of the RapidIO subsystem are defined
 in include/linux/rio.h file.
 
 2.1 Master Port
+---------------
 
 A master port (or mport) is a RapidIO interface controller that is local to the
 processor executing the Linux code. A master port generates and receives RapidIO
@@ -46,6 +47,7 @@ includes rio_ops data structure which contains pointers to hardware specific
 implementations of RapidIO functions.
 
 2.2 Device
+----------
 
 A RapidIO device is any endpoint (other than mport) or switch in the network.
 All devices are presented in the RapidIO subsystem by corresponding rio_dev data
@@ -53,6 +55,7 @@ structure. Devices form one global device list and per-network device lists
 (depending on number of available mports and networks).
 
 2.3 Switch
+----------
 
 A RapidIO switch is a special class of device that routes packets between its
 ports towards their final destination. The packet destination port within a
@@ -66,6 +69,7 @@ specific switch drivers that are designed to provide hardware-specific
 implementation of common switch management routines.
 
 2.4 Network
+-----------
 
 A RapidIO network is a combination of interconnected endpoint and switch devices.
 Each RapidIO network known to the system is represented by corresponding rio_net
@@ -74,11 +78,13 @@ ports that form the same network. It also contains a pointer to the default
 master port that is used to communicate with devices within the network.
 
 2.5 Device Drivers
+------------------
 
 RapidIO device-specific drivers follow Linux Kernel Driver Model and are
 intended to support specific RapidIO devices attached to the RapidIO network.
 
 2.6 Subsystem Interfaces
+------------------------
 
 RapidIO interconnect specification defines features that may be used to provide
 one or more common service layers for all participating RapidIO devices. These
@@ -90,7 +96,7 @@ subsystem interfaces. This allows to have multiple common services attached to
 the same device without blocking attachment of a device-specific driver.
 
 3. Subsystem Initialization
----------------------------
+===========================
 
 In order to initialize the RapidIO subsystem, a platform must initialize and
 register at least one master port within the RapidIO network. To register mport
@@ -105,7 +111,7 @@ RapidIO subsystem can be configured to be built as a statically linked or
 modular component of the kernel (see details below).
 
 4. Enumeration and Discovery
-----------------------------
+============================
 
 4.1 Overview
 ------------
@@ -168,14 +174,16 @@ on RapidIO subsystem build configuration:
   (b) If the RapidIO subsystem core is built as a loadable module, in addition
   to the method shown above, the host destination ID(s) can be specified using
   traditional methods of passing module parameter "hdid=" during its loading:
+
   - from command line: "modprobe rapidio hdid=-1,7", or
   - from modprobe configuration file using configuration command "options",
     like in this example: "options rapidio hdid=-1,7". An example of modprobe
     configuration file is provided in the section below.
 
-  NOTES:
+NOTES:
   (i) if "hdid=" parameter is omitted all available mport will be assigned
   destination ID = -1;
+
   (ii) the "hdid=" parameter in systems with multiple mports can have
   destination ID assignments omitted from the end of list (default = -1).
 
@@ -317,8 +325,7 @@ must ensure that they are loaded before the enumeration/discovery starts.
 This process can be automated by specifying pre- or post- dependencies in the
 RapidIO-specific modprobe configuration file as shown in the example below.
 
-  File /etc/modprobe.d/rapidio.conf:
-  ----------------------------------
+File /etc/modprobe.d/rapidio.conf::
 
   # Configure RapidIO subsystem modules
 
@@ -335,17 +342,21 @@ RapidIO-specific modprobe configuration file as shown in the example below.
 
   --------------------------
 
-NOTE: In the example above, one of "softdep" commands must be removed or
-commented out to keep required module loading sequence.
+NOTE:
+  In the example above, one of "softdep" commands must be removed or
+  commented out to keep required module loading sequence.
 
-A. References
--------------
+5. References
+=============
 
 [1] RapidIO Trade Association. RapidIO Interconnect Specifications.
     http://www.rapidio.org.
+
 [2] Rapidio TA. Technology Comparisons.
     http://www.rapidio.org/education/technology_comparisons/
+
 [3] RapidIO support for Linux.
     http://lwn.net/Articles/139118/
+
 [4] Matt Porter. RapidIO for Linux. Ottawa Linux Symposium, 2005
     http://www.kernel.org/doc/ols/2005/ols2005v2-pages-43-56.pdf
diff --git a/Documentation/rapidio/rio_cm.txt b/Documentation/rapidio/rio_cm.rst
similarity index 76%
rename from Documentation/rapidio/rio_cm.txt
rename to Documentation/rapidio/rio_cm.rst
index 27aa401f1126..5294430a7a74 100644
--- a/Documentation/rapidio/rio_cm.txt
+++ b/Documentation/rapidio/rio_cm.rst
@@ -1,13 +1,10 @@
+==========================================================================
 RapidIO subsystem Channelized Messaging character device driver (rio_cm.c)
 ==========================================================================
 
-Version History:
-----------------
-  1.0.0 - Initial driver release.
 
-==========================================================================
-
-I. Overview
+1. Overview
+===========
 
 This device driver is the result of collaboration within the RapidIO.org
 Software Task Group (STG) between Texas Instruments, Prodrive Technologies,
@@ -41,79 +38,98 @@ in /dev directory common for all registered RapidIO mport devices.
 
 Following ioctl commands are available to user-space applications:
 
-- RIO_CM_MPORT_GET_LIST : Returns to caller list of local mport devices that
+- RIO_CM_MPORT_GET_LIST:
+    Returns to caller list of local mport devices that
     support messaging operations (number of entries up to RIO_MAX_MPORTS).
     Each list entry is combination of mport's index in the system and RapidIO
     destination ID assigned to the port.
-- RIO_CM_EP_GET_LIST_SIZE : Returns number of messaging capable remote endpoints
+- RIO_CM_EP_GET_LIST_SIZE:
+    Returns number of messaging capable remote endpoints
     in a RapidIO network associated with the specified mport device.
-- RIO_CM_EP_GET_LIST : Returns list of RapidIO destination IDs for messaging
+- RIO_CM_EP_GET_LIST:
+    Returns list of RapidIO destination IDs for messaging
     capable remote endpoints (peers) available in a RapidIO network associated
     with the specified mport device.
-- RIO_CM_CHAN_CREATE : Creates RapidIO message exchange channel data structure
+- RIO_CM_CHAN_CREATE:
+    Creates RapidIO message exchange channel data structure
     with channel ID assigned automatically or as requested by a caller.
-- RIO_CM_CHAN_BIND : Binds the specified channel data structure to the specified
+- RIO_CM_CHAN_BIND:
+    Binds the specified channel data structure to the specified
     mport device.
-- RIO_CM_CHAN_LISTEN : Enables listening for connection requests on the specified
+- RIO_CM_CHAN_LISTEN:
+    Enables listening for connection requests on the specified
     channel.
-- RIO_CM_CHAN_ACCEPT : Accepts a connection request from peer on the specified
+- RIO_CM_CHAN_ACCEPT:
+    Accepts a connection request from peer on the specified
     channel. If wait timeout for this request is specified by a caller it is
     a blocking call. If timeout set to 0 this is non-blocking call - ioctl
     handler checks for a pending connection request and if one is not available
     exits with -EGAIN error status immediately.
-- RIO_CM_CHAN_CONNECT : Sends a connection request to a remote peer/channel.
-- RIO_CM_CHAN_SEND : Sends a data message through the specified channel.
+- RIO_CM_CHAN_CONNECT:
+    Sends a connection request to a remote peer/channel.
+- RIO_CM_CHAN_SEND:
+    Sends a data message through the specified channel.
     The handler for this request assumes that message buffer specified by
     a caller includes the reserved space for a packet header required by
     this driver.
-- RIO_CM_CHAN_RECEIVE : Receives a data message through a connected channel.
+- RIO_CM_CHAN_RECEIVE:
+    Receives a data message through a connected channel.
     If the channel does not have an incoming message ready to return this ioctl
     handler will wait for new message until timeout specified by a caller
     expires. If timeout value is set to 0, ioctl handler uses a default value
     defined by MAX_SCHEDULE_TIMEOUT.
-- RIO_CM_CHAN_CLOSE : Closes a specified channel and frees associated buffers.
+- RIO_CM_CHAN_CLOSE:
+    Closes a specified channel and frees associated buffers.
     If the specified channel is in the CONNECTED state, sends close notification
     to the remote peer.
 
 The ioctl command codes and corresponding data structures intended for use by
 user-space applications are defined in 'include/uapi/linux/rio_cm_cdev.h'.
 
-II. Hardware Compatibility
+2. Hardware Compatibility
+=========================
 
 This device driver uses standard interfaces defined by kernel RapidIO subsystem
 and therefore it can be used with any mport device driver registered by RapidIO
 subsystem with limitations set by available mport HW implementation of messaging
 mailboxes.
 
-III. Module parameters
+3. Module parameters
+====================
 
-- 'dbg_level' - This parameter allows to control amount of debug information
+- 'dbg_level'
+      - This parameter allows to control amount of debug information
         generated by this device driver. This parameter is formed by set of
         bit masks that correspond to the specific functional block.
         For mask definitions see 'drivers/rapidio/devices/rio_cm.c'
         This parameter can be changed dynamically.
         Use CONFIG_RAPIDIO_DEBUG=y to enable debug output at the top level.
 
-- 'cmbox' - Number of RapidIO mailbox to use (default value is 1).
+- 'cmbox'
+      - Number of RapidIO mailbox to use (default value is 1).
         This parameter allows to set messaging mailbox number that will be used
         within entire RapidIO network. It can be used when default mailbox is
         used by other device drivers or is not supported by some nodes in the
         RapidIO network.
 
-- 'chstart' - Start channel number for dynamic assignment. Default value - 256.
+- 'chstart'
+      - Start channel number for dynamic assignment. Default value - 256.
         Allows to exclude channel numbers below this parameter from dynamic
         allocation to avoid conflicts with software components that use
         reserved predefined channel numbers.
 
-IV. Known problems
+4. Known problems
+=================
 
   None.
 
-V. User-space Applications and API Library
+5. User-space Applications and API Library
+==========================================
 
 Messaging API library and applications that use this device driver are available
 from RapidIO.org.
 
-VI. TODO List
+6. TODO List
+============
 
 - Add support for system notification messages (reserved channel 0).
diff --git a/Documentation/rapidio/sysfs.txt b/Documentation/rapidio/sysfs.rst
similarity index 75%
rename from Documentation/rapidio/sysfs.txt
rename to Documentation/rapidio/sysfs.rst
index a1adac888e6e..540f72683496 100644
--- a/Documentation/rapidio/sysfs.txt
+++ b/Documentation/rapidio/sysfs.rst
@@ -1,3 +1,7 @@
+=============
+Sysfs entries
+=============
+
 The RapidIO sysfs files have moved to:
 Documentation/ABI/testing/sysfs-bus-rapidio and
 Documentation/ABI/testing/sysfs-class-rapidio
diff --git a/Documentation/rapidio/tsi721.txt b/Documentation/rapidio/tsi721.rst
similarity index 79%
rename from Documentation/rapidio/tsi721.txt
rename to Documentation/rapidio/tsi721.rst
index cd2a2935d51d..42aea438cd20 100644
--- a/Documentation/rapidio/tsi721.txt
+++ b/Documentation/rapidio/tsi721.rst
@@ -1,7 +1,9 @@
+=========================================================================
 RapidIO subsystem mport driver for IDT Tsi721 PCI Express-to-SRIO bridge.
 =========================================================================
 
-I. Overview
+1. Overview
+===========
 
 This driver implements all currently defined RapidIO mport callback functions.
 It supports maintenance read and write operations, inbound and outbound RapidIO
@@ -17,7 +19,9 @@ into the corresponding message queue. Messaging callbacks are implemented to be
 fully compatible with RIONET driver (Ethernet over RapidIO messaging services).
 
 1. Module parameters:
-- 'dbg_level' - This parameter allows to control amount of debug information
+
+- 'dbg_level'
+      - This parameter allows to control amount of debug information
         generated by this device driver. This parameter is formed by set of
         This parameter can be changed bit masks that correspond to the specific
         functional block.
@@ -25,37 +29,44 @@ fully compatible with RIONET driver (Ethernet over RapidIO messaging services).
         This parameter can be changed dynamically.
         Use CONFIG_RAPIDIO_DEBUG=y to enable debug output at the top level.
 
-- 'dma_desc_per_channel' - This parameter defines number of hardware buffer
+- 'dma_desc_per_channel'
+      - This parameter defines number of hardware buffer
         descriptors allocated for each registered Tsi721 DMA channel.
         Its default value is 128.
 
-- 'dma_txqueue_sz' - DMA transactions queue size. Defines number of pending
+- 'dma_txqueue_sz'
+      - DMA transactions queue size. Defines number of pending
         transaction requests that can be accepted by each DMA channel.
         Default value is 16.
 
-- 'dma_sel' - DMA channel selection mask. Bitmask that defines which hardware
+- 'dma_sel'
+      - DMA channel selection mask. Bitmask that defines which hardware
         DMA channels (0 ... 6) will be registered with DmaEngine core.
         If bit is set to 1, the corresponding DMA channel will be registered.
         DMA channels not selected by this mask will not be used by this device
         driver. Default value is 0x7f (use all channels).
 
-- 'pcie_mrrs' - override value for PCIe Maximum Read Request Size (MRRS).
+- 'pcie_mrrs'
+      - override value for PCIe Maximum Read Request Size (MRRS).
         This parameter gives an ability to override MRRS value set during PCIe
         configuration process. Tsi721 supports read request sizes up to 4096B.
         Value for this parameter must be set as defined by PCIe specification:
         0 = 128B, 1 = 256B, 2 = 512B, 3 = 1024B, 4 = 2048B and 5 = 4096B.
         Default value is '-1' (= keep platform setting).
 
-- 'mbox_sel' - RIO messaging MBOX selection mask. This is a bitmask that defines
+- 'mbox_sel'
+      - RIO messaging MBOX selection mask. This is a bitmask that defines
         messaging MBOXes are managed by this device driver. Mask bits 0 - 3
         correspond to MBOX0 - MBOX3. MBOX is under driver's control if the
         corresponding bit is set to '1'. Default value is 0x0f (= all).
 
-II. Known problems
+2. Known problems
+=================
 
   None.
 
-III. DMA Engine Support
+3. DMA Engine Support
+=====================
 
 Tsi721 mport driver supports DMA data transfers between local system memory and
 remote RapidIO devices. This functionality is implemented according to SLAVE
@@ -68,17 +79,21 @@ One BDMA channel is reserved for generation of maintenance read/write requests.
 
 If Tsi721 mport driver have been built with RAPIDIO_DMA_ENGINE support included,
 this driver will accept DMA-specific module parameter:
-  "dma_desc_per_channel" - defines number of hardware buffer descriptors used by
+
+  "dma_desc_per_channel"
+			 - defines number of hardware buffer descriptors used by
                            each BDMA channel of Tsi721 (by default - 128).
 
-IV. Version History
+4. Version History
 
-  1.1.0 - DMA operations re-worked to support data scatter/gather lists larger
+  =====   ====================================================================
+  1.1.0   DMA operations re-worked to support data scatter/gather lists larger
           than hardware buffer descriptors ring.
-  1.0.0 - Initial driver release.
+  1.0.0   Initial driver release.
+  =====   ====================================================================
 
-V.  License
------------------------------------------------
+5.  License
+===========
 
   Copyright(c) 2011 Integrated Device Technology, Inc. All rights reserved.
 
diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index fadafc64705f..467e8fa06904 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -86,7 +86,7 @@ config RAPIDIO_CHMAN
 	  This option includes RapidIO channelized messaging driver which
 	  provides socket-like interface to allow sharing of single RapidIO
 	  messaging mailbox between multiple user-space applications.
-	  See "Documentation/rapidio/rio_cm.txt" for driver description.
+	  See "Documentation/rapidio/rio_cm.rst" for driver description.
 
 config RAPIDIO_MPORT_CDEV
 	tristate "RapidIO /dev mport device driver"
-- 
2.21.0

