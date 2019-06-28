Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF55C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9FB2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725063;
	bh=372JlMqjLn+99cnMTriMrbzK7vAJXX1ne5MaFK7AkJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eRLcrJNu0a6Ayb3VVvHrSsf9YwUwEOGHkiZ7/bzQuGH0sAVrRiZCNxVv2mN0bAgII
	 e0ekt5R9r3bavvOW/EPXvcdXrdKnpnDPw24uXj4qeZPa9yOR6WnKRx6UJ2C80jrWe0
	 FVW4Q7P87/okQ8EH3MyhWIb3BkwaS1/G/+z1Qt6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfF1Mau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:30:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfF1Mao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TbYIpPdC3Cq9y8ZKdQeKfK7OSnLIO+oPvquwZsSYer4=; b=aWlkQwwuUxqbBv+R/AHv4OZl92
        crBo162yAm1UYRzTXWlClGRcYIuneBPhbrDQB7ETRBbT2iyY0fQClFMVlX/iLHqixRMbdES4hhz5V
        WnsJzjd8v20lURl1zBtdaGLDX+e35EOS4NUQ0cLM46fVnU3v8q9px+00q0H1lOLb/uBH4WkJyK4CI
        dltB0ChMFyhNs/EGDD1GnQClQkCz0RwxO8Vw0pY/CNjV5kmNEkcDpWLE0GzH8U0J5cM9gDJO52w7G
        iVUR1cpEDedyfBx6N7iU2qGLH60UkONZTOrRKCfrXr7MGfOnPNC4/38u6mSbaEpIXkA9iWZwE+8Jc
        CkVQoMRQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055H-BH; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005SH-CW; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Matan Ziv-Av <matan@svgalib.org>,
        Mattia Dongili <malattia@linux.it>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 17/39] docs: admin-guide: add laptops documentation
Date:   Fri, 28 Jun 2019 09:30:10 -0300
Message-Id: <f5c35189e421a5fa02075d611f58506bffe77028.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs under Documentation/laptops contain users specific
information.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-device                  | 2 +-
 Documentation/ABI/testing/sysfs-platform-asus-laptop          | 2 +-
 Documentation/admin-guide/index.rst                           | 1 +
 Documentation/admin-guide/kernel-parameters.txt               | 2 +-
 Documentation/{ => admin-guide}/laptops/asus-laptop.rst       | 0
 .../{ => admin-guide}/laptops/disk-shock-protection.rst       | 0
 Documentation/{ => admin-guide}/laptops/index.rst             | 1 -
 Documentation/{ => admin-guide}/laptops/laptop-mode.rst       | 0
 Documentation/{ => admin-guide}/laptops/lg-laptop.rst         | 1 -
 Documentation/{ => admin-guide}/laptops/sony-laptop.rst       | 0
 Documentation/{ => admin-guide}/laptops/sonypi.rst            | 0
 Documentation/{ => admin-guide}/laptops/thinkpad-acpi.rst     | 0
 Documentation/{ => admin-guide}/laptops/toshiba_haps.rst      | 0
 Documentation/admin-guide/sysctl/vm.rst                       | 4 ++--
 MAINTAINERS                                                   | 4 ++--
 drivers/char/Kconfig                                          | 2 +-
 drivers/platform/x86/Kconfig                                  | 4 ++--
 17 files changed, 11 insertions(+), 12 deletions(-)
 rename Documentation/{ => admin-guide}/laptops/asus-laptop.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/disk-shock-protection.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/index.rst (95%)
 rename Documentation/{ => admin-guide}/laptops/laptop-mode.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/lg-laptop.rst (99%)
 rename Documentation/{ => admin-guide}/laptops/sony-laptop.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/sonypi.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/thinkpad-acpi.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/toshiba_haps.rst (100%)

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
index 0d57bbb4fddc..17f2bc7dd261 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -45,7 +45,7 @@ Description:
 		- Values below -2 are rejected with -EINVAL
 
 		For more information, see
-		Documentation/laptops/disk-shock-protection.rst
+		Documentation/admin-guide/laptops/disk-shock-protection.rst
 
 
 What:		/sys/block/*/device/ncq_prio_enable
diff --git a/Documentation/ABI/testing/sysfs-platform-asus-laptop b/Documentation/ABI/testing/sysfs-platform-asus-laptop
index d67fa4bafa70..8b0e8205a6a2 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-laptop
+++ b/Documentation/ABI/testing/sysfs-platform-asus-laptop
@@ -31,7 +31,7 @@ Description:
 		To control the LED display, use the following :
 		    echo 0x0T000DDD > /sys/devices/platform/asus_laptop/
 		where T control the 3 letters display, and DDD the 3 digits display.
-		The DDD table can be found in Documentation/laptops/asus-laptop.rst
+		The DDD table can be found in Documentation/admin-guide/laptops/asus-laptop.rst
 
 What:		/sys/devices/platform/asus_laptop/bluetooth
 Date:		January 2007
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index acd0efa46e9d..9899b78dbe50 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -81,6 +81,7 @@ configure specific aspects of kernel behavior to your liking.
    perf-security
    acpi/index
    device-mapper/index
+   laptops/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a3d3da5baacb..e38b96d061f4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4373,7 +4373,7 @@
 			Format: <integer>
 
 	sonypi.*=	[HW] Sony Programmable I/O Control Device driver
-			See Documentation/laptops/sonypi.rst
+			See Documentation/admin-guide/laptops/sonypi.rst
 
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
diff --git a/Documentation/laptops/asus-laptop.rst b/Documentation/admin-guide/laptops/asus-laptop.rst
similarity index 100%
rename from Documentation/laptops/asus-laptop.rst
rename to Documentation/admin-guide/laptops/asus-laptop.rst
diff --git a/Documentation/laptops/disk-shock-protection.rst b/Documentation/admin-guide/laptops/disk-shock-protection.rst
similarity index 100%
rename from Documentation/laptops/disk-shock-protection.rst
rename to Documentation/admin-guide/laptops/disk-shock-protection.rst
diff --git a/Documentation/laptops/index.rst b/Documentation/admin-guide/laptops/index.rst
similarity index 95%
rename from Documentation/laptops/index.rst
rename to Documentation/admin-guide/laptops/index.rst
index 001a30910d09..6b554e39863b 100644
--- a/Documentation/laptops/index.rst
+++ b/Documentation/admin-guide/laptops/index.rst
@@ -1,4 +1,3 @@
-:orphan:
 
 ==============
 Laptop Drivers
diff --git a/Documentation/laptops/laptop-mode.rst b/Documentation/admin-guide/laptops/laptop-mode.rst
similarity index 100%
rename from Documentation/laptops/laptop-mode.rst
rename to Documentation/admin-guide/laptops/laptop-mode.rst
diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
similarity index 99%
rename from Documentation/laptops/lg-laptop.rst
rename to Documentation/admin-guide/laptops/lg-laptop.rst
index f2c2ffe31101..ce9b14671cb9 100644
--- a/Documentation/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -1,6 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-:orphan:
 
 LG Gram laptop extra features
 =============================
diff --git a/Documentation/laptops/sony-laptop.rst b/Documentation/admin-guide/laptops/sony-laptop.rst
similarity index 100%
rename from Documentation/laptops/sony-laptop.rst
rename to Documentation/admin-guide/laptops/sony-laptop.rst
diff --git a/Documentation/laptops/sonypi.rst b/Documentation/admin-guide/laptops/sonypi.rst
similarity index 100%
rename from Documentation/laptops/sonypi.rst
rename to Documentation/admin-guide/laptops/sonypi.rst
diff --git a/Documentation/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
similarity index 100%
rename from Documentation/laptops/thinkpad-acpi.rst
rename to Documentation/admin-guide/laptops/thinkpad-acpi.rst
diff --git a/Documentation/laptops/toshiba_haps.rst b/Documentation/admin-guide/laptops/toshiba_haps.rst
similarity index 100%
rename from Documentation/laptops/toshiba_haps.rst
rename to Documentation/admin-guide/laptops/toshiba_haps.rst
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 5aceb5cd5ce7..64aeee1009ca 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -108,7 +108,7 @@ block_dump
 ==========
 
 block_dump enables block I/O debugging when set to a nonzero value. More
-information on block I/O debugging is in Documentation/laptops/laptop-mode.rst.
+information on block I/O debugging is in Documentation/admin-guide/laptops/laptop-mode.rst.
 
 
 compact_memory
@@ -298,7 +298,7 @@ laptop_mode
 ===========
 
 laptop_mode is a knob that controls "laptop mode". All the things that are
-controlled by this knob are discussed in Documentation/laptops/laptop-mode.rst.
+controlled by this knob are discussed in Documentation/admin-guide/laptops/laptop-mode.rst.
 
 
 legacy_va_layout
diff --git a/MAINTAINERS b/MAINTAINERS
index 40d057631004..d35ff73f718a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8978,7 +8978,7 @@ M:	Matan Ziv-Av <matan@svgalib.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-platform-lg-laptop
-F:	Documentation/laptops/lg-laptop.rst
+F:	Documentation/admin-guide/laptops/lg-laptop.rst
 F:	drivers/platform/x86/lg-laptop.c
 
 LG2160 MEDIA DRIVER
@@ -14830,7 +14830,7 @@ M:	Mattia Dongili <malattia@linux.it>
 L:	platform-driver-x86@vger.kernel.org
 W:	http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
 S:	Maintained
-F:	Documentation/laptops/sony-laptop.rst
+F:	Documentation/admin-guide/laptops/sony-laptop.rst
 F:	drivers/char/sonypi.c
 F:	drivers/platform/x86/sony-laptop.c
 F:	include/linux/sony-laptop.h
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index bb734066075f..442403abd73a 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -382,7 +382,7 @@ config SONYPI
 	  Device which can be found in many (all ?) Sony Vaio laptops.
 
 	  If you have one of those laptops, read
-	  <file:Documentation/laptops/sonypi.rst>, and say Y or M here.
+	  <file:Documentation/admin-guide/laptops/sonypi.rst>, and say Y or M here.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonypi.
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1f616844fb87..85101c678693 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -448,7 +448,7 @@ config SONY_LAPTOP
 	  screen brightness control, Fn keys and allows powering on/off some
 	  devices.
 
-	  Read <file:Documentation/laptops/sony-laptop.rst> for more information.
+	  Read <file:Documentation/admin-guide/laptops/sony-laptop.rst> for more information.
 
 config SONYPI_COMPAT
 	bool "Sonypi compatibility"
@@ -500,7 +500,7 @@ config THINKPAD_ACPI
 	  support for Fn-Fx key combinations, Bluetooth control, video
 	  output switching, ThinkLight control, UltraBay eject and more.
 	  For more information about this driver see
-	  <file:Documentation/laptops/thinkpad-acpi.rst> and
+	  <file:Documentation/admin-guide/laptops/thinkpad-acpi.rst> and
 	  <http://ibm-acpi.sf.net/> .
 
 	  This driver was formerly known as ibm-acpi.
-- 
2.21.0

