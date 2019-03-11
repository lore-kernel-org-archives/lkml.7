Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D19222BE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfCKNaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:30:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MeTwY-1gTBCw1pqe-00aUxD for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:30 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 021/114] drivers: scsi: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:33 +0100
Message-Id: <1552310346-7629-22-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:1Akns4jpgRLmwiwcIgMJgyJEPaj/j2Pq9b4SwY0SNDrCtHtUFiL
 cRKEJF9l23IQ9IyMoyL/7yl2xSEMRooYXio1/BlvdTYtKjwyF1FQcDK9HW8Z9+oWs1EFCXU
 VsWTl8uzuXKDdbafE2EPmDtIO8CccxUi4oI5fQn+UvCEenSS+DqV9pMG10jgmylDWWwY1vz
 khYeSkIvfu4Rs/FU3jX+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nxKSw5/iYOc=:swAs87wIfY6quA5AXYo7gn
 M2wKVVX1bFMwhgVh5OzgVBqnPl/cLmto8/opYyFlmLXsHeCfecTpHPtpbvlFdIJUKQZo3t1Kx
 aYhXIofecpeux54WPB6DrBHkmgqcF9hGllglov3tsuZHKyaJjzyPxL4H2DWPtydkYJLo2p9FL
 +YNseznBLm6DelPFFe3OxdzyH9mQi1qhTx8o4KJ0bIYlRJgvvJvHYUDjVQnq1kF8NoZbmUNR0
 dur/4g35QKbHn4t4wJyptJq30N72B+5Sv0XDtOCOIWmrNU6zgklagZAdJkxON+Dpu7XZzGv7i
 tfZ3CI0PjNyqROPa0jn05nCC1oF1ZhE7FI1uHkmpyr8CzEZvEOMWdPcVRatQKa+EhDOJkndxp
 lGFNCilY4Nv4c1UjJXEt1Kni84KsncdfpwaCoFOLetcW9Gf7eH/8Ki+fif5s1s6ks23jZOquX
 /c5NgcJM7dd+y5kPO/QcHKW7bw2JcgTA5ZBKvbB2w9klFhmZpxZJ2BopDfFHLRk3wB+egfpl9
 4Q2ko9zLyKaFZdkc2keCFJcH1lC2+jOU0cwrdqeMssAfMZ06swroz9iBBohAevAVtEQ9SbhTK
 n8+cXyexKDIuKdwuR2bmzpaN4oJd5yrQDBYhDe6TMlNtsYyuLn6UhHB2qOgpH476DbSKp2AfC
 7enORQaCHzKPW9MPFrTUI/SwP8F3u+BMBUzBS8dndeYoZ8QaaxAIIfXrDxFeVpLIcpeeg21yx
 4Na73V3D9IAb56TxNwZtzMtoLEP0nvmEGt34Kw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/scsi/Kconfig          | 63 +++++++++++++++++++++----------------------
 drivers/scsi/pcmcia/Kconfig   |  2 +-
 drivers/scsi/qedf/Kconfig     |  8 +++---
 drivers/scsi/smartpqi/Kconfig | 16 +++++------
 4 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index d528018..1a1cca8 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1,9 +1,9 @@
 menu "SCSI device support"
 
 config SCSI_MOD
-       tristate
-       default y if SCSI=n || SCSI=y
-       default m if SCSI=m
+	tristate
+	default y if SCSI=n || SCSI=y
+	default m if SCSI=m
 
 config RAID_ATTRS
 	tristate "RAID Transport Class"
@@ -47,7 +47,7 @@ config SCSI_ESP_PIO
 
 config SCSI_NETLINK
 	bool
-	default	n
+	default n
 	depends on NET
 
 config SCSI_PROC_FS
@@ -307,25 +307,25 @@ config ISCSI_TCP
 	select CRYPTO_CRC32C
 	select SCSI_ISCSI_ATTRS
 	help
-	 The iSCSI Driver provides a host with the ability to access storage
-	 through an IP network. The driver uses the iSCSI protocol to transport
-	 SCSI requests and responses over a TCP/IP network between the host
-	 (the "initiator") and "targets".  Architecturally, the iSCSI driver
-	 combines with the host's TCP/IP stack, network drivers, and Network
-	 Interface Card (NIC) to provide the same functions as a SCSI or a
-	 Fibre Channel (FC) adapter driver with a Host Bus Adapter (HBA).
+	  The iSCSI Driver provides a host with the ability to access storage
+	  through an IP network. The driver uses the iSCSI protocol to transport
+	  SCSI requests and responses over a TCP/IP network between the host
+	  (the "initiator") and "targets".  Architecturally, the iSCSI driver
+	  combines with the host's TCP/IP stack, network drivers, and Network
+	  Interface Card (NIC) to provide the same functions as a SCSI or a
+	  Fibre Channel (FC) adapter driver with a Host Bus Adapter (HBA).
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called iscsi_tcp.
+	  To compile this driver as a module, choose M here: the
+	  module will be called iscsi_tcp.
 
-	 The userspace component needed to initialize the driver, documentation,
-	 and sample configuration files can be found here:
+	  The userspace component needed to initialize the driver, documentation,
+	  and sample configuration files can be found here:
 
-	 http://open-iscsi.org
+	  http://open-iscsi.org
 
 config ISCSI_BOOT_SYSFS
 	tristate "iSCSI Boot Sysfs Interface"
-	default	n
+	default n
 	help
 	  This option enables support for exposing iSCSI boot information
 	  via sysfs to userspace. If you wish to export this information,
@@ -340,7 +340,7 @@ source "drivers/scsi/cxlflash/Kconfig"
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"
 	depends on SGI_HAS_WD93 && SCSI
-  	help
+	help
 	  If you have a Western Digital WD93 SCSI controller on
 	  an SGI MIPS system, say Y.  Otherwise, say N.
 
@@ -455,7 +455,6 @@ config SCSI_AACRAID
 	  To compile this driver as a module, choose M here: the module
 	  will be called aacraid.
 
-
 source "drivers/scsi/aic7xxx/Kconfig.aic7xxx"
 source "drivers/scsi/aic7xxx/Kconfig.aic79xx"
 source "drivers/scsi/aic94xx/Kconfig"
@@ -475,7 +474,7 @@ config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
 	depends on SCSI && PCI && VIRT_TO_BUS
 	help
-	  This driver supports all of Adaptec's I2O based RAID controllers as 
+	  This driver supports all of Adaptec's I2O based RAID controllers as
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
 	  driver by Deanna Bonds.  See <file:Documentation/scsi/dpti.txt>.
 
@@ -669,7 +668,7 @@ config SCSI_GDTH
 	---help---
 	  Formerly called GDT SCSI Disk Array Controller Support.
 
-	  This is a driver for RAID/SCSI Disk Array Controllers (EISA/ISA/PCI) 
+	  This is a driver for RAID/SCSI Disk Array Controllers (EISA/ISA/PCI)
 	  manufactured by Intel Corporation/ICP vortex GmbH. It is documented
 	  in the kernel source in <file:drivers/scsi/gdth.c> and
 	  <file:drivers/scsi/gdth.h>.
@@ -1152,8 +1151,8 @@ config SCSI_LPFC
 	depends on NVME_FC || NVME_FC=n
 	select CRC_T10DIF
 	---help---
-          This lpfc driver supports the Emulex LightPulse
-          Family of Fibre Channel PCI host adapters.
+	  This lpfc driver supports the Emulex LightPulse
+	  Family of Fibre Channel PCI host adapters.
 
 config SCSI_LPFC_DEBUG_FS
 	bool "Emulex LightPulse Fibre Channel debugfs Support"
@@ -1466,14 +1465,14 @@ config ZFCP
 	depends on S390 && QDIO && SCSI
 	depends on SCSI_FC_ATTRS
 	help
-          If you want to access SCSI devices attached to your IBM eServer
-          zSeries by means of Fibre Channel interfaces say Y.
-          For details please refer to the documentation provided by IBM at
-          <http://oss.software.ibm.com/developerworks/opensource/linux390>
+	  If you want to access SCSI devices attached to your IBM eServer
+	  zSeries by means of Fibre Channel interfaces say Y.
+	  For details please refer to the documentation provided by IBM at
+	  <http://oss.software.ibm.com/developerworks/opensource/linux390>
 
-          This driver is also available as a module. This module will be
-          called zfcp. If you want to compile it as a module, say M here
-          and read <file:Documentation/kbuild/modules.txt>.
+	  This driver is also available as a module. This module will be
+	  called zfcp. If you want to compile it as a module, say M here
+	  and read <file:Documentation/kbuild/modules.txt>.
 
 config SCSI_PMCRAID
 	tristate "PMC SIERRA Linux MaxRAID adapter support"
@@ -1504,8 +1503,8 @@ config SCSI_VIRTIO
 	tristate "virtio-scsi support"
 	depends on VIRTIO
 	help
-          This is the virtual HBA driver for virtio.  If the kernel will
-          be used in a virtual machine, say Y or M.
+	  This is the virtual HBA driver for virtio.  If the kernel will
+	  be used in a virtual machine, say Y or M.
 
 source "drivers/scsi/csiostor/Kconfig"
 
diff --git a/drivers/scsi/pcmcia/Kconfig b/drivers/scsi/pcmcia/Kconfig
index 2d435f1..b63b34d 100644
--- a/drivers/scsi/pcmcia/Kconfig
+++ b/drivers/scsi/pcmcia/Kconfig
@@ -32,7 +32,7 @@ config PCMCIA_NINJA_SCSI
 	  NinjaSCSI-3: (version string: "WBT","NinjaSCSI-3","R1.0")
 	    IO-DATA     PCSC-FP
 	    ALPHA DATA  AD-PCS201
-	    CyQ've      SFC-201  
+	    CyQ've      SFC-201
 	    LOGITECH    LPM-SCSI2E
 	    Pioneer PCR-PR24's card
 	    I-O DATA CDPS-PX24's card (PCSC-F)
diff --git a/drivers/scsi/qedf/Kconfig b/drivers/scsi/qedf/Kconfig
index 943f5ee..e2693db 100644
--- a/drivers/scsi/qedf/Kconfig
+++ b/drivers/scsi/qedf/Kconfig
@@ -2,10 +2,10 @@ config QEDF
 	tristate "QLogic QEDF 25/40/100Gb FCoE Initiator Driver Support"
 	depends on PCI && SCSI
 	depends on QED
-        depends on LIBFC
-        depends on LIBFCOE
+	depends on LIBFC
+	depends on LIBFCOE
 	select QED_LL2
 	select QED_FCOE
 	---help---
-	This driver supports FCoE offload for the QLogic FastLinQ
-	41000 Series Converged Network Adapters.
+	  This driver supports FCoE offload for the QLogic FastLinQ
+	  41000 Series Converged Network Adapters.
diff --git a/drivers/scsi/smartpqi/Kconfig b/drivers/scsi/smartpqi/Kconfig
index 97e159c..fafc7f7 100644
--- a/drivers/scsi/smartpqi/Kconfig
+++ b/drivers/scsi/smartpqi/Kconfig
@@ -41,14 +41,14 @@ config SCSI_SMARTPQI
 	select SCSI_SAS_ATTRS
 	select RAID_ATTRS
 	---help---
-	This driver supports Microsemi PQI controllers.
+	  This driver supports Microsemi PQI controllers.
 
-	<http://www.microsemi.com>
+	  <http://www.microsemi.com>
 
-	To compile this driver as a module, choose M here: the
-	module will be called smartpqi.
+	  To compile this driver as a module, choose M here: the
+	  module will be called smartpqi.
 
-        Note: the aacraid driver will not manage a smartpqi
-              controller. You need to enable smartpqi for smartpqi
-              controllers. For more information, please see
-              Documentation/scsi/smartpqi.txt
+	  Note: the aacraid driver will not manage a smartpqi
+	        controller. You need to enable smartpqi for smartpqi
+	        controllers. For more information, please see
+	        Documentation/scsi/smartpqi.txt
-- 
1.9.1

