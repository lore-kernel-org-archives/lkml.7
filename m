Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78735C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFA1206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364868;
	bh=NLAW0McjXbgY17edHo/4tBEOt8KTeJjXuR79JIPbhnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pOBFn3EeG5oVg9LsrI2QHgvYH8qCoLb1g/uby6im3kNXRWrIw+/sJm1e7ARQOcVfp
	 LlVUI/rNBL6M/q48BFm0AM/b9ZHi/mmNFUqj7CMYSeCu1IiB4yKw0cob31uhrIg2Fd
	 DZMGL2ck8qAzSfs96nka+jiwD+JbxsGfFK+aOLhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfFLSlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:41:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfFLSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=21Zv7eTq00CIh0lzgZDFvEV5UnuZ7mj2qLRpatUknN0=; b=ufmXc2HvjIRpMeyVf2MT+z2j/b
        FGyft2v0lWR862VVX7Hy+9n1e4FMRjCDvoPAN9sYStXNvAi+m7ALqkH5KUfSKhlVvBDAVbHeX+J+J
        q2+A0JBb39ouu7Mpy9oCps+yaEf/8BdWl9QO/FwLwCnW5Zvl6ouMhEuRp0/8/VxUe+DO5jsUqupWd
        /obZ8yZeiizoA9KbAPTz5rqQlq4RXuR5h9BH7Wsn/xvW32n6jKLTwhrpDmRLTs1g3meO7x3v7tKoN
        IZiBajcltA8NT5LDDV8hLit9lUeSiiLDJCKcXJa2y6tpE8tnkTTbgt7X8Axl2a86bI1UtIcsf9AFb
        TxwPdcIA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YE-HS; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002Bz-Gf; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 27/31] docs: md: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:30 -0300
Message-Id: <8ad074b04ffa71938dcaf97a1e60c054f68b2fa8.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the md documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/md/index.rst                    |  12 ++
 .../md/{md-cluster.txt => md-cluster.rst}     | 188 ++++++++++++------
 .../md/{raid5-cache.txt => raid5-cache.rst}   |  28 +--
 .../md/{raid5-ppl.txt => raid5-ppl.rst}       |   2 +
 4 files changed, 153 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/md/index.rst
 rename Documentation/md/{md-cluster.txt => md-cluster.rst} (68%)
 rename Documentation/md/{raid5-cache.txt => raid5-cache.rst} (92%)
 rename Documentation/md/{raid5-ppl.txt => raid5-ppl.rst} (98%)

diff --git a/Documentation/md/index.rst b/Documentation/md/index.rst
new file mode 100644
index 000000000000..c4db34ed327d
--- /dev/null
+++ b/Documentation/md/index.rst
@@ -0,0 +1,12 @@
+:orphan:
+
+====
+RAID
+====
+
+.. toctree::
+   :maxdepth: 1
+
+   md-cluster
+   raid5-cache
+   raid5-ppl
diff --git a/Documentation/md/md-cluster.txt b/Documentation/md/md-cluster.rst
similarity index 68%
rename from Documentation/md/md-cluster.txt
rename to Documentation/md/md-cluster.rst
index e1055f105cf5..96eb52cec7eb 100644
--- a/Documentation/md/md-cluster.txt
+++ b/Documentation/md/md-cluster.rst
@@ -1,19 +1,24 @@
+==========
+MD Cluster
+==========
+
 The cluster MD is a shared-device RAID for a cluster, it supports
 two levels: raid1 and raid10 (limited support).
 
 
 1. On-disk format
+=================
 
 Separate write-intent-bitmaps are used for each cluster node.
 The bitmaps record all writes that may have been started on that node,
-and may not yet have finished. The on-disk layout is:
+and may not yet have finished. The on-disk layout is::
 
-0                    4k                     8k                    12k
--------------------------------------------------------------------
-| idle                | md super            | bm super [0] + bits |
-| bm bits[0, contd]   | bm super[1] + bits  | bm bits[1, contd]   |
-| bm super[2] + bits  | bm bits [2, contd]  | bm super[3] + bits  |
-| bm bits [3, contd]  |                     |                     |
+  0                    4k                     8k                    12k
+  -------------------------------------------------------------------
+  | idle                | md super            | bm super [0] + bits |
+  | bm bits[0, contd]   | bm super[1] + bits  | bm bits[1, contd]   |
+  | bm super[2] + bits  | bm bits [2, contd]  | bm super[3] + bits  |
+  | bm bits [3, contd]  |                     |                     |
 
 During "normal" functioning we assume the filesystem ensures that only
 one node writes to any given block at a time, so a write request will
@@ -28,10 +33,12 @@ node) is writing.
 
 
 2. DLM Locks for management
+===========================
 
 There are three groups of locks for managing the device:
 
 2.1 Bitmap lock resource (bm_lockres)
+-------------------------------------
 
  The bm_lockres protects individual node bitmaps. They are named in
  the form bitmap000 for node 1, bitmap001 for node 2 and so on. When a
@@ -48,6 +55,7 @@ There are three groups of locks for managing the device:
  joins the cluster.
 
 2.2 Message passing locks
+-------------------------
 
  Each node has to communicate with other nodes when starting or ending
  resync, and for metadata superblock updates.  This communication is
@@ -55,116 +63,155 @@ There are three groups of locks for managing the device:
  with the Lock Value Block (LVB) of one of the "message" lock.
 
 2.3 new-device management
+-------------------------
 
  A single lock: "no-new-dev" is used to co-ordinate the addition of
  new devices - this must be synchronized across the array.
  Normally all nodes hold a concurrent-read lock on this device.
 
 3. Communication
+================
 
  Messages can be broadcast to all nodes, and the sender waits for all
  other nodes to acknowledge the message before proceeding.  Only one
  message can be processed at a time.
 
 3.1 Message Types
+-----------------
 
  There are six types of messages which are passed:
 
- 3.1.1 METADATA_UPDATED: informs other nodes that the metadata has
+3.1.1 METADATA_UPDATED
+^^^^^^^^^^^^^^^^^^^^^^
+
+   informs other nodes that the metadata has
    been updated, and the node must re-read the md superblock. This is
    performed synchronously. It is primarily used to signal device
    failure.
 
- 3.1.2 RESYNCING: informs other nodes that a resync is initiated or
+3.1.2 RESYNCING
+^^^^^^^^^^^^^^^
+   informs other nodes that a resync is initiated or
    ended so that each node may suspend or resume the region.  Each
    RESYNCING message identifies a range of the devices that the
    sending node is about to resync. This overrides any previous
    notification from that node: only one ranged can be resynced at a
    time per-node.
 
- 3.1.3 NEWDISK: informs other nodes that a device is being added to
+3.1.3 NEWDISK
+^^^^^^^^^^^^^
+
+   informs other nodes that a device is being added to
    the array. Message contains an identifier for that device.  See
    below for further details.
 
- 3.1.4 REMOVE: A failed or spare device is being removed from the
+3.1.4 REMOVE
+^^^^^^^^^^^^
+
+   A failed or spare device is being removed from the
    array. The slot-number of the device is included in the message.
 
- 3.1.5 RE_ADD: A failed device is being re-activated - the assumption
+ 3.1.5 RE_ADD:
+
+   A failed device is being re-activated - the assumption
    is that it has been determined to be working again.
 
- 3.1.6 BITMAP_NEEDS_SYNC: if a node is stopped locally but the bitmap
+ 3.1.6 BITMAP_NEEDS_SYNC:
+
+   If a node is stopped locally but the bitmap
    isn't clean, then another node is informed to take the ownership of
    resync.
 
 3.2 Communication mechanism
+---------------------------
 
  The DLM LVB is used to communicate within nodes of the cluster. There
  are three resources used for the purpose:
 
-  3.2.1 token: The resource which protects the entire communication
+3.2.1 token
+^^^^^^^^^^^
+   The resource which protects the entire communication
    system. The node having the token resource is allowed to
    communicate.
 
-  3.2.2 message: The lock resource which carries the data to
-   communicate.
+3.2.2 message
+^^^^^^^^^^^^^
+   The lock resource which carries the data to communicate.
 
-  3.2.3 ack: The resource, acquiring which means the message has been
+3.2.3 ack
+^^^^^^^^^
+
+   The resource, acquiring which means the message has been
    acknowledged by all nodes in the cluster. The BAST of the resource
    is used to inform the receiving node that a node wants to
    communicate.
 
 The algorithm is:
 
- 1. receive status - all nodes have concurrent-reader lock on "ack".
+ 1. receive status - all nodes have concurrent-reader lock on "ack"::
 
-   sender                         receiver                 receiver
-   "ack":CR                       "ack":CR                 "ack":CR
+	sender                         receiver                 receiver
+	"ack":CR                       "ack":CR                 "ack":CR
 
- 2. sender get EX on "token"
-    sender get EX on "message"
-    sender                        receiver                 receiver
-    "token":EX                    "ack":CR                 "ack":CR
-    "message":EX
-    "ack":CR
+ 2. sender get EX on "token",
+    sender get EX on "message"::
+
+	sender                        receiver                 receiver
+	"token":EX                    "ack":CR                 "ack":CR
+	"message":EX
+	"ack":CR
 
     Sender checks that it still needs to send a message. Messages
     received or other events that happened while waiting for the
     "token" may have made this message inappropriate or redundant.
 
- 3. sender writes LVB.
+ 3. sender writes LVB
+
     sender down-convert "message" from EX to CW
+
     sender try to get EX of "ack"
-    [ wait until all receivers have *processed* the "message" ]
-
-                                     [ triggered by bast of "ack" ]
-                                     receiver get CR on "message"
-                                     receiver read LVB
-                                     receiver processes the message
-                                     [ wait finish ]
-                                     receiver releases "ack"
-                                     receiver tries to get PR on "message"
-
-   sender                         receiver                  receiver
-   "token":EX                     "message":CR              "message":CR
-   "message":CW
-   "ack":EX
+
+    ::
+
+      [ wait until all receivers have *processed* the "message" ]
+
+                                       [ triggered by bast of "ack" ]
+                                       receiver get CR on "message"
+                                       receiver read LVB
+                                       receiver processes the message
+                                       [ wait finish ]
+                                       receiver releases "ack"
+                                       receiver tries to get PR on "message"
+
+     sender                         receiver                  receiver
+     "token":EX                     "message":CR              "message":CR
+     "message":CW
+     "ack":EX
 
  4. triggered by grant of EX on "ack" (indicating all receivers
     have processed message)
+
     sender down-converts "ack" from EX to CR
+
     sender releases "message"
+
     sender releases "token"
-                               receiver upconvert to PR on "message"
-                               receiver get CR of "ack"
-                               receiver release "message"
 
-   sender                      receiver                   receiver
-   "ack":CR                    "ack":CR                   "ack":CR
+    ::
+
+                                 receiver upconvert to PR on "message"
+                                 receiver get CR of "ack"
+                                 receiver release "message"
+
+     sender                      receiver                   receiver
+     "ack":CR                    "ack":CR                   "ack":CR
 
 
 4. Handling Failures
+====================
 
 4.1 Node Failure
+----------------
 
  When a node fails, the DLM informs the cluster with the slot
  number. The node starts a cluster recovery thread. The cluster
@@ -177,11 +224,11 @@ The algorithm is:
 	- cleans the bitmap of the failed node
 	- releases bitmap<number> lock of the failed node
 	- initiates resync of the bitmap on the current node
-		md_check_recovery is invoked within recover_bitmaps,
-		then md_check_recovery -> metadata_update_start/finish,
-		it will lock the communication by lock_comm.
-		Which means when one node is resyncing it blocks all
-		other nodes from writing anywhere on the array.
+	  md_check_recovery is invoked within recover_bitmaps,
+	  then md_check_recovery -> metadata_update_start/finish,
+	  it will lock the communication by lock_comm.
+	  Which means when one node is resyncing it blocks all
+	  other nodes from writing anywhere on the array.
 
  The resync process is the regular md resync. However, in a clustered
  environment when a resync is performed, it needs to tell other nodes
@@ -198,6 +245,7 @@ The algorithm is:
  particular I/O range should be suspended or not.
 
 4.2 Device Failure
+==================
 
  Device failures are handled and communicated with the metadata update
  routine.  When a node detects a device failure it does not allow
@@ -205,38 +253,41 @@ The algorithm is:
  acknowledged by all other nodes.
 
 5. Adding a new Device
+----------------------
 
  For adding a new device, it is necessary that all nodes "see" the new
  device to be added. For this, the following algorithm is used:
 
-    1. Node 1 issues mdadm --manage /dev/mdX --add /dev/sdYY which issues
+   1.  Node 1 issues mdadm --manage /dev/mdX --add /dev/sdYY which issues
        ioctl(ADD_NEW_DISK with disc.state set to MD_DISK_CLUSTER_ADD)
-    2. Node 1 sends a NEWDISK message with uuid and slot number
-    3. Other nodes issue kobject_uevent_env with uuid and slot number
+   2.  Node 1 sends a NEWDISK message with uuid and slot number
+   3.  Other nodes issue kobject_uevent_env with uuid and slot number
        (Steps 4,5 could be a udev rule)
-    4. In userspace, the node searches for the disk, perhaps
+   4.  In userspace, the node searches for the disk, perhaps
        using blkid -t SUB_UUID=""
-    5. Other nodes issue either of the following depending on whether
+   5.  Other nodes issue either of the following depending on whether
        the disk was found:
        ioctl(ADD_NEW_DISK with disc.state set to MD_DISK_CANDIDATE and
-             disc.number set to slot number)
+       disc.number set to slot number)
        ioctl(CLUSTERED_DISK_NACK)
-    6. Other nodes drop lock on "no-new-devs" (CR) if device is found
-    7. Node 1 attempts EX lock on "no-new-dev"
-    8. If node 1 gets the lock, it sends METADATA_UPDATED after
+   6.  Other nodes drop lock on "no-new-devs" (CR) if device is found
+   7.  Node 1 attempts EX lock on "no-new-dev"
+   8.  If node 1 gets the lock, it sends METADATA_UPDATED after
        unmarking the disk as SpareLocal
-    9. If not (get "no-new-dev" lock), it fails the operation and sends
+   9.  If not (get "no-new-dev" lock), it fails the operation and sends
        METADATA_UPDATED.
    10. Other nodes get the information whether a disk is added or not
        by the following METADATA_UPDATED.
 
-6. Module interface.
+6. Module interface
+===================
 
  There are 17 call-backs which the md core can make to the cluster
  module.  Understanding these can give a good overview of the whole
  process.
 
 6.1 join(nodes) and leave()
+---------------------------
 
  These are called when an array is started with a clustered bitmap,
  and when the array is stopped.  join() ensures the cluster is
@@ -244,11 +295,13 @@ The algorithm is:
  Only the first 'nodes' nodes in the cluster can use the array.
 
 6.2 slot_number()
+-----------------
 
  Reports the slot number advised by the cluster infrastructure.
  Range is from 0 to nodes-1.
 
 6.3 resync_info_update()
+------------------------
 
  This updates the resync range that is stored in the bitmap lock.
  The starting point is updated as the resync progresses.  The
@@ -256,6 +309,7 @@ The algorithm is:
  It does *not* send a RESYNCING message.
 
 6.4 resync_start(), resync_finish()
+-----------------------------------
 
  These are called when resync/recovery/reshape starts or stops.
  They update the resyncing range in the bitmap lock and also
@@ -265,8 +319,8 @@ The algorithm is:
  resync_finish() also sends a BITMAP_NEEDS_SYNC message which
  allows some other node to take over.
 
-6.5 metadata_update_start(), metadata_update_finish(),
-    metadata_update_cancel().
+6.5 metadata_update_start(), metadata_update_finish(), metadata_update_cancel()
+-------------------------------------------------------------------------------
 
  metadata_update_start is used to get exclusive access to
  the metadata.  If a change is still needed once that access is
@@ -275,6 +329,7 @@ The algorithm is:
  can be used to release the lock.
 
 6.6 area_resyncing()
+--------------------
 
  This combines two elements of functionality.
 
@@ -289,6 +344,7 @@ The algorithm is:
  a node failure.
 
 6.7 add_new_disk_start(), add_new_disk_finish(), new_disk_ack()
+---------------------------------------------------------------
 
  These are used to manage the new-disk protocol described above.
  When a new device is added, add_new_disk_start() is called before
@@ -300,17 +356,20 @@ The algorithm is:
  new_disk_ack() is called.
 
 6.8 remove_disk()
+-----------------
 
  This is called when a spare or failed device is removed from
  the array.  It causes a REMOVE message to be send to other nodes.
 
 6.9 gather_bitmaps()
+--------------------
 
  This sends a RE_ADD message to all other nodes and then
  gathers bitmap information from all bitmaps.  This combined
  bitmap is then used to recovery the re-added device.
 
 6.10 lock_all_bitmaps() and unlock_all_bitmaps()
+------------------------------------------------
 
  These are called when change bitmap to none. If a node plans
  to clear the cluster raid's bitmap, it need to make sure no other
@@ -319,6 +378,7 @@ The algorithm is:
  accordingly.
 
 7. Unsupported features
+=======================
 
 There are somethings which are not supported by cluster MD yet.
 
diff --git a/Documentation/md/raid5-cache.txt b/Documentation/md/raid5-cache.rst
similarity index 92%
rename from Documentation/md/raid5-cache.txt
rename to Documentation/md/raid5-cache.rst
index 2b210f295786..d7a15f44a7c3 100644
--- a/Documentation/md/raid5-cache.txt
+++ b/Documentation/md/raid5-cache.rst
@@ -1,4 +1,6 @@
-RAID5 cache
+================
+RAID 4/5/6 cache
+================
 
 Raid 4/5/6 could include an extra disk for data cache besides normal RAID
 disks. The role of RAID disks isn't changed with the cache disk. The cache disk
@@ -6,19 +8,19 @@ caches data to the RAID disks. The cache can be in write-through (supported
 since 4.4) or write-back mode (supported since 4.10). mdadm (supported since
 3.4) has a new option '--write-journal' to create array with cache. Please
 refer to mdadm manual for details. By default (RAID array starts), the cache is
-in write-through mode. A user can switch it to write-back mode by:
+in write-through mode. A user can switch it to write-back mode by::
 
-echo "write-back" > /sys/block/md0/md/journal_mode
+	echo "write-back" > /sys/block/md0/md/journal_mode
 
-And switch it back to write-through mode by:
+And switch it back to write-through mode by::
 
-echo "write-through" > /sys/block/md0/md/journal_mode
+	echo "write-through" > /sys/block/md0/md/journal_mode
 
 In both modes, all writes to the array will hit cache disk first. This means
 the cache disk must be fast and sustainable.
 
--------------------------------------
-write-through mode:
+write-through mode
+==================
 
 This mode mainly fixes the 'write hole' issue. For RAID 4/5/6 array, an unclean
 shutdown can cause data in some stripes to not be in consistent state, eg, data
@@ -42,8 +44,8 @@ exposed to 'write hole' again.
 In write-through mode, the cache disk isn't required to be big. Several
 hundreds megabytes are enough.
 
---------------------------------------
-write-back mode:
+write-back mode
+===============
 
 write-back mode fixes the 'write hole' issue too, since all write data is
 cached on cache disk. But the main goal of 'write-back' cache is to speed up
@@ -64,16 +66,16 @@ data loss.
 In write-back mode, MD also caches data in memory. The memory cache includes
 the same data stored on cache disk, so a power loss doesn't cause data loss.
 The memory cache size has performance impact for the array. It's recommended
-the size is big. A user can configure the size by:
+the size is big. A user can configure the size by::
 
-echo "2048" > /sys/block/md0/md/stripe_cache_size
+	echo "2048" > /sys/block/md0/md/stripe_cache_size
 
 Too small cache disk will make the write aggregation less efficient in this
 mode depending on the workloads. It's recommended to use a cache disk with at
 least several gigabytes size in write-back mode.
 
---------------------------------------
-The implementation:
+The implementation
+==================
 
 The write-through and write-back cache use the same disk format. The cache disk
 is organized as a simple write log. The log consists of 'meta data' and 'data'
diff --git a/Documentation/md/raid5-ppl.txt b/Documentation/md/raid5-ppl.rst
similarity index 98%
rename from Documentation/md/raid5-ppl.txt
rename to Documentation/md/raid5-ppl.rst
index bfa092589e00..357e5515bc55 100644
--- a/Documentation/md/raid5-ppl.txt
+++ b/Documentation/md/raid5-ppl.rst
@@ -1,4 +1,6 @@
+==================
 Partial Parity Log
+==================
 
 Partial Parity Log (PPL) is a feature available for RAID5 arrays. The issue
 addressed by PPL is that after a dirty shutdown, parity of a particular stripe
-- 
2.21.0

