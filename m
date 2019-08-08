Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00116C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9122184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YQryhn1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbfHHRAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:00:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:41187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfHHRAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565283589;
        bh=5ZWBx0UX3/ng437SRV+3mNmqF8CMD79gPpuEkR2AKbM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YQryhn1rG/9+XBSxrotpKRjZbmXGxaRp4TLF/p8C8cSX4QZQgfGvAdrqTRjCZ/ryl
         mYYSAEIY6404chQLg2HUs1Sx3EQGHbAl5CjGu5Iv1JrE8O83MNRlhicF2hdRLnJYH5
         IDS+XoWsSJ5XGRtOqgI4OAEZYpPgoJ+NIEUXPsc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSuMn-1hm6c41Hbp-00Rmeb; Thu, 08
 Aug 2019 18:59:49 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation/arm/sa1100: Remove some obsolete documentation
Date:   Thu,  8 Aug 2019 18:58:55 +0200
Message-Id: <20190808165929.16946-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YsvMSYO6/qXktRlP9DkXrpJX0pfkQbk2oEw7BE1e4pc9QCCUx/c
 nmMcYWdfredKjRRQhlfvj1UMPfJcAzXVu0HztDnXtGBIwoVTqyBmQ+4A5L6sLk2Rydqdx7z
 g6WKk0pisksCZtA+AfjuLf7eirU1mFgNt+VuXqitqHhX6pXoxvsg93sI8ykynUJfoRnCWYq
 1LaHgYMce1mnrxyypxSDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nTIuwVpECOU=:ixZtgS9B6mW7eEeSqo/XrF
 yucycVxNAKQW1ED/k6QLCGQG78Iit+AT0jf+8Ziwg9Vt6pA51lmu6fxHYzviK0/Z7sZzaaBaA
 s3teP3u7Le96b6PPDtA3k1edYOgJorAPRGKz+Iu4YC/XMVnmB8dZsY98FRnJVK6n0PyLa40H0
 NnTsd8bDucELULVkCxq3PSIt1Xtz3Ggu/zW+1YXP8PlXVtzSlT1GCiLIYVzQx6RHN8yonHsF3
 5Z0pfmDW+d7r/FJ+LgSHw5cg2bWRUNJqVLaOLBzmV0gIxcJ9M8PHngrjEhdzlXqvSbSG4LHpR
 B/dPtMdHbmht5palWHT+Z2jnltpEeJkmW0f19PRdLh91F032yvzbbGA3uVFjpw9Evr2/51H2J
 P0g7LsVTjiyKqmM3dJ9DAs04VtPfdkpcQYPV+XlNT9rg1tABDUx/CtL/NXNBESCyDAPFh1kiJ
 AgyRo1fVgYKeJ2SQmH6RW0ZLVAZqAmkJEXQV9kus15fLVNM8E3iDC5Qjp4wH34l4xj8SpWoNx
 fMFjmuFRGkL4UPnd9WPkcqsmauFw9cRPiZs76g+LD76Hog23GUVbUQnArqqysRl07O7LiAnPM
 h4wEFH9jTEoKTN83YEOL8kXfxtKccgN8WjM4OiL4xhmuH6nxJUPGDZFyQjTGVX+Sy7SEYaoxH
 brmeDgO757E1/aK8dMw3Be9GYA8ggsg3tUd++pyfBtz/eUvVHr0F+2ThAY9IUTRQ8BZNAvyH/
 00IKibb5nw4gcIo1Zwoyfg4K6g6xrteQKEnDe+n++SiQW7VHEqOPapplP3wDRSHiYRVkNJLMa
 fseEnmPI/Quo0j5xQGaUkAXrtHrNjme9nImQUQV1gvxcjTdaZBVBlvA4M2HS4rjfRbJFwVQfq
 VnYXuDXvVlhXvzTAuRg1sjxLfrIp98VslyYVe/w89T9knGY83SQWeG+Rt31a8luopNFLcw7Li
 OKmE77f07a5+XlS0HiiWvGXQSRcUqS6vnUNg324Br4SsFFSxSdgM5ioBC1OHd1q6SC+GuaWF9
 STYZv80gCo6UAklY8cm9hTQmyP5esnPnbxssM4hJe336JUfWhGydJ4c/v4Xx0BrZTuWt1PwTN
 L5PrDgt+f4bElf4L/qLIrHuYJSsSaCh2TTla7QZrLVVxnF8DeG2RdyRb2TOaJPa9Ro31IUOR6
 FHTBo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for the following boards, among others, was removed in 2004
with commit "[ARM] Remove broken SA1100 machine support.":

- ADS Bitsy
- Brutus
- Freebird
- ADS GraphicsClient Plus
- ADS GraphicsMaster
- H=C3=B6ft & Wessel Webpanel
- Compaq Itsy
- nanoEngine
- Pangolin
- PLEB
- Yopy

Tifon support has been removed in 2.4.3.3.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/arm/sa1100/adsbitsy.rst       |  51 ----------
 Documentation/arm/sa1100/brutus.rst         |  69 -------------
 Documentation/arm/sa1100/freebird.rst       |  25 -----
 Documentation/arm/sa1100/graphicsclient.rst | 102 --------------------
 Documentation/arm/sa1100/graphicsmaster.rst |  60 ------------
 Documentation/arm/sa1100/huw_webpanel.rst   |  21 ----
 Documentation/arm/sa1100/index.rst          |  12 ---
 Documentation/arm/sa1100/itsy.rst           |  47 ---------
 Documentation/arm/sa1100/nanoengine.rst     |  11 ---
 Documentation/arm/sa1100/pangolin.rst       |  29 ------
 Documentation/arm/sa1100/pleb.rst           |  13 ---
 Documentation/arm/sa1100/tifon.rst          |   7 --
 Documentation/arm/sa1100/yopy.rst           |   5 -
 13 files changed, 452 deletions(-)
 delete mode 100644 Documentation/arm/sa1100/adsbitsy.rst
 delete mode 100644 Documentation/arm/sa1100/brutus.rst
 delete mode 100644 Documentation/arm/sa1100/freebird.rst
 delete mode 100644 Documentation/arm/sa1100/graphicsclient.rst
 delete mode 100644 Documentation/arm/sa1100/graphicsmaster.rst
 delete mode 100644 Documentation/arm/sa1100/huw_webpanel.rst
 delete mode 100644 Documentation/arm/sa1100/itsy.rst
 delete mode 100644 Documentation/arm/sa1100/nanoengine.rst
 delete mode 100644 Documentation/arm/sa1100/pangolin.rst
 delete mode 100644 Documentation/arm/sa1100/pleb.rst
 delete mode 100644 Documentation/arm/sa1100/tifon.rst
 delete mode 100644 Documentation/arm/sa1100/yopy.rst

diff --git a/Documentation/arm/sa1100/adsbitsy.rst b/Documentation/arm/sa1=
100/adsbitsy.rst
deleted file mode 100644
index c179cb26b682..000000000000
=2D-- a/Documentation/arm/sa1100/adsbitsy.rst
+++ /dev/null
@@ -1,51 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-ADS Bitsy Single Board Computer
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-
-(It is different from Bitsy(iPAQ) of Compaq)
-
-For more details, contact Applied Data Systems or see
-http://www.applieddata.net/products.html
-
-The Linux support for this product has been provided by
-Woojung Huh <whuh@applieddata.net>
-
-Use 'make adsbitsy_config' before any 'make config'.
-This will set up defaults for ADS Bitsy support.
-
-The kernel zImage is linked to be loaded and executed at 0xc0400000.
-
-Linux can  be used with the ADS BootLoader that ships with the
-newer rev boards. See their documentation on how to load Linux.
-
-Supported peripherals
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
=2D- SA1100 LCD frame buffer (8/16bpp...sort of)
=2D- SA1111 USB Master
=2D- SA1100 serial port
=2D- pcmcia, compact flash
=2D- touchscreen(ucb1200)
=2D- console on LCD screen
=2D- serial ports (ttyS[0-2])
-  - ttyS0 is default for serial console
-
-To do
-=3D=3D=3D=3D=3D
-
=2D- everything else!  :-)
-
-Notes
-=3D=3D=3D=3D=3D
-
=2D- The flash on board is divided into 3 partitions.
-  You should be careful to use flash on board.
-  Its partition is different from GraphicsClient Plus and GraphicsMaster
-
=2D- 16bpp mode requires a different cable than what ships with the board.
-  Contact ADS or look through the manual to wire your own. Currently,
-  if you compile with 16bit mode support and switch into a lower bpp
-  mode, the timing is off so the image is corrupted.  This will be
-  fixed soon.
-
-Any contribution can be sent to nico@fluxnic.net and will be greatly welc=
ome!
diff --git a/Documentation/arm/sa1100/brutus.rst b/Documentation/arm/sa110=
0/brutus.rst
deleted file mode 100644
index e1a23bee6d44..000000000000
=2D-- a/Documentation/arm/sa1100/brutus.rst
+++ /dev/null
@@ -1,69 +0,0 @@
-=3D=3D=3D=3D=3D=3D
-Brutus
-=3D=3D=3D=3D=3D=3D
-
-Brutus is an evaluation platform for the SA1100 manufactured by Intel.
-For more details, see:
-
-http://developer.intel.com
-
-To compile for Brutus, you must issue the following commands::
-
-	make brutus_config
-	make config
-	[accept all the defaults]
-	make zImage
-
-The resulting kernel will end up in linux/arch/arm/boot/zImage.  This fil=
e
-must be loaded at 0xc0008000 in Brutus's memory and execution started at
-0xc0008000 as well with the value of registers r0 =3D 0 and r1 =3D 16 upo=
n
-entry.
-
-But prior to execute the kernel, a ramdisk image must also be loaded in
-memory.  Use memory address 0xd8000000 for this.  Note that the file
-containing the (compressed) ramdisk image must not exceed 4 MB.
-
-Typically, you'll need angelboot to load the kernel.
-The following angelboot.opt file should be used::
-
-	base 0xc0008000
-	entry 0xc0008000
-	r0 0x00000000
-	r1 0x00000010
-	device /dev/ttyS0
-	options "9600 8N1"
-	baud 115200
-	otherfile ramdisk_img.gz
-	otherbase 0xd8000000
-
-Then load the kernel and ramdisk with::
-
-	angelboot -f angelboot.opt zImage
-
-The first Brutus serial port (assumed to be linked to /dev/ttyS0 on your
-host PC) is used by angel to load the kernel and ramdisk image. The seria=
l
-console is provided through the second Brutus serial port. To access it,
-you may use minicom configured with /dev/ttyS1, 9600 baud, 8N1, no flow
-control.
-
-Currently supported
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-	- RS232 serial ports
-	- audio output
-	- LCD screen
-	- keyboard
-
-The actual Brutus support may not be complete without extra patches.
-If such patches exist, they should be found from
-ftp.netwinder.org/users/n/nico.
-
-A full PCMCIA support is still missing, although it's possible to hack
-some drivers in order to drive already inserted cards at boot time with
-little modifications.
-
-Any contribution is welcome.
-
-Please send patches to nico@fluxnic.net
-
-Have Fun !
diff --git a/Documentation/arm/sa1100/freebird.rst b/Documentation/arm/sa1=
100/freebird.rst
deleted file mode 100644
index 81043d0c6d64..000000000000
=2D-- a/Documentation/arm/sa1100/freebird.rst
+++ /dev/null
@@ -1,25 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D
-Freebird
-=3D=3D=3D=3D=3D=3D=3D=3D
-
-Freebird-1.1 is produced by Legend(C), Inc.
-`http://web.archive.org/web/*/http://www.legend.com.cn`
-and software/linux maintained by Coventive(C), Inc.
-(http://www.coventive.com)
-
-Based on the Nicolas's strongarm kernel tree.
-
-Maintainer:
-
-Chester Kuo
-	- <chester@coventive.com>
-	- <chester@linux.org.tw>
-
-Author:
-
=2D- Tim wu <timwu@coventive.com>
=2D- CIH <cih@coventive.com>
=2D- Eric Peng <ericpeng@coventive.com>
=2D- Jeff Lee <jeff_lee@coventive.com>
=2D- Allen Cheng
=2D- Tony Liu <tonyliu@coventive.com>
diff --git a/Documentation/arm/sa1100/graphicsclient.rst b/Documentation/a=
rm/sa1100/graphicsclient.rst
deleted file mode 100644
index a73d61c3ce91..000000000000
=2D-- a/Documentation/arm/sa1100/graphicsclient.rst
+++ /dev/null
@@ -1,102 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-ADS GraphicsClient Plus Single Board Computer
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-For more details, contact Applied Data Systems or see
-http://www.applieddata.net/products.html
-
-The original Linux support for this product has been provided by
-Nicolas Pitre <nico@fluxnic.net>. Continued development work by
-Woojung Huh <whuh@applieddata.net>
-
-It's currently possible to mount a root filesystem via NFS providing a
-complete Linux environment.  Otherwise a ramdisk image may be used.  The
-board supports MTD/JFFS, so you could also mount something on there.
-
-Use 'make graphicsclient_config' before any 'make config'.  This will set=
 up
-defaults for GraphicsClient Plus support.
-
-The kernel zImage is linked to be loaded and executed at 0xc0200000.
-Also the following registers should have the specified values upon entry:=
:
-
-	r0 =3D 0
-	r1 =3D 29	(this is the GraphicsClient architecture number)
-
-Linux can  be used with the ADS BootLoader that ships with the
-newer rev boards. See their documentation on how to load Linux.
-Angel is not available for the GraphicsClient Plus AFAIK.
-
-There is a  board known as just the GraphicsClient that ADS used to
-produce but has end of lifed. This code will not work on the older
-board with the ADS bootloader, but should still work with Angel,
-as outlined below.  In any case, if you're planning on deploying
-something en masse, you should probably get the newer board.
-
-If using Angel on the older boards, here is a typical angel.opt option fi=
le
-if the kernel is loaded through the Angel Debug Monitor::
-
-	base 0xc0200000
-	entry 0xc0200000
-	r0 0x00000000
-	r1 0x0000001d
-	device /dev/ttyS1
-	options "38400 8N1"
-	baud 115200
-	#otherfile ramdisk.gz
-	#otherbase 0xc0800000
-	exec minicom
-
-Then the kernel (and ramdisk if otherfile/otherbase lines above are
-uncommented) would be loaded with::
-
-	angelboot -f angelboot.opt zImage
-
-Here it is assumed that the board is connected to ttyS1 on your PC
-and that minicom is preconfigured with /dev/ttyS1, 38400 baud, 8N1, no fl=
ow
-control by default.
-
-If any other bootloader is used, ensure it accomplish the same, especiall=
y
-for r0/r1 register values before jumping into the kernel.
-
-
-Supported peripherals
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
=2D- SA1100 LCD frame buffer (8/16bpp...sort of)
=2D- on-board SMC 92C96 ethernet NIC
=2D- SA1100 serial port
=2D- flash memory access (MTD/JFFS)
=2D- pcmcia
=2D- touchscreen(ucb1200)
=2D- ps/2 keyboard
=2D- console on LCD screen
=2D- serial ports (ttyS[0-2])
-  - ttyS0 is default for serial console
=2D- Smart I/O (ADC, keypad, digital inputs, etc)
-  See http://www.eurotech-inc.com/linux-sbc.asp for IOCTL documentation
-  and example user space code. ps/2 keybd is multiplexed through this dri=
ver
-
-To do
-=3D=3D=3D=3D=3D
-
=2D- UCB1200 audio with new ucb_generic layer
=2D- everything else!  :-)
-
-Notes
-=3D=3D=3D=3D=3D
-
=2D- The flash on board is divided into 3 partitions.  mtd0 is where
-  the ADS boot ROM and zImage is stored.  It's been marked as
-  read-only to keep you from blasting over the bootloader. :)  mtd1 is
-  for the ramdisk.gz image.  mtd2 is user flash space and can be
-  utilized for either JFFS or if you're feeling crazy, running ext2
-  on top of it. If you're not using the ADS bootloader, you're
-  welcome to blast over the mtd1 partition also.
-
=2D- 16bpp mode requires a different cable than what ships with the board.
-  Contact ADS or look through the manual to wire your own. Currently,
-  if you compile with 16bit mode support and switch into a lower bpp
-  mode, the timing is off so the image is corrupted.  This will be
-  fixed soon.
-
-Any contribution can be sent to nico@fluxnic.net and will be greatly welc=
ome!
diff --git a/Documentation/arm/sa1100/graphicsmaster.rst b/Documentation/a=
rm/sa1100/graphicsmaster.rst
deleted file mode 100644
index e39892514f0c..000000000000
=2D-- a/Documentation/arm/sa1100/graphicsmaster.rst
+++ /dev/null
@@ -1,60 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-ADS GraphicsMaster Single Board Computer
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-For more details, contact Applied Data Systems or see
-http://www.applieddata.net/products.html
-
-The original Linux support for this product has been provided by
-Nicolas Pitre <nico@fluxnic.net>. Continued development work by
-Woojung Huh <whuh@applieddata.net>
-
-Use 'make graphicsmaster_config' before any 'make config'.
-This will set up defaults for GraphicsMaster support.
-
-The kernel zImage is linked to be loaded and executed at 0xc0400000.
-
-Linux can  be used with the ADS BootLoader that ships with the
-newer rev boards. See their documentation on how to load Linux.
-
-Supported peripherals
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
=2D- SA1100 LCD frame buffer (8/16bpp...sort of)
=2D- SA1111 USB Master
=2D- on-board SMC 92C96 ethernet NIC
=2D- SA1100 serial port
=2D- flash memory access (MTD/JFFS)
=2D- pcmcia, compact flash
=2D- touchscreen(ucb1200)
=2D- ps/2 keyboard
=2D- console on LCD screen
=2D- serial ports (ttyS[0-2])
-  - ttyS0 is default for serial console
=2D- Smart I/O (ADC, keypad, digital inputs, etc)
-  See http://www.eurotech-inc.com/linux-sbc.asp for IOCTL documentation
-  and example user space code. ps/2 keybd is multiplexed through this dri=
ver
-
-To do
-=3D=3D=3D=3D=3D
-
=2D- everything else!  :-)
-
-Notes
-=3D=3D=3D=3D=3D
-
=2D- The flash on board is divided into 3 partitions.  mtd0 is where
-  the zImage is stored.  It's been marked as read-only to keep you
-  from blasting over the bootloader. :)  mtd1 is
-  for the ramdisk.gz image.  mtd2 is user flash space and can be
-  utilized for either JFFS or if you're feeling crazy, running ext2
-  on top of it. If you're not using the ADS bootloader, you're
-  welcome to blast over the mtd1 partition also.
-
=2D- 16bpp mode requires a different cable than what ships with the board.
-  Contact ADS or look through the manual to wire your own. Currently,
-  if you compile with 16bit mode support and switch into a lower bpp
-  mode, the timing is off so the image is corrupted.  This will be
-  fixed soon.
-
-Any contribution can be sent to nico@fluxnic.net and will be greatly welc=
ome!
diff --git a/Documentation/arm/sa1100/huw_webpanel.rst b/Documentation/arm=
/sa1100/huw_webpanel.rst
deleted file mode 100644
index 1dc7ccb165f0..000000000000
=2D-- a/Documentation/arm/sa1100/huw_webpanel.rst
+++ /dev/null
@@ -1,21 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-Hoeft & Wessel Webpanel
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-The HUW_WEBPANEL is a product of the german company Hoeft & Wessel AG
-
-If you want more information, please visit
-http://www.hoeft-wessel.de
-
-To build the kernel::
-
-	make huw_webpanel_config
-	make oldconfig
-	[accept all defaults]
-	make zImage
-
-Mostly of the work is done by:
-Roman Jordan         jor@hoeft-wessel.de
-Christoph Schulz    schu@hoeft-wessel.de
-
-2000/12/18/
diff --git a/Documentation/arm/sa1100/index.rst b/Documentation/arm/sa1100=
/index.rst
index 68c2a280a745..c9aed43280ff 100644
=2D-- a/Documentation/arm/sa1100/index.rst
+++ b/Documentation/arm/sa1100/index.rst
@@ -7,19 +7,7 @@ Intel StrongARM 1100
 .. toctree::
     :maxdepth: 1

-    adsbitsy
     assabet
-    brutus
     cerf
-    freebird
-    graphicsclient
-    graphicsmaster
-    huw_webpanel
-    itsy
     lart
-    nanoengine
-    pangolin
-    pleb
     serial_uart
-    tifon
-    yopy
diff --git a/Documentation/arm/sa1100/itsy.rst b/Documentation/arm/sa1100/=
itsy.rst
deleted file mode 100644
index f49896ba3ef1..000000000000
=2D-- a/Documentation/arm/sa1100/itsy.rst
+++ /dev/null
@@ -1,47 +0,0 @@
-=3D=3D=3D=3D
-Itsy
-=3D=3D=3D=3D
-
-Itsy is a research project done by the Western Research Lab, and Systems
-Research Center in Palo Alto, CA. The Itsy project is one of several
-research projects at Compaq that are related to pocket computing.
-
-For more information, see:
-
-	http://www.hpl.hp.com/downloads/crl/itsy/
-
-Notes on initial 2.4 Itsy support (8/27/2000) :
-
-The port was done on an Itsy version 1.5 machine with a daughtercard with
-64 Meg of DRAM and 32 Meg of Flash. The initial work includes support for
-serial console (to see what you're doing).  No other devices have been
-enabled.
-
-To build, do a "make menuconfig" (or xmenuconfig) and select Itsy support=
.
-Disable Flash and LCD support. and then do a make zImage.
-Finally, you will need to cd to arch/arm/boot/tools and execute a make th=
ere
-to build the params-itsy program used to boot the kernel.
-
-In order to install the port of 2.4 to the itsy, You will need to set the
-configuration parameters in the monitor as follows::
-
-	Arg 1:0x08340000, Arg2: 0xC0000000, Arg3:18 (0x12), Arg4:0
-
-Make sure the start-routine address is set to 0x00060000.
-
-Next, flash the params-itsy program to 0x00060000 ("p 1 0x00060000" in th=
e
-flash menu)  Flash the kernel in arch/arm/boot/zImage into 0x08340000
-("p 1 0x00340000").  Finally flash an initial ramdisk into 0xC8000000
-("p 2 0x0")  We used ramdisk-2-30.gz from the 0.11 version directory on
-handhelds.org.
-
-The serial connection we established was at:
-
-8-bit data, no parity, 1 stop bit(s), 115200.00 b/s. in the monitor, in t=
he
-params-itsy program, and in the kernel itself.  This can be changed, but
-not easily. The monitor parameters are easily changed, the params program
-setup is assembly outl's, and the kernel is a configuration item specific=
 to
-the itsy. (i.e. grep for CONFIG_SA1100_ITSY and you'll find where it is.)
-
-
-This should get you a properly booting 2.4 kernel on the itsy.
diff --git a/Documentation/arm/sa1100/nanoengine.rst b/Documentation/arm/s=
a1100/nanoengine.rst
deleted file mode 100644
index 47f1a14cf98a..000000000000
=2D-- a/Documentation/arm/sa1100/nanoengine.rst
+++ /dev/null
@@ -1,11 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-nanoEngine
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-"nanoEngine" is a SA1110 based single board computer from
-Bright Star Engineering Inc.  See www.brightstareng.com/arm
-for more info.
-(Ref: Stuart Adams <sja@brightstareng.com>)
-
-Also visit Larry Doolittle's "Linux for the nanoEngine" site:
-http://www.brightstareng.com/arm/nanoeng.htm
diff --git a/Documentation/arm/sa1100/pangolin.rst b/Documentation/arm/sa1=
100/pangolin.rst
deleted file mode 100644
index f0c5c1618553..000000000000
=2D-- a/Documentation/arm/sa1100/pangolin.rst
+++ /dev/null
@@ -1,29 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D
-Pangolin
-=3D=3D=3D=3D=3D=3D=3D=3D
-
-Pangolin is a StrongARM 1110-based evaluation platform produced
-by Dialogue Technology (http://www.dialogue.com.tw/).
-It has EISA slots for ease of configuration with SDRAM/Flash
-memory card, USB/Serial/Audio card, Compact Flash card,
-PCMCIA/IDE card and TFT-LCD card.
-
-To compile for Pangolin, you must issue the following commands::
-
-	make pangolin_config
-	make oldconfig
-	make zImage
-
-Supported peripherals
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
=2D- SA1110 serial port (UART1/UART2/UART3)
=2D- flash memory access
=2D- compact flash driver
=2D- UDA1341 sound driver
=2D- SA1100 LCD controller for 800x600 16bpp TFT-LCD
=2D- MQ-200 driver for 800x600 16bpp TFT-LCD
=2D- Penmount(touch panel) driver
=2D- PCMCIA driver
=2D- SMC91C94 LAN driver
=2D- IDE driver (experimental)
diff --git a/Documentation/arm/sa1100/pleb.rst b/Documentation/arm/sa1100/=
pleb.rst
deleted file mode 100644
index d5b732967aa3..000000000000
=2D-- a/Documentation/arm/sa1100/pleb.rst
+++ /dev/null
@@ -1,13 +0,0 @@
-=3D=3D=3D=3D
-PLEB
-=3D=3D=3D=3D
-
-The PLEB project was started as a student initiative at the School of
-Computer Science and Engineering, University of New South Wales to make a
-pocket computer capable of running the Linux Kernel.
-
-PLEB support has yet to be fully integrated.
-
-For more information, see:
-
-	http://www.cse.unsw.edu.au
diff --git a/Documentation/arm/sa1100/tifon.rst b/Documentation/arm/sa1100=
/tifon.rst
deleted file mode 100644
index c26e910b9ea7..000000000000
=2D-- a/Documentation/arm/sa1100/tifon.rst
+++ /dev/null
@@ -1,7 +0,0 @@
-=3D=3D=3D=3D=3D
-Tifon
-=3D=3D=3D=3D=3D
-
-More info has to come...
-
-Contact: Peter Danielsson <peter.danielsson@era-t.ericsson.se>
diff --git a/Documentation/arm/sa1100/yopy.rst b/Documentation/arm/sa1100/=
yopy.rst
deleted file mode 100644
index 5b35a5f61a44..000000000000
=2D-- a/Documentation/arm/sa1100/yopy.rst
+++ /dev/null
@@ -1,5 +0,0 @@
-=3D=3D=3D=3D
-Yopy
-=3D=3D=3D=3D
-
-See http://www.yopydeveloper.org for more.
=2D-
2.20.1

