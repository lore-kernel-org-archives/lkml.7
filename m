Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B27C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD32206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfCKNZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0X4c-1gp7uV2BqW-00wY5H for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 060/114] drivers: pci: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:12 +0100
Message-Id: <1552310346-7629-61-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:awYL8q6tUkHMyecssVHGDwCQcJR20gt7eES0GPoeLDAgO3uU0OG
 Yr0Zy2I9VHmBw5g4zZ+IxoK1iHuS3yTFKDUUjClgPq3Z0tIjffVt0oFVT3JsjbsR+k0UsTk
 mT/N3NuLMt3YNacbaDrm6ZpZsFYUFgtHdqeJG9bI8VKd0Qkr/lK31b1j03xfffnOOhe05Ee
 rls5YKKEbq26wB94JNMRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SF4X7w1afeA=:HRNHGCxwmknJNs1Qx+ZiBv
 EolHxQ8b8vj04jAS4GRT+hsXvX3PThqtaK7Tg61r35QxLh345oNCK4VdSHxsd/M9IHfKB8dnh
 y3m6k1kMW4RhCPDC9D2r1PsfsYNvfjppA7DG1LIZ8KacuIkc+Sv5S/tELLlcYdL8BMMrIO/L/
 MxVxR19gz5YyBIrLJZEFRezE1F+z+X7AfsUJYd7TrujVlCXz/9cpOvkOvMk4krvIAfEghOki/
 9tq2DcnDRU5FuB9rBOejxlWYf3QiOVvRJo3Z5kJFyOs/muB/xyoKwjvWubxnA+f02EEHmLMGW
 l/+0hSGyjBILVW6WZLgbQaZTG0e63EiLa63uQ7u5Zu4BOAEufebgZvvz7FjUPTKO/voEWhWFP
 QAbb1WC1Jh6d2f9FQNqehp4G7A1ShN0tzxFENprHHI7nA22A98mZdyV7saeu4xmnXtsJn2kyD
 8NmMlG8JQA7rxyl7pn7DZHNCBpXzG6xko57A0CApVYvhP7gKJvBvaVik/YfyrOx327m173BRh
 tWjs9VwWRgG54oSmWIJcK2mAoeqYc/qQIQNOYDKO4y3LikDf68CPFrI1uHVbJb0RWDxdwAf5Q
 6tDPzSGSCOJjarDPHmgjKbB7bxNFk+dBqaoLXrNVWyapirbKSRGSJR/8LtVLkUtOAn2Pi+VIW
 NIbFnFrKr9XSJ/U+gUPf+t7SNnaP/aTH0cS4lQlI1GBGx2aHAm/3J8xDZSkHS+fsBtpk2ZYiX
 rnHNsRJCXaL9cMj68OjT0QHLhCjbXl8iNU62Tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/pci/Kconfig                    | 40 +++++++++++++++++-----------------
 drivers/pci/controller/Kconfig         | 14 ++++++------
 drivers/pci/controller/dwc/Kconfig     |  6 ++---
 drivers/pci/endpoint/Kconfig           | 20 ++++++++---------
 drivers/pci/endpoint/functions/Kconfig |  6 ++---
 drivers/pci/hotplug/Kconfig            |  2 +-
 drivers/pci/switch/Kconfig             | 10 ++++-----
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab9240..cf27052 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -40,16 +40,16 @@ config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	select GENERIC_MSI_IRQ
 	help
-	   This allows device drivers to enable MSI (Message Signaled
-	   Interrupts).  Message Signaled Interrupts enable a device to
-	   generate an interrupt using an inbound Memory Write on its
-	   PCI bus instead of asserting a device IRQ pin.
+	  This allows device drivers to enable MSI (Message Signaled
+	  Interrupts).  Message Signaled Interrupts enable a device to
+	  generate an interrupt using an inbound Memory Write on its
+	  PCI bus instead of asserting a device IRQ pin.
 
-	   Use of PCI MSI interrupts can be disabled at kernel boot time
-	   by using the 'pci=nomsi' option.  This disables MSI for the
-	   entire system.
+	  Use of PCI MSI interrupts can be disabled at kernel boot time
+	  by using the 'pci=nomsi' option.  This disables MSI for the
+	  entire system.
 
-	   If you don't know what to do here, say Y.
+	  If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
 	def_bool ARC || ARM || ARM64 || X86
@@ -106,14 +106,14 @@ config PCI_PF_STUB
 	  When in doubt, say N.
 
 config XEN_PCIDEV_FRONTEND
-        tristate "Xen PCI Frontend"
-        depends on X86 && XEN
-        select PCI_XEN
+	tristate "Xen PCI Frontend"
+	depends on X86 && XEN
+	select PCI_XEN
 	select XEN_XENBUS_FRONTEND
-        default y
-        help
-          The PCI device frontend driver allows the kernel to import arbitrary
-          PCI devices from a PCI backend to support PCI driver domains.
+	default y
+	help
+	  The PCI device frontend driver allows the kernel to import arbitrary
+	  PCI devices from a PCI backend to support PCI driver domains.
 
 config PCI_ATS
 	bool
@@ -180,11 +180,11 @@ config PCI_LABEL
 	select NLS
 
 config PCI_HYPERV
-        tristate "Hyper-V PCI Frontend"
-        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
-        help
-          The PCI device frontend driver allows the kernel to import arbitrary
-          PCI devices from a PCI backend to support PCI driver domains.
+	tristate "Hyper-V PCI Frontend"
+	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+	help
+	  The PCI device frontend driver allows the kernel to import arbitrary
+	  PCI devices from a PCI backend to support PCI driver domains.
 
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6012f30..cf262b8 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -18,9 +18,9 @@ config PCI_AARDVARK
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_BRIDGE_EMUL
 	help
-	 Add support for Aardvark 64bit PCIe Host Controller. This
-	 controller is part of the South Bridge of the Marvel Armada
-	 3700 SoC.
+	  Add support for Aardvark 64bit PCIe Host Controller. This
+	  controller is part of the South Bridge of the Marvel Armada
+	  3700 SoC.
 
 menu "Cadence PCIe controllers support"
 
@@ -55,10 +55,10 @@ config PCIE_XILINX_NWL
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
-	 Say 'Y' here if you want kernel support for Xilinx
-	 NWL PCIe controller. The controller can act as Root Port
-	 or End Point. The current option selection will only
-	 support root port enabling.
+	  Say 'Y' here if you want kernel support for Xilinx
+	  NWL PCIe controller. The controller can act as Root Port
+	  or End Point. The current option selection will only
+	  support root port enabling.
 
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 6ea74b1..5312377 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -7,9 +7,9 @@ config PCIE_DW
 	bool
 
 config PCIE_DW_HOST
-        bool
+	bool
 	depends on PCI_MSI_IRQ_DOMAIN
-        select PCIE_DW
+	select PCIE_DW
 
 config PCIE_DW_EP
 	bool
@@ -191,7 +191,7 @@ config PCIE_HISI_STB
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-          Say Y here if you want PCIe controller support on HiSilicon STB SoCs
+	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
 
 config PCI_MESON
 	bool "MESON PCIe controller"
diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 17bbdc9..5cd41e8 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -9,24 +9,24 @@ config PCI_ENDPOINT
 	bool "PCI Endpoint Support"
 	depends on HAVE_PCI
 	help
-	   Enable this configuration option to support configurable PCI
-	   endpoint. This should be enabled if the platform has a PCI
-	   controller that can operate in endpoint mode.
+	  Enable this configuration option to support configurable PCI
+	  endpoint. This should be enabled if the platform has a PCI
+	  controller that can operate in endpoint mode.
 
-	   Enabling this option will build the endpoint library, which
-	   includes endpoint controller library and endpoint function
-	   library.
+	  Enabling this option will build the endpoint library, which
+	  includes endpoint controller library and endpoint function
+	  library.
 
-	   If in doubt, say "N" to disable Endpoint support.
+	  If in doubt, say "N" to disable Endpoint support.
 
 config PCI_ENDPOINT_CONFIGFS
 	bool "PCI Endpoint Configfs Support"
 	depends on PCI_ENDPOINT
 	select CONFIGFS_FS
 	help
-	   This will enable the configfs entry that can be used to
-	   configure the endpoint function and used to bind the
-	   function with a endpoint controller.
+	  This will enable the configfs entry that can be used to
+	  configure the endpoint function and used to bind the
+	  function with a endpoint controller.
 
 source "drivers/pci/endpoint/functions/Kconfig"
 
diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 8820d0f..5038da7 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -8,7 +8,7 @@ config PCI_EPF_TEST
 	depends on PCI_ENDPOINT
 	select CRC32
 	help
-	   Enable this configuration option to enable the test driver
-	   for PCI Endpoint.
+	  Enable this configuration option to enable the test driver
+	  for PCI Endpoint.
 
-	   If in doubt, say "N" to disable Endpoint test driver.
+	  If in doubt, say "N" to disable Endpoint test driver.
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index e9f78eb..dad20d8 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -83,7 +83,7 @@ config HOTPLUG_PCI_CPCI_ZT5550
 	depends on HOTPLUG_PCI_CPCI && X86
 	help
 	  Say Y here if you have an Performance Technologies (formerly Intel,
-          formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
+	  formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpcihp_zt5550.
diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
index aee28a5..6d1d3a6 100644
--- a/drivers/pci/switch/Kconfig
+++ b/drivers/pci/switch/Kconfig
@@ -6,10 +6,10 @@ menu "PCI switch controller drivers"
 config PCI_SW_SWITCHTEC
 	tristate "MicroSemi Switchtec PCIe Switch Management Driver"
 	help
-	 Enables support for the management interface for the MicroSemi
-	 Switchtec series of PCIe switches. Supports userspace access
-	 to submit MRPC commands to the switch via /dev/switchtecX
-	 devices. See <file:Documentation/switchtec.txt> for more
-	 information.
+	  Enables support for the management interface for the MicroSemi
+	  Switchtec series of PCIe switches. Supports userspace access
+	  to submit MRPC commands to the switch via /dev/switchtecX
+	  devices. See <file:Documentation/switchtec.txt> for more
+	  information.
 
 endmenu
-- 
1.9.1

