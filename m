Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BDFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EAA2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfCKNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmlfM-1gbOff1Lp0-00joLN for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 074/114] drivers: md: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:26 +0100
Message-Id: <1552310346-7629-75-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:70s86Uj/+QeHlvCdUztE2ULpzU2eBiMIfTj07G3KnJr5WWRalIu
 S/SoB7CK1KNfsaB2aHNNIsCUTpdMpPkz/nKAfTAR8e5gIi4QuQHwBCwCboB8bhleqk/3C9f
 tNrIpXKij2ML4zIc69f88vHNfPBgozd3w/0IQ88l4dcfN0ILSO2Y1Kw5ZBI3e+OEuORaIk/
 VMO8RYFBuE2vNjGM+1k2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gT4rfH1alF0=:DuJGsFqVjrmDnSPXTmCsQF
 By1R3elLfcGVA40r41RaspJM4u7nOfDXSh2pkD6Y8o0sNMdhqLX2+3DMT447E/+aQKDmqI4B9
 FclbVSu0l7voUGaPCjr2A/vZgzQNwEgSSNiVACo37ZLZ4HlCibeSRzEUKxRIRZdAGc0fQwqBj
 0qiyKdpX0iO4rUKatGcWD3Bu7ANBPUv8hcgvYv7zd478iEJqLCmlizEdcAQmhhU1yuxXdHZ2D
 IEwz23JgFHh2XV7m2goDtmyb018AUXDmilzCjlW5r5RhzxIY4Qi7lY3phVpR/aH0fPyu43/L6
 FFUmrUlApW2RObB6OJQCicmiGVh9QxGXMhD5LIJN55Xh9mXzzcF8blXGR/KjcrAdtrFw5oEkT
 MC/Pgpav4DraRsy8HeZEUGFbVb1Z+IU2j8NFg2txdqonl5MoMonzfR3+RnrMnskC0kWnZUuUr
 NgEAXkFtqQ0D4NkIsIPreubH7pW7dHd2rnaDv5mrdcje+pw9hpsTMHCrP+8CZG5I8AHgRa01D
 CxCBVRDZcrpvG6wcUTsL0dWjWubK6U17Z4MD1MSKSpkC1/opAxK1gZIvT0qHr82Eshim2Itkk
 ukiE8G95DtNsXDQkcN1/SV+SbKofDOj/2k4aWI2cVqvuEdwM00/vHXPc2kLdMEsDrR+1URwbp
 ah/qhy3pf7RPi8sflQR24NtleGglXic08iagFGBzDXHg3rRiveecf6+l+3uDabQS357Dl1kav
 vR7Dq4GNCBGq8VSR7C9/OJ+7pw5fmjHytHkI3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/md/Kconfig                 | 236 ++++++++++++++++++-------------------
 drivers/md/persistent-data/Kconfig |  15 ++-
 2 files changed, 125 insertions(+), 126 deletions(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 2557f19..e7e1596 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -37,9 +37,9 @@ config MD_AUTODETECT
 	default y
 	---help---
 	  If you say Y here, then the kernel will try to autodetect raid
-	  arrays as part of its boot process. 
+	  arrays as part of its boot process.
 
-	  If you don't use raid and say Y, this autodetection can cause 
+	  If you don't use raid and say Y, this autodetection can cause
 	  a several-second delay in the boot time due to various
 	  synchronisation steps that are part of this step.
 
@@ -183,15 +183,15 @@ config MD_CLUSTER
 	depends on DLM
 	default n
 	---help---
-	Clustering support for MD devices. This enables locking and
-	synchronization across multiple systems on the cluster, so all
-	nodes in the cluster can access the MD devices simultaneously.
+	  Clustering support for MD devices. This enables locking and
+	  synchronization across multiple systems on the cluster, so all
+	  nodes in the cluster can access the MD devices simultaneously.
 
-	This brings the redundancy (and uptime) of RAID levels across the
-	nodes of the cluster. Currently, it can work with raid1 and raid10
-	(limited support).
+	  This brings the redundancy (and uptime) of RAID levels across the
+	  nodes of the cluster. Currently, it can work with raid1 and raid10
+	  (limited support).
 
-	If unsure, say N.
+	  If unsure, say N.
 
 source "drivers/md/bcache/Kconfig"
 
@@ -224,44 +224,44 @@ config DM_DEBUG
 	  If unsure, say N.
 
 config DM_BUFIO
-       tristate
-       depends on BLK_DEV_DM
-       ---help---
-	 This interface allows you to do buffered I/O on a device and acts
-	 as a cache, holding recently-read blocks in memory and performing
-	 delayed writes.
+	tristate
+	depends on BLK_DEV_DM
+	---help---
+	  This interface allows you to do buffered I/O on a device and acts
+	  as a cache, holding recently-read blocks in memory and performing
+	  delayed writes.
 
 config DM_DEBUG_BLOCK_MANAGER_LOCKING
-       bool "Block manager locking"
-       depends on DM_BUFIO
-       ---help---
-	 Block manager locking can catch various metadata corruption issues.
+	bool "Block manager locking"
+	depends on DM_BUFIO
+	---help---
+	  Block manager locking can catch various metadata corruption issues.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 config DM_DEBUG_BLOCK_STACK_TRACING
-       bool "Keep stack trace of persistent data block lock holders"
-       depends on STACKTRACE_SUPPORT && DM_DEBUG_BLOCK_MANAGER_LOCKING
-       select STACKTRACE
-       ---help---
-	 Enable this for messages that may help debug problems with the
-	 block manager locking used by thin provisioning and caching.
+	bool "Keep stack trace of persistent data block lock holders"
+	depends on STACKTRACE_SUPPORT && DM_DEBUG_BLOCK_MANAGER_LOCKING
+	select STACKTRACE
+	---help---
+	  Enable this for messages that may help debug problems with the
+	  block manager locking used by thin provisioning and caching.
 
-	 If unsure, say N.
+	  If unsure, say N.
 
 config DM_BIO_PRISON
-       tristate
-       depends on BLK_DEV_DM
-       ---help---
-	 Some bio locking schemes used by other device-mapper targets
-	 including thin provisioning.
+	tristate
+	depends on BLK_DEV_DM
+	---help---
+	  Some bio locking schemes used by other device-mapper targets
+	  including thin provisioning.
 
 source "drivers/md/persistent-data/Kconfig"
 
 config DM_UNSTRIPED
-       tristate "Unstriped target"
-       depends on BLK_DEV_DM
-       ---help---
+	tristate "Unstriped target"
+	depends on BLK_DEV_DM
+	---help---
 	  Unstripes I/O so it is issued solely on a single drive in a HW
 	  RAID0 or dm-striped target.
 
@@ -284,73 +284,73 @@ config DM_CRYPT
 	  If unsure, say N.
 
 config DM_SNAPSHOT
-       tristate "Snapshot target"
-       depends on BLK_DEV_DM
-       select DM_BUFIO
-       ---help---
-         Allow volume managers to take writable snapshots of a device.
+	tristate "Snapshot target"
+	depends on BLK_DEV_DM
+	select DM_BUFIO
+	---help---
+	  Allow volume managers to take writable snapshots of a device.
 
 config DM_THIN_PROVISIONING
-       tristate "Thin provisioning target"
-       depends on BLK_DEV_DM
-       select DM_PERSISTENT_DATA
-       select DM_BIO_PRISON
-       ---help---
-         Provides thin provisioning and snapshots that share a data store.
+	tristate "Thin provisioning target"
+	depends on BLK_DEV_DM
+	select DM_PERSISTENT_DATA
+	select DM_BIO_PRISON
+	---help---
+	  Provides thin provisioning and snapshots that share a data store.
 
 config DM_CACHE
-       tristate "Cache target (EXPERIMENTAL)"
-       depends on BLK_DEV_DM
-       default n
-       select DM_PERSISTENT_DATA
-       select DM_BIO_PRISON
-       ---help---
-         dm-cache attempts to improve performance of a block device by
-         moving frequently used data to a smaller, higher performance
-         device.  Different 'policy' plugins can be used to change the
-         algorithms used to select which blocks are promoted, demoted,
-         cleaned etc.  It supports writeback and writethrough modes.
+	tristate "Cache target (EXPERIMENTAL)"
+	depends on BLK_DEV_DM
+	default n
+	select DM_PERSISTENT_DATA
+	select DM_BIO_PRISON
+	---help---
+	  dm-cache attempts to improve performance of a block device by
+	  moving frequently used data to a smaller, higher performance
+	  device.  Different 'policy' plugins can be used to change the
+	  algorithms used to select which blocks are promoted, demoted,
+	  cleaned etc.  It supports writeback and writethrough modes.
 
 config DM_CACHE_SMQ
-       tristate "Stochastic MQ Cache Policy (EXPERIMENTAL)"
-       depends on DM_CACHE
-       default y
-       ---help---
-         A cache policy that uses a multiqueue ordered by recent hits
-         to select which blocks should be promoted and demoted.
-         This is meant to be a general purpose policy.  It prioritises
-         reads over writes.  This SMQ policy (vs MQ) offers the promise
-         of less memory utilization, improved performance and increased
-         adaptability in the face of changing workloads.
+	tristate "Stochastic MQ Cache Policy (EXPERIMENTAL)"
+	depends on DM_CACHE
+	default y
+	---help---
+	  A cache policy that uses a multiqueue ordered by recent hits
+	  to select which blocks should be promoted and demoted.
+	  This is meant to be a general purpose policy.  It prioritises
+	  reads over writes.  This SMQ policy (vs MQ) offers the promise
+	  of less memory utilization, improved performance and increased
+	  adaptability in the face of changing workloads.
 
 config DM_WRITECACHE
 	tristate "Writecache target"
 	depends on BLK_DEV_DM
 	---help---
-	   The writecache target caches writes on persistent memory or SSD.
-	   It is intended for databases or other programs that need extremely
-	   low commit latency.
+	  The writecache target caches writes on persistent memory or SSD.
+	  It is intended for databases or other programs that need extremely
+	  low commit latency.
 
-	   The writecache target doesn't cache reads because reads are supposed
-	   to be cached in standard RAM.
+	  The writecache target doesn't cache reads because reads are supposed
+	  to be cached in standard RAM.
 
 config DM_ERA
-       tristate "Era target (EXPERIMENTAL)"
-       depends on BLK_DEV_DM
-       default n
-       select DM_PERSISTENT_DATA
-       select DM_BIO_PRISON
-       ---help---
-         dm-era tracks which parts of a block device are written to
-         over time.  Useful for maintaining cache coherency when using
-         vendor snapshots.
+	tristate "Era target (EXPERIMENTAL)"
+	depends on BLK_DEV_DM
+	default n
+	select DM_PERSISTENT_DATA
+	select DM_BIO_PRISON
+	---help---
+	  dm-era tracks which parts of a block device are written to
+	  over time.  Useful for maintaining cache coherency when using
+	  vendor snapshots.
 
 config DM_MIRROR
-       tristate "Mirror target"
-       depends on BLK_DEV_DM
-       ---help---
-         Allow volume managers to mirror logical volumes, also
-         needed for live data migration tools such as 'pvmove'.
+	tristate "Mirror target"
+	depends on BLK_DEV_DM
+	---help---
+	  Allow volume managers to mirror logical volumes, also
+	  needed for live data migration tools such as 'pvmove'.
 
 config DM_LOG_USERSPACE
 	tristate "Mirror userspace logging"
@@ -364,31 +364,31 @@ config DM_LOG_USERSPACE
 	  by leveraging this framework.
 
 config DM_RAID
-       tristate "RAID 1/4/5/6/10 target"
-       depends on BLK_DEV_DM
-       select MD_RAID0
-       select MD_RAID1
-       select MD_RAID10
-       select MD_RAID456
-       select BLK_DEV_MD
-       ---help---
-	 A dm target that supports RAID1, RAID10, RAID4, RAID5 and RAID6 mappings
-
-	 A RAID-5 set of N drives with a capacity of C MB per drive provides
-	 the capacity of C * (N - 1) MB, and protects against a failure
-	 of a single drive. For a given sector (row) number, (N - 1) drives
-	 contain data sectors, and one drive contains the parity protection.
-	 For a RAID-4 set, the parity blocks are present on a single drive,
-	 while a RAID-5 set distributes the parity across the drives in one
-	 of the available parity distribution methods.
-
-	 A RAID-6 set of N drives with a capacity of C MB per drive
-	 provides the capacity of C * (N - 2) MB, and protects
-	 against a failure of any two drives. For a given sector
-	 (row) number, (N - 2) drives contain data sectors, and two
-	 drives contains two independent redundancy syndromes.  Like
-	 RAID-5, RAID-6 distributes the syndromes across the drives
-	 in one of the available parity distribution methods.
+	tristate "RAID 1/4/5/6/10 target"
+	depends on BLK_DEV_DM
+	select MD_RAID0
+	select MD_RAID1
+	select MD_RAID10
+	select MD_RAID456
+	select BLK_DEV_MD
+	---help---
+	  A dm target that supports RAID1, RAID10, RAID4, RAID5 and RAID6 mappings
+
+	  A RAID-5 set of N drives with a capacity of C MB per drive provides
+	  the capacity of C * (N - 1) MB, and protects against a failure
+	  of a single drive. For a given sector (row) number, (N - 1) drives
+	  contain data sectors, and one drive contains the parity protection.
+	  For a RAID-4 set, the parity blocks are present on a single drive,
+	  while a RAID-5 set distributes the parity across the drives in one
+	  of the available parity distribution methods.
+
+	  A RAID-6 set of N drives with a capacity of C MB per drive
+	  provides the capacity of C * (N - 2) MB, and protects
+	  against a failure of any two drives. For a given sector
+	  (row) number, (N - 2) drives contain data sectors, and two
+	  drives contains two independent redundancy syndromes.  Like
+	  RAID-5, RAID-6 distributes the syndromes across the drives
+	  in one of the available parity distribution methods.
 
 config DM_ZERO
 	tristate "Zero target"
@@ -431,10 +431,10 @@ config DM_DELAY
 	tristate "I/O delaying target"
 	depends on BLK_DEV_DM
 	---help---
-	A target that delays reads and/or writes and can send
-	them to different devices.  Useful for testing.
+	  A target that delays reads and/or writes and can send
+	  them to different devices.  Useful for testing.
 
-	If unsure, say N.
+	  If unsure, say N.
 
 config DM_INIT
 	bool "DM \"dm-mod.create=\" parameter support"
@@ -455,10 +455,10 @@ config DM_UEVENT
 	Generate udev events for DM events.
 
 config DM_FLAKEY
-       tristate "Flakey target"
-       depends on BLK_DEV_DM
-       ---help---
-         A target that intermittently fails I/O for debugging purposes.
+	tristate "Flakey target"
+	depends on BLK_DEV_DM
+	---help---
+	  A target that intermittently fails I/O for debugging purposes.
 
 config DM_VERITY
 	tristate "Verity target support"
diff --git a/drivers/md/persistent-data/Kconfig b/drivers/md/persistent-data/Kconfig
index a53cbc9..28b77ee 100644
--- a/drivers/md/persistent-data/Kconfig
+++ b/drivers/md/persistent-data/Kconfig
@@ -1,9 +1,8 @@
 config DM_PERSISTENT_DATA
-       tristate
-       depends on BLK_DEV_DM
-       select LIBCRC32C
-       select DM_BUFIO
-       ---help---
-	 Library providing immutable on-disk data structure support for
-	 device-mapper targets such as the thin provisioning target.
-
+	tristate
+	depends on BLK_DEV_DM
+	select LIBCRC32C
+	select DM_BUFIO
+	---help---
+	  Library providing immutable on-disk data structure support for
+	  device-mapper targets such as the thin provisioning target.
-- 
1.9.1

