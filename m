Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C67C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC972166E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891965;
	bh=twsA5qtEjmBgR7PQdifZZ065wTy0pDAa/Lk/ID8SnFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EXDVfGhPB5l2f3Wh8qUMkT2TUU7LeFBW8c394nxBCXIUrVFB2aRBcvFwquiyn/KFI
	 rJyqchm7437RLelPxn8lKutx2tFoEA7H9YpeCEoOiMFVDKxtw1qIZxmQaqo6FNOwQo
	 M7Twb0ZmL612Una/pibllII8gzjknvRKDyZcOlzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfFRVGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:06:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbfFRVGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dcxf7zwOHu3l7RO//1d7a3XSJTm3UME8I19tl0QnMeA=; b=fyVuvuOiBPFbAq2oLDnTbiPd2N
        i/xvJzrZS6IB3adrs0C0PFv9KT1Ois0Rd5gsCeQmfpH0UlHjRToz0nb5n0i4ar9kNXRP+zYfd2IOv
        SuGmy654YswOpsw8z115Rs9LL8jvQuwKeWavHnQYlAxMb3xHmqQ+bny1VZQRDc9+SNwA3+rb7ij+7
        XZiaZqDonOWK0UxdsT0VSRmi2xi35+K059kPCsu7i8l1cSK1DyjGK1x4+ixnxb7p71L8YPutP4MoR
        L+gkxXIUW/att93iINsR5AHEZa1IHYsfGgvUkyDQWVxT3CfxkaBVytENVfZZTq6zk1vilzM9Mb/lb
        +1GR5V1w==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIm-00079V-9W; Tue, 18 Jun 2019 21:06:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIa-0002Ci-0k; Tue, 18 Jun 2019 18:05:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 14/22] docs: usb: rename files to .rst and add them to drivers-api
Date:   Tue, 18 Jun 2019 18:05:38 -0300
Message-Id: <c05aecb424e4f835e3f7872ecb5818e1d2f3267c.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While there are a mix of things here, most of the stuff
were written from Kernel developer's PoV. So, add them to
the driver-api book.

A follow up for this patch would be to move documents from
there that are specific to sysadmins, adding them to the
admin-guide.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst                       |  1 +
 Documentation/usb/{acm.txt => acm.rst}        |  0
 .../{authorization.txt => authorization.rst}  |  0
 .../usb/{chipidea.txt => chipidea.rst}        |  0
 Documentation/usb/{dwc3.txt => dwc3.rst}      |  0
 Documentation/usb/{ehci.txt => ehci.rst}      |  0
 .../usb/{functionfs.txt => functionfs.rst}    |  0
 ...{gadget-testing.txt => gadget-testing.rst} |  4 +-
 ...adget_configfs.txt => gadget_configfs.rst} |  0
 .../usb/{gadget_hid.txt => gadget_hid.rst}    |  0
 .../{gadget_multi.txt => gadget_multi.rst}    |  0
 ...{gadget_printer.txt => gadget_printer.rst} |  0
 .../{gadget_serial.txt => gadget_serial.rst}  |  0
 Documentation/usb/index.rst                   | 39 +++++++++++++++++++
 .../usb/{iuu_phoenix.txt => iuu_phoenix.rst}  |  0
 .../{mass-storage.txt => mass-storage.rst}    |  0
 ...{misc_usbsevseg.txt => misc_usbsevseg.rst} |  0
 .../usb/{mtouchusb.txt => mtouchusb.rst}      |  0
 Documentation/usb/{ohci.txt => ohci.rst}      |  0
 Documentation/usb/{rio.txt => rio.rst}        |  0
 Documentation/usb/text_files.rst              | 29 ++++++++++++++
 .../usb/{usb-help.txt => usb-help.rst}        |  0
 .../usb/{usb-serial.txt => usb-serial.rst}    |  0
 ...{usbip_protocol.txt => usbip_protocol.rst} |  0
 Documentation/usb/{usbmon.txt => usbmon.rst}  |  0
 ...-overview.txt => wusb-design-overview.rst} |  0
 MAINTAINERS                                   | 12 +++---
 drivers/usb/Kconfig                           |  2 +-
 drivers/usb/class/Kconfig                     |  2 +-
 drivers/usb/gadget/Kconfig                    |  6 +--
 drivers/usb/gadget/function/f_mass_storage.c  |  2 +-
 drivers/usb/gadget/legacy/Kconfig             |  6 +--
 drivers/usb/host/Kconfig                      |  2 +-
 drivers/usb/misc/Kconfig                      |  2 +-
 drivers/usb/mon/Kconfig                       |  2 +-
 drivers/usb/serial/Kconfig                    | 10 ++---
 drivers/usb/serial/belkin_sa.c                |  2 +-
 drivers/usb/serial/belkin_sa.h                |  2 +-
 drivers/usb/serial/cypress_m8.c               |  2 +-
 drivers/usb/serial/empeg.c                    |  2 +-
 drivers/usb/serial/ftdi_sio.c                 |  2 +-
 drivers/usb/serial/ir-usb.c                   |  2 +-
 drivers/usb/serial/keyspan_pda.c              |  2 +-
 drivers/usb/serial/omninet.c                  |  2 +-
 drivers/usb/serial/oti6858.c                  |  2 +-
 drivers/usb/serial/pl2303.c                   |  2 +-
 drivers/usb/serial/usb-serial.c               |  2 +-
 drivers/usb/serial/visor.c                    |  2 +-
 drivers/usb/serial/visor.h                    |  2 +-
 drivers/usb/serial/whiteheat.c                |  2 +-
 drivers/usb/serial/whiteheat.h                |  2 +-
 51 files changed, 109 insertions(+), 40 deletions(-)
 rename Documentation/usb/{acm.txt => acm.rst} (100%)
 rename Documentation/usb/{authorization.txt => authorization.rst} (100%)
 rename Documentation/usb/{chipidea.txt => chipidea.rst} (100%)
 rename Documentation/usb/{dwc3.txt => dwc3.rst} (100%)
 rename Documentation/usb/{ehci.txt => ehci.rst} (100%)
 rename Documentation/usb/{functionfs.txt => functionfs.rst} (100%)
 rename Documentation/usb/{gadget-testing.txt => gadget-testing.rst} (99%)
 rename Documentation/usb/{gadget_configfs.txt => gadget_configfs.rst} (100%)
 rename Documentation/usb/{gadget_hid.txt => gadget_hid.rst} (100%)
 rename Documentation/usb/{gadget_multi.txt => gadget_multi.rst} (100%)
 rename Documentation/usb/{gadget_printer.txt => gadget_printer.rst} (100%)
 rename Documentation/usb/{gadget_serial.txt => gadget_serial.rst} (100%)
 create mode 100644 Documentation/usb/index.rst
 rename Documentation/usb/{iuu_phoenix.txt => iuu_phoenix.rst} (100%)
 rename Documentation/usb/{mass-storage.txt => mass-storage.rst} (100%)
 rename Documentation/usb/{misc_usbsevseg.txt => misc_usbsevseg.rst} (100%)
 rename Documentation/usb/{mtouchusb.txt => mtouchusb.rst} (100%)
 rename Documentation/usb/{ohci.txt => ohci.rst} (100%)
 rename Documentation/usb/{rio.txt => rio.rst} (100%)
 create mode 100644 Documentation/usb/text_files.rst
 rename Documentation/usb/{usb-help.txt => usb-help.rst} (100%)
 rename Documentation/usb/{usb-serial.txt => usb-serial.rst} (100%)
 rename Documentation/usb/{usbip_protocol.txt => usbip_protocol.rst} (100%)
 rename Documentation/usb/{usbmon.txt => usbmon.rst} (100%)
 rename Documentation/usb/{WUSB-Design-overview.txt => wusb-design-overview.rst} (100%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index a57d975e969a..2f9bf37b8989 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -103,6 +103,7 @@ needed).
    vm/index
    bpf/index
    PCI/index
+   usb/index
    misc-devices/index
 
 Architecture-specific documentation
diff --git a/Documentation/usb/acm.txt b/Documentation/usb/acm.rst
similarity index 100%
rename from Documentation/usb/acm.txt
rename to Documentation/usb/acm.rst
diff --git a/Documentation/usb/authorization.txt b/Documentation/usb/authorization.rst
similarity index 100%
rename from Documentation/usb/authorization.txt
rename to Documentation/usb/authorization.rst
diff --git a/Documentation/usb/chipidea.txt b/Documentation/usb/chipidea.rst
similarity index 100%
rename from Documentation/usb/chipidea.txt
rename to Documentation/usb/chipidea.rst
diff --git a/Documentation/usb/dwc3.txt b/Documentation/usb/dwc3.rst
similarity index 100%
rename from Documentation/usb/dwc3.txt
rename to Documentation/usb/dwc3.rst
diff --git a/Documentation/usb/ehci.txt b/Documentation/usb/ehci.rst
similarity index 100%
rename from Documentation/usb/ehci.txt
rename to Documentation/usb/ehci.rst
diff --git a/Documentation/usb/functionfs.txt b/Documentation/usb/functionfs.rst
similarity index 100%
rename from Documentation/usb/functionfs.txt
rename to Documentation/usb/functionfs.rst
diff --git a/Documentation/usb/gadget-testing.txt b/Documentation/usb/gadget-testing.rst
similarity index 99%
rename from Documentation/usb/gadget-testing.txt
rename to Documentation/usb/gadget-testing.rst
index 7d7f2340af42..2eeb3e9299e4 100644
--- a/Documentation/usb/gadget-testing.txt
+++ b/Documentation/usb/gadget-testing.rst
@@ -254,7 +254,7 @@ Device:
 - connect the gadget to a host, preferably not the one used
   to control the gadget
 - run a program which writes to /dev/hidg<N>, e.g.
-  a userspace program found in Documentation/usb/gadget_hid.txt::
+  a userspace program found in Documentation/usb/gadget_hid.rst::
 
 	$ ./hid_gadget_test /dev/hidg0 keyboard
 
@@ -886,7 +886,7 @@ host::
 	# cat /dev/usb/lp0
 
 More advanced testing can be done with the prn_example
-described in Documentation/usb/gadget_printer.txt.
+described in Documentation/usb/gadget_printer.rst.
 
 
 20. UAC1 function (virtual ALSA card, using u_audio API)
diff --git a/Documentation/usb/gadget_configfs.txt b/Documentation/usb/gadget_configfs.rst
similarity index 100%
rename from Documentation/usb/gadget_configfs.txt
rename to Documentation/usb/gadget_configfs.rst
diff --git a/Documentation/usb/gadget_hid.txt b/Documentation/usb/gadget_hid.rst
similarity index 100%
rename from Documentation/usb/gadget_hid.txt
rename to Documentation/usb/gadget_hid.rst
diff --git a/Documentation/usb/gadget_multi.txt b/Documentation/usb/gadget_multi.rst
similarity index 100%
rename from Documentation/usb/gadget_multi.txt
rename to Documentation/usb/gadget_multi.rst
diff --git a/Documentation/usb/gadget_printer.txt b/Documentation/usb/gadget_printer.rst
similarity index 100%
rename from Documentation/usb/gadget_printer.txt
rename to Documentation/usb/gadget_printer.rst
diff --git a/Documentation/usb/gadget_serial.txt b/Documentation/usb/gadget_serial.rst
similarity index 100%
rename from Documentation/usb/gadget_serial.txt
rename to Documentation/usb/gadget_serial.rst
diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
new file mode 100644
index 000000000000..e55386a4abfb
--- /dev/null
+++ b/Documentation/usb/index.rst
@@ -0,0 +1,39 @@
+===========
+USB support
+===========
+
+.. toctree::
+    :maxdepth: 1
+
+    acm
+    authorization
+    chipidea
+    dwc3
+    ehci
+    functionfs
+    gadget_configfs
+    gadget_hid
+    gadget_multi
+    gadget_printer
+    gadget_serial
+    gadget-testing
+    iuu_phoenix
+    mass-storage
+    misc_usbsevseg
+    mtouchusb
+    ohci
+    rio
+    usbip_protocol
+    usbmon
+    usb-serial
+    wusb-design-overview
+
+    usb-help
+    text_files
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/usb/iuu_phoenix.txt b/Documentation/usb/iuu_phoenix.rst
similarity index 100%
rename from Documentation/usb/iuu_phoenix.txt
rename to Documentation/usb/iuu_phoenix.rst
diff --git a/Documentation/usb/mass-storage.txt b/Documentation/usb/mass-storage.rst
similarity index 100%
rename from Documentation/usb/mass-storage.txt
rename to Documentation/usb/mass-storage.rst
diff --git a/Documentation/usb/misc_usbsevseg.txt b/Documentation/usb/misc_usbsevseg.rst
similarity index 100%
rename from Documentation/usb/misc_usbsevseg.txt
rename to Documentation/usb/misc_usbsevseg.rst
diff --git a/Documentation/usb/mtouchusb.txt b/Documentation/usb/mtouchusb.rst
similarity index 100%
rename from Documentation/usb/mtouchusb.txt
rename to Documentation/usb/mtouchusb.rst
diff --git a/Documentation/usb/ohci.txt b/Documentation/usb/ohci.rst
similarity index 100%
rename from Documentation/usb/ohci.txt
rename to Documentation/usb/ohci.rst
diff --git a/Documentation/usb/rio.txt b/Documentation/usb/rio.rst
similarity index 100%
rename from Documentation/usb/rio.txt
rename to Documentation/usb/rio.rst
diff --git a/Documentation/usb/text_files.rst b/Documentation/usb/text_files.rst
new file mode 100644
index 000000000000..6a8d3fcf64b6
--- /dev/null
+++ b/Documentation/usb/text_files.rst
@@ -0,0 +1,29 @@
+Linux CDC ACM inf
+-----------------
+
+.. include:: linux-cdc-acm.inf
+    :literal:
+
+Linux inf
+---------
+
+.. include:: linux.inf
+    :literal:
+
+USB devfs drop permissions source
+---------------------------------
+
+.. literalinclude:: usbdevfs-drop-permissions.c
+    :language: c
+
+WUSB command line script to manipulate auth credentials
+-------------------------------------------------------
+
+.. literalinclude:: wusb-cbaf
+   :language: shell
+
+Credits
+-------
+
+.. include:: CREDITS
+    :literal:
diff --git a/Documentation/usb/usb-help.txt b/Documentation/usb/usb-help.rst
similarity index 100%
rename from Documentation/usb/usb-help.txt
rename to Documentation/usb/usb-help.rst
diff --git a/Documentation/usb/usb-serial.txt b/Documentation/usb/usb-serial.rst
similarity index 100%
rename from Documentation/usb/usb-serial.txt
rename to Documentation/usb/usb-serial.rst
diff --git a/Documentation/usb/usbip_protocol.txt b/Documentation/usb/usbip_protocol.rst
similarity index 100%
rename from Documentation/usb/usbip_protocol.txt
rename to Documentation/usb/usbip_protocol.rst
diff --git a/Documentation/usb/usbmon.txt b/Documentation/usb/usbmon.rst
similarity index 100%
rename from Documentation/usb/usbmon.txt
rename to Documentation/usb/usbmon.rst
diff --git a/Documentation/usb/WUSB-Design-overview.txt b/Documentation/usb/wusb-design-overview.rst
similarity index 100%
rename from Documentation/usb/WUSB-Design-overview.txt
rename to Documentation/usb/wusb-design-overview.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index b7364119ce83..e07cbd44d48a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3761,7 +3761,7 @@ F:	scripts/extract-cert.c
 CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
 L:	linux-usb@vger.kernel.org
 S:	Orphan
-F:	Documentation/usb/WUSB-Design-overview.txt
+F:	Documentation/usb/wusb-design-overview.rst
 F:	Documentation/usb/wusb-cbaf
 F:	drivers/usb/host/hwa-hc.c
 F:	drivers/usb/host/whci/
@@ -16315,7 +16315,7 @@ USB ACM DRIVER
 M:	Oliver Neukum <oneukum@suse.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-F:	Documentation/usb/acm.txt
+F:	Documentation/usb/acm.rst
 F:	drivers/usb/class/cdc-acm.*
 
 USB AR5523 WIRELESS DRIVER
@@ -16368,7 +16368,7 @@ USB EHCI DRIVER
 M:	Alan Stern <stern@rowland.harvard.edu>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-F:	Documentation/usb/ehci.txt
+F:	Documentation/usb/ehci.rst
 F:	drivers/usb/host/ehci*
 
 USB GADGET/PERIPHERAL SUBSYSTEM
@@ -16442,7 +16442,7 @@ USB OHCI DRIVER
 M:	Alan Stern <stern@rowland.harvard.edu>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-F:	Documentation/usb/ohci.txt
+F:	Documentation/usb/ohci.rst
 F:	drivers/usb/host/ohci*
 
 USB OTG FSM (Finite State Machine)
@@ -16458,7 +16458,7 @@ M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-F:	Documentation/usb/usbip_protocol.txt
+F:	Documentation/usb/usbip_protocol.rst
 F:	drivers/usb/usbip/
 F:	tools/usb/usbip/
 F:	tools/testing/selftests/drivers/usb/usbip/
@@ -16506,7 +16506,7 @@ M:	Johan Hovold <johan@kernel.org>
 L:	linux-usb@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git
 S:	Maintained
-F:	Documentation/usb/usb-serial.txt
+F:	Documentation/usb/usb-serial.rst
 F:	drivers/usb/serial/
 F:	include/linux/usb/serial.h
 
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 389c57d8eba7..6e59d370ef81 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -75,7 +75,7 @@ config USB
 	  After choosing your HCD, then select drivers for the USB peripherals
 	  you'll be using.  You may want to check out the information provided
 	  in <file:Documentation/usb/> and especially the links given in
-	  <file:Documentation/usb/usb-help.txt>.
+	  <file:Documentation/usb/usb-help.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbcore.
diff --git a/drivers/usb/class/Kconfig b/drivers/usb/class/Kconfig
index 52f3a531a82f..f8a798900093 100644
--- a/drivers/usb/class/Kconfig
+++ b/drivers/usb/class/Kconfig
@@ -10,7 +10,7 @@ config USB_ACM
 	---help---
 	  This driver supports USB modems and ISDN adapters which support the
 	  Communication Device Class Abstract Control Model interface.
-	  Please read <file:Documentation/usb/acm.txt> for details.
+	  Please read <file:Documentation/usb/acm.rst> for details.
 
 	  If your modem only reports "Cls=ff(vend.)" in the descriptors in
 	  /sys/kernel/debug/usb/devices, then your modem will not work with this
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index ec189d7855a0..02ff850278b1 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -228,7 +228,7 @@ config USB_CONFIGFS
 	  specified simply by creating appropriate directories in configfs.
 	  Associating functions with configurations is done by creating
 	  appropriate symbolic links.
-	  For more information see Documentation/usb/gadget_configfs.txt.
+	  For more information see Documentation/usb/gadget_configfs.rst.
 
 config USB_CONFIGFS_SERIAL
 	bool "Generic serial bulk in/out"
@@ -441,7 +441,7 @@ config USB_CONFIGFS_F_HID
 	  The HID function driver provides generic emulation of USB
 	  Human Interface Devices (HID).
 
-	  For more information, see Documentation/usb/gadget_hid.txt.
+	  For more information, see Documentation/usb/gadget_hid.rst.
 
 config USB_CONFIGFS_F_UVC
 	bool "USB Webcam function"
@@ -466,7 +466,7 @@ config USB_CONFIGFS_F_PRINTER
 	  receive or send printer data. It can use ioctl calls to
 	  the device file to get or set printer status.
 
-	  For more information, see Documentation/usb/gadget_printer.txt
+	  For more information, see Documentation/usb/gadget_printer.rst
 	  which includes sample code for accessing the device file.
 
 config USB_CONFIGFS_F_TCM
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 043f97ad8f22..29cc5693e05c 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -47,7 +47,7 @@
  *
  * For more information about MSF and in particular its module
  * parameters and sysfs interface read the
- * <Documentation/usb/mass-storage.txt> file.
+ * <Documentation/usb/mass-storage.rst> file.
  */
 
 /*
diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
index 94fc3c462930..69ff7f8c86f5 100644
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -287,7 +287,7 @@ config USB_G_SERIAL
 	  Say "y" to link the driver statically, or "m" to build a
 	  dynamically linked module called "g_serial".
 
-	  For more information, see Documentation/usb/gadget_serial.txt
+	  For more information, see Documentation/usb/gadget_serial.rst
 	  which includes instructions and a "driver info file" needed to
 	  make MS-Windows work with CDC ACM.
 
@@ -321,7 +321,7 @@ config USB_G_PRINTER
 	  Say "y" to link the driver statically, or "m" to build a
 	  dynamically linked module called "g_printer".
 
-	  For more information, see Documentation/usb/gadget_printer.txt
+	  For more information, see Documentation/usb/gadget_printer.rst
 	  which includes sample code for accessing the device file.
 
 if TTY
@@ -436,7 +436,7 @@ config USB_G_HID
 	  The HID gadget driver provides generic emulation of USB
 	  Human Interface Devices (HID).
 
-	  For more information, see Documentation/usb/gadget_hid.txt which
+	  For more information, see Documentation/usb/gadget_hid.rst which
 	  includes sample code for accessing the device files.
 
 	  Say "y" to link the driver statically, or "m" to build a
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index fb3406ea8592..40b5de597112 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -114,7 +114,7 @@ config USB_EHCI_HCD
 	  Controller Driver or UHCI (for Via motherboards) Host Controller
 	  Driver too.
 
-	  You may want to read <file:Documentation/usb/ehci.txt>.
+	  You may want to read <file:Documentation/usb/ehci.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ehci-hcd.
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 4a88e1ca25c0..bdae62b2ffe0 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -51,7 +51,7 @@ config USB_RIO500
 	tristate "USB Diamond Rio500 support"
 	help
 	  Say Y here if you want to connect a USB Rio500 mp3 player to your
-	  computer's USB port. Please read <file:Documentation/usb/rio.txt>
+	  computer's USB port. Please read <file:Documentation/usb/rio.rst>
 	  for more information.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/usb/mon/Kconfig b/drivers/usb/mon/Kconfig
index 48f1b2dadb24..ffc7cd422874 100644
--- a/drivers/usb/mon/Kconfig
+++ b/drivers/usb/mon/Kconfig
@@ -8,6 +8,6 @@ config USB_MON
 	help
 	  If you select this option, a component which captures the USB traffic
 	  between peripheral-specific drivers and HC drivers will be built.
-	  For more information, see <file:Documentation/usb/usbmon.txt>.
+	  For more information, see <file:Documentation/usb/usbmon.rst>.
 
 	  If unsure, say Y, if allowed, otherwise M.
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 7d031911d04e..67279c6bce33 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -11,7 +11,7 @@ menuconfig USB_SERIAL
 	  ports, or acts like a serial device, and you want to connect it to
 	  your USB bus.
 
-	  Please read <file:Documentation/usb/usb-serial.txt> for more
+	  Please read <file:Documentation/usb/usb-serial.rst> for more
 	  information on the specifics of the different devices that are
 	  supported, and on how to use them.
 
@@ -47,7 +47,7 @@ config USB_SERIAL_GENERIC
 	bool "USB Generic Serial Driver"
 	help
 	  Say Y here if you want to use the generic USB serial driver.  Please
-	  read <file:Documentation/usb/usb-serial.txt> for more information on
+	  read <file:Documentation/usb/usb-serial.rst> for more information on
 	  using this driver.  It is recommended that the "USB Serial converter
 	  support" be compiled as a module for this driver to be used
 	  properly.
@@ -163,7 +163,7 @@ config USB_SERIAL_EMPEG
 	help
 	  Say Y here if you want to connect to your Empeg empeg-car Mark I/II
 	  mp3 player via USB.  The driver uses a single ttyUSB{0,1,2,...}
-	  device node.  See <file:Documentation/usb/usb-serial.txt> for more
+	  device node.  See <file:Documentation/usb/usb-serial.rst> for more
 	  tidbits of information.
 
 	  To compile this driver as a module, choose M here: the
@@ -199,7 +199,7 @@ config USB_SERIAL_IPAQ
 	  Say Y here if you want to connect to your Compaq iPAQ, HP Jornada
 	  or any other PDA running Windows CE 3.0 or PocketPC 2002
 	  using a USB cradle/cable. For information on using the driver,
-	  read <file:Documentation/usb/usb-serial.txt>.
+	  read <file:Documentation/usb/usb-serial.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ipaq.
@@ -334,7 +334,7 @@ config USB_SERIAL_KLSI
 	  adapter sold by Palm Inc. for use with their Palm III and Palm V
 	  series PDAs.
 
-	  Please read <file:Documentation/usb/usb-serial.txt> for more
+	  Please read <file:Documentation/usb/usb-serial.rst> for more
 	  information.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index c1235d5b9fba..9bb123ab9bc9 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -10,7 +10,7 @@
  *  and associated source files.  Please see the usb/serial files for
  *  individual credits and copyrights.
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  * TODO:
diff --git a/drivers/usb/serial/belkin_sa.h b/drivers/usb/serial/belkin_sa.h
index 51bc06287603..a13a98d284f2 100644
--- a/drivers/usb/serial/belkin_sa.h
+++ b/drivers/usb/serial/belkin_sa.h
@@ -9,7 +9,7 @@
  *  and associated source files.  Please see the usb/serial files for
  *  individual credits and copyrights.
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  * 12-Mar-2001 gkh
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 72d3ae1ebc64..216edd5826ca 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -7,7 +7,7 @@
  *	Copyright (C) 2003,2004
  *	    Neil Whelchel (koyama@firstlight.net)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  * See http://geocities.com/i0xox0i for information on this driver and the
diff --git a/drivers/usb/serial/empeg.c b/drivers/usb/serial/empeg.c
index d680bec62547..405e835e93dd 100644
--- a/drivers/usb/serial/empeg.c
+++ b/drivers/usb/serial/empeg.c
@@ -8,7 +8,7 @@
  *	Copyright (C) 1999 - 2001
  *	    Greg Kroah-Hartman (greg@kroah.com)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  */
 
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 1d8461ae2c34..8b15bbf545d4 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -10,7 +10,7 @@
  *	Copyright (C) 2002
  *	    Kuba Ober (kuba@mareimbrium.org)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  * See http://ftdi-usb-sio.sourceforge.net for up to date testing info
diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 7643716b5299..302eb9530859 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -16,7 +16,7 @@
  * was written by Roman Weissgaerber <weissg@vienna.at>, Dag Brattli
  * <dag@brattli.net>, and Jean Tourrilhes <jt@hpl.hp.com>
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  */
 
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 38d43c4b7ce5..bf988f77d400 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1999, 2000 Brian Warner	<warner@lothar.com>
  * Copyright (C) 2000 Al Borchers		<borchers@steinerpoint.com>
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  */
 
diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index e51c9464ea42..5b6e982a9376 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2013,2017 Johan Hovold <johan@kernel.org>
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  * Please report both successes and troubles to the author at omninet@kroah.com
diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index 38ae0fc826cc..8151dd7a45e8 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -22,7 +22,7 @@
  * So, THIS CODE CAN DESTROY OTi-6858 AND ANY OTHER DEVICES, THAT ARE
  * CONNECTED TO IT!
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  * TODO:
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d7abde14b3cf..9d27b76c5c6e 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -7,7 +7,7 @@
  *
  * Original driver for 2.2.x by anonymous
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  */
 
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 676c296103a2..a3179fea38c8 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -10,7 +10,7 @@
  * This driver was originally based on the ACM driver by Armin Fuerst (which was
  * based on a driver by Brad Keryan)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  */
 
diff --git a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
index 8ddbecc25d89..4412834db21c 100644
--- a/drivers/usb/serial/visor.c
+++ b/drivers/usb/serial/visor.c
@@ -6,7 +6,7 @@
  *	Copyright (C) 1999 - 2004
  *	    Greg Kroah-Hartman (greg@kroah.com)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  */
diff --git a/drivers/usb/serial/visor.h b/drivers/usb/serial/visor.h
index fe290243f1ce..4bd69d047036 100644
--- a/drivers/usb/serial/visor.h
+++ b/drivers/usb/serial/visor.h
@@ -5,7 +5,7 @@
  *	Copyright (C) 1999 - 2003
  *	    Greg Kroah-Hartman (greg@kroah.com)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver.
  *
  */
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index aefd84f88b59..79314d8c94a4 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -8,7 +8,7 @@
  *	Copyright (C) 1999 - 2001
  *	    Greg Kroah-Hartman (greg@kroah.com)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  */
 
diff --git a/drivers/usb/serial/whiteheat.h b/drivers/usb/serial/whiteheat.h
index 72c1b0cf4063..00398149cd8d 100644
--- a/drivers/usb/serial/whiteheat.h
+++ b/drivers/usb/serial/whiteheat.h
@@ -8,7 +8,7 @@
  *      Copyright (C) 1999, 2000
  *          Greg Kroah-Hartman (greg@kroah.com)
  *
- * See Documentation/usb/usb-serial.txt for more information on using this
+ * See Documentation/usb/usb-serial.rst for more information on using this
  * driver
  *
  */
-- 
2.21.0

