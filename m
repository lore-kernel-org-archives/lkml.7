Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B0DC10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F5220656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383592;
	bh=pf1PlH8RC91qw5z0d3ZyPIi/zWHX8k2K2GfLSVfPBeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fofluw8FTy/Sw1vGMew02z7pW39jnjOcC/IRHBlDxB/aMhj7zaRhGqFfTnafqJua8
	 SXDHxzZ1JE63SGh5BDJDH7qb+JSbejhVOHhyCd1ptcha+9jjDfgYJMTDFMtb5M/Nyb
	 EIYYsFZChh3iQt1LPDdNWfeGrfcaoXReEGUy0kAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfDPC7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfDPC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xZqxQ+7QUlcEhhqbzQgATnTFcBpGRooNzVNL0OU2e+g=; b=f2sjWLf0VAYWkp3+8NeGioI6+/
        wde/CJYiSnDDdqvSoUAcsVXfdMEiwDGEKt8xkIOMKIVsw+wv0tzy7Lk6Y77i1M9m7KYh4GU++hNAS
        UHzAkdZ8c2wU6rQV5/fXqMyQl/+ulgyZUe64JcwSqdMJtM84LqKer+5irct+CbUBZou1hHzXOfQCJ
        F+5OdyzAJXMiRgDK2GSBNzHJYC22t3+X7gDJEp+HCAQ18O6HIP8fzVczq00W9r5QyzLYeQin8ML1p
        fT8laj7tbsASM91BFmNsCHF4j2Wf9yngT9HaylBrJiSEUteZWpt+ZBSPh9/Ll1xUuJbiM0AP/wHcN
        OaE4OxwQ==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGq-0007ar-0s; Tue, 16 Apr 2019 02:56:30 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001oi-Sz; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 36/57] docs: usb: convert documents to ReST
Date:   Mon, 15 Apr 2019 23:56:01 -0300
Message-Id: <eaafc5741ccfe3b96ab2a9ef799c537c49ab20e5.1555382110.git.mchehab+samsung@kernel.org>
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

Convert USB documents to ReST, in order to prepare for adding it
to the kernel API book, as most of the stuff there are driver or
subsystem-related.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/usb/WUSB-Design-overview.txt |  56 +-
 Documentation/usb/acm.txt                  | 156 +++---
 Documentation/usb/authorization.txt        |  75 +--
 Documentation/usb/chipidea.txt             | 101 ++--
 Documentation/usb/dwc3.txt                 |  12 +-
 Documentation/usb/ehci.txt                 |  42 +-
 Documentation/usb/functionfs.txt           |  17 +-
 Documentation/usb/gadget-testing.txt       | 609 ++++++++++++---------
 Documentation/usb/gadget_configfs.txt      | 302 +++++-----
 Documentation/usb/gadget_hid.txt           | 175 +++---
 Documentation/usb/gadget_multi.txt         |  43 +-
 Documentation/usb/gadget_printer.txt       | 155 +++---
 Documentation/usb/gadget_serial.txt        |  73 +--
 Documentation/usb/iuu_phoenix.txt          |  34 +-
 Documentation/usb/mass-storage.txt         |  19 +-
 Documentation/usb/misc_usbsevseg.txt       |   9 +-
 Documentation/usb/mtouchusb.txt            |  42 +-
 Documentation/usb/ohci.txt                 |   5 +-
 Documentation/usb/rio.txt                  |  83 +--
 Documentation/usb/usb-help.txt             |  21 +-
 Documentation/usb/usb-serial.txt           | 203 ++++---
 Documentation/usb/usbip_protocol.txt       | 552 ++++++++++---------
 Documentation/usb/usbmon.txt               | 100 ++--
 23 files changed, 1654 insertions(+), 1230 deletions(-)

diff --git a/Documentation/usb/WUSB-Design-overview.txt b/Documentation/usb/WUSB-Design-overview.txt
index fdb47637720e..dc5e21609bb5 100644
--- a/Documentation/usb/WUSB-Design-overview.txt
+++ b/Documentation/usb/WUSB-Design-overview.txt
@@ -1,7 +1,9 @@
-
+================================
 Linux UWB + Wireless USB + WiNET
+================================
+
+   Copyright (C) 2005-2006 Intel Corporation
 
-   (C) 2005-2006 Intel Corporation
    Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
 
    This program is free software; you can redistribute it and/or
@@ -29,6 +31,7 @@ drivers for the USB based UWB radio controllers defined in the
 Wireless USB 1.0 specification (including Wireless USB host controller
 and an Intel WiNET controller).
 
+.. Contents
    1. Introduction
          1. HWA: Host Wire adapters, your Wireless USB dongle
 
@@ -51,7 +54,8 @@ and an Intel WiNET controller).
    4. Glossary
 
 
-    Introduction
+Introduction
+============
 
 UWB is a wide-band communication protocol that is to serve also as the
 low-level protocol for others (much like TCP sits on IP). Currently
@@ -93,7 +97,8 @@ The different logical parts of this driver are:
       do the actual WUSB.
 
 
-      HWA: Host Wire adapters, your Wireless USB dongle
+HWA: Host Wire adapters, your Wireless USB dongle
+-------------------------------------------------
 
 WUSB also defines a device called a Host Wire Adaptor (HWA), which in
 mere terms is a USB dongle that enables your PC to have UWB and Wireless
@@ -125,7 +130,8 @@ The HWA itself is broken in two or three main interfaces:
       their type and kick into gear.
 
 
-      DWA: Device Wired Adaptor, a Wireless USB hub for wired devices
+DWA: Device Wired Adaptor, a Wireless USB hub for wired devices
+---------------------------------------------------------------
 
 These are the complement to HWAs. They are a USB host for connecting
 wired devices, but it is connected to your PC connected via Wireless
@@ -137,7 +143,8 @@ code with the HWA-RC driver; there is a bunch of factorization work that
 has been done to support that in upcoming releases.
 
 
-      WHCI: Wireless Host Controller Interface, the PCI WUSB host adapter
+WHCI: Wireless Host Controller Interface, the PCI WUSB host adapter
+-------------------------------------------------------------------
 
 This is your usual PCI device that implements WHCI. Similar in concept
 to EHCI, it allows your wireless USB devices (including DWAs) to connect
@@ -148,7 +155,8 @@ There is still no driver support for this, but will be in upcoming
 releases.
 
 
-    The UWB stack
+The UWB stack
+=============
 
 The main mission of the UWB stack is to keep a tally of which devices
 are in radio proximity to allow drivers to connect to them. As well, it
@@ -156,7 +164,8 @@ provides an API for controlling the local radio controllers (RCs from
 now on), such as to start/stop beaconing, scan, allocate bandwidth, etc.
 
 
-      Devices and hosts: the basic structure
+Devices and hosts: the basic structure
+--------------------------------------
 
 The main building block here is the UWB device (struct uwb_dev). For
 each device that pops up in radio presence (ie: the UWB host receives a
@@ -187,7 +196,8 @@ the USB connected HWA. Eventually, drivers/whci-rc.c will do the same
 for the PCI connected WHCI controller.
 
 
-      Host Controller life cycle
+Host Controller life cycle
+--------------------------
 
 So let's say we connect a dongle to the system: it is detected and
 firmware uploaded if needed [for Intel's i1480
@@ -209,7 +219,8 @@ When a dongle is disconnected, /drivers/uwb/hwa-rc.c:hwarc_disconnect()/
 takes time of tearing everything down safely (or not...).
 
 
-      On the air: beacons and enumerating the radio neighborhood
+On the air: beacons and enumerating the radio neighborhood
+----------------------------------------------------------
 
 So assuming we have devices and we have agreed for a channel to connect
 on (let's say 9), we put the new RC to beacon:
@@ -235,12 +246,14 @@ are received in some time, the device is considered gone and wiped out
 the beacon cache of dead devices].
 
 
-      Device lists
+Device lists
+------------
 
 All UWB devices are kept in the list of the struct bus_type uwb_bus_type.
 
 
-      Bandwidth allocation
+Bandwidth allocation
+--------------------
 
 The UWB stack maintains a local copy of DRP availability through
 processing of incoming *DRP Availability Change* notifications. This
@@ -260,7 +273,8 @@ completion. [Note: The bandwidth reservation work is in progress and
 subject to change.]
 
 
-    Wireless USB Host Controller drivers
+Wireless USB Host Controller drivers
+====================================
 
 *WARNING* This section needs a lot of work!
 
@@ -296,7 +310,8 @@ starts sending MMCs.
 
 Now it all depends on external stimuli.
 
-*New device connection*
+New device connection
+---------------------
 
 A new device pops up, it scans the radio looking for MMCs that give out
 the existence of Wireless USB channels. Once one (or more) are found,
@@ -322,7 +337,8 @@ has seen the port status changes, as we have been toggling them. It will
 start enumerating and doing transfers through usb_hcd->urb_enqueue() to
 read descriptors and move our data.
 
-*Device life cycle and keep alives*
+Device life cycle and keep alives
+---------------------------------
 
 Every time there is a successful transfer to/from a device, we update a
 per-device activity timestamp. If not, every now and then we check and
@@ -340,7 +356,8 @@ device list looking for whom needs refreshing.
 If the device wants to disconnect, it will either die (ugly) or send a
 /DN_Disconnect/ that will prompt a disconnection from the system.
 
-*Sending and receiving data*
+Sending and receiving data
+--------------------------
 
 Data is sent and received through /Remote Pipes/ (rpipes). An rpipe is
 /aimed/ at an endpoint in a WUSB device. This is the same for HWAs and
@@ -394,7 +411,8 @@ finalize the transfer.
 For IN xfers, we only issue URBs for the segments we want to read and
 then wait for the xfer result data.
 
-*URB mapping into xfers*
+URB mapping into xfers
+^^^^^^^^^^^^^^^^^^^^^^
 
 This is done by hwahc_op_urb_[en|de]queue(). In enqueue() we aim an
 rpipe to the endpoint where we have to transmit, create a transfer
@@ -407,7 +425,8 @@ and not yet done and when all that is done, the xfer callback will be
 called--this will call the URB callback.
 
 
-    Glossary
+Glossary
+========
 
 *DWA* -- Device Wire Adapter
 
@@ -436,4 +455,3 @@ the host.
 
 Design-overview.txt-1.8 (last edited 2006-11-04 12:22:24 by
 InakyPerezGonzalez)
-
diff --git a/Documentation/usb/acm.txt b/Documentation/usb/acm.txt
index 903abca10517..e8bda98e9b51 100644
--- a/Documentation/usb/acm.txt
+++ b/Documentation/usb/acm.txt
@@ -1,127 +1,131 @@
-			  Linux ACM driver v0.16
-		 (c) 1999 Vojtech Pavlik <vojtech@suse.cz>
-			     Sponsored by SuSE
-----------------------------------------------------------------------------
+======================
+Linux ACM driver v0.16
+======================
+
+Copyright (c) 1999 Vojtech Pavlik <vojtech@suse.cz>
+
+Sponsored by SuSE
 
 0. Disclaimer
 ~~~~~~~~~~~~~
-  This program is free software; you can redistribute it and/or modify it
+This program is free software; you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by the Free
 Software Foundation; either version 2 of the License, or (at your option)
 any later version.
 
-  This program is distributed in the hope that it will be useful, but
+This program is distributed in the hope that it will be useful, but
 WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 more details.
 
-  You should have received a copy of the GNU General Public License along
+You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc., 59
 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
-  Should you need to contact me, the author, you can do so either by e-mail
-- mail your message to <vojtech@suse.cz>, or by paper mail: Vojtech Pavlik,
+Should you need to contact me, the author, you can do so either by e-mail -
+mail your message to <vojtech@suse.cz>, or by paper mail: Vojtech Pavlik,
 Ucitelska 1576, Prague 8, 182 00 Czech Republic
 
-  For your convenience, the GNU General Public License version 2 is included
+For your convenience, the GNU General Public License version 2 is included
 in the package: See the file COPYING.
 
 1. Usage
 ~~~~~~~~
-  The drivers/usb/class/cdc-acm.c drivers works with USB modems and USB ISDN terminal
+The drivers/usb/class/cdc-acm.c drivers works with USB modems and USB ISDN terminal
 adapters that conform to the Universal Serial Bus Communication Device Class
 Abstract Control Model (USB CDC ACM) specification.
 
-  Many modems do, here is a list of those I know of:
+Many modems do, here is a list of those I know of:
 
-	3Com OfficeConnect 56k
-	3Com Voice FaxModem Pro
-	3Com Sportster
-	MultiTech MultiModem 56k
-	Zoom 2986L FaxModem
-	Compaq 56k FaxModem
-	ELSA Microlink 56k
+	- 3Com OfficeConnect 56k
+	- 3Com Voice FaxModem Pro
+	- 3Com Sportster
+	- MultiTech MultiModem 56k
+	- Zoom 2986L FaxModem
+	- Compaq 56k FaxModem
+	- ELSA Microlink 56k
 
-  I know of one ISDN TA that does work with the acm driver:
+I know of one ISDN TA that does work with the acm driver:
 
-	3Com USR ISDN Pro TA
+	- 3Com USR ISDN Pro TA
 
-  Some cell phones also connect via USB. I know the following phones work:
+Some cell phones also connect via USB. I know the following phones work:
 
-	SonyEricsson K800i
+	- SonyEricsson K800i
 
-  Unfortunately many modems and most ISDN TAs use proprietary interfaces and
+Unfortunately many modems and most ISDN TAs use proprietary interfaces and
 thus won't work with this drivers. Check for ACM compliance before buying.
 
-  To use the modems you need these modules loaded:
+To use the modems you need these modules loaded::
 
 	usbcore.ko
 	uhci-hcd.ko ohci-hcd.ko or ehci-hcd.ko
 	cdc-acm.ko
 
-  After that, the modem[s] should be accessible. You should be able to use
+After that, the modem[s] should be accessible. You should be able to use
 minicom, ppp and mgetty with them.
 
 2. Verifying that it works
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-  The first step would be to check /sys/kernel/debug/usb/devices, it should look
-like this:
 
-T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
-B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
-D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
-P:  Vendor=0000 ProdID=0000 Rev= 0.00
-S:  Product=USB UHCI Root Hub
-S:  SerialNumber=6800
-C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
-I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
-E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
-T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
-D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
-P:  Vendor=04c1 ProdID=008f Rev= 2.07
-S:  Manufacturer=3Com Inc.
-S:  Product=3Com U.S. Robotics Pro ISDN TA
-S:  SerialNumber=UFT53A49BVT7
-C:  #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
-I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=acm
-E:  Ad=85(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
-E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
-E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
-C:* #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
-I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
-E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
-I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
-E:  Ad=85(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
-E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
+The first step would be to check /sys/kernel/debug/usb/devices, it should look
+like this::
+
+  T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
+  B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
+  D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
+  P:  Vendor=0000 ProdID=0000 Rev= 0.00
+  S:  Product=USB UHCI Root Hub
+  S:  SerialNumber=6800
+  C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
+  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
+  E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
+  T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
+  D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
+  P:  Vendor=04c1 ProdID=008f Rev= 2.07
+  S:  Manufacturer=3Com Inc.
+  S:  Product=3Com U.S. Robotics Pro ISDN TA
+  S:  SerialNumber=UFT53A49BVT7
+  C:  #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
+  I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=acm
+  E:  Ad=85(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
+  E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
+  E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
+  C:* #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
+  I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
+  E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
+  I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
+  E:  Ad=85(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
+  E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
 
 The presence of these three lines (and the Cls= 'comm' and 'data' classes)
 is important, it means it's an ACM device. The Driver=acm means the acm
 driver is used for the device. If you see only Cls=ff(vend.) then you're out
-of luck, you have a device with vendor specific-interface.
+of luck, you have a device with vendor specific-interface::
 
-D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
-I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
-I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
+  D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
+  I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
+  I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
 
-In the system log you should see:
+In the system log you should see::
 
-usb.c: USB new device connect, assigned device number 2
-usb.c: kmalloc IF c7691fa0, numif 1
-usb.c: kmalloc IF c7b5f3e0, numif 2
-usb.c: skipped 4 class/vendor specific interface descriptors
-usb.c: new device strings: Mfr=1, Product=2, SerialNumber=3
-usb.c: USB device number 2 default language ID 0x409
-Manufacturer: 3Com Inc.
-Product: 3Com U.S. Robotics Pro ISDN TA
-SerialNumber: UFT53A49BVT7
-acm.c: probing config 1
-acm.c: probing config 2
-ttyACM0: USB ACM device
-acm.c: acm_control_msg: rq: 0x22 val: 0x0 len: 0x0 result: 0
-acm.c: acm_control_msg: rq: 0x20 val: 0x0 len: 0x7 result: 7
-usb.c: acm driver claimed interface c7b5f3e0
-usb.c: acm driver claimed interface c7b5f3f8
-usb.c: acm driver claimed interface c7691fa0
+  usb.c: USB new device connect, assigned device number 2
+  usb.c: kmalloc IF c7691fa0, numif 1
+  usb.c: kmalloc IF c7b5f3e0, numif 2
+  usb.c: skipped 4 class/vendor specific interface descriptors
+  usb.c: new device strings: Mfr=1, Product=2, SerialNumber=3
+  usb.c: USB device number 2 default language ID 0x409
+  Manufacturer: 3Com Inc.
+  Product: 3Com U.S. Robotics Pro ISDN TA
+  SerialNumber: UFT53A49BVT7
+  acm.c: probing config 1
+  acm.c: probing config 2
+  ttyACM0: USB ACM device
+  acm.c: acm_control_msg: rq: 0x22 val: 0x0 len: 0x0 result: 0
+  acm.c: acm_control_msg: rq: 0x20 val: 0x0 len: 0x7 result: 7
+  usb.c: acm driver claimed interface c7b5f3e0
+  usb.c: acm driver claimed interface c7b5f3f8
+  usb.c: acm driver claimed interface c7691fa0
 
 If all this seems to be OK, fire up minicom and set it to talk to the ttyACM
 device and try typing 'at'. If it responds with 'OK', then everything is
diff --git a/Documentation/usb/authorization.txt b/Documentation/usb/authorization.txt
index 9dd1dc7b1009..9e53909d04c2 100644
--- a/Documentation/usb/authorization.txt
+++ b/Documentation/usb/authorization.txt
@@ -1,7 +1,8 @@
-
+==============================================================
 Authorizing (or not) your USB devices to connect to the system
+==============================================================
 
-(C) 2007 Inaky Perez-Gonzalez <inaky@linux.intel.com> Intel Corporation
+Copyright (C) 2007 Inaky Perez-Gonzalez <inaky@linux.intel.com> Intel Corporation
 
 This feature allows you to control if a USB device can be used (or
 not) in a system. This feature will allow you to implement a lock-down
@@ -12,24 +13,25 @@ its interfaces are immediately made available to the users.  With this
 modification, only if root authorizes the device to be configured will
 then it be possible to use it.
 
-Usage:
+Usage
+=====
 
-Authorize a device to connect:
+Authorize a device to connect::
 
-$ echo 1 > /sys/bus/usb/devices/DEVICE/authorized
+	$ echo 1 > /sys/bus/usb/devices/DEVICE/authorized
 
-Deauthorize a device:
+De-authorize a device::
 
-$ echo 0 > /sys/bus/usb/devices/DEVICE/authorized
+	$ echo 0 > /sys/bus/usb/devices/DEVICE/authorized
 
 Set new devices connected to hostX to be deauthorized by default (ie:
-lock down):
+lock down)::
 
-$ echo 0 > /sys/bus/usb/devices/usbX/authorized_default
+	$ echo 0 > /sys/bus/usb/devices/usbX/authorized_default
 
-Remove the lock down:
+Remove the lock down::
 
-$ echo 1 > /sys/bus/usb/devices/usbX/authorized_default
+	$ echo 1 > /sys/bus/usb/devices/usbX/authorized_default
 
 By default, Wired USB devices are authorized by default to
 connect. Wireless USB hosts deauthorize by default all new connected
@@ -40,21 +42,21 @@ USB ports.
 
 
 Example system lockdown (lame)
------------------------
+------------------------------
 
 Imagine you want to implement a lockdown so only devices of type XYZ
 can be connected (for example, it is a kiosk machine with a visible
-USB port):
+USB port)::
 
-boot up
-rc.local ->
+  boot up
+  rc.local ->
 
- for host in /sys/bus/usb/devices/usb*
- do
-    echo 0 > $host/authorized_default
- done
+   for host in /sys/bus/usb/devices/usb*
+   do
+      echo 0 > $host/authorized_default
+   done
 
-Hookup an script to udev, for new USB devices
+Hookup an script to udev, for new USB devices::
 
  if device_is_my_type $DEV
  then
@@ -67,10 +69,10 @@ checking if the class, type and protocol match something is the worse
 security verification you can make (or the best, for someone willing
 to break it). If you need something secure, use crypto and Certificate
 Authentication or stuff like that. Something simple for an storage key
-could be:
+could be::
 
-function device_is_my_type()
-{
+ function device_is_my_type()
+ {
    echo 1 > authorized		# temporarily authorize it
                                 # FIXME: make sure none can mount it
    mount DEVICENODE /mntpoint
@@ -83,7 +85,7 @@ function device_is_my_type()
    else
         echo 0 > authorized
    fi
-}
+ }
 
 
 Of course, this is lame, you'd want to do a real certificate
@@ -95,30 +97,35 @@ welcome.
 
 Interface authorization
 -----------------------
+
 There is a similar approach to allow or deny specific USB interfaces.
 That allows to block only a subset of an USB device.
 
-Authorize an interface:
-$ echo 1 > /sys/bus/usb/devices/INTERFACE/authorized
+Authorize an interface::
 
-Deauthorize an interface:
-$ echo 0 > /sys/bus/usb/devices/INTERFACE/authorized
+	$ echo 1 > /sys/bus/usb/devices/INTERFACE/authorized
+
+Deauthorize an interface::
+
+	$ echo 0 > /sys/bus/usb/devices/INTERFACE/authorized
 
 The default value for new interfaces
 on a particular USB bus can be changed, too.
 
-Allow interfaces per default:
-$ echo 1 > /sys/bus/usb/devices/usbX/interface_authorized_default
+Allow interfaces per default::
 
-Deny interfaces per default:
-$ echo 0 > /sys/bus/usb/devices/usbX/interface_authorized_default
+	$ echo 1 > /sys/bus/usb/devices/usbX/interface_authorized_default
+
+Deny interfaces per default::
+
+	$ echo 0 > /sys/bus/usb/devices/usbX/interface_authorized_default
 
 Per default the interface_authorized_default bit is 1.
 So all interfaces would authorized per default.
 
 Note:
-If a deauthorized interface will be authorized so the driver probing must
-be triggered manually by writing INTERFACE to /sys/bus/usb/drivers_probe
+  If a deauthorized interface will be authorized so the driver probing must
+  be triggered manually by writing INTERFACE to /sys/bus/usb/drivers_probe
 
 For drivers that need multiple interfaces all needed interfaces should be
 authorized first. After that the drivers should be probed.
diff --git a/Documentation/usb/chipidea.txt b/Documentation/usb/chipidea.txt
index d1eedc01b00a..68473abe2823 100644
--- a/Documentation/usb/chipidea.txt
+++ b/Documentation/usb/chipidea.txt
@@ -1,22 +1,37 @@
+==============================================
+ChipIdea Highspeed Dual Role Controller Driver
+==============================================
+
 1. How to test OTG FSM(HNP and SRP)
 -----------------------------------
+
 To show how to demo OTG HNP and SRP functions via sys input files
 with 2 Freescale i.MX6Q sabre SD boards.
 
 1.1 How to enable OTG FSM
----------------------------------------
+-------------------------
+
 1.1.1 Select CONFIG_USB_OTG_FSM in menuconfig, rebuild kernel
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
 Image and modules. If you want to check some internal
 variables for otg fsm, mount debugfs, there are 2 files
-which can show otg fsm variables and some controller registers value:
-cat /sys/kernel/debug/ci_hdrc.0/otg
-cat /sys/kernel/debug/ci_hdrc.0/registers
+which can show otg fsm variables and some controller registers value::
+
+	cat /sys/kernel/debug/ci_hdrc.0/otg
+	cat /sys/kernel/debug/ci_hdrc.0/registers
+
 1.1.2 Add below entries in your dts file for your controller node
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
 	otg-rev = <0x0200>;
 	adp-disable;
 
 1.2 Test operations
 -------------------
+
 1) Power up 2 Freescale i.MX6Q sabre SD boards with gadget class driver loaded
    (e.g. g_mass_storage).
 
@@ -26,19 +41,24 @@ cat /sys/kernel/debug/ci_hdrc.0/registers
    The A-device(with micro A plug inserted) should enumerate B-device.
 
 3) Role switch
-   On B-device:
-   echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
+
+   On B-device::
+
+	echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
 
    B-device should take host role and enumerate A-device.
 
 4) A-device switch back to host.
-   On B-device:
-   echo 0 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
+
+   On B-device::
+
+	echo 0 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
 
    or, by introducing HNP polling, B-Host can know when A-peripheral wish
    to be host role, so this role switch also can be trigged in A-peripheral
-   side by answering the polling from B-Host, this can be done on A-device:
-   echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_req
+   side by answering the polling from B-Host, this can be done on A-device::
+
+	echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_req
 
    A-device should switch back to host and enumerate B-device.
 
@@ -49,23 +69,31 @@ cat /sys/kernel/debug/ci_hdrc.0/registers
    A-device should NOT enumerate B-device.
 
    if A-device wants to use bus:
-   On A-device:
-   echo 0 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_drop
-   echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_req
+
+   On A-device::
+
+	echo 0 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_drop
+	echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_req
 
    if B-device wants to use bus:
-   On B-device:
-   echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
+
+   On B-device::
+
+	echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
 
 7) A-device power down the bus.
-   On A-device:
-   echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_drop
+
+   On A-device::
+
+	echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/a_bus_drop
 
    A-device should disconnect with B-device and power down the bus.
 
 8) B-device does data pulse for SRP.
-   On B-device:
-   echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
+
+   On B-device::
+
+	echo 1 > /sys/bus/platform/devices/ci_hdrc.0/inputs/b_bus_req
 
    A-device should resume usb bus and enumerate B-device.
 
@@ -75,22 +103,31 @@ cat /sys/kernel/debug/ci_hdrc.0/registers
 July 27, 2012 Revision 2.0 version 1.1a"
 
 2. How to enable USB as system wakeup source
------------------------------------
+--------------------------------------------
 Below is the example for how to enable USB as system wakeup source
 at imx6 platform.
 
-2.1 Enable core's wakeup
-echo enabled > /sys/bus/platform/devices/ci_hdrc.0/power/wakeup
-2.2 Enable glue layer's wakeup
-echo enabled > /sys/bus/platform/devices/2184000.usb/power/wakeup
-2.3 Enable PHY's wakeup (optional)
-echo enabled > /sys/bus/platform/devices/20c9000.usbphy/power/wakeup
-2.4 Enable roothub's wakeup
-echo enabled > /sys/bus/usb/devices/usb1/power/wakeup
-2.5 Enable related device's wakeup
-echo enabled > /sys/bus/usb/devices/1-1/power/wakeup
+2.1 Enable core's wakeup::
+
+	echo enabled > /sys/bus/platform/devices/ci_hdrc.0/power/wakeup
+
+2.2 Enable glue layer's wakeup::
+
+	echo enabled > /sys/bus/platform/devices/2184000.usb/power/wakeup
+
+2.3 Enable PHY's wakeup (optional)::
+
+	echo enabled > /sys/bus/platform/devices/20c9000.usbphy/power/wakeup
+
+2.4 Enable roothub's wakeup::
+
+	echo enabled > /sys/bus/usb/devices/usb1/power/wakeup
+
+2.5 Enable related device's wakeup::
+
+	echo enabled > /sys/bus/usb/devices/1-1/power/wakeup
 
 If the system has only one usb port, and you want usb wakeup at this port, you
-can use below script to enable usb wakeup.
-for i in $(find /sys -name wakeup | grep usb);do echo enabled > $i;done;
+can use below script to enable usb wakeup::
 
+	for i in $(find /sys -name wakeup | grep usb);do echo enabled > $i;done;
diff --git a/Documentation/usb/dwc3.txt b/Documentation/usb/dwc3.txt
index 1d02c01d1c7c..f94a7ba16573 100644
--- a/Documentation/usb/dwc3.txt
+++ b/Documentation/usb/dwc3.txt
@@ -1,6 +1,11 @@
+===========
+DWC3 driver
+===========
+
+
+TODO
+~~~~
 
- TODO
-~~~~~~
 Please pick something while reading :)
 
 - Convert interrupt handler to per-ep-thread-irq
@@ -9,6 +14,7 @@ Please pick something while reading :)
   until the command completes which is bad.
 
   Implementation idea:
+
   - dwc core implements a demultiplexing irq chip for interrupts per
     endpoint. The interrupt numbers are allocated during probe and belong
     to the device. If MSI provides per-endpoint interrupt this dummy
@@ -19,6 +25,7 @@ Please pick something while reading :)
   - dwc3_send_gadget_ep_cmd() will sleep in wait_for_completion_timeout()
     until the command completes.
   - the interrupt handler is split into the following pieces:
+
     - primary handler of the device
       goes through every event and calls generic_handle_irq() for event
       it. On return from generic_handle_irq() in acknowledges the event
@@ -40,6 +47,7 @@ Please pick something while reading :)
       for command completion.
 
   Latency:
+
    There should be no increase in latency since the interrupt-thread has a
    high priority and will be run before an average task in user land
    (except the user changed priorities).
diff --git a/Documentation/usb/ehci.txt b/Documentation/usb/ehci.txt
index 160bd6c3ab7b..31f650e7c1b4 100644
--- a/Documentation/usb/ehci.txt
+++ b/Documentation/usb/ehci.txt
@@ -1,3 +1,7 @@
+﻿===========
+EHCI driver
+===========
+
 27-Dec-2002
 
 The EHCI driver is used to talk to high speed USB 2.0 devices using
@@ -40,7 +44,8 @@ APIs exposed to USB device drivers.
   <dbrownell@users.sourceforge.net>
 
 
-FUNCTIONALITY
+Functionality
+=============
 
 This driver is regularly tested on x86 hardware, and has also been
 used on PPC hardware so big/little endianness issues should be gone.
@@ -48,6 +53,7 @@ It's believed to do all the right PCI magic so that I/O works even on
 systems with interesting DMA mapping issues.
 
 Transfer Types
+--------------
 
 At this writing the driver should comfortably handle all control, bulk,
 and interrupt transfers, including requests to USB 1.1 devices through
@@ -63,6 +69,7 @@ since EHCI represents these with a different data structure.  So for now,
 most USB audio and video devices can't be connected to high speed buses.
 
 Driver Behavior
+---------------
 
 Transfers of all types can be queued.  This means that control transfers
 from a driver on one interface (or through usbfs) won't interfere with
@@ -83,14 +90,15 @@ limits on the number of periodic transactions that can be scheduled,
 and prevent use of polling intervals of less than one frame.
 
 
-USE BY
+Use by
+======
 
 Assuming you have an EHCI controller (on a PCI card or motherboard)
-and have compiled this driver as a module, load this like:
+and have compiled this driver as a module, load this like::
 
     # modprobe ehci-hcd
 
-and remove it by:
+and remove it by::
 
     # rmmod ehci-hcd
 
@@ -112,13 +120,16 @@ If you're using this driver on a 2.5 kernel, and you've enabled USB
 debugging support, you'll see three files in the "sysfs" directory for
 any EHCI controller:
 
-	"async" dumps the asynchronous schedule, used for control
+	"async"
+		dumps the asynchronous schedule, used for control
 		and bulk transfers.  Shows each active qh and the qtds
 		pending, usually one qtd per urb.  (Look at it with
 		usb-storage doing disk I/O; watch the request queues!)
-	"periodic" dumps the periodic schedule, used for interrupt
+	"periodic"
+		dumps the periodic schedule, used for interrupt
 		and isochronous transfers.  Doesn't show qtds.
-	"registers" show controller register state, and
+	"registers"
+		show controller register state, and
 
 The contents of those files can help identify driver problems.
 
@@ -136,7 +147,8 @@ transaction translators are in use; some drivers have been seen to behave
 badly when they see different faults than OHCI or UHCI report.
 
 
-PERFORMANCE
+Performance
+===========
 
 USB 2.0 throughput is gated by two main factors:  how fast the host
 controller can process requests, and how fast devices can respond to
@@ -156,6 +168,7 @@ hardware and device driver software allow it.  Periodic transfer modes
 approach the quoted 480 MBit/sec transfer rate.
 
 Hardware Performance
+--------------------
 
 At this writing, individual USB 2.0 devices tend to max out at around
 20 MByte/sec transfer rates.  This is of course subject to change;
@@ -183,6 +196,7 @@ you issue a control or bulk request you can often expect to learn that
 it completed in less than 250 usec (depending on transfer size).
 
 Software Performance
+--------------------
 
 To get even 20 MByte/sec transfer rates, Linux-USB device drivers will
 need to keep the EHCI queue full.  That means issuing large requests,
@@ -206,9 +220,11 @@ mapping (which might apply an IOMMU) and IRQ reduction, all of which will
 help make high speed transfers run as fast as they can.
 
 
-TBD:  Interrupt and ISO transfer performance issues.  Those periodic
-transfers are fully scheduled, so the main issue is likely to be how
-to trigger "high bandwidth" modes.
+TBD:
+   Interrupt and ISO transfer performance issues.  Those periodic
+   transfers are fully scheduled, so the main issue is likely to be how
+   to trigger "high bandwidth" modes.
 
-TBD:  More than standard 80% periodic bandwidth allocation is possible
-through sysfs uframe_periodic_max parameter. Describe that.
+TBD:
+   More than standard 80% periodic bandwidth allocation is possible
+   through sysfs uframe_periodic_max parameter. Describe that.
diff --git a/Documentation/usb/functionfs.txt b/Documentation/usb/functionfs.txt
index eaaaea019fc7..7fdc6d840ac5 100644
--- a/Documentation/usb/functionfs.txt
+++ b/Documentation/usb/functionfs.txt
@@ -1,4 +1,6 @@
-*How FunctionFS works*
+====================
+How FunctionFS works
+====================
 
 From kernel point of view it is just a composite function with some
 unique behaviour.  It may be added to an USB configuration only after
@@ -38,13 +40,13 @@ when mounting.
 
 One can imagine a gadget that has an Ethernet, MTP and HID interfaces
 where the last two are implemented via FunctionFS.  On user space
-level it would look like this:
+level it would look like this::
 
-$ insmod g_ffs.ko idVendor=<ID> iSerialNumber=<string> functions=mtp,hid
-$ mkdir /dev/ffs-mtp && mount -t functionfs mtp /dev/ffs-mtp
-$ ( cd /dev/ffs-mtp && mtp-daemon ) &
-$ mkdir /dev/ffs-hid && mount -t functionfs hid /dev/ffs-hid
-$ ( cd /dev/ffs-hid && hid-daemon ) &
+  $ insmod g_ffs.ko idVendor=<ID> iSerialNumber=<string> functions=mtp,hid
+  $ mkdir /dev/ffs-mtp && mount -t functionfs mtp /dev/ffs-mtp
+  $ ( cd /dev/ffs-mtp && mtp-daemon ) &
+  $ mkdir /dev/ffs-hid && mount -t functionfs hid /dev/ffs-hid
+  $ ( cd /dev/ffs-hid && hid-daemon ) &
 
 On kernel level the gadget checks ffs_data->dev_name to identify
 whether it's FunctionFS designed for MTP ("mtp") or HID ("hid").
@@ -64,4 +66,3 @@ have been written to their ep0's.
 
 Conversely, the gadget is unregistered after the first USB function
 closes its endpoints.
-
diff --git a/Documentation/usb/gadget-testing.txt b/Documentation/usb/gadget-testing.txt
index 5908a21fddb6..7d7f2340af42 100644
--- a/Documentation/usb/gadget-testing.txt
+++ b/Documentation/usb/gadget-testing.txt
@@ -1,26 +1,32 @@
+==============
+Gadget Testing
+==============
+
 This file summarizes information on basic testing of USB functions
 provided by gadgets.
 
-1. ACM function
-2. ECM function
-3. ECM subset function
-4. EEM function
-5. FFS function
-6. HID function
-7. LOOPBACK function
-8. MASS STORAGE function
-9. MIDI function
-10. NCM function
-11. OBEX function
-12. PHONET function
-13. RNDIS function
-14. SERIAL function
-15. SOURCESINK function
-16. UAC1 function (legacy implementation)
-17. UAC2 function
-18. UVC function
-19. PRINTER function
-20. UAC1 function (new API)
+.. contents
+
+   1. ACM function
+   2. ECM function
+   3. ECM subset function
+   4. EEM function
+   5. FFS function
+   6. HID function
+   7. LOOPBACK function
+   8. MASS STORAGE function
+   9. MIDI function
+   10. NCM function
+   11. OBEX function
+   12. PHONET function
+   13. RNDIS function
+   14. SERIAL function
+   15. SOURCESINK function
+   16. UAC1 function (legacy implementation)
+   17. UAC2 function
+   18. UVC function
+   19. PRINTER function
+   20. UAC1 function (new API)
 
 
 1. ACM function
@@ -44,13 +50,23 @@ There can be at most 4 ACM/generic serial/OBEX ports in the system.
 Testing the ACM function
 ------------------------
 
-On the host: cat > /dev/ttyACM<X>
-On the device : cat /dev/ttyGS<Y>
+On the host::
+
+	cat > /dev/ttyACM<X>
+
+On the device::
+
+	cat /dev/ttyGS<Y>
 
 then the other way round
 
-On the device: cat > /dev/ttyGS<Y>
-On the host: cat /dev/ttyACM<X>
+On the device::
+
+	cat > /dev/ttyGS<Y>
+
+On the host::
+
+	cat /dev/ttyACM<X>
 
 2. ECM function
 ===============
@@ -63,13 +79,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ecm".
 The ECM function provides these attributes in its function directory:
 
-	ifname		- network device interface name associated with this
+	=============== ==================================================
+	ifname		network device interface name associated with this
 			function instance
-	qmult		- queue length multiplier for high and super speed
-	host_addr	- MAC address of host's end of this
+	qmult		queue length multiplier for high and super speed
+	host_addr	MAC address of host's end of this
 			Ethernet over USB link
-	dev_addr	- MAC address of device's end of this
+	dev_addr	MAC address of device's end of this
 			Ethernet over USB link
+	=============== ==================================================
 
 and after creating the functions/ecm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -82,8 +100,13 @@ Testing the ECM function
 
 Configure IP addresses of the device and the host. Then:
 
-On the device: ping <host's IP>
-On the host: ping <device's IP>
+On the device::
+
+	ping <host's IP>
+
+On the host::
+
+	ping <device's IP>
 
 3. ECM subset function
 ======================
@@ -96,13 +119,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "geth".
 The ECM subset function provides these attributes in its function directory:
 
-	ifname		- network device interface name associated with this
+	=============== ==================================================
+	ifname		network device interface name associated with this
 			function instance
-	qmult		- queue length multiplier for high and super speed
-	host_addr	- MAC address of host's end of this
+	qmult		queue length multiplier for high and super speed
+	host_addr	MAC address of host's end of this
 			Ethernet over USB link
-	dev_addr	- MAC address of device's end of this
+	dev_addr	MAC address of device's end of this
 			Ethernet over USB link
+	=============== ==================================================
 
 and after creating the functions/ecm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -115,8 +140,13 @@ Testing the ECM subset function
 
 Configure IP addresses of the device and the host. Then:
 
-On the device: ping <host's IP>
-On the host: ping <device's IP>
+On the device::
+
+	ping <host's IP>
+
+On the host::
+
+	ping <device's IP>
 
 4. EEM function
 ===============
@@ -129,13 +159,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "eem".
 The EEM function provides these attributes in its function directory:
 
-	ifname		- network device interface name associated with this
+	=============== ==================================================
+	ifname		network device interface name associated with this
 			function instance
-	qmult		- queue length multiplier for high and super speed
-	host_addr	- MAC address of host's end of this
+	qmult		queue length multiplier for high and super speed
+	host_addr	MAC address of host's end of this
 			Ethernet over USB link
-	dev_addr	- MAC address of device's end of this
+	dev_addr	MAC address of device's end of this
 			Ethernet over USB link
+	=============== ==================================================
 
 and after creating the functions/eem.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -148,8 +180,13 @@ Testing the EEM function
 
 Configure IP addresses of the device and the host. Then:
 
-On the device: ping <host's IP>
-On the host: ping <device's IP>
+On the device::
+
+	ping <host's IP>
+
+On the host::
+
+	ping <device's IP>
 
 5. FFS function
 ===============
@@ -172,6 +209,7 @@ Testing the FFS function
 ------------------------
 
 On the device: start the function's userspace daemon, enable the gadget
+
 On the host: use the USB function provided by the device
 
 6. HID function
@@ -185,39 +223,43 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "hid".
 The HID function provides these attributes in its function directory:
 
-	protocol	- HID protocol to use
-	report_desc	- data to be used in HID reports, except data
+	=============== ===========================================
+	protocol	HID protocol to use
+	report_desc	data to be used in HID reports, except data
 			passed with /dev/hidg<X>
-	report_length	- HID report length
-	subclass	- HID subclass to use
+	report_length	HID report length
+	subclass	HID subclass to use
+	=============== ===========================================
 
 For a keyboard the protocol and the subclass are 1, the report_length is 8,
-while the report_desc is:
+while the report_desc is::
 
-$ hd my_report_desc
-00000000  05 01 09 06 a1 01 05 07  19 e0 29 e7 15 00 25 01  |..........)...%.|
-00000010  75 01 95 08 81 02 95 01  75 08 81 03 95 05 75 01  |u.......u.....u.|
-00000020  05 08 19 01 29 05 91 02  95 01 75 03 91 03 95 06  |....).....u.....|
-00000030  75 08 15 00 25 65 05 07  19 00 29 65 81 00 c0     |u...%e....)e...|
-0000003f
+  $ hd my_report_desc
+  00000000  05 01 09 06 a1 01 05 07  19 e0 29 e7 15 00 25 01  |..........)...%.|
+  00000010  75 01 95 08 81 02 95 01  75 08 81 03 95 05 75 01  |u.......u.....u.|
+  00000020  05 08 19 01 29 05 91 02  95 01 75 03 91 03 95 06  |....).....u.....|
+  00000030  75 08 15 00 25 65 05 07  19 00 29 65 81 00 c0     |u...%e....)e...|
+  0000003f
 
-Such a sequence of bytes can be stored to the attribute with echo:
+Such a sequence of bytes can be stored to the attribute with echo::
 
-$ echo -ne \\x05\\x01\\x09\\x06\\xa1.....
+  $ echo -ne \\x05\\x01\\x09\\x06\\xa1.....
 
 Testing the HID function
 ------------------------
 
 Device:
+
 - create the gadget
 - connect the gadget to a host, preferably not the one used
-to control the gadget
+  to control the gadget
 - run a program which writes to /dev/hidg<N>, e.g.
-a userspace program found in Documentation/usb/gadget_hid.txt:
+  a userspace program found in Documentation/usb/gadget_hid.txt::
 
-$ ./hid_gadget_test /dev/hidg0 keyboard
+	$ ./hid_gadget_test /dev/hidg0 keyboard
 
 Host:
+
 - observe the keystrokes from the gadget
 
 7. LOOPBACK function
@@ -231,13 +273,16 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "Loopback".
 The LOOPBACK function provides these attributes in its function directory:
 
-	qlen		- depth of loopback queue
-	bulk_buflen	- buffer length
+	=============== =======================
+	qlen		depth of loopback queue
+	bulk_buflen	buffer length
+	=============== =======================
 
 Testing the LOOPBACK function
 -----------------------------
 
 device: run the gadget
+
 host: test-usb (tools/usb/testusb.c)
 
 8. MASS STORAGE function
@@ -252,18 +297,20 @@ The function name to use when creating the function directory is "mass_storage".
 The MASS STORAGE function provides these attributes in its directory:
 files:
 
-	stall		- Set to permit function to halt bulk endpoints.
+	=============== ==============================================
+	stall		Set to permit function to halt bulk endpoints.
 			Disabled on some USB devices known not to work
 			correctly. You should set it to true.
-	num_buffers	- Number of pipeline buffers. Valid numbers
+	num_buffers	Number of pipeline buffers. Valid numbers
 			are 2..4. Available only if
 			CONFIG_USB_GADGET_DEBUG_FILES is set.
+	=============== ==============================================
 
 and a default lun.0 directory corresponding to SCSI LUN #0.
 
-A new lun can be added with mkdir:
+A new lun can be added with mkdir::
 
-$ mkdir functions/mass_storage.0/partition.5
+	$ mkdir functions/mass_storage.0/partition.5
 
 Lun numbering does not have to be continuous, except for lun #0 which is
 created by default. A maximum of 8 luns can be specified and they all must be
@@ -273,18 +320,20 @@ although it is not mandatory.
 
 In each lun directory there are the following attribute files:
 
-	file		- The path to the backing file for the LUN.
+	=============== ==============================================
+	file		The path to the backing file for the LUN.
 			Required if LUN is not marked as removable.
-	ro		- Flag specifying access to the LUN shall be
+	ro		Flag specifying access to the LUN shall be
 			read-only. This is implied if CD-ROM emulation
 			is enabled as well as when it was impossible
 			to open "filename" in R/W mode.
-	removable	- Flag specifying that LUN shall be indicated as
+	removable	Flag specifying that LUN shall be indicated as
 			being removable.
-	cdrom		- Flag specifying that LUN shall be reported as
+	cdrom		Flag specifying that LUN shall be reported as
 			being a CD-ROM.
-	nofua		- Flag specifying that FUA flag
+	nofua		Flag specifying that FUA flag
 			in SCSI WRITE(10,12)
+	=============== ==============================================
 
 Testing the MASS STORAGE function
 ---------------------------------
@@ -304,12 +353,14 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "midi".
 The MIDI function provides these attributes in its function directory:
 
-	buflen		- MIDI buffer length
-	id		- ID string for the USB MIDI adapter
-	in_ports	- number of MIDI input ports
-	index		- index value for the USB MIDI adapter
-	out_ports	- number of MIDI output ports
-	qlen		- USB read request queue length
+	=============== ====================================
+	buflen		MIDI buffer length
+	id		ID string for the USB MIDI adapter
+	in_ports	number of MIDI input ports
+	index		index value for the USB MIDI adapter
+	out_ports	number of MIDI output ports
+	qlen		USB read request queue length
+	=============== ====================================
 
 Testing the MIDI function
 -------------------------
@@ -317,60 +368,63 @@ Testing the MIDI function
 There are two cases: playing a mid from the gadget to
 the host and playing a mid from the host to the gadget.
 
-1) Playing a mid from the gadget to the host
-host)
+1) Playing a mid from the gadget to the host:
 
-$ arecordmidi -l
- Port    Client name                      Port name
- 14:0    Midi Through                     Midi Through Port-0
- 24:0    MIDI Gadget                      MIDI Gadget MIDI 1
-$ arecordmidi -p 24:0 from_gadget.mid
+host::
 
-gadget)
+  $ arecordmidi -l
+   Port    Client name                      Port name
+   14:0    Midi Through                     Midi Through Port-0
+   24:0    MIDI Gadget                      MIDI Gadget MIDI 1
+  $ arecordmidi -p 24:0 from_gadget.mid
 
-$ aplaymidi -l
- Port    Client name                      Port name
- 20:0    f_midi                           f_midi
+gadget::
 
-$ aplaymidi -p 20:0 to_host.mid
+  $ aplaymidi -l
+   Port    Client name                      Port name
+   20:0    f_midi                           f_midi
+
+  $ aplaymidi -p 20:0 to_host.mid
 
 2) Playing a mid from the host to the gadget
-gadget)
 
-$ arecordmidi -l
- Port    Client name                      Port name
- 20:0    f_midi                           f_midi
+gadget::
 
-$ arecordmidi -p 20:0 from_host.mid
+  $ arecordmidi -l
+   Port    Client name                      Port name
+   20:0    f_midi                           f_midi
 
-host)
+  $ arecordmidi -p 20:0 from_host.mid
 
-$ aplaymidi -l
- Port    Client name                      Port name
- 14:0    Midi Through                     Midi Through Port-0
- 24:0    MIDI Gadget                      MIDI Gadget MIDI 1
+host::
 
-$ aplaymidi -p24:0 to_gadget.mid
+  $ aplaymidi -l
+   Port    Client name                      Port name
+   14:0    Midi Through                     Midi Through Port-0
+   24:0    MIDI Gadget                      MIDI Gadget MIDI 1
+
+  $ aplaymidi -p24:0 to_gadget.mid
 
 The from_gadget.mid should sound identical to the to_host.mid.
+
 The from_host.id should sound identical to the to_gadget.mid.
 
-MIDI files can be played to speakers/headphones with e.g. timidity installed
+MIDI files can be played to speakers/headphones with e.g. timidity installed::
 
-$ aplaymidi -l
- Port    Client name                      Port name
- 14:0    Midi Through                     Midi Through Port-0
- 24:0    MIDI Gadget                      MIDI Gadget MIDI 1
-128:0    TiMidity                         TiMidity port 0
-128:1    TiMidity                         TiMidity port 1
-128:2    TiMidity                         TiMidity port 2
-128:3    TiMidity                         TiMidity port 3
+  $ aplaymidi -l
+   Port    Client name                      Port name
+   14:0    Midi Through                     Midi Through Port-0
+   24:0    MIDI Gadget                      MIDI Gadget MIDI 1
+  128:0    TiMidity                         TiMidity port 0
+  128:1    TiMidity                         TiMidity port 1
+  128:2    TiMidity                         TiMidity port 2
+  128:3    TiMidity                         TiMidity port 3
 
-$ aplaymidi -p 128:0 file.mid
+  $ aplaymidi -p 128:0 file.mid
 
-MIDI ports can be logically connected using the aconnect utility, e.g.:
+MIDI ports can be logically connected using the aconnect utility, e.g.::
 
-$ aconnect 24:0 128:0 # try it on the host
+  $ aconnect 24:0 128:0 # try it on the host
 
 After the gadget's MIDI port is connected to timidity's MIDI port,
 whatever is played at the gadget side with aplaymidi -l is audible
@@ -387,13 +441,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ncm".
 The NCM function provides these attributes in its function directory:
 
-	ifname		- network device interface name associated with this
+	=============== ==================================================
+	ifname		network device interface name associated with this
 			function instance
-	qmult		- queue length multiplier for high and super speed
-	host_addr	- MAC address of host's end of this
+	qmult		queue length multiplier for high and super speed
+	host_addr	MAC address of host's end of this
 			Ethernet over USB link
-	dev_addr	- MAC address of device's end of this
+	dev_addr	MAC address of device's end of this
 			Ethernet over USB link
+	=============== ==================================================
 
 and after creating the functions/ncm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -406,8 +462,13 @@ Testing the NCM function
 
 Configure IP addresses of the device and the host. Then:
 
-On the device: ping <host's IP>
-On the host: ping <device's IP>
+On the device::
+
+	ping <host's IP>
+
+On the host::
+
+	ping <device's IP>
 
 11. OBEX function
 =================
@@ -429,13 +490,18 @@ There can be at most 4 ACM/generic serial/OBEX ports in the system.
 Testing the OBEX function
 -------------------------
 
-On device: seriald -f /dev/ttyGS<Y> -s 1024
-On host: serialc -v <vendorID> -p <productID> -i<interface#> -a1 -s1024 \
-             -t<out endpoint addr> -r<in endpoint addr>
+On device::
+
+	seriald -f /dev/ttyGS<Y> -s 1024
+
+On host::
+
+	serialc -v <vendorID> -p <productID> -i<interface#> -a1 -s1024 \
+                -t<out endpoint addr> -r<in endpoint addr>
 
 where seriald and serialc are Felipe's utilities found here:
 
-https://github.com/felipebalbi/usb-tools.git master
+	https://github.com/felipebalbi/usb-tools.git master
 
 12. PHONET function
 ===================
@@ -448,8 +514,10 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "phonet".
 The PHONET function provides just one attribute in its function directory:
 
-	ifname		- network device interface name associated with this
+	=============== ==================================================
+	ifname		network device interface name associated with this
 			function instance
+	=============== ==================================================
 
 Testing the PHONET function
 ---------------------------
@@ -464,41 +532,41 @@ These tools are required:
 
 git://git.gitorious.org/meego-cellular/phonet-utils.git
 
-On the host:
+On the host::
 
-$ ./phonet -a 0x10 -i usbpn0
-$ ./pnroute add 0x6c usbpn0
-$./pnroute add 0x10 usbpn0
-$ ifconfig usbpn0 up
+	$ ./phonet -a 0x10 -i usbpn0
+	$ ./pnroute add 0x6c usbpn0
+	$./pnroute add 0x10 usbpn0
+	$ ifconfig usbpn0 up
 
-On the device:
+On the device::
 
-$ ./phonet -a 0x6c -i upnlink0
-$ ./pnroute add 0x10 upnlink0
-$ ifconfig upnlink0 up
+	$ ./phonet -a 0x6c -i upnlink0
+	$ ./pnroute add 0x10 upnlink0
+	$ ifconfig upnlink0 up
 
-Then a test program can be used:
+Then a test program can be used::
 
-http://www.spinics.net/lists/linux-usb/msg85690.html
+	http://www.spinics.net/lists/linux-usb/msg85690.html
 
-On the device:
+On the device::
 
-$ ./pnxmit -a 0x6c -r
+	$ ./pnxmit -a 0x6c -r
 
-On the host:
+On the host::
 
-$ ./pnxmit -a 0x10 -s 0x6c
+	$ ./pnxmit -a 0x10 -s 0x6c
 
 As a result some data should be sent from host to device.
 Then the other way round:
 
-On the host:
+On the host::
 
-$ ./pnxmit -a 0x10 -r
+	$ ./pnxmit -a 0x10 -r
 
-On the device:
+On the device::
 
-$ ./pnxmit -a 0x6c -s 0x10
+	$ ./pnxmit -a 0x6c -s 0x10
 
 13. RNDIS function
 ==================
@@ -511,13 +579,15 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "rndis".
 The RNDIS function provides these attributes in its function directory:
 
-	ifname		- network device interface name associated with this
+	=============== ==================================================
+	ifname		network device interface name associated with this
 			function instance
-	qmult		- queue length multiplier for high and super speed
-	host_addr	- MAC address of host's end of this
+	qmult		queue length multiplier for high and super speed
+	host_addr	MAC address of host's end of this
 			Ethernet over USB link
-	dev_addr	- MAC address of device's end of this
+	dev_addr	MAC address of device's end of this
 			Ethernet over USB link
+	=============== ==================================================
 
 and after creating the functions/rndis.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
@@ -530,8 +600,13 @@ Testing the RNDIS function
 
 Configure IP addresses of the device and the host. Then:
 
-On the device: ping <host's IP>
-On the host: ping <device's IP>
+On the device::
+
+	ping <host's IP>
+
+On the host::
+
+	ping <device's IP>
 
 14. SERIAL function
 ===================
@@ -553,15 +628,28 @@ There can be at most 4 ACM/generic serial/OBEX ports in the system.
 Testing the SERIAL function
 ---------------------------
 
-On host: insmod usbserial
-	 echo VID PID >/sys/bus/usb-serial/drivers/generic/new_id
-On host: cat > /dev/ttyUSB<X>
-On target: cat /dev/ttyGS<Y>
+On host::
+
+	insmod usbserial
+	echo VID PID >/sys/bus/usb-serial/drivers/generic/new_id
+
+On host::
+
+	cat > /dev/ttyUSB<X>
+
+On target::
+
+	cat /dev/ttyGS<Y>
 
 then the other way round
 
-On target: cat > /dev/ttyGS<Y>
-On host: cat /dev/ttyUSB<X>
+On target::
+
+	cat > /dev/ttyGS<Y>
+
+On host::
+
+	cat /dev/ttyUSB<X>
 
 15. SOURCESINK function
 =======================
@@ -574,24 +662,27 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "SourceSink".
 The SOURCESINK function provides these attributes in its function directory:
 
-	pattern		- 0 (all zeros), 1 (mod63), 2 (none)
-	isoc_interval	- 1..16
-	isoc_maxpacket	- 0 - 1023 (fs), 0 - 1024 (hs/ss)
-	isoc_mult	- 0..2 (hs/ss only)
-	isoc_maxburst	- 0..15 (ss only)
-	bulk_buflen	- buffer length
-	bulk_qlen	- depth of queue for bulk
-	iso_qlen	- depth of queue for iso
+	=============== ==================================
+	pattern		0 (all zeros), 1 (mod63), 2 (none)
+	isoc_interval	1..16
+	isoc_maxpacket	0 - 1023 (fs), 0 - 1024 (hs/ss)
+	isoc_mult	0..2 (hs/ss only)
+	isoc_maxburst	0..15 (ss only)
+	bulk_buflen	buffer length
+	bulk_qlen	depth of queue for bulk
+	iso_qlen	depth of queue for iso
+	=============== ==================================
 
 Testing the SOURCESINK function
 -------------------------------
 
 device: run the gadget
+
 host: test-usb (tools/usb/testusb.c)
 
 
 16. UAC1 function (legacy implementation)
-=================
+=========================================
 
 The function is provided by usb_f_uac1_legacy.ko module.
 
@@ -602,12 +693,14 @@ The function name to use when creating the function directory
 is "uac1_legacy".
 The uac1 function provides these attributes in its function directory:
 
-	audio_buf_size - audio buffer size
-	fn_cap - capture pcm device file name
-	fn_cntl - control device file name
-	fn_play - playback pcm device file name
-	req_buf_size - ISO OUT endpoint request buffer size
-	req_count - ISO OUT endpoint request count
+	=============== ====================================
+	audio_buf_size	audio buffer size
+	fn_cap		capture pcm device file name
+	fn_cntl		control device file name
+	fn_play		playback pcm device file name
+	req_buf_size	ISO OUT endpoint request buffer size
+	req_count	ISO OUT endpoint request count
+	=============== ====================================
 
 The attributes have sane default values.
 
@@ -615,7 +708,10 @@ Testing the UAC1 function
 -------------------------
 
 device: run the gadget
-host: aplay -l # should list our USB Audio Gadget
+
+host::
+
+	aplay -l # should list our USB Audio Gadget
 
 17. UAC2 function
 =================
@@ -628,14 +724,16 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uac2".
 The uac2 function provides these attributes in its function directory:
 
-	c_chmask - capture channel mask
-	c_srate - capture sampling rate
-	c_ssize - capture sample size (bytes)
-	p_chmask - playback channel mask
-	p_srate - playback sampling rate
-	p_ssize - playback sample size (bytes)
-	req_number - the number of pre-allocated request for both capture
-		     and playback
+	=============== ====================================================
+	c_chmask	capture channel mask
+	c_srate		capture sampling rate
+	c_ssize		capture sample size (bytes)
+	p_chmask	playback channel mask
+	p_srate		playback sampling rate
+	p_ssize		playback sample size (bytes)
+	req_number	the number of pre-allocated request for both capture
+			and playback
+	=============== ====================================================
 
 The attributes have sane default values.
 
@@ -648,14 +746,14 @@ host: aplay -l # should list our USB Audio Gadget
 This function does not require real hardware support, it just
 sends a stream of audio data to/from the host. In order to
 actually hear something at the device side, a command similar
-to this must be used at the device side:
+to this must be used at the device side::
 
-$ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
+	$ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
 
-e.g.:
+e.g.::
 
-$ arecord -f dat -t wav -D hw:CARD=UAC2Gadget,DEV=0 | \
-aplay -D default:CARD=OdroidU3
+	$ arecord -f dat -t wav -D hw:CARD=UAC2Gadget,DEV=0 | \
+	  aplay -D default:CARD=OdroidU3
 
 18. UVC function
 ================
@@ -668,66 +766,73 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uvc".
 The uvc function provides these attributes in its function directory:
 
-	streaming_interval - interval for polling endpoint for data transfers
-	streaming_maxburst - bMaxBurst for super speed companion descriptor
-	streaming_maxpacket - maximum packet size this endpoint is capable of
-			      sending or receiving when this configuration is
-			      selected
+	=================== ================================================
+	streaming_interval  interval for polling endpoint for data transfers
+	streaming_maxburst  bMaxBurst for super speed companion descriptor
+	streaming_maxpacket maximum packet size this endpoint is capable of
+			    sending or receiving when this configuration is
+			    selected
+	=================== ================================================
 
 There are also "control" and "streaming" subdirectories, each of which contain
 a number of their subdirectories. There are some sane defaults provided, but
 the user must provide the following:
 
-	control header - create in control/header, link from control/class/fs
-			and/or control/class/ss
-	streaming header - create in streaming/header, link from
-			streaming/class/fs and/or streaming/class/hs and/or
-			streaming/class/ss
-	format description - create in streaming/mjpeg and/or
-			streaming/uncompressed
-	frame description - create in streaming/mjpeg/<format> and/or in
-			streaming/uncompressed/<format>
+	================== ====================================================
+	control header     create in control/header, link from control/class/fs
+			   and/or control/class/ss
+	streaming header   create in streaming/header, link from
+			   streaming/class/fs and/or streaming/class/hs and/or
+			   streaming/class/ss
+	format description create in streaming/mjpeg and/or
+			   streaming/uncompressed
+	frame description  create in streaming/mjpeg/<format> and/or in
+			   streaming/uncompressed/<format>
+	================== ====================================================
 
 Each frame description contains frame interval specification, and each
 such specification consists of a number of lines with an inverval value
-in each line. The rules stated above are best illustrated with an example:
+in each line. The rules stated above are best illustrated with an example::
 
-# mkdir functions/uvc.usb0/control/header/h
-# cd functions/uvc.usb0/control/
-# ln -s header/h class/fs
-# ln -s header/h class/ss
-# mkdir -p functions/uvc.usb0/streaming/uncompressed/u/360p
-# cat <<EOF > functions/uvc.usb0/streaming/uncompressed/u/360p/dwFrameInterval
-666666
-1000000
-5000000
-EOF
-# cd $GADGET_CONFIGFS_ROOT
-# mkdir functions/uvc.usb0/streaming/header/h
-# cd functions/uvc.usb0/streaming/header/h
-# ln -s ../../uncompressed/u
-# cd ../../class/fs
-# ln -s ../../header/h
-# cd ../../class/hs
-# ln -s ../../header/h
-# cd ../../class/ss
-# ln -s ../../header/h
+  # mkdir functions/uvc.usb0/control/header/h
+  # cd functions/uvc.usb0/control/
+  # ln -s header/h class/fs
+  # ln -s header/h class/ss
+  # mkdir -p functions/uvc.usb0/streaming/uncompressed/u/360p
+  # cat <<EOF > functions/uvc.usb0/streaming/uncompressed/u/360p/dwFrameInterval
+  666666
+  1000000
+  5000000
+  EOF
+  # cd $GADGET_CONFIGFS_ROOT
+  # mkdir functions/uvc.usb0/streaming/header/h
+  # cd functions/uvc.usb0/streaming/header/h
+  # ln -s ../../uncompressed/u
+  # cd ../../class/fs
+  # ln -s ../../header/h
+  # cd ../../class/hs
+  # ln -s ../../header/h
+  # cd ../../class/ss
+  # ln -s ../../header/h
 
 
 Testing the UVC function
 ------------------------
 
-device: run the gadget, modprobe vivid
+device: run the gadget, modprobe vivid::
 
-# uvc-gadget -u /dev/video<uvc video node #> -v /dev/video<vivid video node #>
+  # uvc-gadget -u /dev/video<uvc video node #> -v /dev/video<vivid video node #>
 
 where uvc-gadget is this program:
-http://git.ideasonboard.org/uvc-gadget.git
+	http://git.ideasonboard.org/uvc-gadget.git
 
 with these patches:
-http://www.spinics.net/lists/linux-usb/msg99220.html
 
-host: luvcview -f yuv
+	http://www.spinics.net/lists/linux-usb/msg99220.html
+
+host::
+
+	luvcview -f yuv
 
 19. PRINTER function
 ====================
@@ -740,16 +845,19 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "printer".
 The printer function provides these attributes in its function directory:
 
-	pnp_string	- Data to be passed to the host in pnp string
-	q_len		- Number of requests per endpoint
+	==========	===========================================
+	pnp_string	Data to be passed to the host in pnp string
+	q_len		Number of requests per endpoint
+	==========	===========================================
 
 Testing the PRINTER function
 ----------------------------
 
 The most basic testing:
 
-device: run the gadget
-# ls -l /devices/virtual/usb_printer_gadget/
+device: run the gadget::
+
+	# ls -l /devices/virtual/usb_printer_gadget/
 
 should show g_printer<number>.
 
@@ -761,23 +869,28 @@ If udev is active, then e.g. /dev/usb/lp0 should appear.
 
 host->device transmission:
 
-device:
-# cat /dev/g_printer<number>
-host:
-# cat > /dev/usb/lp0
+device::
 
-device->host transmission:
+	# cat /dev/g_printer<number>
 
-# cat > /dev/g_printer<number>
-host:
-# cat /dev/usb/lp0
+host::
+
+	# cat > /dev/usb/lp0
+
+device->host transmission::
+
+	# cat > /dev/g_printer<number>
+
+host::
+
+	# cat /dev/usb/lp0
 
 More advanced testing can be done with the prn_example
 described in Documentation/usb/gadget_printer.txt.
 
 
 20. UAC1 function (virtual ALSA card, using u_audio API)
-=================
+========================================================
 
 The function is provided by usb_f_uac1.ko module.
 It will create a virtual ALSA card and the audio streams are simply
@@ -789,14 +902,16 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "uac1".
 The uac1 function provides these attributes in its function directory:
 
-	c_chmask - capture channel mask
-	c_srate - capture sampling rate
-	c_ssize - capture sample size (bytes)
-	p_chmask - playback channel mask
-	p_srate - playback sampling rate
-	p_ssize - playback sample size (bytes)
-	req_number - the number of pre-allocated request for both capture
-		     and playback
+	========== ====================================================
+	c_chmask   capture channel mask
+	c_srate    capture sampling rate
+	c_ssize    capture sample size (bytes)
+	p_chmask   playback channel mask
+	p_srate    playback sampling rate
+	p_ssize    playback sample size (bytes)
+	req_number the number of pre-allocated request for both capture
+		   and playback
+	========== ====================================================
 
 The attributes have sane default values.
 
@@ -809,11 +924,11 @@ host: aplay -l # should list our USB Audio Gadget
 This function does not require real hardware support, it just
 sends a stream of audio data to/from the host. In order to
 actually hear something at the device side, a command similar
-to this must be used at the device side:
+to this must be used at the device side::
 
-$ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
+	$ arecord -f dat -t wav -D hw:2,0 | aplay -D hw:0,0 &
 
-e.g.:
+e.g.::
 
-$ arecord -f dat -t wav -D hw:CARD=UAC1Gadget,DEV=0 | \
-aplay -D default:CARD=OdroidU3
+	$ arecord -f dat -t wav -D hw:CARD=UAC1Gadget,DEV=0 | \
+	  aplay -D default:CARD=OdroidU3
diff --git a/Documentation/usb/gadget_configfs.txt b/Documentation/usb/gadget_configfs.txt
index b8cb38a98c19..54fb08baae22 100644
--- a/Documentation/usb/gadget_configfs.txt
+++ b/Documentation/usb/gadget_configfs.txt
@@ -1,11 +1,9 @@
+============================================
+Linux USB gadget configured through configfs
+============================================
 
 
-
-
-		Linux USB gadget configured through configfs
-
-
-			     25th April 2013
+25th April 2013
 
 
 
@@ -26,7 +24,7 @@ Linux provides a number of functions for gadgets to use.
 Creating a gadget means deciding what configurations there will be
 and which functions each configuration will provide.
 
-Configfs (please see Documentation/filesystems/configfs/*) lends itself nicely
+Configfs (please see `Documentation/filesystems/configfs/*`) lends itself nicely
 for the purpose of telling the kernel about the above mentioned decision.
 This document is about how to do it.
 
@@ -51,44 +49,46 @@ Usage
 made available through configfs can be seen here:
 http://www.spinics.net/lists/linux-usb/msg76388.html)
 
-$ modprobe libcomposite
-$ mount none $CONFIGFS_HOME -t configfs
+::
+
+	$ modprobe libcomposite
+	$ mount none $CONFIGFS_HOME -t configfs
 
 where CONFIGFS_HOME is the mount point for configfs
 
 1. Creating the gadgets
 -----------------------
 
-For each gadget to be created its corresponding directory must be created:
+For each gadget to be created its corresponding directory must be created::
 
-$ mkdir $CONFIGFS_HOME/usb_gadget/<gadget name>
+	$ mkdir $CONFIGFS_HOME/usb_gadget/<gadget name>
 
-e.g.:
+e.g.::
 
-$ mkdir $CONFIGFS_HOME/usb_gadget/g1
+	$ mkdir $CONFIGFS_HOME/usb_gadget/g1
 
-...
-...
-...
+	...
+	...
+	...
 
-$ cd $CONFIGFS_HOME/usb_gadget/g1
+	$ cd $CONFIGFS_HOME/usb_gadget/g1
 
-Each gadget needs to have its vendor id <VID> and product id <PID> specified:
+Each gadget needs to have its vendor id <VID> and product id <PID> specified::
 
-$ echo <VID> > idVendor
-$ echo <PID> > idProduct
+	$ echo <VID> > idVendor
+	$ echo <PID> > idProduct
 
 A gadget also needs its serial number, manufacturer and product strings.
 In order to have a place to store them, a strings subdirectory must be created
-for each language, e.g.:
+for each language, e.g.::
 
-$ mkdir strings/0x409
+	$ mkdir strings/0x409
 
-Then the strings can be specified:
+Then the strings can be specified::
 
-$ echo <serial number> > strings/0x409/serialnumber
-$ echo <manufacturer> > strings/0x409/manufacturer
-$ echo <product> > strings/0x409/product
+	$ echo <serial number> > strings/0x409/serialnumber
+	$ echo <manufacturer> > strings/0x409/manufacturer
+	$ echo <product> > strings/0x409/product
 
 2. Creating the configurations
 ------------------------------
@@ -99,43 +99,43 @@ directories must be created:
 $ mkdir configs/<name>.<number>
 
 where <name> can be any string which is legal in a filesystem and the
-<number> is the configuration's number, e.g.:
+<number> is the configuration's number, e.g.::
 
-$ mkdir configs/c.1
+	$ mkdir configs/c.1
 
-...
-...
-...
+	...
+	...
+	...
 
 Each configuration also needs its strings, so a subdirectory must be created
-for each language, e.g.:
+for each language, e.g.::
 
-$ mkdir configs/c.1/strings/0x409
+	$ mkdir configs/c.1/strings/0x409
 
-Then the configuration string can be specified:
+Then the configuration string can be specified::
 
-$ echo <configuration> > configs/c.1/strings/0x409/configuration
+	$ echo <configuration> > configs/c.1/strings/0x409/configuration
 
-Some attributes can also be set for a configuration, e.g.:
+Some attributes can also be set for a configuration, e.g.::
 
-$ echo 120 > configs/c.1/MaxPower
+	$ echo 120 > configs/c.1/MaxPower
 
 3. Creating the functions
 -------------------------
 
 The gadget will provide some functions, for each function its corresponding
-directory must be created:
+directory must be created::
 
-$ mkdir functions/<name>.<instance name>
+	$ mkdir functions/<name>.<instance name>
 
 where <name> corresponds to one of allowed function names and instance name
-is an arbitrary string allowed in a filesystem, e.g.:
+is an arbitrary string allowed in a filesystem, e.g.::
 
-$ mkdir functions/ncm.usb0 # usb_f_ncm.ko gets loaded with request_module()
+  $ mkdir functions/ncm.usb0 # usb_f_ncm.ko gets loaded with request_module()
 
-...
-...
-...
+  ...
+  ...
+  ...
 
 Each function provides its specific set of attributes, with either read-only
 or read-write access. Where applicable they need to be written to as
@@ -149,17 +149,17 @@ At this moment a number of gadgets is created, each of which has a number of
 configurations specified and a number of functions available. What remains
 is specifying which function is available in which configuration (the same
 function can be used in multiple configurations). This is achieved with
-creating symbolic links:
+creating symbolic links::
 
-$ ln -s functions/<name>.<instance name> configs/<name>.<number>
+	$ ln -s functions/<name>.<instance name> configs/<name>.<number>
 
-e.g.:
+e.g.::
 
-$ ln -s functions/ncm.usb0 configs/c.1
+	$ ln -s functions/ncm.usb0 configs/c.1
 
-...
-...
-...
+	...
+	...
+	...
 
 5. Enabling the gadget
 ----------------------
@@ -167,123 +167,127 @@ $ ln -s functions/ncm.usb0 configs/c.1
 All the above steps serve the purpose of composing the gadget of
 configurations and functions.
 
-An example directory structure might look like this:
+An example directory structure might look like this::
 
-.
-./strings
-./strings/0x409
-./strings/0x409/serialnumber
-./strings/0x409/product
-./strings/0x409/manufacturer
-./configs
-./configs/c.1
-./configs/c.1/ncm.usb0 -> ../../../../usb_gadget/g1/functions/ncm.usb0
-./configs/c.1/strings
-./configs/c.1/strings/0x409
-./configs/c.1/strings/0x409/configuration
-./configs/c.1/bmAttributes
-./configs/c.1/MaxPower
-./functions
-./functions/ncm.usb0
-./functions/ncm.usb0/ifname
-./functions/ncm.usb0/qmult
-./functions/ncm.usb0/host_addr
-./functions/ncm.usb0/dev_addr
-./UDC
-./bcdUSB
-./bcdDevice
-./idProduct
-./idVendor
-./bMaxPacketSize0
-./bDeviceProtocol
-./bDeviceSubClass
-./bDeviceClass
+  .
+  ./strings
+  ./strings/0x409
+  ./strings/0x409/serialnumber
+  ./strings/0x409/product
+  ./strings/0x409/manufacturer
+  ./configs
+  ./configs/c.1
+  ./configs/c.1/ncm.usb0 -> ../../../../usb_gadget/g1/functions/ncm.usb0
+  ./configs/c.1/strings
+  ./configs/c.1/strings/0x409
+  ./configs/c.1/strings/0x409/configuration
+  ./configs/c.1/bmAttributes
+  ./configs/c.1/MaxPower
+  ./functions
+  ./functions/ncm.usb0
+  ./functions/ncm.usb0/ifname
+  ./functions/ncm.usb0/qmult
+  ./functions/ncm.usb0/host_addr
+  ./functions/ncm.usb0/dev_addr
+  ./UDC
+  ./bcdUSB
+  ./bcdDevice
+  ./idProduct
+  ./idVendor
+  ./bMaxPacketSize0
+  ./bDeviceProtocol
+  ./bDeviceSubClass
+  ./bDeviceClass
 
 
 Such a gadget must be finally enabled so that the USB host can enumerate it.
-In order to enable the gadget it must be bound to a UDC (USB Device Controller).
 
-$ echo <udc name> > UDC
+In order to enable the gadget it must be bound to a UDC (USB Device
+Controller)::
+
+	$ echo <udc name> > UDC
 
 where <udc name> is one of those found in /sys/class/udc/*
-e.g.:
+e.g.::
 
-$ echo s3c-hsotg > UDC
+	$ echo s3c-hsotg > UDC
 
 
 6. Disabling the gadget
 -----------------------
 
-$ echo "" > UDC
+::
+
+	$ echo "" > UDC
 
 7. Cleaning up
 --------------
 
-Remove functions from configurations:
+Remove functions from configurations::
 
-$ rm configs/<config name>.<number>/<function>
+	$ rm configs/<config name>.<number>/<function>
 
 where <config name>.<number> specify the configuration and <function> is
-a symlink to a function being removed from the configuration, e.g.:
+a symlink to a function being removed from the configuration, e.g.::
 
-$ rm configs/c.1/ncm.usb0
+	$ rm configs/c.1/ncm.usb0
 
-...
-...
-...
+	...
+	...
+	...
 
-Remove strings directories in configurations
+Remove strings directories in configurations:
 
-$ rmdir configs/<config name>.<number>/strings/<lang>
+	$ rmdir configs/<config name>.<number>/strings/<lang>
 
-e.g.:
+e.g.::
 
-$ rmdir configs/c.1/strings/0x409
+	$ rmdir configs/c.1/strings/0x409
 
-...
-...
-...
+	...
+	...
+	...
 
-and remove the configurations
+and remove the configurations::
 
-$ rmdir configs/<config name>.<number>
+	$ rmdir configs/<config name>.<number>
 
-e.g.:
+e.g.::
 
-rmdir configs/c.1
+	rmdir configs/c.1
 
-...
-...
-...
+	...
+	...
+	...
 
-Remove functions (function modules are not unloaded, though)
+Remove functions (function modules are not unloaded, though):
 
-$ rmdir functions/<name>.<instance name>
+	$ rmdir functions/<name>.<instance name>
 
-e.g.:
+e.g.::
 
-$ rmdir functions/ncm.usb0
+	$ rmdir functions/ncm.usb0
 
-...
-...
-...
+	...
+	...
+	...
 
-Remove strings directories in the gadget
+Remove strings directories in the gadget::
 
-$ rmdir strings/<lang>
+	$ rmdir strings/<lang>
 
-e.g.:
+e.g.::
 
-$ rmdir strings/0x409
+	$ rmdir strings/0x409
 
-and finally remove the gadget:
+and finally remove the gadget::
 
-$ cd ..
-$ rmdir <gadget name>
+	$ cd ..
+	$ rmdir <gadget name>
 
-e.g.:
+e.g.::
 
-$ rmdir g1
+	$ rmdir g1
 
 
 
@@ -305,16 +309,16 @@ configured elements. However, they are embedded in usage-specific
 larger structures. In the picture below there is a "cs" which contains
 a config_item and an "sa" which contains a configfs_attribute.
 
-The filesystem view would be like this:
+The filesystem view would be like this::
 
-./
-./cs        (directory)
-   |
-   +--sa    (file)
-   |
-   .
-   .
-   .
+  ./
+  ./cs        (directory)
+     |
+     +--sa    (file)
+     |
+     .
+     .
+     .
 
 Whenever a user reads/writes the "sa" file, a function is called
 which accepts a struct config_item and a struct configfs_attribute.
@@ -326,29 +330,31 @@ buffer), while the "store" is for modifying the file's contents (copy data
 from the buffer to the cs), but it is up to the implementer of the
 two functions to decide what they actually do.
 
-typedef struct configured_structure cs;
-typedef struct specific_attribute sa;
+::
 
-                                       sa
-                       +----------------------------------+
-        cs             |  (*show)(cs *, buffer);          |
-+-----------------+    |  (*store)(cs *, buffer, length); |
-|                 |    |                                  |
-| +-------------+ |    |       +------------------+       |
-| | struct      |-|----|------>|struct            |       |
-| | config_item | |    |       |configfs_attribute|       |
-| +-------------+ |    |       +------------------+       |
-|                 |    +----------------------------------+
-| data to be set  |                .
-|                 |                .
-+-----------------+                .
+  typedef struct configured_structure cs;
+  typedef struct specific_attribute sa;
+
+                                         sa
+                         +----------------------------------+
+          cs             |  (*show)(cs *, buffer);          |
+  +-----------------+    |  (*store)(cs *, buffer, length); |
+  |                 |    |                                  |
+  | +-------------+ |    |       +------------------+       |
+  | | struct      |-|----|------>|struct            |       |
+  | | config_item | |    |       |configfs_attribute|       |
+  | +-------------+ |    |       +------------------+       |
+  |                 |    +----------------------------------+
+  | data to be set  |                .
+  |                 |                .
+  +-----------------+                .
 
 The file names are decided by the config item/group designer, while
 the directories in general can be named at will. A group can have
 a number of its default sub-groups created automatically.
 
 For more information on configfs please see
-Documentation/filesystems/configfs/*.
+`Documentation/filesystems/configfs/*`.
 
 The concepts described above translate to USB gadgets like this:
 
diff --git a/Documentation/usb/gadget_hid.txt b/Documentation/usb/gadget_hid.txt
index 7a0fb8e16e27..098d563040cc 100644
--- a/Documentation/usb/gadget_hid.txt
+++ b/Documentation/usb/gadget_hid.txt
@@ -1,28 +1,31 @@
-
-		     Linux USB HID gadget driver
+===========================
+Linux USB HID gadget driver
+===========================
 
 Introduction
+============
 
-	The HID Gadget driver provides emulation of USB Human Interface
-	Devices (HID). The basic HID handling is done in the kernel,
-	and HID reports can be sent/received through I/O on the
-	/dev/hidgX character devices.
+The HID Gadget driver provides emulation of USB Human Interface
+Devices (HID). The basic HID handling is done in the kernel,
+and HID reports can be sent/received through I/O on the
+/dev/hidgX character devices.
 
-	For more details about HID, see the developer page on
-	http://www.usb.org/developers/hidpage/
+For more details about HID, see the developer page on
+http://www.usb.org/developers/hidpage/
 
 Configuration
+=============
 
-	g_hid is a platform driver, so to use it you need to add
-	struct platform_device(s) to your platform code defining the
-	HID function descriptors you want to use - E.G. something
-	like:
+g_hid is a platform driver, so to use it you need to add
+struct platform_device(s) to your platform code defining the
+HID function descriptors you want to use - E.G. something
+like::
 
-#include <linux/platform_device.h>
-#include <linux/usb/g_hid.h>
+  #include <linux/platform_device.h>
+  #include <linux/usb/g_hid.h>
 
-/* hid descriptor for a keyboard */
-static struct hidg_func_descriptor my_hid_data = {
+  /* hid descriptor for a keyboard */
+  static struct hidg_func_descriptor my_hid_data = {
 	.subclass		= 0, /* No subclass */
 	.protocol		= 1, /* Keyboard */
 	.report_length		= 8,
@@ -61,85 +64,87 @@ static struct hidg_func_descriptor my_hid_data = {
 		0x81, 0x00,	/*   INPUT (Data,Ary,Abs)                 */
 		0xc0		/* END_COLLECTION                         */
 	}
-};
+  };
 
-static struct platform_device my_hid = {
+  static struct platform_device my_hid = {
 	.name			= "hidg",
 	.id			= 0,
 	.num_resources		= 0,
 	.resource		= 0,
 	.dev.platform_data	= &my_hid_data,
-};
+  };
 
-	You can add as many HID functions as you want, only limited by
-	the amount of interrupt endpoints your gadget driver supports.
+You can add as many HID functions as you want, only limited by
+the amount of interrupt endpoints your gadget driver supports.
 
 Configuration with configfs
+===========================
 
-	Instead of adding fake platform devices and drivers in order to pass
-	some data to the kernel, if HID is a part of a gadget composed with
-	configfs the hidg_func_descriptor.report_desc is passed to the kernel
-	by writing the appropriate stream of bytes to a configfs attribute.
+Instead of adding fake platform devices and drivers in order to pass
+some data to the kernel, if HID is a part of a gadget composed with
+configfs the hidg_func_descriptor.report_desc is passed to the kernel
+by writing the appropriate stream of bytes to a configfs attribute.
 
 Send and receive HID reports
+============================
 
-	HID reports can be sent/received using read/write on the
-	/dev/hidgX character devices. See below for an example program
-	to do this.
+HID reports can be sent/received using read/write on the
+/dev/hidgX character devices. See below for an example program
+to do this.
 
-	hid_gadget_test is a small interactive program to test the HID
-	gadget driver. To use, point it at a hidg device and set the
-	device type (keyboard / mouse / joystick) - E.G.:
+hid_gadget_test is a small interactive program to test the HID
+gadget driver. To use, point it at a hidg device and set the
+device type (keyboard / mouse / joystick) - E.G.::
 
-		# hid_gadget_test /dev/hidg0 keyboard
+	# hid_gadget_test /dev/hidg0 keyboard
 
-	You are now in the prompt of hid_gadget_test. You can type any
-	combination of options and values. Available options and
-	values are listed at program start. In keyboard mode you can
-	send up to six values.
+You are now in the prompt of hid_gadget_test. You can type any
+combination of options and values. Available options and
+values are listed at program start. In keyboard mode you can
+send up to six values.
 
-	For example type: g i s t r --left-shift
+For example type: g i s t r --left-shift
 
-	Hit return and the corresponding report will be sent by the
-	HID gadget.
+Hit return and the corresponding report will be sent by the
+HID gadget.
 
-	Another interesting example is the caps lock test. Type
-	--caps-lock and hit return. A report is then sent by the
-	gadget and you should receive the host answer, corresponding
-	to the caps lock LED status.
+Another interesting example is the caps lock test. Type
+--caps-lock and hit return. A report is then sent by the
+gadget and you should receive the host answer, corresponding
+to the caps lock LED status::
 
-		--caps-lock
-		recv report:2
+	--caps-lock
+	recv report:2
 
-	With this command:
+With this command::
 
-		# hid_gadget_test /dev/hidg1 mouse
+	# hid_gadget_test /dev/hidg1 mouse
 
-	You can test the mouse emulation. Values are two signed numbers.
+You can test the mouse emulation. Values are two signed numbers.
 
 
-Sample code
+Sample code::
 
-/* hid_gadget_test */
+    /* hid_gadget_test */
 
-#include <pthread.h>
-#include <string.h>
-#include <stdio.h>
-#include <ctype.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
+    #include <pthread.h>
+    #include <string.h>
+    #include <stdio.h>
+    #include <ctype.h>
+    #include <fcntl.h>
+    #include <errno.h>
+    #include <stdio.h>
+    #include <stdlib.h>
+    #include <unistd.h>
 
-#define BUF_LEN 512
+    #define BUF_LEN 512
 
-struct options {
+    struct options {
 	const char    *opt;
 	unsigned char val;
-};
+  };
 
-static struct options kmod[] = {
+  static struct options kmod[] = {
 	{.opt = "--left-ctrl",		.val = 0x01},
 	{.opt = "--right-ctrl",		.val = 0x10},
 	{.opt = "--left-shift",		.val = 0x02},
@@ -149,9 +154,9 @@ static struct options kmod[] = {
 	{.opt = "--left-meta",		.val = 0x08},
 	{.opt = "--right-meta",		.val = 0x80},
 	{.opt = NULL}
-};
+  };
 
-static struct options kval[] = {
+  static struct options kval[] = {
 	{.opt = "--return",	.val = 0x28},
 	{.opt = "--esc",	.val = 0x29},
 	{.opt = "--bckspc",	.val = 0x2a},
@@ -183,10 +188,10 @@ static struct options kval[] = {
 	{.opt = "--up",		.val = 0x52},
 	{.opt = "--num-lock",	.val = 0x53},
 	{.opt = NULL}
-};
+  };
 
-int keyboard_fill_report(char report[8], char buf[BUF_LEN], int *hold)
-{
+  int keyboard_fill_report(char report[8], char buf[BUF_LEN], int *hold)
+  {
 	char *tok = strtok(buf, " ");
 	int key = 0;
 	int i = 0;
@@ -229,17 +234,17 @@ int keyboard_fill_report(char report[8], char buf[BUF_LEN], int *hold)
 			fprintf(stderr, "unknown option: %s\n", tok);
 	}
 	return 8;
-}
+  }
 
-static struct options mmod[] = {
+  static struct options mmod[] = {
 	{.opt = "--b1", .val = 0x01},
 	{.opt = "--b2", .val = 0x02},
 	{.opt = "--b3", .val = 0x04},
 	{.opt = NULL}
-};
+  };
 
-int mouse_fill_report(char report[8], char buf[BUF_LEN], int *hold)
-{
+  int mouse_fill_report(char report[8], char buf[BUF_LEN], int *hold)
+  {
 	char *tok = strtok(buf, " ");
 	int mvt = 0;
 	int i = 0;
@@ -274,9 +279,9 @@ int mouse_fill_report(char report[8], char buf[BUF_LEN], int *hold)
 		fprintf(stderr, "unknown option: %s\n", tok);
 	}
 	return 3;
-}
+  }
 
-static struct options jmod[] = {
+  static struct options jmod[] = {
 	{.opt = "--b1",		.val = 0x10},
 	{.opt = "--b2",		.val = 0x20},
 	{.opt = "--b3",		.val = 0x40},
@@ -287,10 +292,10 @@ static struct options jmod[] = {
 	{.opt = "--hat4",	.val = 0x03},
 	{.opt = "--hatneutral",	.val = 0x04},
 	{.opt = NULL}
-};
+  };
 
-int joystick_fill_report(char report[8], char buf[BUF_LEN], int *hold)
-{
+  int joystick_fill_report(char report[8], char buf[BUF_LEN], int *hold)
+  {
 	char *tok = strtok(buf, " ");
 	int mvt = 0;
 	int i = 0;
@@ -326,10 +331,10 @@ int joystick_fill_report(char report[8], char buf[BUF_LEN], int *hold)
 		fprintf(stderr, "unknown option: %s\n", tok);
 	}
 	return 4;
-}
+  }
 
-void print_options(char c)
-{
+  void print_options(char c)
+  {
 	int i = 0;
 
 	if (c == 'k') {
@@ -358,10 +363,10 @@ void print_options(char c)
 		       "		three signed numbers\n"
 		       "--quit to close\n");
 	}
-}
+  }
 
-int main(int argc, const char *argv[])
-{
+  int main(int argc, const char *argv[])
+  {
 	const char *filename = NULL;
 	int fd = 0;
 	char buf[BUF_LEN];
@@ -449,4 +454,4 @@ int main(int argc, const char *argv[])
 
 	close(fd);
 	return 0;
-}
+  }
diff --git a/Documentation/usb/gadget_multi.txt b/Documentation/usb/gadget_multi.txt
index b3146dd7aa43..9806b55af301 100644
--- a/Documentation/usb/gadget_multi.txt
+++ b/Documentation/usb/gadget_multi.txt
@@ -1,6 +1,9 @@
-                                                             -*- org -*-
+==============================
+Multifunction Composite Gadget
+==============================
 
-* Overview
+Overview
+========
 
 The Multifunction Composite Gadget (or g_multi) is a composite gadget
 that makes extensive use of the composite framework to provide
@@ -17,13 +20,15 @@ have two configurations -- one with RNDIS and another with CDC ECM[3].
 Please note that if you use non-standard configuration (that is enable
 CDC ECM) you may need to change vendor and/or product ID.
 
-* Host drivers
+Host drivers
+============
 
 To make use of the gadget one needs to make it work on host side --
 without that there's no hope of achieving anything with the gadget.
 As one might expect, things one need to do very from system to system.
 
-** Linux host drivers
+Linux host drivers
+------------------
 
 Since the gadget uses standard composite framework and appears as such
 to Linux host it does not need any additional drivers on Linux host
@@ -34,11 +39,13 @@ This is also true for two configuration set-up with RNDIS
 configuration being the first one.  Linux host will use the second
 configuration with CDC ECM which should work better under Linux.
 
-** Windows host drivers
+Windows host drivers
+--------------------
 
 For the gadget to work under Windows two conditions have to be met:
 
-*** Detecting as composite gadget
+Detecting as composite gadget
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 First of all, Windows need to detect the gadget as an USB composite
 gadget which on its own have some conditions[4].  If they are met,
@@ -53,7 +60,8 @@ The only thing to worry is that the gadget has to have a single
 configuration so a dual RNDIS and CDC ECM gadget won't work unless you
 create a proper INF -- and of course, if you do submit it!
 
-*** Installing drivers for each function
+Installing drivers for each function
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The other, trickier thing is making Windows install drivers for each
 individual function.
@@ -63,7 +71,8 @@ implementing USB Mass Storage class and selects appropriate driver.
 
 Things are harder with RDNIS and CDC ACM.
 
-**** RNDIS
+RNDIS
+.....
 
 To make Windows select RNDIS drivers for the first function in the
 gadget, one needs to use the [[file:linux.inf]] file provided with this
@@ -75,11 +84,13 @@ RNDIS was not the first interface.  You do not need to worry abut it
 unless you are trying to develop your own gadget in which case watch
 out for this bug.
 
-**** CDC ACM
+CDC ACM
+.......
 
 Similarly, [[file:linux-cdc-acm.inf]] is provided for CDC ACM.
 
-**** Customising the gadget
+Customising the gadget
+......................
 
 If you intend to hack the g_multi gadget be advised that rearranging
 functions will obviously change interface numbers for each of the
@@ -97,14 +108,16 @@ things don't work as intended before realising Windows have cached
 some drivers information (changing USB port may sometimes help plus
 you might try using USBDeview[8] to remove the phantom device).
 
-**** INF testing
+INF testing
+...........
 
 Provided INF files have been tested on Windows XP SP3, Windows Vista
 and Windows 7, all 32-bit versions.  It should work on 64-bit versions
 as well.  It most likely won't work on Windows prior to Windows XP
 SP2.
 
-** Other systems
+Other systems
+-------------
 
 At this moment, drivers for any other systems have not been tested.
 Knowing how MacOS is based on BSD and BSD is an Open Source it is
@@ -115,7 +128,8 @@ For more exotic systems I have even less to say...
 
 Any testing and drivers *are* *welcome*!
 
-* Authors
+Authors
+=======
 
 This document has been written by Michal Nazarewicz
 ([[mailto:mina86@mina86.com]]).  INF files have been hacked with
@@ -124,7 +138,8 @@ Xiaofan Chen ([[mailto:xiaofanc@gmail.com]]) basing on the MS RNDIS
 template[9], Microchip's CDC ACM INF file and David Brownell's
 ([[mailto:dbrownell@users.sourceforge.net]]) original INF files.
 
-* Footnotes
+Footnotes
+=========
 
 [1] Remote Network Driver Interface Specification,
 [[http://msdn.microsoft.com/en-us/library/ee484414.aspx]].
diff --git a/Documentation/usb/gadget_printer.txt b/Documentation/usb/gadget_printer.txt
index ad995bf0db41..5e5516c69075 100644
--- a/Documentation/usb/gadget_printer.txt
+++ b/Documentation/usb/gadget_printer.txt
@@ -1,12 +1,14 @@
+﻿===============================
+Linux USB Printer Gadget Driver
+===============================
 
-                       Linux USB Printer Gadget Driver
-                                 06/04/2007
+06/04/2007
 
-              Copyright (C) 2007 Craig W. Nadler <craig@nadler.us>
+Copyright (C) 2007 Craig W. Nadler <craig@nadler.us>
 
 
 
-GENERAL
+General
 =======
 
 This driver may be used if you are writing printer firmware using Linux as
@@ -29,52 +31,60 @@ user space firmware can read or write this status byte using a device file
 
 
 
-HOWTO USE THIS DRIVER
+Howto Use This Driver
 =====================
 
 To load the USB device controller driver and the printer gadget driver. The
-following example uses the Netchip 2280 USB device controller driver:
+following example uses the Netchip 2280 USB device controller driver::
 
-modprobe net2280
-modprobe g_printer
+	modprobe net2280
+	modprobe g_printer
 
 
 The follow command line parameter can be used when loading the printer gadget
 (ex: modprobe g_printer idVendor=0x0525 idProduct=0xa4a8 ):
 
-idVendor - This is the Vendor ID used in the device descriptor. The default is
+idVendor
+	This is the Vendor ID used in the device descriptor. The default is
 	the Netchip vendor id 0x0525. YOU MUST CHANGE TO YOUR OWN VENDOR ID
 	BEFORE RELEASING A PRODUCT. If you plan to release a product and don't
 	already have a Vendor ID please see www.usb.org for details on how to
 	get one.
 
-idProduct - This is the Product ID used in the device descriptor. The default
+idProduct
+	This is the Product ID used in the device descriptor. The default
 	is 0xa4a8, you should change this to an ID that's not used by any of
 	your other USB products if you have any. It would be a good idea to
 	start numbering your products starting with say 0x0001.
 
-bcdDevice - This is the version number of your product. It would be a good idea
+bcdDevice
+	This is the version number of your product. It would be a good idea
 	to put your firmware version here.
 
-iManufacturer - A string containing the name of the Vendor.
+iManufacturer
+	A string containing the name of the Vendor.
 
-iProduct - A string containing the Product Name.
+iProduct
+	A string containing the Product Name.
 
-iSerialNum - A string containing the Serial Number. This should be changed for
+iSerialNum
+	A string containing the Serial Number. This should be changed for
 	each unit of your product.
 
-iPNPstring -  The PNP ID string used for this printer. You will want to set
+iPNPstring
+	The PNP ID string used for this printer. You will want to set
 	either on the command line or hard code the PNP ID string used for
 	your printer product.
 
-qlen - The number of 8k buffers to use per endpoint. The default is 10, you
+qlen
+	The number of 8k buffers to use per endpoint. The default is 10, you
 	should tune this for your product. You may also want to tune the
 	size of each buffer for your product.
 
 
 
 
-USING THE EXAMPLE CODE
+Using The Example Code
 ======================
 
 This example code talks to stdout, instead of a print engine.
@@ -82,22 +92,23 @@ This example code talks to stdout, instead of a print engine.
 To compile the test code below:
 
 1) save it to a file called prn_example.c
-2) compile the code with the follow command:
+2) compile the code with the follow command::
+
 	 gcc prn_example.c -o prn_example
 
 
 
-To read printer data from the host to stdout:
+To read printer data from the host to stdout::
 
 	# prn_example -read_data
 
 
-To write printer data from a file (data_file) to the host:
+To write printer data from a file (data_file) to the host::
 
 	# cat data_file | prn_example -write_data
 
 
-To get the current printer status for the gadget driver:
+To get the current printer status for the gadget driver:::
 
 	# prn_example -get_status
 
@@ -107,60 +118,62 @@ To get the current printer status for the gadget driver:
 	     Printer OK
 
 
-To set printer to Selected/On-line:
+To set printer to Selected/On-line::
 
 	# prn_example -selected
 
 
-To set printer to Not Selected/Off-line:
+To set printer to Not Selected/Off-line::
 
 	# prn_example -not_selected
 
 
-To set paper status to paper out:
+To set paper status to paper out::
 
 	# prn_example -paper_out
 
 
-To set paper status to paper loaded:
+To set paper status to paper loaded::
 
 	# prn_example -paper_loaded
 
 
-To set error status to printer OK:
+To set error status to printer OK::
 
 	# prn_example -no_error
 
 
-To set error status to ERROR:
+To set error status to ERROR::
 
 	# prn_example -error
 
 
 
 
-EXAMPLE CODE
+Example Code
 ============
 
+::
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <linux/poll.h>
-#include <sys/ioctl.h>
-#include <linux/usb/g_printer.h>
 
-#define PRINTER_FILE			"/dev/g_printer"
-#define BUF_SIZE			512
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <fcntl.h>
+  #include <linux/poll.h>
+  #include <sys/ioctl.h>
+  #include <linux/usb/g_printer.h>
 
+  #define PRINTER_FILE			"/dev/g_printer"
+  #define BUF_SIZE			512
 
-/*
- * 'usage()' - Show program usage.
- */
 
-static void
-usage(const char *option)		/* I - Option string or NULL */
-{
+  /*
+   * 'usage()' - Show program usage.
+   */
+
+  static void
+  usage(const char *option)		/* I - Option string or NULL */
+  {
 	if (option) {
 		fprintf(stderr,"prn_example: Unknown option \"%s\"!\n",
 				option);
@@ -186,12 +199,12 @@ usage(const char *option)		/* I - Option string or NULL */
 	fputs("\n\n", stderr);
 
 	exit(1);
-}
+  }
 
 
-static int
-read_printer_data()
-{
+  static int
+  read_printer_data()
+  {
 	struct pollfd	fd[1];
 
 	/* Open device file for printer gadget. */
@@ -236,12 +249,12 @@ read_printer_data()
 	close(fd[0].fd);
 
 	return 0;
-}
+  }
 
 
-static int
-write_printer_data()
-{
+  static int
+  write_printer_data()
+  {
 	struct pollfd	fd[1];
 
 	/* Open device file for printer gadget. */
@@ -295,12 +308,12 @@ write_printer_data()
 	close(fd[0].fd);
 
 	return 0;
-}
+  }
 
 
-static int
-read_NB_printer_data()
-{
+  static int
+  read_NB_printer_data()
+  {
 	int		fd;
 	static char	buf[BUF_SIZE];
 	int		bytes_read;
@@ -329,12 +342,12 @@ read_NB_printer_data()
 	close(fd);
 
 	return 0;
-}
+  }
 
 
-static int
-get_printer_status()
-{
+  static int
+  get_printer_status()
+  {
 	int	retval;
 	int	fd;
 
@@ -357,12 +370,12 @@ get_printer_status()
 	close(fd);
 
 	return(retval);
-}
+  }
 
 
-static int
-set_printer_status(unsigned char buf, int clear_printer_status_bit)
-{
+  static int
+  set_printer_status(unsigned char buf, int clear_printer_status_bit)
+  {
 	int	retval;
 	int	fd;
 
@@ -397,12 +410,12 @@ set_printer_status(unsigned char buf, int clear_printer_status_bit)
 	close(fd);
 
 	return 0;
-}
+  }
 
 
-static int
-display_printer_status()
-{
+  static int
+  display_printer_status()
+  {
 	char	printer_status;
 
 	printer_status = get_printer_status();
@@ -429,12 +442,12 @@ display_printer_status()
 	}
 
 	return(0);
-}
+  }
 
 
-int
-main(int  argc, char *argv[])
-{
+  int
+  main(int  argc, char *argv[])
+  {
 	int	i;		/* Looping var */
 	int	retval = 0;
 
@@ -507,4 +520,4 @@ main(int  argc, char *argv[])
 	}
 
 	exit(retval);
-}
+  }
diff --git a/Documentation/usb/gadget_serial.txt b/Documentation/usb/gadget_serial.txt
index d1def3186782..dce8bc1fb1f2 100644
--- a/Documentation/usb/gadget_serial.txt
+++ b/Documentation/usb/gadget_serial.txt
@@ -1,7 +1,10 @@
+===============================
+Linux Gadget Serial Driver v2.0
+===============================
 
-                 Linux Gadget Serial Driver v2.0
-                           11/20/2004
-                  (updated 8-May-2008 for v2.3)
+11/20/2004
+
+(updated 8-May-2008 for v2.3)
 
 
 License and Disclaimer
@@ -56,7 +59,7 @@ hardware; for example, a PDA, an embedded Linux system, or a PC
 with a USB development card.
 
 The gadget serial driver talks over USB to either a CDC ACM driver
-or a generic USB serial driver running on a host PC.
+or a generic USB serial driver running on a host PC::
 
    Host
    --------------------------------------
@@ -112,11 +115,11 @@ configuring the kernel.  Then rebuild and install the kernel or
 modules.
 
 Then you must load the gadget serial driver.  To load it as an
-ACM device (recommended for interoperability), do this:
+ACM device (recommended for interoperability), do this::
 
   modprobe g_serial
 
-To load it as a vendor specific bulk in/out device, do this:
+To load it as a vendor specific bulk in/out device, do this::
 
   modprobe g_serial use_acm=0
 
@@ -127,7 +130,7 @@ desired.
 
 Your system should use mdev (from busybox) or udev to make the
 device nodes.  After this gadget driver has been set up you should
-then see a /dev/ttyGS0 node:
+then see a /dev/ttyGS0 node::
 
   # ls -l /dev/ttyGS0 | cat
   crw-rw----    1 root     root     253,   0 May  8 14:10 /dev/ttyGS0
@@ -187,24 +190,24 @@ support".
 
 Once the gadget serial driver is loaded and the USB device connected
 to the Linux host with a USB cable, the host system should recognize
-the gadget serial device.  For example, the command
+the gadget serial device.  For example, the command::
 
   cat /sys/kernel/debug/usb/devices
 
-should show something like this:
+should show something like this:::
 
-T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  5 Spd=480 MxCh= 0
-D:  Ver= 2.00 Cls=02(comm.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
-P:  Vendor=0525 ProdID=a4a7 Rev= 2.01
-S:  Manufacturer=Linux 2.6.8.1 with net2280
-S:  Product=Gadget Serial
-S:  SerialNumber=0
-C:* #Ifs= 2 Cfg#= 2 Atr=c0 MxPwr=  2mA
-I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
-E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
-I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
-E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
-E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
+  T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  5 Spd=480 MxCh= 0
+  D:  Ver= 2.00 Cls=02(comm.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
+  P:  Vendor=0525 ProdID=a4a7 Rev= 2.01
+  S:  Manufacturer=Linux 2.6.8.1 with net2280
+  S:  Product=Gadget Serial
+  S:  SerialNumber=0
+  C:* #Ifs= 2 Cfg#= 2 Atr=c0 MxPwr=  2mA
+  I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=acm
+  E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
+  I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=acm
+  E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
+  E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
 
 If the host side Linux system is configured properly, the ACM driver
 should be loaded automatically.  The command "lsmod" should show the
@@ -219,29 +222,29 @@ Serial Converter support", and for the "USB Generic Serial Driver".
 
 Once the gadget serial driver is loaded and the USB device connected
 to the Linux host with a USB cable, the host system should recognize
-the gadget serial device.  For example, the command
+the gadget serial device.  For example, the command::
 
   cat /sys/kernel/debug/usb/devices
 
-should show something like this:
+should show something like this:::
 
-T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  6 Spd=480 MxCh= 0
-D:  Ver= 2.00 Cls=ff(vend.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
-P:  Vendor=0525 ProdID=a4a6 Rev= 2.01
-S:  Manufacturer=Linux 2.6.8.1 with net2280
-S:  Product=Gadget Serial
-S:  SerialNumber=0
-C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
-I:  If#= 0 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=serial
-E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
-E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
+  T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  6 Spd=480 MxCh= 0
+  D:  Ver= 2.00 Cls=ff(vend.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
+  P:  Vendor=0525 ProdID=a4a6 Rev= 2.01
+  S:  Manufacturer=Linux 2.6.8.1 with net2280
+  S:  Product=Gadget Serial
+  S:  SerialNumber=0
+  C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
+  I:  If#= 0 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=serial
+  E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
+  E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
 
 You must load the usbserial driver and explicitly set its parameters
-to configure it to recognize the gadget serial device, like this:
+to configure it to recognize the gadget serial device, like this::
 
   echo 0x0525 0xA4A6 >/sys/bus/usb-serial/drivers/generic/new_id
 
-The legacy way is to use module parameters:
+The legacy way is to use module parameters::
 
   modprobe usbserial vendor=0x0525 product=0xA4A6
 
diff --git a/Documentation/usb/iuu_phoenix.txt b/Documentation/usb/iuu_phoenix.txt
index e5f048067da4..b76268728450 100644
--- a/Documentation/usb/iuu_phoenix.txt
+++ b/Documentation/usb/iuu_phoenix.txt
@@ -1,5 +1,6 @@
+=============================
 Infinity Usb Unlimited Readme
------------------------------
+=============================
 
 Hi all,
 
@@ -19,7 +20,8 @@ have his own device file(/dev/ttyUSB0,/dev/ttyUSB1,...)
 
 
 
-How to tune the reader speed ?
+How to tune the reader speed?
+=============================
 
  A few parameters can be used at load time
  To use parameters, just unload the module if it is
@@ -27,26 +29,33 @@ How to tune the reader speed ?
  In case of prebuilt module, use the command
  insmod iuu_phoenix param=value.
 
- Example:
+ Example::
 
- modprobe iuu_phoenix clockmode=3
+	modprobe iuu_phoenix clockmode=3
 
  The parameters are:
 
- parm:           clockmode:1=3Mhz579,2=3Mhz680,3=6Mhz (int)
- parm:           boost:overclock boost percent 100 to 500 (int)
- parm:           cdmode:Card detect mode 0=none, 1=CD, 2=!CD, 3=DSR, 4=!DSR, 5=CTS, 6=!CTS, 7=RING, 8=!RING (int)
- parm:           xmas:xmas color enabled or not (bool)
- parm:           debug:Debug enabled or not (bool)
+clockmode:
+	1=3Mhz579,2=3Mhz680,3=6Mhz (int)
+boost:
+	overclock boost percent 100 to 500 (int)
+cdmode:
+	Card detect mode
+	0=none, 1=CD, 2=!CD, 3=DSR, 4=!DSR, 5=CTS, 6=!CTS, 7=RING, 8=!RING (int)
+xmas:
+	xmas color enabled or not (bool)
+debug:
+	Debug enabled or not (bool)
 
 -  clockmode will provide 3 different base settings commonly adopted by
    different software:
- 	1. 3Mhz579
+
+	1. 3Mhz579
 	2. 3Mhz680
 	3. 6Mhz
 
 -  boost provide a way to overclock the reader ( my favorite :-)  )
-   For example to have best performance than a simple clockmode=3, try this:
+   For example to have best performance than a simple clockmode=3, try this::
 
       modprobe boost=195
 
@@ -66,7 +75,8 @@ How to tune the reader speed ?
 -  debug will produce a lot of debugging messages...
 
 
- Last notes:
+Last notes
+==========
 
  Don't worry about the serial settings, the serial emulation
  is an abstraction, so use any speed or parity setting will
diff --git a/Documentation/usb/mass-storage.txt b/Documentation/usb/mass-storage.txt
index e89803a5a960..d181b47c3cb6 100644
--- a/Documentation/usb/mass-storage.txt
+++ b/Documentation/usb/mass-storage.txt
@@ -1,4 +1,9 @@
-* Overview
+=========================
+Mass Storage Gadget (MSG)
+=========================
+
+Overview
+========
 
   Mass Storage Gadget (or MSG) acts as a USB Mass Storage device,
   appearing to the host as a disk or a CD-ROM drive.  It supports
@@ -24,7 +29,8 @@
   (which is no longer included in Linux).  It will talk only briefly
   about how to use MSF within composite gadgets.
 
-* Module parameters
+Module parameters
+=================
 
   The mass storage gadget accepts the following mass storage specific
   module parameters:
@@ -146,7 +152,8 @@
   - iProduct      -- USB Product string (string)
   - iSerialNumber -- SerialNumber string (sting)
 
-* sysfs entries
+sysfs entries
+=============
 
   For each logical unit, the gadget creates a directory in the sysfs
   hierarchy.  Inside of it the following three files are created:
@@ -177,7 +184,8 @@
   Other then those, as usual, the values of module parameters can be
   read from /sys/module/g_mass_storage/parameters/* files.
 
-* Other gadgets using mass storage function
+Other gadgets using mass storage function
+=========================================
 
   The Mass Storage Gadget uses the Mass Storage Function to handle
   mass storage protocol.  As a composite function, MSF may be used by
@@ -193,7 +201,8 @@
   may take a look at mass_storage.c, acm_ms.c and multi.c (sorted by
   complexity).
 
-* Relation to file storage gadget
+Relation to file storage gadget
+===============================
 
   The Mass Storage Function and thus the Mass Storage Gadget has been
   based on the File Storage Gadget.  The difference between the two is
diff --git a/Documentation/usb/misc_usbsevseg.txt b/Documentation/usb/misc_usbsevseg.txt
index 0f6be4f9930b..6274aee083ed 100644
--- a/Documentation/usb/misc_usbsevseg.txt
+++ b/Documentation/usb/misc_usbsevseg.txt
@@ -1,4 +1,7 @@
+=============================
 USB 7-Segment Numeric Display
+=============================
+
 Manufactured by Delcom Engineering
 
 Device Information
@@ -13,9 +16,13 @@ Device Modes
 ------------
 By default, the driver assumes the display is only 6 characters
 The mode for 6 characters is:
+
 	MSB 0x06; LSB 0x3f
+
 For the 8 character display:
+
 	MSB 0x08; LSB 0xff
+
 The device can accept "text" either in raw, hex, or ascii textmode.
 raw controls each segment manually,
 hex expects a value between 0-15 per character,
@@ -42,5 +49,3 @@ Device Operation
 	To set multiple decimals points sum up each power.
 	For example, to set the 0th and 3rd decimal place
 	echo 1001 > /sys/bus/usb/.../decimals
-
-
diff --git a/Documentation/usb/mtouchusb.txt b/Documentation/usb/mtouchusb.txt
index a91adb26ea7b..d1111b74bf75 100644
--- a/Documentation/usb/mtouchusb.txt
+++ b/Documentation/usb/mtouchusb.txt
@@ -1,19 +1,27 @@
-CHANGES
+﻿================
+mtouchusb driver
+================
+
+Changes
+=======
 
 - 0.3 - Created based off of scanner & INSTALL from the original touchscreen
   driver on freecode (http://freecode.com/projects/3mtouchscreendriver)
 - Amended for linux-2.4.18, then 2.4.19
 
 - 0.5 - Complete rewrite using Linux Input in 2.6.3
-   Unfortunately no calibration support at this time
+  Unfortunately no calibration support at this time
 
 - 1.4 - Multiple changes to support the EXII 5000UC and house cleaning
-   Changed reset from standard USB dev reset to vendor reset
-   Changed data sent to host from compensated to raw coordinates
-   Eliminated vendor/product module params
-   Performed multiple successful tests with an EXII-5010UC
+  Changed reset from standard USB dev reset to vendor reset
+  Changed data sent to host from compensated to raw coordinates
+  Eliminated vendor/product module params
+  Performed multiple successful tests with an EXII-5010UC
 
-SUPPORTED HARDWARE:
+Supported Hardware
+==================
+
+::
 
         All controllers have the Vendor: 0x0596 & Product: 0x0001
 
@@ -29,9 +37,10 @@ SUPPORTED HARDWARE:
         USB Capacitive - Black Case     EXII-5030UC
         USB Capacitive - No Case        EXII-5050UC
 
-DRIVER NOTES:
+Driver Notes
+============
 
-Installation is simple, you only need to add Linux Input, Linux USB, and the 
+Installation is simple, you only need to add Linux Input, Linux USB, and the
 driver to the kernel.  The driver can also be optionally built as a module.
 
 This driver appears to be one of possible 2 Linux USB Input Touchscreen
@@ -49,24 +58,27 @@ The controller screen resolution is now 0 to 16384 for both X and Y reporting
 the raw touch data.  This is the same for the old and new capacitive USB
 controllers.
 
-Perhaps at some point an abstract function will be placed into evdev so 
-generic functions like calibrations, resets, and vendor information can be 
+Perhaps at some point an abstract function will be placed into evdev so
+generic functions like calibrations, resets, and vendor information can be
 requested from the userspace (And the drivers would handle the vendor specific
 tasks).
 
-TODO:
+TODO
+====
 
 Implement a control urb again to handle requests to and from the device
 such as calibration, etc once/if it becomes available.
 
-DISCLAIMER:
+Disclaimer
+==========
 
-I am not a MicroTouch/3M employee, nor have I ever been.  3M does not support 
+I am not a MicroTouch/3M employee, nor have I ever been.  3M does not support
 this driver!  If you want touch drivers only supported within X, please go to:
 
 http://www.3m.com/3MTouchSystems/
 
-THANKS:
+Thanks
+======
 
 A huge thank you to 3M Touch Systems for the EXII-5010UC controllers for
 testing!
diff --git a/Documentation/usb/ohci.txt b/Documentation/usb/ohci.txt
index 99320d9fa523..bb3c49719e6b 100644
--- a/Documentation/usb/ohci.txt
+++ b/Documentation/usb/ohci.txt
@@ -1,3 +1,7 @@
+====
+OHCI
+====
+
 23-Aug-2002
 
 The "ohci-hcd" driver is a USB Host Controller Driver (HCD) that is derived
@@ -29,4 +33,3 @@ work on while the OS is getting around to the relevant IRQ processing.
 
 - David Brownell
   <dbrownell@users.sourceforge.net>
-
diff --git a/Documentation/usb/rio.txt b/Documentation/usb/rio.txt
index aee715af7db7..ca9adcf56355 100644
--- a/Documentation/usb/rio.txt
+++ b/Documentation/usb/rio.txt
@@ -1,72 +1,80 @@
+﻿============
+Diamonds Rio
+============
+
 Copyright (C) 1999, 2000 Bruce Tenison
+
 Portions Copyright (C) 1999, 2000 David Nelson
+
 Thanks to David Nelson for guidance and the usage of the scanner.txt
 and scanner.c files to model our driver and this informative file.
 
 Mar. 2, 2000
 
-CHANGES
+Changes
+=======
 
 - Initial Revision
 
 
-OVERVIEW
+Overview
+========
 
 This README will address issues regarding how to configure the kernel
-to access a RIO 500 mp3 player.  
+to access a RIO 500 mp3 player.
 Before I explain how to use this to access the Rio500 please be warned:
 
-W A R N I N G:
---------------
+.. warning::
 
-Please note that this software is still under development.  The authors
-are in no way responsible for any damage that may occur, no matter how
-inconsequential.
+   Please note that this software is still under development.  The authors
+   are in no way responsible for any damage that may occur, no matter how
+   inconsequential.
 
 It seems that the Rio has a problem when sending .mp3 with low batteries.
 I suggest when the batteries are low and you want to transfer stuff that you
 replace it with a fresh one. In my case, what happened is I lost two 16kb
 blocks (they are no longer usable to store information to it). But I don't
-know if that's normal or not; it could simply be a problem with the flash 
+know if that's normal or not; it could simply be a problem with the flash
 memory.
 
-In an extreme case, I left my Rio playing overnight and the batteries wore 
-down to nothing and appear to have corrupted the flash memory. My RIO 
-needed to be replaced as a result.  Diamond tech support is aware of the 
-problem.  Do NOT allow your batteries to wear down to nothing before 
-changing them.  It appears RIO 500 firmware does not handle low battery 
-power well at all. 
+In an extreme case, I left my Rio playing overnight and the batteries wore
+down to nothing and appear to have corrupted the flash memory. My RIO
+needed to be replaced as a result.  Diamond tech support is aware of the
+problem.  Do NOT allow your batteries to wear down to nothing before
+changing them.  It appears RIO 500 firmware does not handle low battery
+power well at all.
 
-On systems with OHCI controllers, the kernel OHCI code appears to have 
-power on problems with some chipsets.  If you are having problems 
-connecting to your RIO 500, try turning it on first and then plugging it 
-into the USB cable.  
+On systems with OHCI controllers, the kernel OHCI code appears to have
+power on problems with some chipsets.  If you are having problems
+connecting to your RIO 500, try turning it on first and then plugging it
+into the USB cable.
 
-Contact information:
---------------------
+Contact Information
+-------------------
 
    The main page for the project is hosted at sourceforge.net in the following
    URL: <http://rio500.sourceforge.net>. You can also go to the project's
    sourceforge home page at: <http://sourceforge.net/projects/rio500/>.
    There is also a mailing list: rio500-users@lists.sourceforge.net
 
-Authors:
+Authors
 -------
 
-Most of the code was written by Cesar Miquel <miquel@df.uba.ar>. Keith 
+Most of the code was written by Cesar Miquel <miquel@df.uba.ar>. Keith
 Clayton <kclayton@jps.net> is incharge of the PPC port and making sure
 things work there. Bruce Tenison <btenison@dibbs.net> is adding support
 for .fon files and also does testing. The program will mostly sure be
 re-written and Pete Ikusz along with the rest will re-design it. I would
-also like to thank Tri Nguyen <tmn_3022000@hotmail.com> who provided use 
+also like to thank Tri Nguyen <tmn_3022000@hotmail.com> who provided use
 with some important information regarding the communication with the Rio.
 
-ADDITIONAL INFORMATION and Userspace tools
+Additional Information and userspace tools
 
-http://rio500.sourceforge.net/
+	http://rio500.sourceforge.net/
 
 
-REQUIREMENTS
+Requirements
+============
 
 A host with a USB port.  Ideally, either a UHCI (Intel) or OHCI
 (Compaq and others) hardware port should work.
@@ -80,11 +88,11 @@ A Linux kernel with RIO 500 support enabled.
 'lspci' which is only needed to determine the type of USB hardware
 available in your machine.
 
-CONFIGURATION
+Configuration
 
 Using `lspci -v`, determine the type of USB hardware available.
 
-  If you see something like:
+  If you see something like::
 
     USB Controller: ......
     Flags: .....
@@ -92,7 +100,7 @@ Using `lspci -v`, determine the type of USB hardware available.
 
   Then you have a UHCI based controller.
 
-  If you see something like:
+  If you see something like::
 
      USB Controller: .....
      Flags: ....
@@ -107,8 +115,9 @@ hardware (determined from the steps above), 'USB Diamond Rio500 support', and
 (you may need to execute `depmod -a` to update the module
 dependencies).
 
-Add a device for the USB rio500:
-  `mknod /dev/usb/rio500 c 180 64`
+Add a device for the USB rio500::
+
+  mknod /dev/usb/rio500 c 180 64
 
 Set appropriate permissions for /dev/usb/rio500 (don't forget about
 group and world permissions).  Both read and write permissions are
@@ -116,12 +125,14 @@ required for proper operation.
 
 Load the appropriate modules (if compiled as modules):
 
-  OHCI:
+  OHCI::
+
     modprobe usbcore
     modprobe usb-ohci
     modprobe rio500
 
-  UHCI:
+  UHCI::
+
     modprobe usbcore
     modprobe usb-uhci  (or uhci)
     modprobe rio500
@@ -129,10 +140,10 @@ Load the appropriate modules (if compiled as modules):
 That's it.  The Rio500 Utils at: http://rio500.sourceforge.net should
 be able to access the rio500.
 
-BUGS
+Bugs
+====
 
 If you encounter any problems feel free to drop me an email.
 
 Bruce Tenison
 btenison@dibbs.net
-
diff --git a/Documentation/usb/usb-help.txt b/Documentation/usb/usb-help.txt
index 4273ca2b86ba..dc23ecd4d802 100644
--- a/Documentation/usb/usb-help.txt
+++ b/Documentation/usb/usb-help.txt
@@ -1,16 +1,17 @@
-usb-help.txt
+==============
+USB references
+==============
+
 2008-Mar-7
 
 For USB help other than the readme files that are located in
-Documentation/usb/*, see the following:
+`Documentation/usb/*`, see the following:
 
-Linux-USB project:  http://www.linux-usb.org
-  mirrors at        http://usb.in.tum.de/linux-usb/
-         and        http://it.linux-usb.org
-Linux USB Guide:    http://linux-usb.sourceforge.net
-Linux-USB device overview (working devices and drivers):
-                    http://www.qbik.ch/usb/devices/
+- Linux-USB project:  http://www.linux-usb.org
+  mirrors at          http://usb.in.tum.de/linux-usb/
+  and                 http://it.linux-usb.org
+- Linux USB Guide:    http://linux-usb.sourceforge.net
+- Linux-USB device overview (working devices and drivers):
+  http://www.qbik.ch/usb/devices/
 
 The Linux-USB mailing list is at linux-usb@vger.kernel.org
-
-###
diff --git a/Documentation/usb/usb-serial.txt b/Documentation/usb/usb-serial.txt
index ab100d6ee436..8fa7dbd3da9a 100644
--- a/Documentation/usb/usb-serial.txt
+++ b/Documentation/usb/usb-serial.txt
@@ -1,4 +1,9 @@
-INTRODUCTION
+﻿==========
+USB serial
+==========
+
+Introduction
+============
 
   The USB serial driver currently supports a number of different USB to
   serial converter products, as well as some devices that use a serial
@@ -8,13 +13,15 @@ INTRODUCTION
   the different devices.
 
 
-CONFIGURATION
+Configuration
+=============
 
   Currently the driver can handle up to 256 different serial interfaces at
-  one time. 
+  one time.
 
     The major number that the driver uses is 188 so to use the driver,
-    create the following nodes:
+    create the following nodes::
+
 	mknod /dev/ttyUSB0 c 188 0
 	mknod /dev/ttyUSB1 c 188 1
 	mknod /dev/ttyUSB2 c 188 2
@@ -28,12 +35,14 @@ CONFIGURATION
   When the device is connected and recognized by the driver, the driver
   will print to the system log, which node(s) the device has been bound
   to.
-  
 
-SPECIFIC DEVICES SUPPORTED
+
+Specific Devices Supported
+==========================
 
 
 ConnectTech WhiteHEAT 4 port converter
+--------------------------------------
 
   ConnectTech has been very forthcoming with information about their
   device, including providing a unit to test with.
@@ -46,6 +55,7 @@ ConnectTech WhiteHEAT 4 port converter
 
 
 HandSpring Visor, Palm USB, and Clié USB driver
+-----------------------------------------------
 
   This driver works with all HandSpring USB, Palm USB, and Sony Clié USB
   devices.
@@ -62,7 +72,7 @@ HandSpring Visor, Palm USB, and Clié USB driver
     This goes against the current documentation for pilot-xfer and other
     packages, but is the only way that it will work due to the hardware
     in the device.
-  
+
   When the device is connected, try talking to it on the second port
   (this is usually /dev/ttyUSB1 if you do not have any other usb-serial
   devices in the system.) The system log should tell you which port is
@@ -78,10 +88,10 @@ HandSpring Visor, Palm USB, and Clié USB driver
   try resetting the device, first a hot reset, and then a cold reset if
   necessary.  Some devices need this before they can talk to the USB port
   properly.
-  
+
   Devices that are not compiled into the kernel can be specified with module
   parameters.  e.g. modprobe visor vendor=0x54c product=0x66
-  
+
   There is a webpage and mailing lists for this portion of the driver at:
   http://sourceforge.net/projects/usbvisor/
 
@@ -90,6 +100,7 @@ HandSpring Visor, Palm USB, and Clié USB driver
 
 
 PocketPC PDA Driver
+-------------------
 
   This driver can be used to connect to Compaq iPAQ, HP Jornada, Casio EM500
   and other PDAs running Windows CE 3.0 or PocketPC 2002 using a USB
@@ -135,12 +146,13 @@ PocketPC PDA Driver
   be used to flash the ROM, as well as the microP code..  so much for needing
   Toshiba's $350 serial cable for flashing!! :D
   NOTE: This has NOT been tested. Use at your own risk.
- 
+
   For any questions or problems with the driver, please contact Ganesh
   Varadarajan <ganesh@veritas.com>
 
 
 Keyspan PDA Serial Adapter
+--------------------------
 
   Single port DB-9 serial adapter, pushed as a PDA adapter for iMacs (mostly
   sold in Macintosh catalogs, comes in a translucent white/green dongle).
@@ -148,32 +160,37 @@ Keyspan PDA Serial Adapter
   This driver also works for the Xircom/Entrega single port serial adapter.
 
   Current status:
+
    Things that work:
-     basic input/output (tested with 'cu')
-     blocking write when serial line can't keep up
-     changing baud rates (up to 115200)
-     getting/setting modem control pins (TIOCM{GET,SET,BIS,BIC})
-     sending break (although duration looks suspect)
+     - basic input/output (tested with 'cu')
+     - blocking write when serial line can't keep up
+     - changing baud rates (up to 115200)
+     - getting/setting modem control pins (TIOCM{GET,SET,BIS,BIC})
+     - sending break (although duration looks suspect)
+
    Things that don't:
-     device strings (as logged by kernel) have trailing binary garbage
-     device ID isn't right, might collide with other Keyspan products
-     changing baud rates ought to flush tx/rx to avoid mangled half characters
+     - device strings (as logged by kernel) have trailing binary garbage
+     - device ID isn't right, might collide with other Keyspan products
+     - changing baud rates ought to flush tx/rx to avoid mangled half characters
+
    Big Things on the todo list:
-     parity, 7 vs 8 bits per char, 1 or 2 stop bits
-     HW flow control
-     not all of the standard USB descriptors are handled: Get_Status, Set_Feature
-     O_NONBLOCK, select()
+     - parity, 7 vs 8 bits per char, 1 or 2 stop bits
+     - HW flow control
+     - not all of the standard USB descriptors are handled:
+       Get_Status, Set_Feature, O_NONBLOCK, select()
 
   For any questions or problems with this driver, please contact Brian
-  Warner at warner@lothar.com 
+  Warner at warner@lothar.com
 
 
 Keyspan USA-series Serial Adapters
+----------------------------------
 
-  Single, Dual and Quad port adapters - driver uses Keyspan supplied 
+  Single, Dual and Quad port adapters - driver uses Keyspan supplied
   firmware and is being developed with their support.
-  
+
   Current status:
+
     The USA-18X, USA-28X, USA-19, USA-19W and USA-49W are supported and
     have been pretty thoroughly tested at various baud rates with 8-N-1
     character settings.  Other character lengths and parity setups are
@@ -182,32 +199,37 @@ Keyspan USA-series Serial Adapters
     The USA-28 isn't yet supported though doing so should be pretty
     straightforward.  Contact the maintainer if you require this
     functionality.
-  
+
   More information is available at:
+
         http://www.carnationsoftware.com/carnation/Keyspan.html
-   
+
   For any questions or problems with this driver, please contact Hugh
   Blemings at hugh@misc.nu
 
 
 FTDI Single Port Serial Driver
+------------------------------
 
   This is a single port DB-25 serial adapter.
 
   Devices supported include:
-                -TripNav TN-200 USB GPS
-                -Navis Engineering Bureau CH-4711 USB GPS
+
+                - TripNav TN-200 USB GPS
+                - Navis Engineering Bureau CH-4711 USB GPS
 
   For any questions or problems with this driver, please contact Bill Ryder.
 
 
 ZyXEL omni.net lcd plus ISDN TA
+-------------------------------
 
   This is an ISDN TA. Please report both successes and troubles to
   azummo@towertech.it
 
 
 Cypress M8 CY4601 Family Serial Driver
+--------------------------------------
 
   This driver was in most part developed by Neil "koyama" Whelchel.  It
   has been improved since that previous form to support dynamic serial
@@ -215,18 +237,19 @@ Cypress M8 CY4601 Family Serial Driver
   part stable and has been tested on an smp machine. (dual p2)
 
     Chipsets supported under CY4601 family:
-	
+
 		CY7C63723, CY7C63742, CY7C63743, CY7C64013
 
     Devices supported:
 
-		-DeLorme's USB Earthmate GPS (SiRF Star II lp arch)
-		-Cypress HID->COM RS232 adapter
-	
-		Note: Cypress Semiconductor claims no affiliation with the
+		- DeLorme's USB Earthmate GPS (SiRF Star II lp arch)
+		- Cypress HID->COM RS232 adapter
+
+		Note:
+			Cypress Semiconductor claims no affiliation with the
 			hid->com device.
 
-	Most devices using chipsets under the CY4601 family should
+     Most devices using chipsets under the CY4601 family should
      work with the driver.  As long as they stay true to the CY4601
      usbserial specification.
 
@@ -236,8 +259,9 @@ Cypress M8 CY4601 Family Serial Driver
 	upon start init to this setting.  usbserial core provides the rest
 	of the termios settings, along with some custom termios so that the
 	output is in proper format and parsable.
-	
-	The device can be put into sirf mode by issuing NMEA command:
+
+	The device can be put into sirf mode by issuing NMEA command::
+
 		$PSRF100,<protocol>,<baud>,<databits>,<stopbits>,<parity>*CHECKSUM
 		$PSRF100,0,9600,8,1,0*0C
 
@@ -259,11 +283,14 @@ Cypress M8 CY4601 Family Serial Driver
 
 	If you have any questions, problems, patches, feature requests, etc. you can
 	contact me here via email:
+
 					dignome@gmail.com
+
 		(your problems/patches can alternately be submitted to usb-devel)
 
 
 Digi AccelePort Driver
+----------------------
 
   This driver supports the Digi AccelePort USB 2 and 4 devices, 2 port
   (plus a parallel port) and 4 port USB serial converters.  The driver
@@ -285,42 +312,49 @@ Digi AccelePort Driver
 
 
 Belkin USB Serial Adapter F5U103
+--------------------------------
 
   Single port DB-9/PS-2 serial adapter from Belkin with firmware by eTEK Labs.
   The Peracom single port serial adapter also works with this driver, as
   well as the GoHubs adapter.
 
   Current status:
+
     The following have been tested and work:
-      Baud rate    300-230400               
-      Data bits    5-8
-      Stop bits    1-2
-      Parity       N,E,O,M,S
-      Handshake    None, Software (XON/XOFF), Hardware (CTSRTS,CTSDTR)*
-      Break        Set and clear
-      Line control Input/Output query and control **
 
-      *  Hardware input flow control is only enabled for firmware
+      - Baud rate    300-230400
+      - Data bits    5-8
+      - Stop bits    1-2
+      - Parity       N,E,O,M,S
+      - Handshake    None, Software (XON/XOFF), Hardware (CTSRTS,CTSDTR) [1]_
+      - Break        Set and clear
+      - Line control Input/Output query and control [2]_
+
+  .. [1]
+         Hardware input flow control is only enabled for firmware
          levels above 2.06.  Read source code comments describing Belkin
          firmware errata.  Hardware output flow control is working for all
          firmware versions.
-      ** Queries of inputs (CTS,DSR,CD,RI) show the last
+
+  .. [2]
+         Queries of inputs (CTS,DSR,CD,RI) show the last
          reported state.  Queries of outputs (DTR,RTS) show the last
          requested state and may not reflect current state as set by
          automatic hardware flow control.
 
   TO DO List:
-    -- Add true modem control line query capability.  Currently tracks the
-       states reported by the interrupt and the states requested.
-    -- Add error reporting back to application for UART error conditions.
-    -- Add support for flush ioctls.
-    -- Add everything else that is missing :)
+    - Add true modem control line query capability.  Currently tracks the
+      states reported by the interrupt and the states requested.
+    - Add error reporting back to application for UART error conditions.
+    - Add support for flush ioctls.
+    - Add everything else that is missing :)
 
   For any questions or problems with this driver, please contact William
   Greathouse at wgreathouse@smva.com
 
 
 Empeg empeg-car Mark I/II Driver
+--------------------------------
 
   This is an experimental driver to provide connectivity support for the
   client synchronization tools for an Empeg empeg-car mp3 player.
@@ -335,6 +369,7 @@ Empeg empeg-car Mark I/II Driver
 
 
 MCT USB Single Port Serial Adapter U232
+---------------------------------------
 
   This driver is for the MCT USB-RS232 Converter (25 pin, Model No.
   U232-P25) from Magic Control Technology Corp. (there is also a 9 pin
@@ -355,35 +390,39 @@ MCT USB Single Port Serial Adapter U232
 
 
 Inside Out Networks Edgeport Driver
+-----------------------------------
 
   This driver supports all devices made by Inside Out Networks, specifically
   the following models:
-       Edgeport/4
-       Rapidport/4
-       Edgeport/4t
-       Edgeport/2
-       Edgeport/4i
-       Edgeport/2i
-       Edgeport/421
-       Edgeport/21
-       Edgeport/8
-       Edgeport/8 Dual
-       Edgeport/2D8
-       Edgeport/4D8
-       Edgeport/8i
-       Edgeport/2 DIN
-       Edgeport/4 DIN
-       Edgeport/16 Dual
+
+       - Edgeport/4
+       - Rapidport/4
+       - Edgeport/4t
+       - Edgeport/2
+       - Edgeport/4i
+       - Edgeport/2i
+       - Edgeport/421
+       - Edgeport/21
+       - Edgeport/8
+       - Edgeport/8 Dual
+       - Edgeport/2D8
+       - Edgeport/4D8
+       - Edgeport/8i
+       - Edgeport/2 DIN
+       - Edgeport/4 DIN
+       - Edgeport/16 Dual
 
   For any questions or problems with this driver, please contact Greg
   Kroah-Hartman at greg@kroah.com
 
 
 REINER SCT cyberJack pinpad/e-com USB chipcard reader
-   
+-----------------------------------------------------
+
   Interface to ISO 7816 compatible contactbased chipcards, e.g. GSM SIMs.
-  
+
   Current status:
+
     This is the kernel part of the driver for this USB card reader.
     There is also a user part for a CT-API driver available. A site
     for downloading is TBA. For now, you can request it from the
@@ -394,6 +433,7 @@ REINER SCT cyberJack pinpad/e-com USB chipcard reader
 
 
 Prolific PL2303 Driver
+----------------------
 
   This driver supports any device that has the PL2303 chip from Prolific
   in it.  This includes a number of single port USB to serial converters,
@@ -403,11 +443,13 @@ Prolific PL2303 Driver
 
   For any questions or problems with this driver, please contact Greg
   Kroah-Hartman at greg@kroah.com
-  
+
 
 KL5KUSB105 chipset / PalmConnect USB single-port adapter
-  
+--------------------------------------------------------
+
 Current status:
+
   The driver was put together by looking at the usb bus transactions
   done by Palm's driver under Windows, so a lot of functionality is
   still missing.  Notably, serial ioctls are sometimes faked or not yet
@@ -417,21 +459,25 @@ Current status:
   are supported, but handshaking (software or hardware) is not, which is
   why it is wise to cut down on the rate used is wise for large
   transfers until this is settled.
-  
+
   See http://www.uuhaus.de/linux/palmconnect.html for up-to-date
   information on this driver.
 
 Winchiphead CH341 Driver
+------------------------
 
   This driver is for the Winchiphead CH341 USB-RS232 Converter. This chip
   also implements an IEEE 1284 parallel port, I2C and SPI, but that is not
   supported by the driver. The protocol was analyzed from the behaviour
   of the Windows driver, no datasheet is available at present.
+
   The manufacturer's website: http://www.winchiphead.com/.
+
   For any questions or problems with this driver, please contact
   frank@kingswood-consulting.co.uk.
 
 Moschip MCS7720, MCS7715 driver
+-------------------------------
 
   These chips are present in devices sold by various manufacturers, such as Syba
   and Cables Unlimited.  There may be others.  The 7720 provides two serial
@@ -449,20 +495,24 @@ Moschip MCS7720, MCS7715 driver
       don't have one of these devices, so I can't say for sure.
 
 Generic Serial driver
+---------------------
 
   If your device is not one of the above listed devices, compatible with
   the above models, you can try out the "generic" interface. This
   interface does not provide any type of control messages sent to the
   device, and does not support any kind of device flow control. All that
   is required of your device is that it has at least one bulk in endpoint,
-  or one bulk out endpoint. 
+  or one bulk out endpoint.
+
+  To enable the generic driver to recognize your device, provide::
 
-  To enable the generic driver to recognize your device, provide
 	echo <vid> <pid> >/sys/bus/usb-serial/drivers/generic/new_id
+
   where the <vid> and <pid> is replaced with the hex representation of your
   device's vendor id and product id.
   If the driver is compiled as a module you can also provide one id when
-  loading the module
+  loading the module::
+
 	insmod usbserial vendor=0x#### product=0x####
 
   This driver has been successfully used to connect to the NetChip USB
@@ -473,7 +523,8 @@ Generic Serial driver
   Kroah-Hartman at greg@kroah.com
 
 
-CONTACT:
+Contact
+=======
 
   If anyone has any problems using these drivers, with any of the above
   specified products, please contact the specific driver's author listed
diff --git a/Documentation/usb/usbip_protocol.txt b/Documentation/usb/usbip_protocol.txt
index c7a0f4c7e7f1..988c832166cd 100644
--- a/Documentation/usb/usbip_protocol.txt
+++ b/Documentation/usb/usbip_protocol.txt
@@ -1,3 +1,7 @@
+===============
+USB/IP protocol
+===============
+
 PRELIMINARY DRAFT, MAY CONTAIN MISTAKES!
 28 Jun 2011
 
@@ -12,6 +16,8 @@ in one or more pieces at the low level transport layer). The server sends back
 the OP_REP_DEVLIST packet which lists the exported USB devices. Finally the
 TCP/IP connection is closed.
 
+::
+
  virtual host controller                                 usb host
       "client"                                           "server"
   (imports USB devices)                             (exports USB devices)
@@ -32,6 +38,8 @@ send two types of packets: the USBIP_CMD_SUBMIT to submit an URB, and
 USBIP_CMD_UNLINK to unlink a previously submitted URB. The answers of the
 server may be USBIP_RET_SUBMIT and USBIP_RET_UNLINK respectively.
 
+::
+
  virtual host controller                                 usb host
       "client"                                           "server"
   (imports USB devices)                             (exports USB devices)
@@ -88,270 +96,316 @@ The fields are in network (big endian) byte order meaning that the most signific
 byte (MSB) is stored at the lowest address.
 
 
-OP_REQ_DEVLIST: Retrieve the list of exported USB devices.
+OP_REQ_DEVLIST:
+	Retrieve the list of exported USB devices.
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0
------------+--------+------------+---------------------------------------------------
- 2         | 2      | 0x8005     | Command code: Retrieve the list of exported USB
-           |        |            |   devices.
------------+--------+------------+---------------------------------------------------
- 4         | 4      | 0x00000000 | Status: unused, shall be set to 0
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
++-----------+--------+------------+---------------------------------------------------+
+| 2         | 2      | 0x8005     | Command code: Retrieve the list of exported USB   |
+|           |        |            | devices.                                          |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      | 0x00000000 | Status: unused, shall be set to 0                 |
++-----------+--------+------------+---------------------------------------------------+
 
-OP_REP_DEVLIST: Reply with the list of exported USB devices.
+OP_REP_DEVLIST:
+	Reply with the list of exported USB devices.
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0.
------------+--------+------------+---------------------------------------------------
- 2         | 2      | 0x0005     | Reply code: The list of exported USB devices.
------------+--------+------------+---------------------------------------------------
- 4         | 4      | 0x00000000 | Status: 0 for OK
------------+--------+------------+---------------------------------------------------
- 8         | 4      | n          | Number of exported devices: 0 means no exported
-           |        |            |   devices.
------------+--------+------------+---------------------------------------------------
- 0x0C      |        |            | From now on the exported n devices are described,
-           |        |            |   if any. If no devices are exported the message
-           |        |            |   ends with the previous "number of exported
-           |        |            |   devices" field.
------------+--------+------------+---------------------------------------------------
-           | 256    |            | path: Path of the device on the host exporting the
-           |        |            |   USB device, string closed with zero byte, e.g.
-           |        |            |   "/sys/devices/pci0000:00/0000:00:1d.1/usb3/3-2"
-           |        |            |   The unused bytes shall be filled with zero
-           |        |            |   bytes.
------------+--------+------------+---------------------------------------------------
- 0x10C     | 32     |            | busid: Bus ID of the exported device, string
-           |        |            |   closed with zero byte, e.g. "3-2". The unused
-           |        |            |   bytes shall be filled with zero bytes.
------------+--------+------------+---------------------------------------------------
- 0x12C     | 4      |            | busnum
------------+--------+------------+---------------------------------------------------
- 0x130     | 4      |            | devnum
------------+--------+------------+---------------------------------------------------
- 0x134     | 4      |            | speed
------------+--------+------------+---------------------------------------------------
- 0x138     | 2      |            | idVendor
------------+--------+------------+---------------------------------------------------
- 0x13A     | 2      |            | idProduct
------------+--------+------------+---------------------------------------------------
- 0x13C     | 2      |            | bcdDevice
------------+--------+------------+---------------------------------------------------
- 0x13E     | 1      |            | bDeviceClass
------------+--------+------------+---------------------------------------------------
- 0x13F     | 1      |            | bDeviceSubClass
------------+--------+------------+---------------------------------------------------
- 0x140     | 1      |            | bDeviceProtocol
------------+--------+------------+---------------------------------------------------
- 0x141     | 1      |            | bConfigurationValue
------------+--------+------------+---------------------------------------------------
- 0x142     | 1      |            | bNumConfigurations
------------+--------+------------+---------------------------------------------------
- 0x143     | 1      |            | bNumInterfaces
------------+--------+------------+---------------------------------------------------
- 0x144     |        | m_0        | From now on each interface is described, all
-           |        |            |   together bNumInterfaces times, with the
-           |        |            |   the following 4 fields:
------------+--------+------------+---------------------------------------------------
-           | 1      |            | bInterfaceClass
------------+--------+------------+---------------------------------------------------
- 0x145     | 1      |            | bInterfaceSubClass
------------+--------+------------+---------------------------------------------------
- 0x146     | 1      |            | bInterfaceProtocol
------------+--------+------------+---------------------------------------------------
- 0x147     | 1      |            | padding byte for alignment, shall be set to zero
------------+--------+------------+---------------------------------------------------
- 0xC +     |        |            | The second exported USB device starts at i=1
- i*0x138 + |        |            | with the busid field.
- m_(i-1)*4 |        |            |
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0.|
++-----------+--------+------------+---------------------------------------------------+
+| 2         | 2      | 0x0005     | Reply code: The list of exported USB devices.     |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      | 0x00000000 | Status: 0 for OK                                  |
++-----------+--------+------------+---------------------------------------------------+
+| 8         | 4      | n          | Number of exported devices: 0 means no exported   |
+|           |        |            | devices.                                          |
++-----------+--------+------------+---------------------------------------------------+
+| 0x0C      |        |            | From now on the exported n devices are described, |
+|           |        |            | if any. If no devices are exported the message    |
+|           |        |            | ends with the previous "number of exported        |
+|           |        |            | devices" field.                                   |
++-----------+--------+------------+---------------------------------------------------+
+|           | 256    |            | path: Path of the device on the host exporting the|
+|           |        |            | USB device, string closed with zero byte, e.g.    |
+|           |        |            | "/sys/devices/pci0000:00/0000:00:1d.1/usb3/3-2"   |
+|           |        |            | The unused bytes shall be filled with zero        |
+|           |        |            | bytes.                                            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x10C     | 32     |            | busid: Bus ID of the exported device, string      |
+|           |        |            | closed with zero byte, e.g. "3-2". The unused     |
+|           |        |            | bytes shall be filled with zero bytes.            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x12C     | 4      |            | busnum                                            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x130     | 4      |            | devnum                                            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x134     | 4      |            | speed                                             |
++-----------+--------+------------+---------------------------------------------------+
+| 0x138     | 2      |            | idVendor                                          |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13A     | 2      |            | idProduct                                         |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13C     | 2      |            | bcdDevice                                         |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13E     | 1      |            | bDeviceClass                                      |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13F     | 1      |            | bDeviceSubClass                                   |
++-----------+--------+------------+---------------------------------------------------+
+| 0x140     | 1      |            | bDeviceProtocol                                   |
++-----------+--------+------------+---------------------------------------------------+
+| 0x141     | 1      |            | bConfigurationValue                               |
++-----------+--------+------------+---------------------------------------------------+
+| 0x142     | 1      |            | bNumConfigurations                                |
++-----------+--------+------------+---------------------------------------------------+
+| 0x143     | 1      |            | bNumInterfaces                                    |
++-----------+--------+------------+---------------------------------------------------+
+| 0x144     |        | m_0        | From now on each interface is described, all      |
+|           |        |            | together bNumInterfaces times, with the           |
+|           |        |            | the following 4 fields:                           |
++-----------+--------+------------+---------------------------------------------------+
+|           | 1      |            | bInterfaceClass                                   |
++-----------+--------+------------+---------------------------------------------------+
+| 0x145     | 1      |            | bInterfaceSubClass                                |
++-----------+--------+------------+---------------------------------------------------+
+| 0x146     | 1      |            | bInterfaceProtocol                                |
++-----------+--------+------------+---------------------------------------------------+
+| 0x147     | 1      |            | padding byte for alignment, shall be set to zero  |
++-----------+--------+------------+---------------------------------------------------+
+| 0xC +     |        |            | The second exported USB device starts at i=1      |
+| i*0x138 + |        |            | with the busid field.                             |
+| m_(i-1)*4 |        |            |                                                   |
++-----------+--------+------------+---------------------------------------------------+
 
-OP_REQ_IMPORT: Request to import (attach) a remote USB device.
+OP_REQ_IMPORT:
+	Request to import (attach) a remote USB device.
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0
------------+--------+------------+---------------------------------------------------
- 2         | 2      | 0x8003     | Command code: import a remote USB device.
------------+--------+------------+---------------------------------------------------
- 4         | 4      | 0x00000000 | Status: unused, shall be set to 0
------------+--------+------------+---------------------------------------------------
- 8         | 32     |            | busid: the busid of the exported device on the
-           |        |            |   remote host. The possible values are taken
-           |        |            |   from the message field OP_REP_DEVLIST.busid.
-           |        |            |   A string closed with zero, the unused bytes
-           |        |            |   shall be filled with zeros.
------------+--------+------------+---------------------------------------------------
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
++-----------+--------+------------+---------------------------------------------------+
+| 2         | 2      | 0x8003     | Command code: import a remote USB device.         |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      | 0x00000000 | Status: unused, shall be set to 0                 |
++-----------+--------+------------+---------------------------------------------------+
+| 8         | 32     |            | busid: the busid of the exported device on the    |
+|           |        |            | remote host. The possible values are taken        |
+|           |        |            | from the message field OP_REP_DEVLIST.busid.      |
+|           |        |            | A string closed with zero, the unused bytes       |
+|           |        |            | shall be filled with zeros.                       |
++-----------+--------+------------+---------------------------------------------------+
 
-OP_REP_IMPORT: Reply to import (attach) a remote USB device.
+OP_REP_IMPORT:
+	Reply to import (attach) a remote USB device.
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0
------------+--------+------------+---------------------------------------------------
- 2         | 2      | 0x0003     | Reply code: Reply to import.
------------+--------+------------+---------------------------------------------------
- 4         | 4      | 0x00000000 | Status: 0 for OK
-           |        |            |         1 for error
------------+--------+------------+---------------------------------------------------
- 8         |        |            | From now on comes the details of the imported
-           |        |            |   device, if the previous status field was OK (0),
-           |        |            |   otherwise the reply ends with the status field.
------------+--------+------------+---------------------------------------------------
-           | 256    |            | path: Path of the device on the host exporting the
-           |        |            |   USB device, string closed with zero byte, e.g.
-           |        |            |   "/sys/devices/pci0000:00/0000:00:1d.1/usb3/3-2"
-           |        |            |   The unused bytes shall be filled with zero
-           |        |            |   bytes.
------------+--------+------------+---------------------------------------------------
- 0x108     | 32     |            | busid: Bus ID of the exported device, string
-           |        |            |   closed with zero byte, e.g. "3-2". The unused
-           |        |            |   bytes shall be filled with zero bytes.
------------+--------+------------+---------------------------------------------------
- 0x128     | 4      |            | busnum
------------+--------+------------+---------------------------------------------------
- 0x12C     | 4      |            | devnum
------------+--------+------------+---------------------------------------------------
- 0x130     | 4      |            | speed
------------+--------+------------+---------------------------------------------------
- 0x134     | 2      |            | idVendor
------------+--------+------------+---------------------------------------------------
- 0x136     | 2      |            | idProduct
------------+--------+------------+---------------------------------------------------
- 0x138     | 2      |            | bcdDevice
------------+--------+------------+---------------------------------------------------
- 0x139     | 1      |            | bDeviceClass
------------+--------+------------+---------------------------------------------------
- 0x13A     | 1      |            | bDeviceSubClass
------------+--------+------------+---------------------------------------------------
- 0x13B     | 1      |            | bDeviceProtocol
------------+--------+------------+---------------------------------------------------
- 0x13C     | 1      |            | bConfigurationValue
------------+--------+------------+---------------------------------------------------
- 0x13D     | 1      |            | bNumConfigurations
------------+--------+------------+---------------------------------------------------
- 0x13E     | 1      |            | bNumInterfaces
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 2      | 0x0100     | Binary-coded decimal USBIP version number: v1.0.0 |
++-----------+--------+------------+---------------------------------------------------+
+| 2         | 2      | 0x0003     | Reply code: Reply to import.                      |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      | 0x00000000 | Status:                                           |
+|           |        |            |                                                   |
+|           |        |            |   - 0 for OK                                      |
+|           |        |            |   - 1 for error                                   |
++-----------+--------+------------+---------------------------------------------------+
+| 8         |        |            | From now on comes the details of the imported     |
+|           |        |            | device, if the previous status field was OK (0),  |
+|           |        |            | otherwise the reply ends with the status field.   |
++-----------+--------+------------+---------------------------------------------------+
+|           | 256    |            | path: Path of the device on the host exporting the|
+|           |        |            | USB device, string closed with zero byte, e.g.    |
+|           |        |            | "/sys/devices/pci0000:00/0000:00:1d.1/usb3/3-2"   |
+|           |        |            | The unused bytes shall be filled with zero        |
+|           |        |            | bytes.                                            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x108     | 32     |            | busid: Bus ID of the exported device, string      |
+|           |        |            | closed with zero byte, e.g. "3-2". The unused     |
+|           |        |            | bytes shall be filled with zero bytes.            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x128     | 4      |            | busnum                                            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x12C     | 4      |            | devnum                                            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x130     | 4      |            | speed                                             |
++-----------+--------+------------+---------------------------------------------------+
+| 0x134     | 2      |            | idVendor                                          |
++-----------+--------+------------+---------------------------------------------------+
+| 0x136     | 2      |            | idProduct                                         |
++-----------+--------+------------+---------------------------------------------------+
+| 0x138     | 2      |            | bcdDevice                                         |
++-----------+--------+------------+---------------------------------------------------+
+| 0x139     | 1      |            | bDeviceClass                                      |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13A     | 1      |            | bDeviceSubClass                                   |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13B     | 1      |            | bDeviceProtocol                                   |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13C     | 1      |            | bConfigurationValue                               |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13D     | 1      |            | bNumConfigurations                                |
++-----------+--------+------------+---------------------------------------------------+
+| 0x13E     | 1      |            | bNumInterfaces                                    |
++-----------+--------+------------+---------------------------------------------------+
 
-USBIP_CMD_SUBMIT: Submit an URB
+USBIP_CMD_SUBMIT:
+	Submit an URB
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 4      | 0x00000001 | command: Submit an URB
------------+--------+------------+---------------------------------------------------
- 4         | 4      |            | seqnum: the sequence number of the URB to submit
------------+--------+------------+---------------------------------------------------
- 8         | 4      |            | devid
------------+--------+------------+---------------------------------------------------
- 0xC       | 4      |            | direction: 0: USBIP_DIR_OUT
-           |        |            |            1: USBIP_DIR_IN
------------+--------+------------+---------------------------------------------------
- 0x10      | 4      |            | ep: endpoint number, possible values are: 0...15
------------+--------+------------+---------------------------------------------------
- 0x14      | 4      |            | transfer_flags: possible values depend on the
-           |        |            |   URB transfer type, see below
------------+--------+------------+---------------------------------------------------
- 0x18      | 4      |            | transfer_buffer_length
------------+--------+------------+---------------------------------------------------
- 0x1C      | 4      |            | start_frame: specify the selected frame to
-           |        |            |   transmit an ISO frame, ignored if URB_ISO_ASAP
-           |        |            |   is specified at transfer_flags
------------+--------+------------+---------------------------------------------------
- 0x20      | 4      |            | number_of_packets: number of ISO packets
------------+--------+------------+---------------------------------------------------
- 0x24      | 4      |            | interval: maximum time for the request on the
-           |        |            |   server-side host controller
------------+--------+------------+---------------------------------------------------
- 0x28      | 8      |            | setup: data bytes for USB setup, filled with
-           |        |            |   zeros if not used
------------+--------+------------+---------------------------------------------------
- 0x30      |        |            | URB data. For ISO transfers the padding between
-           |        |            |   each ISO packets is not transmitted.
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 4      | 0x00000001 | command: Submit an URB                            |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      |            | seqnum: the sequence number of the URB to submit  |
++-----------+--------+------------+---------------------------------------------------+
+| 8         | 4      |            | devid                                             |
++-----------+--------+------------+---------------------------------------------------+
+| 0xC       | 4      |            | direction:                                        |
+|           |        |            |                                                   |
+|           |        |            |    - 0: USBIP_DIR_OUT                             |
+|           |        |            |    - 1: USBIP_DIR_IN                              |
++-----------+--------+------------+---------------------------------------------------+
+| 0x10      | 4      |            | ep: endpoint number, possible values are: 0...15  |
++-----------+--------+------------+---------------------------------------------------+
+| 0x14      | 4      |            | transfer_flags: possible values depend on the     |
+|           |        |            | URB transfer type, see below                      |
++-----------+--------+------------+---------------------------------------------------+
+| 0x18      | 4      |            | transfer_buffer_length                            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x1C      | 4      |            | start_frame: specify the selected frame to        |
+|           |        |            | transmit an ISO frame, ignored if URB_ISO_ASAP    |
+|           |        |            | is specified at transfer_flags                    |
++-----------+--------+------------+---------------------------------------------------+
+| 0x20      | 4      |            | number_of_packets: number of ISO packets          |
++-----------+--------+------------+---------------------------------------------------+
+| 0x24      | 4      |            | interval: maximum time for the request on the     |
+|           |        |            | server-side host controller                       |
++-----------+--------+------------+---------------------------------------------------+
+| 0x28      | 8      |            | setup: data bytes for USB setup, filled with      |
+|           |        |            | zeros if not used                                 |
++-----------+--------+------------+---------------------------------------------------+
+| 0x30      |        |            | URB data. For ISO transfers the padding between   |
+|           |        |            | each ISO packets is not transmitted.              |
++-----------+--------+------------+---------------------------------------------------+
 
 
-  Allowed transfer_flags  | value      | control | interrupt | bulk     | isochronous
- -------------------------+------------+---------+-----------+----------+-------------
-  URB_SHORT_NOT_OK        | 0x00000001 | only in | only in   | only in  | no
-  URB_ISO_ASAP            | 0x00000002 | no      | no        | no       | yes
-  URB_NO_TRANSFER_DMA_MAP | 0x00000004 | yes     | yes       | yes      | yes
-  URB_ZERO_PACKET         | 0x00000040 | no      | no        | only out | no
-  URB_NO_INTERRUPT        | 0x00000080 | yes     | yes       | yes      | yes
-  URB_FREE_BUFFER         | 0x00000100 | yes     | yes       | yes      | yes
-  URB_DIR_MASK            | 0x00000200 | yes     | yes       | yes      | yes
+ +-------------------------+------------+---------+-----------+----------+-------------+
+ | Allowed transfer_flags  | value      | control | interrupt | bulk     | isochronous |
+ +=========================+============+=========+===========+==========+=============+
+ | URB_SHORT_NOT_OK        | 0x00000001 | only in | only in   | only in  | no          |
+ +-------------------------+------------+---------+-----------+----------+-------------+
+ | URB_ISO_ASAP            | 0x00000002 | no      | no        | no       | yes         |
+ +-------------------------+------------+---------+-----------+----------+-------------+
+ | URB_NO_TRANSFER_DMA_MAP | 0x00000004 | yes     | yes       | yes      | yes         |
+ +-------------------------+------------+---------+-----------+----------+-------------+
+ | URB_ZERO_PACKET         | 0x00000040 | no      | no        | only out | no          |
+ +-------------------------+------------+---------+-----------+----------+-------------+
+ | URB_NO_INTERRUPT        | 0x00000080 | yes     | yes       | yes      | yes         |
+ +-------------------------+------------+---------+-----------+----------+-------------+
+ | URB_FREE_BUFFER         | 0x00000100 | yes     | yes       | yes      | yes         |
+ +-------------------------+------------+---------+-----------+----------+-------------+
+ | URB_DIR_MASK            | 0x00000200 | yes     | yes       | yes      | yes         |
+ +-------------------------+------------+---------+-----------+----------+-------------+
 
 
-USBIP_RET_SUBMIT: Reply for submitting an URB
+USBIP_RET_SUBMIT:
+	Reply for submitting an URB
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 4      | 0x00000003 | command
------------+--------+------------+---------------------------------------------------
- 4         | 4      |            | seqnum: URB sequence number
------------+--------+------------+---------------------------------------------------
- 8         | 4      |            | devid
------------+--------+------------+---------------------------------------------------
- 0xC       | 4      |            | direction: 0: USBIP_DIR_OUT
-           |        |            |            1: USBIP_DIR_IN
------------+--------+------------+---------------------------------------------------
- 0x10      | 4      |            | ep: endpoint number
------------+--------+------------+---------------------------------------------------
- 0x14      | 4      |            | status: zero for successful URB transaction,
-           |        |            |   otherwise some kind of error happened.
------------+--------+------------+---------------------------------------------------
- 0x18      | 4      | n          | actual_length: number of URB data bytes
------------+--------+------------+---------------------------------------------------
- 0x1C      | 4      |            | start_frame: for an ISO frame the actually
-           |        |            |   selected frame for transmit.
------------+--------+------------+---------------------------------------------------
- 0x20      | 4      |            | number_of_packets
------------+--------+------------+---------------------------------------------------
- 0x24      | 4      |            | error_count
------------+--------+------------+---------------------------------------------------
- 0x28      | 8      |            | setup: data bytes for USB setup, filled with
-           |        |            |   zeros if not used
------------+--------+------------+---------------------------------------------------
- 0x30      | n      |            | URB data bytes. For ISO transfers the padding
-           |        |            |   between each ISO packets is not transmitted.
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 4      | 0x00000003 | command                                           |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      |            | seqnum: URB sequence number                       |
++-----------+--------+------------+---------------------------------------------------+
+| 8         | 4      |            | devid                                             |
++-----------+--------+------------+---------------------------------------------------+
+| 0xC       | 4      |            | direction:                                        |
+|           |        |            |                                                   |
+|           |        |            |    - 0: USBIP_DIR_OUT                             |
+|           |        |            |    - 1: USBIP_DIR_IN                              |
++-----------+--------+------------+---------------------------------------------------+
+| 0x10      | 4      |            | ep: endpoint number                               |
++-----------+--------+------------+---------------------------------------------------+
+| 0x14      | 4      |            | status: zero for successful URB transaction,      |
+|           |        |            | otherwise some kind of error happened.            |
++-----------+--------+------------+---------------------------------------------------+
+| 0x18      | 4      | n          | actual_length: number of URB data bytes           |
++-----------+--------+------------+---------------------------------------------------+
+| 0x1C      | 4      |            | start_frame: for an ISO frame the actually        |
+|           |        |            | selected frame for transmit.                      |
++-----------+--------+------------+---------------------------------------------------+
+| 0x20      | 4      |            | number_of_packets                                 |
++-----------+--------+------------+---------------------------------------------------+
+| 0x24      | 4      |            | error_count                                       |
++-----------+--------+------------+---------------------------------------------------+
+| 0x28      | 8      |            | setup: data bytes for USB setup, filled with      |
+|           |        |            | zeros if not used                                 |
++-----------+--------+------------+---------------------------------------------------+
+| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
+|           |        |            | between each ISO packets is not transmitted.      |
++-----------+--------+------------+---------------------------------------------------+
 
-USBIP_CMD_UNLINK: Unlink an URB
+USBIP_CMD_UNLINK:
+	Unlink an URB
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 4      | 0x00000002 | command: URB unlink command
------------+--------+------------+---------------------------------------------------
- 4         | 4      |            | seqnum: URB sequence number to unlink: FIXME: is this so?
------------+--------+------------+---------------------------------------------------
- 8         | 4      |            | devid
------------+--------+------------+---------------------------------------------------
- 0xC       | 4      |            | direction: 0: USBIP_DIR_OUT
-           |        |            |            1: USBIP_DIR_IN
------------+--------+------------+---------------------------------------------------
- 0x10      | 4      |            | ep: endpoint number: zero
------------+--------+------------+---------------------------------------------------
- 0x14      | 4      |            | seqnum: the URB sequence number given previously
-           |        |            |   at USBIP_CMD_SUBMIT.seqnum field
------------+--------+------------+---------------------------------------------------
- 0x30      | n      |            | URB data bytes. For ISO transfers the padding
-           |        |            |   between each ISO packets is not transmitted.
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 4      | 0x00000002 | command: URB unlink command                       |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      |            | seqnum: URB sequence number to unlink:            |
+|           |        |            |                                                   |
+|           |        |            | FIXME:                                            |
+|           |        |            |    is this so?                                    |
++-----------+--------+------------+---------------------------------------------------+
+| 8         | 4      |            | devid                                             |
++-----------+--------+------------+---------------------------------------------------+
+| 0xC       | 4      |            | direction:                                        |
+|           |        |            |                                                   |
+|           |        |            |    - 0: USBIP_DIR_OUT                             |
+|           |        |            |    - 1: USBIP_DIR_IN                              |
++-----------+--------+------------+---------------------------------------------------+
+| 0x10      | 4      |            | ep: endpoint number: zero                         |
++-----------+--------+------------+---------------------------------------------------+
+| 0x14      | 4      |            | seqnum: the URB sequence number given previously  |
+|           |        |            | at USBIP_CMD_SUBMIT.seqnum field                  |
++-----------+--------+------------+---------------------------------------------------+
+| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
+|           |        |            | between each ISO packets is not transmitted.      |
++-----------+--------+------------+---------------------------------------------------+
 
-USBIP_RET_UNLINK: Reply for URB unlink
+USBIP_RET_UNLINK:
+	Reply for URB unlink
 
- Offset    | Length | Value      | Description
------------+--------+------------+---------------------------------------------------
- 0         | 4      | 0x00000004 | command: reply for the URB unlink command
------------+--------+------------+---------------------------------------------------
- 4         | 4      |            | seqnum: the unlinked URB sequence number
------------+--------+------------+---------------------------------------------------
- 8         | 4      |            | devid
------------+--------+------------+---------------------------------------------------
- 0xC       | 4      |            | direction: 0: USBIP_DIR_OUT
-           |        |            |            1: USBIP_DIR_IN
------------+--------+------------+---------------------------------------------------
- 0x10      | 4      |            | ep: endpoint number
------------+--------+------------+---------------------------------------------------
- 0x14      | 4      |            | status: This is the value contained in the
-           |        |            |   urb->status in the URB completition handler.
-           |        |            |   FIXME: a better explanation needed.
------------+--------+------------+---------------------------------------------------
- 0x30      | n      |            | URB data bytes. For ISO transfers the padding
-           |        |            |   between each ISO packets is not transmitted.
++-----------+--------+------------+---------------------------------------------------+
+| Offset    | Length | Value      | Description                                       |
++===========+========+============+===================================================+
+| 0         | 4      | 0x00000004 | command: reply for the URB unlink command         |
++-----------+--------+------------+---------------------------------------------------+
+| 4         | 4      |            | seqnum: the unlinked URB sequence number          |
++-----------+--------+------------+---------------------------------------------------+
+| 8         | 4      |            | devid                                             |
++-----------+--------+------------+---------------------------------------------------+
+| 0xC       | 4      |            | direction:                                        |
+|           |        |            |                                                   |
+|           |        |            |    - 0: USBIP_DIR_OUT                             |
+|           |        |            |    - 1: USBIP_DIR_IN                              |
++-----------+--------+------------+---------------------------------------------------+
+| 0x10      | 4      |            | ep: endpoint number                               |
++-----------+--------+------------+---------------------------------------------------+
+| 0x14      | 4      |            | status: This is the value contained in the        |
+|           |        |            | urb->status in the URB completition handler.      |
+|           |        |            |                                                   |
+|           |        |            | FIXME:                                            |
+|           |        |            |      a better explanation needed.                 |
++-----------+--------+------------+---------------------------------------------------+
+| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
+|           |        |            | between each ISO packets is not transmitted.      |
++-----------+--------+------------+---------------------------------------------------+
diff --git a/Documentation/usb/usbmon.txt b/Documentation/usb/usbmon.txt
index 28425f736756..b0bd51080799 100644
--- a/Documentation/usb/usbmon.txt
+++ b/Documentation/usb/usbmon.txt
@@ -1,4 +1,9 @@
-* Introduction
+======
+usbmon
+======
+
+Introduction
+============
 
 The name "usbmon" in lowercase refers to a facility in kernel which is
 used to collect traces of I/O on the USB bus. This function is analogous
@@ -16,7 +21,8 @@ Two APIs are currently implemented: "text" and "binary". The binary API
 is available through a character device in /dev namespace and is an ABI.
 The text API is deprecated since 2.6.35, but available for convenience.
 
-* How to use usbmon to collect raw text traces
+How to use usbmon to collect raw text traces
+============================================
 
 Unlike the packet socket, usbmon has an interface which provides traces
 in a text format. This is used for two purposes. First, it serves as a
@@ -26,38 +32,41 @@ are finalized. Second, humans can read it in case tools are not available.
 To collect a raw text trace, execute following steps.
 
 1. Prepare
+----------
 
 Mount debugfs (it has to be enabled in your kernel configuration), and
 load the usbmon module (if built as module). The second step is skipped
-if usbmon is built into the kernel.
+if usbmon is built into the kernel::
 
-# mount -t debugfs none_debugs /sys/kernel/debug
-# modprobe usbmon
-#
+	# mount -t debugfs none_debugs /sys/kernel/debug
+	# modprobe usbmon
+	#
 
-Verify that bus sockets are present.
+Verify that bus sockets are present:
 
-# ls /sys/kernel/debug/usb/usbmon
-0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
-#
+	# ls /sys/kernel/debug/usb/usbmon
+	0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
+	#
 
 Now you can choose to either use the socket '0u' (to capture packets on all
 buses), and skip to step #3, or find the bus used by your device with step #2.
 This allows to filter away annoying devices that talk continuously.
 
 2. Find which bus connects to the desired device
+------------------------------------------------
 
 Run "cat /sys/kernel/debug/usb/devices", and find the T-line which corresponds
 to the device. Usually you do it by looking for the vendor string. If you have
 many similar devices, unplug one and compare the two
 /sys/kernel/debug/usb/devices outputs. The T-line will have a bus number.
-Example:
 
-T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
-D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
-P:  Vendor=0557 ProdID=2004 Rev= 1.00
-S:  Manufacturer=ATEN
-S:  Product=UC100KM V2.00
+Example::
+
+  T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
+  D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
+  P:  Vendor=0557 ProdID=2004 Rev= 1.00
+  S:  Manufacturer=ATEN
+  S:  Product=UC100KM V2.00
 
 "Bus=03" means it's bus 3. Alternatively, you can look at the output from
 "lsusb" and get the bus number from the appropriate line. Example:
@@ -65,23 +74,28 @@ S:  Product=UC100KM V2.00
 Bus 003 Device 002: ID 0557:2004 ATEN UC100KM V2.00
 
 3. Start 'cat'
+--------------
 
-# cat /sys/kernel/debug/usb/usbmon/3u > /tmp/1.mon.out
+::
 
-to listen on a single bus, otherwise, to listen on all buses, type:
+	# cat /sys/kernel/debug/usb/usbmon/3u > /tmp/1.mon.out
 
-# cat /sys/kernel/debug/usb/usbmon/0u > /tmp/1.mon.out
+to listen on a single bus, otherwise, to listen on all buses, type::
+
+	# cat /sys/kernel/debug/usb/usbmon/0u > /tmp/1.mon.out
 
 This process will read until it is killed. Naturally, the output can be
 redirected to a desirable location. This is preferred, because it is going
 to be quite long.
 
 4. Perform the desired operation on the USB bus
+-----------------------------------------------
 
 This is where you do something that creates the traffic: plug in a flash key,
 copy files, control a webcam, etc.
 
 5. Kill cat
+-----------
 
 Usually it's done with a keyboard interrupt (Control-C).
 
@@ -89,7 +103,8 @@ At this point the output file (/tmp/1.mon.out in this example) can be saved,
 sent by e-mail, or inspected with a text editor. In the last case make sure
 that the file size is not excessive for your favourite editor.
 
-* Raw text data format
+Raw text data format
+====================
 
 Two formats are supported currently: the original, or '1t' format, and
 the '1u' format. The '1t' format is deprecated in kernel 2.6.21. The '1u'
@@ -122,10 +137,14 @@ Here is the list of words, from left to right:
 - "Address" word (formerly a "pipe"). It consists of four fields, separated by
   colons: URB type and direction, Bus number, Device address, Endpoint number.
   Type and direction are encoded with two bytes in the following manner:
+
+    == ==   =============================
     Ci Co   Control input and output
     Zi Zo   Isochronous input and output
     Ii Io   Interrupt input and output
     Bi Bo   Bulk input and output
+    == ==   =============================
+
   Bus number, Device address, and Endpoint are decimal numbers, but they may
   have leading zeros, for the sake of human readers.
 
@@ -178,24 +197,25 @@ Here is the list of words, from left to right:
 
 Examples:
 
-An input control transfer to get a port status.
+An input control transfer to get a port status::
 
-d5ea89a0 3575914555 S Ci:1:001:0 s a3 00 0000 0003 0004 4 <
-d5ea89a0 3575914560 C Ci:1:001:0 0 4 = 01050000
+  d5ea89a0 3575914555 S Ci:1:001:0 s a3 00 0000 0003 0004 4 <
+  d5ea89a0 3575914560 C Ci:1:001:0 0 4 = 01050000
 
 An output bulk transfer to send a SCSI command 0x28 (READ_10) in a 31-byte
-Bulk wrapper to a storage device at address 5:
+Bulk wrapper to a storage device at address 5::
 
-dd65f0e8 4128379752 S Bo:1:005:2 -115 31 = 55534243 ad000000 00800000 80010a28 20000000 20000040 00000000 000000
-dd65f0e8 4128379808 C Bo:1:005:2 0 31 >
+  dd65f0e8 4128379752 S Bo:1:005:2 -115 31 = 55534243 ad000000 00800000 80010a28 20000000 20000040 00000000 000000
+  dd65f0e8 4128379808 C Bo:1:005:2 0 31 >
 
-* Raw binary format and API
+Raw binary format and API
+=========================
 
 The overall architecture of the API is about the same as the one above,
 only the events are delivered in binary format. Each event is sent in
-the following structure (its name is made up, so that we can refer to it):
+the following structure (its name is made up, so that we can refer to it)::
 
-struct usbmon_packet {
+  struct usbmon_packet {
 	u64 id;			/*  0: URB ID - from submission to callback */
 	unsigned char type;	/*  8: Same as text; extensible. */
 	unsigned char xfer_type; /*    ISO (0), Intr, Control, Bulk (3) */
@@ -220,7 +240,7 @@ struct usbmon_packet {
 	int start_frame;	/* 52: For ISO */
 	unsigned int xfer_flags; /* 56: copy of URB's transfer_flags */
 	unsigned int ndesc;	/* 60: Actual number of ISO descriptors */
-};				/* 64 total length */
+  };				/* 64 total length */
 
 These events can be received from a character device by reading with read(2),
 with an ioctl(2), or by accessing the buffer with mmap. However, read(2)
@@ -244,12 +264,12 @@ no events are available.
 
  MON_IOCG_STATS, defined as _IOR(MON_IOC_MAGIC, 3, struct mon_bin_stats)
 
-The argument is a pointer to the following structure:
+The argument is a pointer to the following structure::
 
-struct mon_bin_stats {
+  struct mon_bin_stats {
 	u32 queued;
 	u32 dropped;
-};
+  };
 
 The member "queued" refers to the number of events currently queued in the
 buffer (and not to the number of events processed since the last reset).
@@ -273,13 +293,13 @@ This call returns the current size of the buffer in bytes.
 
 These calls wait for events to arrive if none were in the kernel buffer,
 then return the first event. The argument is a pointer to the following
-structure:
+structure::
 
-struct mon_get_arg {
+  struct mon_get_arg {
 	struct usbmon_packet *hdr;
 	void *data;
 	size_t alloc;		/* Length of data (can be zero) */
-};
+  };
 
 Before the call, hdr, data, and alloc should be filled. Upon return, the area
 pointed by hdr contains the next event structure, and the data buffer contains
@@ -290,13 +310,13 @@ The MON_IOCX_GET copies 48 bytes to hdr area, MON_IOCX_GETX copies 64 bytes.
  MON_IOCX_MFETCH, defined as _IOWR(MON_IOC_MAGIC, 7, struct mon_mfetch_arg)
 
 This ioctl is primarily used when the application accesses the buffer
-with mmap(2). Its argument is a pointer to the following structure:
+with mmap(2). Its argument is a pointer to the following structure::
 
-struct mon_mfetch_arg {
+  struct mon_mfetch_arg {
 	uint32_t *offvec;	/* Vector of events fetched */
 	uint32_t nfetch;	/* Number of events to fetch (out: fetched) */
 	uint32_t nflush;	/* Number of events to flush */
-};
+  };
 
 The ioctl operates in 3 stages.
 
@@ -329,7 +349,7 @@ be polled with select(2) and poll(2). But lseek(2) does not work.
 The basic idea is simple:
 
 To prepare, map the buffer by getting the current size, then using mmap(2).
-Then, execute a loop similar to the one written in pseudo-code below:
+Then, execute a loop similar to the one written in pseudo-code below::
 
    struct mon_mfetch_arg fetch;
    struct usbmon_packet *hdr;
-- 
2.20.1

