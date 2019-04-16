Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC867C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4F620656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383536;
	bh=Xgbw2ycklcqGImAv4kH6a+Q1rDtwo4uGRBHpKtZaEbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WjTWb2wZzGfz2+EbzAl8AUCXLtQ1siO6346TlrqSaVfI1U2ukD+EZYhy5l9ouvtKQ
	 /PXKNYTVTNQesIYwJzolaOqNApm4gZM5anzcn0PYO0O0qQK8DMAKhw+Ie/GqheVxMh
	 rFgwhD0FFIctgXPmeCoVp7eTIHEmzGN3pTCqeKXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfDPC6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:58:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WkTudZtpG68WmcIDYeK3O75YhWNPGPQp46BDcY2cs5Q=; b=Ms+7wAV/qu2a6kBlBopC0MyKLG
        47FN/EhtLkVbnoPbnwqUTfKyEKkaPMmQqVCrQBS+zXl00GuJARtCF44RM8cmMCkN94/3ONs7tArT3
        1W47m5+K2bOuudcaR9DCQDMUdERWK5yOYRCxfe5th+Bz7SvYilQGXGYgT7tg4MKUDEt/W/vAwol+J
        NPhX1UP8bnn6S4zxZFIRjXEl8mRvz+ySAs01K2zRxmYSE0csSQc+z+eC/h7K2T4uEKavz14Ni2IKD
        hG381azCjiuKd6KDQiRqjBJljisCYShCns2OrFxGFzQ7TGHlbcDaj61p9+qVaCbb4T8RgxCRFNETW
        ZhzjR4/Q==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007aY-FL; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001m9-AC; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 16/57] docs: ide: convert it to ReST format
Date:   Mon, 15 Apr 2019 23:55:41 -0300
Message-Id: <4ca04f310a20234dd5ede53dae7cf794241650ab.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the IDE documentation to ReST format, in order to prepare
for its addition inside a book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ide/ide-tape.txt        |  23 ++--
 Documentation/ide/ide.txt             | 147 ++++++++++++++------------
 Documentation/ide/warm-plug-howto.txt |  10 +-
 3 files changed, 96 insertions(+), 84 deletions(-)

diff --git a/Documentation/ide/ide-tape.txt b/Documentation/ide/ide-tape.txt
index 3f348a0b21d8..3e061d9c0e38 100644
--- a/Documentation/ide/ide-tape.txt
+++ b/Documentation/ide/ide-tape.txt
@@ -1,4 +1,6 @@
-IDE ATAPI streaming tape driver.
+===============================
+IDE ATAPI streaming tape driver
+===============================
 
 This driver is a part of the Linux ide driver.
 
@@ -10,14 +12,14 @@ to the request-list of the block device, and waits for their completion.
 The block device major and minor numbers are determined from the
 tape's relative position in the ide interfaces, as explained in ide.c.
 
-The character device interface consists of the following devices:
+The character device interface consists of the following devices::
 
-ht0		major 37, minor 0	first  IDE tape, rewind on close.
-ht1		major 37, minor 1	second IDE tape, rewind on close.
-...
-nht0		major 37, minor 128	first  IDE tape, no rewind on close.
-nht1		major 37, minor 129	second IDE tape, no rewind on close.
-...
+  ht0		major 37, minor 0	first  IDE tape, rewind on close.
+  ht1		major 37, minor 1	second IDE tape, rewind on close.
+  ...
+  nht0		major 37, minor 128	first  IDE tape, no rewind on close.
+  nht1		major 37, minor 129	second IDE tape, no rewind on close.
+  ...
 
 The general magnetic tape commands compatible interface, as defined by
 include/linux/mtio.h, is accessible through the character device.
@@ -40,9 +42,10 @@ Testing was done with a 2 GB CONNER CTMA 4000 IDE ATAPI Streaming Tape Drive.
 Here are some words from the first releases of hd.c, which are quoted
 in ide.c and apply here as well:
 
-| Special care is recommended.  Have Fun!
+* Special care is recommended.  Have Fun!
 
-Possible improvements:
+Possible improvements
+=====================
 
 1. Support for the ATAPI overlap protocol.
 
diff --git a/Documentation/ide/ide.txt b/Documentation/ide/ide.txt
index 7aca987c23d9..88bdcba92f7d 100644
--- a/Documentation/ide/ide.txt
+++ b/Documentation/ide/ide.txt
@@ -1,41 +1,43 @@
-
-	Information regarding the Enhanced IDE drive in Linux 2.6
-
-==============================================================================
-
+============================================
+Information regarding the Enhanced IDE drive
+============================================
 
    The hdparm utility can be used to control various IDE features on a
    running system. It is packaged separately.  Please Look for it on popular
    linux FTP sites.
 
+-------------------------------------------------------------------------------
 
+.. important::
 
-***  IMPORTANT NOTICES:  BUGGY IDE CHIPSETS CAN CORRUPT DATA!!
-***  =================
-***  PCI versions of the CMD640 and RZ1000 interfaces are now detected
-***  automatically at startup when PCI BIOS support is configured.
-***
-***  Linux disables the "prefetch" ("readahead") mode of the RZ1000
-***  to prevent data corruption possible due to hardware design flaws.
-***
-***  For the CMD640, linux disables "IRQ unmasking" (hdparm -u1) on any
-***  drive for which the "prefetch" mode of the CMD640 is turned on.
-***  If "prefetch" is disabled (hdparm -p8), then "IRQ unmasking" can be
-***  used again.
-***
-***  For the CMD640, linux disables "32bit I/O" (hdparm -c1) on any drive
-***  for which the "prefetch" mode of the CMD640 is turned off.
-***  If "prefetch" is enabled (hdparm -p9), then "32bit I/O" can be
-***  used again.
-***
-***  The CMD640 is also used on some Vesa Local Bus (VLB) cards, and is *NOT*
-***  automatically detected by Linux.  For safe, reliable operation with such
-***  interfaces, one *MUST* use the "cmd640.probe_vlb" kernel option.
-***
-***  Use of the "serialize" option is no longer necessary.
-
-================================================================================
-Common pitfalls:
+   BUGGY IDE CHIPSETS CAN CORRUPT DATA!!
+
+    PCI versions of the CMD640 and RZ1000 interfaces are now detected
+    automatically at startup when PCI BIOS support is configured.
+
+    Linux disables the "prefetch" ("readahead") mode of the RZ1000
+    to prevent data corruption possible due to hardware design flaws.
+
+    For the CMD640, linux disables "IRQ unmasking" (hdparm -u1) on any
+    drive for which the "prefetch" mode of the CMD640 is turned on.
+    If "prefetch" is disabled (hdparm -p8), then "IRQ unmasking" can be
+    used again.
+
+    For the CMD640, linux disables "32bit I/O" (hdparm -c1) on any drive
+    for which the "prefetch" mode of the CMD640 is turned off.
+    If "prefetch" is enabled (hdparm -p9), then "32bit I/O" can be
+    used again.
+
+    The CMD640 is also used on some Vesa Local Bus (VLB) cards, and is *NOT*
+    automatically detected by Linux.  For safe, reliable operation with such
+    interfaces, one *MUST* use the "cmd640.probe_vlb" kernel option.
+
+    Use of the "serialize" option is no longer necessary.
+
+-------------------------------------------------------------------------------
+
+Common pitfalls
+===============
 
 - 40-conductor IDE cables are capable of transferring data in DMA modes up to
   udma2, but no faster.
@@ -49,19 +51,18 @@ Common pitfalls:
 - Even better try to stick to the same vendor and device type on the same
   cable.
 
-================================================================================
-
-This is the multiple IDE interface driver, as evolved from hd.c.
+This is the multiple IDE interface driver, as evolved from hd.c
+===============================================================
 
 It supports up to 9 IDE interfaces per default, on one or more IRQs (usually
-14 & 15).  There can be up to two drives per interface, as per the ATA-6 spec.
+14 & 15).  There can be up to two drives per interface, as per the ATA-6 spec.::
 
-Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
-Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
-Tertiary:   ide2, port 0x1e8; major=33; hde is minor=0; hdf is minor=64
-Quaternary: ide3, port 0x168; major=34; hdg is minor=0; hdh is minor=64
-fifth..     ide4, usually PCI, probed
-sixth..     ide5, usually PCI, probed
+  Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
+  Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
+  Tertiary:   ide2, port 0x1e8; major=33; hde is minor=0; hdf is minor=64
+  Quaternary: ide3, port 0x168; major=34; hdg is minor=0; hdh is minor=64
+  fifth..     ide4, usually PCI, probed
+  sixth..     ide5, usually PCI, probed
 
 To access devices on interfaces > ide0, device entries please make sure that
 device files for them are present in /dev.  If not, please create such
@@ -80,12 +81,15 @@ seldom occurs.  Be careful, and if in doubt, don't do it!
 
 Drives are normally found by auto-probing and/or examining the CMOS/BIOS data.
 For really weird situations, the apparent (fdisk) geometry can also be specified
-on the kernel "command line" using LILO.  The format of such lines is:
+on the kernel "command line" using LILO.  The format of such lines is::
 
 	ide_core.chs=[interface_number.device_number]:cyls,heads,sects
-or	ide_core.cdrom=[interface_number.device_number]
 
-For example:
+or::
+
+	ide_core.cdrom=[interface_number.device_number]
+
+For example::
 
 	ide_core.chs=1.0:1050,32,64  ide_core.cdrom=1.1
 
@@ -96,10 +100,12 @@ geometry for partitioning purposes (fdisk).
 If the auto-probing during boot time confuses a drive (ie. the drive works
 with hd.c but not with ide.c), then an command line option may be specified
 for each drive for which you'd like the drive to skip the hardware
-probe/identification sequence.  For example:
+probe/identification sequence.  For example::
 
 	ide_core.noprobe=0.1
-or
+
+or::
+
 	ide_core.chs=1.0:768,16,32
 	ide_core.noprobe=1.0
 
@@ -115,22 +121,24 @@ Such drives will be identified at boot time, just like a hard disk.
 
 If for some reason your cdrom drive is *not* found at boot time, you can force
 the probe to look harder by supplying a kernel command line parameter
-via LILO, such as:
+via LILO, such as:::
 
 	ide_core.cdrom=1.0	/* "master" on second interface (hdc) */
-or
+
+or::
+
 	ide_core.cdrom=1.1	/* "slave" on second interface (hdd) */
 
 For example, a GW2000 system might have a hard drive on the primary
 interface (/dev/hda) and an IDE cdrom drive on the secondary interface
-(/dev/hdc).  To mount a CD in the cdrom drive, one would use something like:
+(/dev/hdc).  To mount a CD in the cdrom drive, one would use something like::
 
 	ln -sf /dev/hdc /dev/cdrom
 	mkdir /mnt/cdrom
 	mount /dev/cdrom /mnt/cdrom -t iso9660 -o ro
 
 If, after doing all of the above, mount doesn't work and you see
-errors from the driver (with dmesg) complaining about `status=0xff',
+errors from the driver (with dmesg) complaining about `status=0xff`,
 this means that the hardware is not responding to the driver's attempts
 to read it.  One of the following is probably the problem:
 
@@ -165,7 +173,7 @@ drivers can always be compiled as loadable modules, the chipset drivers
 can only be compiled into the kernel, and the core code (ide.c) can be
 compiled as a loadable module provided no chipset support is needed.
 
-When using ide.c as a module in combination with kmod, add:
+When using ide.c as a module in combination with kmod, add::
 
 	alias block-major-3 ide-probe
 
@@ -176,10 +184,8 @@ driver using the "options=" keyword to insmod, while replacing any ',' with
 ';'.
 
 
-================================================================================
-
 Summary of ide driver parameters for kernel command line
---------------------------------------------------------
+========================================================
 
 For legacy IDE VLB host drivers (ali14xx/dtc2278/ht6560b/qd65xx/umc8672)
 you need to explicitly enable probing by using "probe" kernel parameter,
@@ -226,28 +232,31 @@ Other kernel parameters for ide_core are:
 
 * "chs=[interface_number.device_number]" to force device as a disk (using CHS)
 
-================================================================================
 
 Some Terminology
-----------------
-IDE = Integrated Drive Electronics, meaning that each drive has a built-in
-controller, which is why an "IDE interface card" is not a "controller card".
+================
 
-ATA = AT (the old IBM 286 computer) Attachment Interface, a draft American
-National Standard for connecting hard drives to PCs.  This is the official
-name for "IDE".
+IDE
+  Integrated Drive Electronics, meaning that each drive has a built-in
+  controller, which is why an "IDE interface card" is not a "controller card".
 
-The latest standards define some enhancements, known as the ATA-6 spec,
-which grew out of vendor-specific "Enhanced IDE" (EIDE) implementations.
+ATA
+  AT (the old IBM 286 computer) Attachment Interface, a draft American
+  National Standard for connecting hard drives to PCs.  This is the official
+  name for "IDE".
 
-ATAPI = ATA Packet Interface, a new protocol for controlling the drives,
-similar to SCSI protocols, created at the same time as the ATA2 standard.
-ATAPI is currently used for controlling CDROM, TAPE and FLOPPY (ZIP or
-LS120/240) devices, removable R/W cartridges, and for high capacity hard disk
-drives.
+  The latest standards define some enhancements, known as the ATA-6 spec,
+  which grew out of vendor-specific "Enhanced IDE" (EIDE) implementations.
+
+ATAPI
+  ATA Packet Interface, a new protocol for controlling the drives,
+  similar to SCSI protocols, created at the same time as the ATA2 standard.
+  ATAPI is currently used for controlling CDROM, TAPE and FLOPPY (ZIP or
+  LS120/240) devices, removable R/W cartridges, and for high capacity hard disk
+  drives.
 
 mlord@pobox.com
---
+
 
 Wed Apr 17 22:52:44 CEST 2002 edited by Marcin Dalecki, the current
 maintainer.
diff --git a/Documentation/ide/warm-plug-howto.txt b/Documentation/ide/warm-plug-howto.txt
index 98152bcd515a..c245242ef2f1 100644
--- a/Documentation/ide/warm-plug-howto.txt
+++ b/Documentation/ide/warm-plug-howto.txt
@@ -1,14 +1,14 @@
-
+===================
 IDE warm-plug HOWTO
 ===================
 
-To warm-plug devices on a port 'idex':
+To warm-plug devices on a port 'idex'::
 
-# echo -n "1" > /sys/class/ide_port/idex/delete_devices
+	# echo -n "1" > /sys/class/ide_port/idex/delete_devices
 
-unplug old device(s) and plug new device(s)
+unplug old device(s) and plug new device(s)::
 
-# echo -n "1" > /sys/class/ide_port/idex/scan
+	# echo -n "1" > /sys/class/ide_port/idex/scan
 
 done
 
-- 
2.20.1

