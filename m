Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637EDC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185A320896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364742;
	bh=yvQSmnhSxUxQccea17Fu8xmL88QQ6t4T0IV7q3XUZ4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eTVGj1e60C1mo0Ix7hRWsiMuijbFOTdQOPlKWMsM6OJ1xw1evmYYh1gGe6Dkrx0AN
	 ssgkbdx5S140GnKSDHPoCIhdYEXQaFRP9+sk/x1hhQJDVk0RWknHEZLzV2Q/Kmoxep
	 tWbMpQ2ZgaG+hZp0RCZYmi/QXRPFH0lBJP8JdpRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfFLSjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:39:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfFLSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1YxH1eCx5scHBYTenHe231faj+3yvkZp9ZtS7rHqtG8=; b=l1PSi98xZEauuIUbzSZQsZ9pog
        giKmQ/xtF5Imjz7dK+oZGzTpxoyS95c0iXCn2+Vouj/ktoFHrFeGzc79Myr6KtvTe8nwlbrXXB0+V
        /ygu9ZKKTUH/hALrZ1LTbBHpb4IlD5/aGqCnB+QPZaLYBV4eb6lV3u9om4zal+GEgakGIilTn6fY2
        dshYKbsrMcfmjfNZa6dw7Q1DB5XNK81xx3iTyt7VcNcsgyU6KGq8O1gfgWuV4/do6yZZaexddoqJy
        xdHHdJSuVLNvoqe+UGZGizaVb5WnPlnNOp3/nry8/HI7B8ZuJc66UdQPvYAUeB1VpP0rGeOEjCu0W
        y/NEUKGQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YL-Jl; Wed, 12 Jun 2019 18:38:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88p-0002AV-Se; Wed, 12 Jun 2019 15:38:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 04/31] docs: m68k: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 15:38:07 -0300
Message-Id: <5cac4c146a52d949f3c766ccea5becce19e6067c.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the m68k kernel-options.txt file to ReST.

The conversion is trivial, as the document is already on a format
close enough to ReST. Just some small adjustments were needed in
order to make it both good for being parsed while keeping it on
a good txt shape.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../admin-guide/kernel-parameters.rst         |   2 +-
 Documentation/m68k/index.rst                  |  17 +
 ...{kernel-options.txt => kernel-options.rst} | 319 ++++++++++--------
 3 files changed, 191 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/m68k/index.rst
 rename Documentation/m68k/{kernel-options.txt => kernel-options.rst} (78%)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 8d3273e32eb1..006196bd763a 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -118,7 +118,7 @@ parameter is applicable::
 	LOOP	Loopback device support is enabled.
 	M68k	M68k architecture is enabled.
 			These options have more detailed description inside of
-			Documentation/m68k/kernel-options.txt.
+			Documentation/m68k/kernel-options.rst.
 	MDA	MDA console support is enabled.
 	MIPS	MIPS architecture is enabled.
 	MOUSE	Appropriate mouse support is enabled.
diff --git a/Documentation/m68k/index.rst b/Documentation/m68k/index.rst
new file mode 100644
index 000000000000..f3273ec075c3
--- /dev/null
+++ b/Documentation/m68k/index.rst
@@ -0,0 +1,17 @@
+:orphan:
+
+=================
+m68k Architecture
+=================
+
+.. toctree::
+   :maxdepth: 2
+
+   kernel-options
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/m68k/kernel-options.txt b/Documentation/m68k/kernel-options.rst
similarity index 78%
rename from Documentation/m68k/kernel-options.txt
rename to Documentation/m68k/kernel-options.rst
index 79d21246c75a..cabd9419740d 100644
--- a/Documentation/m68k/kernel-options.txt
+++ b/Documentation/m68k/kernel-options.rst
@@ -1,22 +1,24 @@
-
-
-				  Command Line Options for Linux/m68k
-				  ===================================
+===================================
+Command Line Options for Linux/m68k
+===================================
 
 Last Update: 2 May 1999
+
 Linux/m68k version: 2.2.6
+
 Author: Roman.Hodek@informatik.uni-erlangen.de (Roman Hodek)
+
 Update: jds@kom.auc.dk (Jes Sorensen) and faq@linux-m68k.org (Chris Lawrence)
 
 0) Introduction
 ===============
 
-  Often I've been asked which command line options the Linux/m68k
+Often I've been asked which command line options the Linux/m68k
 kernel understands, or how the exact syntax for the ... option is, or
 ... about the option ... . I hope, this document supplies all the
 answers...
 
-  Note that some options might be outdated, their descriptions being
+Note that some options might be outdated, their descriptions being
 incomplete or missing. Please update the information and send in the
 patches.
 
@@ -38,11 +40,11 @@ argument contains an '=', it is of class 2, and the definition is put
 into init's environment. All other arguments are passed to init as
 command line options.
 
-  This document describes the valid kernel options for Linux/m68k in
+This document describes the valid kernel options for Linux/m68k in
 the version mentioned at the start of this file. Later revisions may
 add new such options, and some may be missing in older versions.
 
-  In general, the value (the part after the '=') of an option is a
+In general, the value (the part after the '=') of an option is a
 list of values separated by commas. The interpretation of these values
 is up to the driver that "owns" the option. This association of
 options with drivers is also the reason that some are further
@@ -55,21 +57,21 @@ subdivided.
 2.1) root=
 ----------
 
-Syntax: root=/dev/<device>
-    or: root=<hex_number>
+:Syntax: root=/dev/<device>
+:or:     root=<hex_number>
 
 This tells the kernel which device it should mount as the root
 filesystem. The device must be a block device with a valid filesystem
 on it.
 
-  The first syntax gives the device by name. These names are converted
+The first syntax gives the device by name. These names are converted
 into a major/minor number internally in the kernel in an unusual way.
 Normally, this "conversion" is done by the device files in /dev, but
 this isn't possible here, because the root filesystem (with /dev)
 isn't mounted yet... So the kernel parses the name itself, with some
 hardcoded name to number mappings. The name must always be a
 combination of two or three letters, followed by a decimal number.
-Valid names are:
+Valid names are::
 
   /dev/ram: -> 0x0100 (initial ramdisk)
   /dev/hda: -> 0x0300 (first IDE disk)
@@ -81,7 +83,7 @@ Valid names are:
   /dev/sde: -> 0x0840 (fifth SCSI disk)
   /dev/fd : -> 0x0200 (floppy disk)
 
-  The name must be followed by a decimal number, that stands for the
+The name must be followed by a decimal number, that stands for the
 partition number. Internally, the value of the number is just
 added to the device number mentioned in the table above. The
 exceptions are /dev/ram and /dev/fd, where /dev/ram refers to an
@@ -100,12 +102,12 @@ the kernel command line.
 
 [Strange and maybe uninteresting stuff ON]
 
-  This unusual translation of device names has some strange
+This unusual translation of device names has some strange
 consequences: If, for example, you have a symbolic link from /dev/fd
 to /dev/fd0D720 as an abbreviation for floppy driver #0 in DD format,
 you cannot use this name for specifying the root device, because the
 kernel cannot see this symlink before mounting the root FS and it
-isn't in the table above. If you use it, the root device will not be 
+isn't in the table above. If you use it, the root device will not be
 set at all, without an error message. Another example: You cannot use a
 partition on e.g. the sixth SCSI disk as the root filesystem, if you
 want to specify it by name. This is, because only the devices up to
@@ -118,7 +120,7 @@ knowledge that each disk uses 16 minors, and write "root=/dev/sde17"
 
 [Strange and maybe uninteresting stuff OFF]
 
-  If the device containing your root partition isn't in the table
+If the device containing your root partition isn't in the table
 above, you can also specify it by major and minor numbers. These are
 written in hex, with no prefix and no separator between. E.g., if you
 have a CD with contents appropriate as a root filesystem in the first
@@ -136,6 +138,7 @@ known partition UUID as the starting point.  For example,
 if partition 5 of the device has the UUID of
 00112233-4455-6677-8899-AABBCCDDEEFF then partition 3 may be found as
 follows:
+
   PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF/PARTNROFF=-2
 
 Authoritative information can be found in
@@ -145,8 +148,8 @@ Authoritative information can be found in
 2.2) ro, rw
 -----------
 
-Syntax: ro
-    or: rw
+:Syntax: ro
+:or:     rw
 
 These two options tell the kernel whether it should mount the root
 filesystem read-only or read-write. The default is read-only, except
@@ -156,7 +159,7 @@ for ramdisks, which default to read-write.
 2.3) debug
 ----------
 
-Syntax: debug
+:Syntax: debug
 
 This raises the kernel log level to 10 (the default is 7). This is the
 same level as set by the "dmesg" command, just that the maximum level
@@ -166,7 +169,7 @@ selectable by dmesg is 8.
 2.4) debug=
 -----------
 
-Syntax: debug=<device>
+:Syntax: debug=<device>
 
 This option causes certain kernel messages be printed to the selected
 debugging device. This can aid debugging the kernel, since the
@@ -175,7 +178,7 @@ devices are possible depends on the machine type. There are no checks
 for the validity of the device name. If the device isn't implemented,
 nothing happens.
 
-  Messages logged this way are in general stack dumps after kernel
+Messages logged this way are in general stack dumps after kernel
 memory faults or bad kernel traps, and kernel panics. To be exact: all
 messages of level 0 (panic messages) and all messages printed while
 the log level is 8 or more (their level doesn't matter). Before stack
@@ -185,19 +188,27 @@ at least 8 can also be set by the "debug" command line option (see
 
 Devices possible for Amiga:
 
- - "ser": built-in serial port; parameters: 9600bps, 8N1
- - "mem": Save the messages to a reserved area in chip mem. After
+ - "ser":
+	  built-in serial port; parameters: 9600bps, 8N1
+ - "mem":
+	  Save the messages to a reserved area in chip mem. After
           rebooting, they can be read under AmigaOS with the tool
           'dmesg'.
 
 Devices possible for Atari:
 
- - "ser1": ST-MFP serial port ("Modem1"); parameters: 9600bps, 8N1
- - "ser2": SCC channel B serial port ("Modem2"); parameters: 9600bps, 8N1
- - "ser" : default serial port
+ - "ser1":
+	   ST-MFP serial port ("Modem1"); parameters: 9600bps, 8N1
+ - "ser2":
+	   SCC channel B serial port ("Modem2"); parameters: 9600bps, 8N1
+ - "ser" :
+	   default serial port
            This is "ser2" for a Falcon, and "ser1" for any other machine
- - "midi": The MIDI port; parameters: 31250bps, 8N1
- - "par" : parallel port
+ - "midi":
+	   The MIDI port; parameters: 31250bps, 8N1
+ - "par" :
+	   parallel port
+
            The printing routine for this implements a timeout for the
            case there's no printer connected (else the kernel would
            lock up). The timeout is not exact, but usually a few
@@ -205,26 +216,29 @@ Devices possible for Atari:
 
 
 2.6) ramdisk_size=
--------------
+------------------
 
-Syntax: ramdisk_size=<size>
+:Syntax: ramdisk_size=<size>
 
-  This option instructs the kernel to set up a ramdisk of the given
+This option instructs the kernel to set up a ramdisk of the given
 size in KBytes. Do not use this option if the ramdisk contents are
 passed by bootstrap! In this case, the size is selected automatically
 and should not be overwritten.
 
-  The only application is for root filesystems on floppy disks, that
+The only application is for root filesystems on floppy disks, that
 should be loaded into memory. To do that, select the corresponding
 size of the disk as ramdisk size, and set the root device to the disk
 drive (with "root=").
 
 
 2.7) swap=
+
+  I can't find any sign of this option in 2.2.6.
+
 2.8) buff=
 -----------
 
-  I can't find any sign of these options in 2.2.6.
+  I can't find any sign of this option in 2.2.6.
 
 
 3) General Device Options (Amiga and Atari)
@@ -233,13 +247,13 @@ drive (with "root=").
 3.1) ether=
 -----------
 
-Syntax: ether=[<irq>[,<base_addr>[,<mem_start>[,<mem_end>]]]],<dev-name>
+:Syntax: ether=[<irq>[,<base_addr>[,<mem_start>[,<mem_end>]]]],<dev-name>
 
-  <dev-name> is the name of a net driver, as specified in
+<dev-name> is the name of a net driver, as specified in
 drivers/net/Space.c in the Linux source. Most prominent are eth0, ...
 eth3, sl0, ... sl3, ppp0, ..., ppp3, dummy, and lo.
 
-  The non-ethernet drivers (sl, ppp, dummy, lo) obviously ignore the
+The non-ethernet drivers (sl, ppp, dummy, lo) obviously ignore the
 settings by this options. Also, the existing ethernet drivers for
 Linux/m68k (ariadne, a2065, hydra) don't use them because Zorro boards
 are really Plug-'n-Play, so the "ether=" option is useless altogether
@@ -249,9 +263,9 @@ for Linux/m68k.
 3.2) hd=
 --------
 
-Syntax: hd=<cylinders>,<heads>,<sectors>
+:Syntax: hd=<cylinders>,<heads>,<sectors>
 
-  This option sets the disk geometry of an IDE disk. The first hd=
+This option sets the disk geometry of an IDE disk. The first hd=
 option is for the first IDE disk, the second for the second one.
 (I.e., you can give this option twice.) In most cases, you won't have
 to use this option, since the kernel can obtain the geometry data
@@ -262,9 +276,9 @@ disks.
 3.3) max_scsi_luns=
 -------------------
 
-Syntax: max_scsi_luns=<n>
+:Syntax: max_scsi_luns=<n>
 
-  Sets the maximum number of LUNs (logical units) of SCSI devices to
+Sets the maximum number of LUNs (logical units) of SCSI devices to
 be scanned. Valid values for <n> are between 1 and 8. Default is 8 if
 "Probe all LUNs on each SCSI device" was selected during the kernel
 configuration, else 1.
@@ -273,9 +287,9 @@ configuration, else 1.
 3.4) st=
 --------
 
-Syntax: st=<buffer_size>,[<write_thres>,[<max_buffers>]]
+:Syntax: st=<buffer_size>,[<write_thres>,[<max_buffers>]]
 
-  Sets several parameters of the SCSI tape driver. <buffer_size> is
+Sets several parameters of the SCSI tape driver. <buffer_size> is
 the number of 512-byte buffers reserved for tape operations for each
 device. <write_thres> sets the number of blocks which must be filled
 to start an actual write operation to the tape. Maximum value is the
@@ -286,9 +300,9 @@ buffers allocated for all tape devices.
 3.5) dmasound=
 --------------
 
-Syntax: dmasound=[<buffers>,<buffer-size>[,<catch-radius>]]
+:Syntax: dmasound=[<buffers>,<buffer-size>[,<catch-radius>]]
 
-  This option controls some configurations of the Linux/m68k DMA sound
+This option controls some configurations of the Linux/m68k DMA sound
 driver (Amiga and Atari): <buffers> is the number of buffers you want
 to use (minimum 4, default 4), <buffer-size> is the size of each
 buffer in kilobytes (minimum 4, default 32) and <catch-radius> says
@@ -305,20 +319,22 @@ don't need to expand the sound.
 4.1) video=
 -----------
 
-Syntax: video=<fbname>:<sub-options...>
+:Syntax: video=<fbname>:<sub-options...>
 
 The <fbname> parameter specifies the name of the frame buffer,
-eg. most atari users will want to specify `atafb' here. The
+eg. most atari users will want to specify `atafb` here. The
 <sub-options> is a comma-separated list of the sub-options listed
 below.
 
-NB: Please notice that this option was renamed from `atavideo' to
-    `video' during the development of the 1.3.x kernels, thus you
+NB:
+    Please notice that this option was renamed from `atavideo` to
+    `video` during the development of the 1.3.x kernels, thus you
     might need to update your boot-scripts if upgrading to 2.x from
     an 1.2.x kernel.
 
-NBB: The behavior of video= was changed in 2.1.57 so the recommended
-option is to specify the name of the frame buffer.
+NBB:
+    The behavior of video= was changed in 2.1.57 so the recommended
+    option is to specify the name of the frame buffer.
 
 4.1.1) Video Mode
 -----------------
@@ -341,11 +357,11 @@ mode, if the hardware allows. Currently defined names are:
  - falh2           : 896x608x1, Falcon only
  - falh16          : 896x608x4, Falcon only
 
-  If no video mode is given on the command line, the kernel tries the
+If no video mode is given on the command line, the kernel tries the
 modes names "default<n>" in turn, until one is possible with the
 hardware in use.
 
-  A video mode setting doesn't make sense, if the external driver is
+A video mode setting doesn't make sense, if the external driver is
 activated by a "external:" sub-option.
 
 4.1.2) inverse
@@ -358,17 +374,17 @@ option, you can make the background white.
 4.1.3) font
 -----------
 
-Syntax: font:<fontname>
+:Syntax: font:<fontname>
 
 Specify the font to use in text modes. Currently you can choose only
-between `VGA8x8', `VGA8x16' and `PEARL8x8'. `VGA8x8' is default, if the
+between `VGA8x8`, `VGA8x16` and `PEARL8x8`. `VGA8x8` is default, if the
 vertical size of the display is less than 400 pixel rows. Otherwise, the
-`VGA8x16' font is the default.
+`VGA8x16` font is the default.
 
-4.1.4) hwscroll_
-----------------
+4.1.4) `hwscroll_`
+------------------
 
-Syntax: hwscroll_<n>
+:Syntax: `hwscroll_<n>`
 
 The number of additional lines of video memory to reserve for
 speeding up the scrolling ("hardware scrolling"). Hardware scrolling
@@ -378,7 +394,7 @@ possible with plain STs and graphics cards (The former because the
 base address must be on a 256 byte boundary there, the latter because
 the kernel doesn't know how to set the base address at all.)
 
-  By default, <n> is set to the number of visible text lines on the
+By default, <n> is set to the number of visible text lines on the
 display. Thus, the amount of video memory is doubled, compared to no
 hardware scrolling. You can turn off the hardware scrolling altogether
 by setting <n> to 0.
@@ -386,31 +402,31 @@ by setting <n> to 0.
 4.1.5) internal:
 ----------------
 
-Syntax: internal:<xres>;<yres>[;<xres_max>;<yres_max>;<offset>]
+:Syntax: internal:<xres>;<yres>[;<xres_max>;<yres_max>;<offset>]
 
 This option specifies the capabilities of some extended internal video
 hardware, like e.g. OverScan. <xres> and <yres> give the (extended)
 dimensions of the screen.
 
-  If your OverScan needs a black border, you have to write the last
+If your OverScan needs a black border, you have to write the last
 three arguments of the "internal:". <xres_max> is the maximum line
 length the hardware allows, <yres_max> the maximum number of lines.
 <offset> is the offset of the visible part of the screen memory to its
 physical start, in bytes.
 
-  Often, extended interval video hardware has to be activated somehow.
+Often, extended interval video hardware has to be activated somehow.
 For this, see the "sw_*" options below.
 
 4.1.6) external:
 ----------------
 
-Syntax:
-  external:<xres>;<yres>;<depth>;<org>;<scrmem>[;<scrlen>[;<vgabase>\
-           [;<colw>[;<coltype>[;<xres_virtual>]]]]]
+:Syntax:
+  external:<xres>;<yres>;<depth>;<org>;<scrmem>[;<scrlen>[;<vgabase>
+  [;<colw>[;<coltype>[;<xres_virtual>]]]]]
 
-[I had to break this line...]
+.. I had to break this line...
 
-  This is probably the most complicated parameter... It specifies that
+This is probably the most complicated parameter... It specifies that
 you have some external video hardware (a graphics board), and how to
 use it under Linux/m68k. The kernel cannot know more about the hardware
 than you tell it here! The kernel also is unable to set or change any
@@ -418,38 +434,44 @@ video modes, since it doesn't know about any board internal. So, you
 have to switch to that video mode before you start Linux, and cannot
 switch to another mode once Linux has started.
 
-  The first 3 parameters of this sub-option should be obvious: <xres>,
+The first 3 parameters of this sub-option should be obvious: <xres>,
 <yres> and <depth> give the dimensions of the screen and the number of
 planes (depth). The depth is the logarithm to base 2 of the number
 of colors possible. (Or, the other way round: The number of colors is
 2^depth).
 
-  You have to tell the kernel furthermore how the video memory is
+You have to tell the kernel furthermore how the video memory is
 organized. This is done by a letter as <org> parameter:
 
- 'n': "normal planes", i.e. one whole plane after another
- 'i': "interleaved planes", i.e. 16 bit of the first plane, than 16 bit
+ 'n':
+      "normal planes", i.e. one whole plane after another
+ 'i':
+      "interleaved planes", i.e. 16 bit of the first plane, than 16 bit
       of the next, and so on... This mode is used only with the
-	  built-in Atari video modes, I think there is no card that
-	  supports this mode.
- 'p': "packed pixels", i.e. <depth> consecutive bits stand for all
-	  planes of one pixel; this is the most common mode for 8 planes
-	  (256 colors) on graphic cards
- 't': "true color" (more or less packed pixels, but without a color
-	  lookup table); usually depth is 24
+      built-in Atari video modes, I think there is no card that
+      supports this mode.
+ 'p':
+      "packed pixels", i.e. <depth> consecutive bits stand for all
+      planes of one pixel; this is the most common mode for 8 planes
+      (256 colors) on graphic cards
+ 't':
+      "true color" (more or less packed pixels, but without a color
+      lookup table); usually depth is 24
 
 For monochrome modes (i.e., <depth> is 1), the <org> letter has a
 different meaning:
 
- 'n': normal colors, i.e. 0=white, 1=black
- 'i': inverted colors, i.e. 0=black, 1=white
+ 'n':
+      normal colors, i.e. 0=white, 1=black
+ 'i':
+      inverted colors, i.e. 0=black, 1=white
 
-  The next important information about the video hardware is the base
+The next important information about the video hardware is the base
 address of the video memory. That is given in the <scrmem> parameter,
 as a hexadecimal number with a "0x" prefix. You have to find out this
 address in the documentation of your hardware.
 
-  The next parameter, <scrlen>, tells the kernel about the size of the
+The next parameter, <scrlen>, tells the kernel about the size of the
 video memory. If it's missing, the size is calculated from <xres>,
 <yres>, and <depth>. For now, it is not useful to write a value here.
 It would be used only for hardware scrolling (which isn't possible
@@ -460,7 +482,7 @@ empty, either by ending the "external:" after the video address or by
 writing two consecutive semicolons, if you want to give a <vgabase>
 (it is allowed to leave this parameter empty).
 
-  The <vgabase> parameter is optional. If it is not given, the kernel
+The <vgabase> parameter is optional. If it is not given, the kernel
 cannot read or write any color registers of the video hardware, and
 thus you have to set appropriate colors before you start Linux. But if
 your card is somehow VGA compatible, you can tell the kernel the base
@@ -472,18 +494,18 @@ uses the addresses vgabase+0x3c7...vgabase+0x3c9. The <vgabase>
 parameter is written in hexadecimal with a "0x" prefix, just as
 <scrmem>.
 
-  <colw> is meaningful only if <vgabase> is specified. It tells the
+<colw> is meaningful only if <vgabase> is specified. It tells the
 kernel how wide each of the color register is, i.e. the number of bits
 per single color (red/green/blue). Default is 6, another quite usual
 value is 8.
 
-  Also <coltype> is used together with <vgabase>. It tells the kernel
+Also <coltype> is used together with <vgabase>. It tells the kernel
 about the color register model of your gfx board. Currently, the types
 "vga" (which is also the default) and "mv300" (SANG MV300) are
 implemented.
 
-  Parameter <xres_virtual> is required for ProMST or ET4000 cards where
-the physical linelength differs from the visible length. With ProMST, 
+Parameter <xres_virtual> is required for ProMST or ET4000 cards where
+the physical linelength differs from the visible length. With ProMST,
 xres_virtual must be set to 2048. For ET4000, xres_virtual depends on the
 initialisation of the video-card.
 If you're missing a corresponding yres_virtual: the external part is legacy,
@@ -499,13 +521,13 @@ currently works only with the ScreenWonder!
 4.1.8) monitorcap:
 -------------------
 
-Syntax: monitorcap:<vmin>;<vmax>;<hmin>;<hmax>
+:Syntax: monitorcap:<vmin>;<vmax>;<hmin>;<hmax>
 
 This describes the capabilities of a multisync monitor. Don't use it
 with a fixed-frequency monitor! For now, only the Falcon frame buffer
 uses the settings of "monitorcap:".
 
-  <vmin> and <vmax> are the minimum and maximum, resp., vertical frequencies
+<vmin> and <vmax> are the minimum and maximum, resp., vertical frequencies
 your monitor can work with, in Hz. <hmin> and <hmax> are the same for
 the horizontal frequency, in kHz.
 
@@ -520,28 +542,28 @@ If this option is given, the framebuffer device doesn't do any video
 mode calculations and settings on its own. The only Atari fb device
 that does this currently is the Falcon.
 
-  What you reach with this: Settings for unknown video extensions
+What you reach with this: Settings for unknown video extensions
 aren't overridden by the driver, so you can still use the mode found
 when booting, when the driver doesn't know to set this mode itself.
 But this also means, that you can't switch video modes anymore...
 
-  An example where you may want to use "keep" is the ScreenBlaster for
+An example where you may want to use "keep" is the ScreenBlaster for
 the Falcon.
 
 
 4.2) atamouse=
 --------------
 
-Syntax: atamouse=<x-threshold>,[<y-threshold>]
+:Syntax: atamouse=<x-threshold>,[<y-threshold>]
 
-  With this option, you can set the mouse movement reporting threshold.
+With this option, you can set the mouse movement reporting threshold.
 This is the number of pixels of mouse movement that have to accumulate
 before the IKBD sends a new mouse packet to the kernel. Higher values
 reduce the mouse interrupt load and thus reduce the chance of keyboard
 overruns. Lower values give a slightly faster mouse responses and
 slightly better mouse tracking.
 
-  You can set the threshold in x and y separately, but usually this is
+You can set the threshold in x and y separately, but usually this is
 of little practical use. If there's just one number in the option, it
 is used for both dimensions. The default value is 2 for both
 thresholds.
@@ -550,7 +572,7 @@ thresholds.
 4.3) ataflop=
 -------------
 
-Syntax: ataflop=<drive type>[,<trackbuffering>[,<steprateA>[,<steprateB>]]]
+:Syntax: ataflop=<drive type>[,<trackbuffering>[,<steprateA>[,<steprateB>]]]
 
    The drive type may be 0, 1, or 2, for DD, HD, and ED, resp. This
    setting affects how many buffers are reserved and which formats are
@@ -563,15 +585,15 @@ Syntax: ataflop=<drive type>[,<trackbuffering>[,<steprateA>[,<steprateB>]]]
    no for the Medusa and yes for all others.
 
    With the two following parameters, you can change the default
-   steprate used for drive A and B, resp. 
+   steprate used for drive A and B, resp.
 
 
 4.4) atascsi=
 -------------
 
-Syntax: atascsi=<can_queue>[,<cmd_per_lun>[,<scat-gat>[,<host-id>[,<tagged>]]]]
+:Syntax: atascsi=<can_queue>[,<cmd_per_lun>[,<scat-gat>[,<host-id>[,<tagged>]]]]
 
-  This option sets some parameters for the Atari native SCSI driver.
+This option sets some parameters for the Atari native SCSI driver.
 Generally, any number of arguments can be omitted from the end. And
 for each of the numbers, a negative value means "use default". The
 defaults depend on whether TT-style or Falcon-style SCSI is used.
@@ -597,11 +619,14 @@ ignored (others aren't affected).
     32). Default: 8/1. (Note: Values > 1 seem to cause problems on a
     Falcon, cause not yet known.)
 
-      The <cmd_per_lun> value at a great part determines the amount of
+    The <cmd_per_lun> value at a great part determines the amount of
     memory SCSI reserves for itself. The formula is rather
     complicated, but I can give you some hints:
-      no scatter-gather  : cmd_per_lun * 232 bytes
-      full scatter-gather: cmd_per_lun * approx. 17 Kbytes
+
+      no scatter-gather:
+	cmd_per_lun * 232 bytes
+      full scatter-gather:
+	cmd_per_lun * approx. 17 Kbytes
 
   <scat-gat>:
     Size of the scatter-gather table, i.e. the number of requests
@@ -634,19 +659,23 @@ ignored (others aren't affected).
 4.5 switches=
 -------------
 
-Syntax: switches=<list of switches>
+:Syntax: switches=<list of switches>
 
-  With this option you can switch some hardware lines that are often
+With this option you can switch some hardware lines that are often
 used to enable/disable certain hardware extensions. Examples are
 OverScan, overclocking, ...
 
-  The <list of switches> is a comma-separated list of the following
+The <list of switches> is a comma-separated list of the following
 items:
 
-  ikbd: set RTS of the keyboard ACIA high
-  midi: set RTS of the MIDI ACIA high
-  snd6: set bit 6 of the PSG port A
-  snd7: set bit 6 of the PSG port A
+  ikbd:
+	set RTS of the keyboard ACIA high
+  midi:
+	set RTS of the MIDI ACIA high
+  snd6:
+	set bit 6 of the PSG port A
+  snd7:
+	set bit 6 of the PSG port A
 
 It doesn't make sense to mention a switch more than once (no
 difference to only once), but you can give as many switches as you
@@ -654,16 +683,16 @@ want to enable different features. The switch lines are set as early
 as possible during kernel initialization (even before determining the
 present hardware.)
 
-  All of the items can also be prefixed with "ov_", i.e. "ov_ikbd",
-"ov_midi", ... These options are meant for switching on an OverScan
+All of the items can also be prefixed with `ov_`, i.e. `ov_ikbd`,
+`ov_midi`, ... These options are meant for switching on an OverScan
 video extension. The difference to the bare option is that the
 switch-on is done after video initialization, and somehow synchronized
 to the HBLANK. A speciality is that ov_ikbd and ov_midi are switched
 off before rebooting, so that OverScan is disabled and TOS boots
 correctly.
 
-  If you give an option both, with and without the "ov_" prefix, the
-earlier initialization ("ov_"-less) takes precedence. But the
+If you give an option both, with and without the `ov_` prefix, the
+earlier initialization (`ov_`-less) takes precedence. But the
 switching-off on reset still happens in this case.
 
 5) Options for Amiga Only:
@@ -672,10 +701,10 @@ switching-off on reset still happens in this case.
 5.1) video=
 -----------
 
-Syntax: video=<fbname>:<sub-options...>
+:Syntax: video=<fbname>:<sub-options...>
 
 The <fbname> parameter specifies the name of the frame buffer, valid
-options are `amifb', `cyber', 'virge', `retz3' and `clgen', provided
+options are `amifb`, `cyber`, 'virge', `retz3` and `clgen`, provided
 that the respective frame buffer devices have been compiled into the
 kernel (or compiled as loadable modules). The behavior of the <fbname>
 option was changed in 2.1.57 so it is now recommended to specify this
@@ -697,9 +726,11 @@ predefined video modes are available:
 NTSC modes:
  - ntsc            : 640x200, 15 kHz, 60 Hz
  - ntsc-lace       : 640x400, 15 kHz, 60 Hz interlaced
+
 PAL modes:
  - pal             : 640x256, 15 kHz, 50 Hz
  - pal-lace        : 640x512, 15 kHz, 50 Hz interlaced
+
 ECS modes:
  - multiscan       : 640x480, 29 kHz, 57 Hz
  - multiscan-lace  : 640x960, 29 kHz, 57 Hz interlaced
@@ -715,6 +746,7 @@ ECS modes:
  - dblpal-lace     : 640x1024, 27 kHz, 47 Hz interlaced
  - dblntsc         : 640x200, 27 kHz, 57 Hz doublescan
  - dblpal          : 640x256, 27 kHz, 47 Hz doublescan
+
 VGA modes:
  - vga             : 640x480, 31 kHz, 60 Hz
  - vga70           : 640x400, 31 kHz, 70 Hz
@@ -726,7 +758,7 @@ chipset and 8-bit color for the AGA chipset.
 5.1.2) depth
 ------------
 
-Syntax: depth:<nr. of bit-planes>
+:Syntax: depth:<nr. of bit-planes>
 
 Specify the number of bit-planes for the selected video-mode.
 
@@ -739,32 +771,32 @@ Use inverted display (black on white). Functionally the same as the
 5.1.4) font
 -----------
 
-Syntax: font:<fontname>
+:Syntax: font:<fontname>
 
 Specify the font to use in text modes. Functionally the same as the
-"font" sub-option for the Atari, except that `PEARL8x8' is used instead
-of `VGA8x8' if the vertical size of the display is less than 400 pixel
+"font" sub-option for the Atari, except that `PEARL8x8` is used instead
+of `VGA8x8` if the vertical size of the display is less than 400 pixel
 rows.
 
 5.1.5) monitorcap:
 -------------------
 
-Syntax: monitorcap:<vmin>;<vmax>;<hmin>;<hmax>
+:Syntax: monitorcap:<vmin>;<vmax>;<hmin>;<hmax>
 
 This describes the capabilities of a multisync monitor. For now, only
 the color frame buffer uses the settings of "monitorcap:".
 
-  <vmin> and <vmax> are the minimum and maximum, resp., vertical frequencies
+<vmin> and <vmax> are the minimum and maximum, resp., vertical frequencies
 your monitor can work with, in Hz. <hmin> and <hmax> are the same for
 the horizontal frequency, in kHz.
 
-  The defaults are 50;90;15;38 (Generic Amiga multisync monitor).
+The defaults are 50;90;15;38 (Generic Amiga multisync monitor).
 
 
 5.2) fd_def_df0=
 ----------------
 
-Syntax: fd_def_df0=<value>
+:Syntax: fd_def_df0=<value>
 
 Sets the df0 value for "silent" floppy drives. The value should be in
 hexadecimal with "0x" prefix.
@@ -773,7 +805,7 @@ hexadecimal with "0x" prefix.
 5.3) wd33c93=
 -------------
 
-Syntax: wd33c93=<sub-options...>
+:Syntax: wd33c93=<sub-options...>
 
 These options affect the A590/A2091, A3000 and GVP Series II SCSI
 controllers.
@@ -784,9 +816,9 @@ below.
 5.3.1) nosync
 -------------
 
-Syntax: nosync:bitmask
+:Syntax: nosync:bitmask
 
-  bitmask is a byte where the 1st 7 bits correspond with the 7
+bitmask is a byte where the 1st 7 bits correspond with the 7
 possible SCSI devices. Set a bit to prevent sync negotiation on that
 device. To maintain backwards compatibility, a command-line such as
 "wd33c93=255" will be automatically translated to
@@ -796,35 +828,35 @@ all devices, eg. nosync:0xff.
 5.3.2) period
 -------------
 
-Syntax: period:ns
+:Syntax: period:ns
 
-  `ns' is the minimum # of nanoseconds in a SCSI data transfer
+`ns` is the minimum # of nanoseconds in a SCSI data transfer
 period. Default is 500; acceptable values are 250 - 1000.
 
 5.3.3) disconnect
 -----------------
 
-Syntax: disconnect:x
+:Syntax: disconnect:x
 
-  Specify x = 0 to never allow disconnects, 2 to always allow them.
+Specify x = 0 to never allow disconnects, 2 to always allow them.
 x = 1 does 'adaptive' disconnects, which is the default and generally
 the best choice.
 
 5.3.4) debug
 ------------
 
-Syntax: debug:x
+:Syntax: debug:x
 
-  If `DEBUGGING_ON' is defined, x is a bit mask that causes various
+If `DEBUGGING_ON` is defined, x is a bit mask that causes various
 types of debug output to printed - see the DB_xxx defines in
 wd33c93.h.
 
 5.3.5) clock
 ------------
 
-Syntax: clock:x
+:Syntax: clock:x
 
-  x = clock input in MHz for WD33c93 chip. Normal values would be from
+x = clock input in MHz for WD33c93 chip. Normal values would be from
 8 through 20. The default value depends on your hostadapter(s),
 default for the A3000 internal controller is 14, for the A2091 it's 8
 and for the GVP hostadapters it's either 8 or 14, depending on the
@@ -834,15 +866,15 @@ hostadapters.
 5.3.6) next
 -----------
 
-  No argument. Used to separate blocks of keywords when there's more
+No argument. Used to separate blocks of keywords when there's more
 than one wd33c93-based host adapter in the system.
 
 5.3.7) nodma
 ------------
 
-Syntax: nodma:x
+:Syntax: nodma:x
 
-  If x is 1 (or if the option is just written as "nodma"), the WD33c93
+If x is 1 (or if the option is just written as "nodma"), the WD33c93
 controller will not use DMA (= direct memory access) to access the
 Amiga's memory.  This is useful for some systems (like A3000's and
 A4000's with the A3640 accelerator, revision 3.0) that have problems
@@ -853,32 +885,27 @@ possible.
 5.4) gvp11=
 -----------
 
-Syntax: gvp11=<addr-mask>
+:Syntax: gvp11=<addr-mask>
 
-  The earlier versions of the GVP driver did not handle DMA
+The earlier versions of the GVP driver did not handle DMA
 address-mask settings correctly which made it necessary for some
 people to use this option, in order to get their GVP controller
 running under Linux. These problems have hopefully been solved and the
 use of this option is now highly unrecommended!
 
-  Incorrect use can lead to unpredictable behavior, so please only use
+Incorrect use can lead to unpredictable behavior, so please only use
 this option if you *know* what you are doing and have a reason to do
 so. In any case if you experience problems and need to use this
 option, please inform us about it by mailing to the Linux/68k kernel
 mailing list.
 
-  The address mask set by this option specifies which addresses are
+The address mask set by this option specifies which addresses are
 valid for DMA with the GVP Series II SCSI controller. An address is
 valid, if no bits are set except the bits that are set in the mask,
 too.
 
-  Some versions of the GVP can only DMA into a 24 bit address range,
+Some versions of the GVP can only DMA into a 24 bit address range,
 some can address a 25 bit address range while others can use the whole
 32 bit address range for DMA. The correct setting depends on your
 controller and should be autodetected by the driver. An example is the
 24 bit region which is specified by a mask of 0x00fffffe.
-
-
-/* Local Variables: */
-/* mode: text       */
-/* End:             */
-- 
2.21.0

