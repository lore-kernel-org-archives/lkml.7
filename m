Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A8AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570C420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfCKNUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLA6m-1hKJj93R7y-00IHZx for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 078/114] drivers: firmware: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:30 +0100
Message-Id: <1552310346-7629-79-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:zMa/QRnTP8vK29ybB9zdBCux6R0GvDunVOLkegwrYNYoG9nkLam
 vd7N07b+IGLq5urbEkG2gXQ1vXturlzK8YB7HEO1SfvQE256FX8Np/9J0bjid/Rl5Foaet/
 o/hVJ16Si8upumsY8QDQ3ZgvcnHtJOxHoOVurODe4FXZhe07u9p0q3ZIQ3CV6S1g0WDS4GM
 S/oYVeirxgen7MM6ookZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cWkJz66HylE=:w5MPVQ4XYBNkZlI6DuWV4Z
 OHS5lmD1Lnvh6YrePAi/wLnM/+/yeJ3+3a3xZRenvG37XhoiTCqwgcwvCx7DjqqtXJUsGOPLi
 i0vbw00SYv+4unCpTxrQQ1S/iR8n5pagg2Zp9ccmrmaLNEHARSHGz682GVp+J6mI4696Jb5Rp
 sfHbh06g/gJpSpOsLnDhGR7ILsXM/afOyQRQ0+DurWa4L/ChukXxaiGrSuBnVE8uPcr7ufYK0
 SNlwAbzU+UcEHW0EdzLkn0rzArcNdVsCydNdEH3ZH6N2Sesnzk2gbtycDdgWbPAl5tsbBq4cs
 Mi7CTFWGsvcePldrjKtyV46dS5/kCQ7pJfBuGiYxd98l09zOkYVDIiEFyNbDWQaHmtundJwWo
 X0mbOMQhb1jLQOBXd4R2nKIMiXeKX4MF5X23IjKrbP62yJAYONyFWnKOjK6Hm29CtvTR7e84b
 T8md26S5Dgh9/VPQGlp/Eb0QukMGaSUpWbhO3gS8bSPE6yOz3xpSTWmQPAF7bIDdDJdD8m+xo
 JTlqwUnEYZF7cOXbXSyQUnvO5ZDbVQoe4/DKmiWdYHEU84yxp6O0vkytXrIKVTLKt4DJVmWJi
 Zn0f5ay2ZkZT/aBUzpQnxb9d5H+VlKuoO2jfzkssWe1TlINWZp7Y4YfL1mPcZQUnP0MoCJlez
 ZnKgH5tg+3RUIzrJ/AN25pZdWNO/+tE7eC0+dEbmnNMHsdxqvh7gr6ulBK/jRwsbtCUworfk3
 8XaTIg5Wkfvmmd9poiUraC4reRUueo0QwUlteQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/firmware/Kconfig     | 28 ++++++++++++++--------------
 drivers/firmware/efi/Kconfig |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index cac16c4..1a18ccb 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -99,8 +99,8 @@ config EDD
 	  BIOS tries boot from.  This information is then exported via sysfs.
 
 	  This option is experimental and is known to fail to boot on some
-          obscure configurations. Most disk controller BIOS vendors do
-          not yet implement this feature.
+	  obscure configurations. Most disk controller BIOS vendors do
+	  not yet implement this feature.
 
 config EDD_OFF
 	bool "Sets default behavior for EDD detection to off"
@@ -112,14 +112,14 @@ config EDD_OFF
 	  using the kernel parameter 'edd={on|skipmbr|off}'.
 
 config FIRMWARE_MEMMAP
-    bool "Add firmware-provided memory map to sysfs" if EXPERT
-    default X86
-    help
-      Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
-      That memory map is used for example by kexec to set up parameter area
-      for the next kernel, but can also be used for debugging purposes.
+	bool "Add firmware-provided memory map to sysfs" if EXPERT
+	default X86
+	help
+	  Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
+	  That memory map is used for example by kexec to set up parameter area
+	  for the next kernel, but can also be used for debugging purposes.
 
-      See also Documentation/ABI/testing/sysfs-firmware-memmap.
+	  See also Documentation/ABI/testing/sysfs-firmware-memmap.
 
 config EFI_PCDP
 	bool "Console device selection via EFI PCDP or HCDP table"
@@ -143,12 +143,12 @@ config EFI_PCDP
 	  You must also enable the appropriate drivers (serial, VGA, etc.)
 
 	  See DIG64_HCDPv20_042804.pdf available from
-	  <http://www.dig64.org/specifications/> 
+	  <http://www.dig64.org/specifications/>
 
 config DMIID
-    bool "Export DMI identification via sysfs to userspace"
-    depends on DMI
-    default y
+	bool "Export DMI identification via sysfs to userspace"
+	depends on DMI
+	default y
 	help
 	  Say Y here if you want to query SMBIOS/DMI system identification
 	  information from userspace through /sys/class/dmi/id/ or if you want
@@ -182,7 +182,7 @@ config ISCSI_IBFT
 	tristate "iSCSI Boot Firmware Table Attributes module"
 	select ISCSI_BOOT_SYSFS
 	depends on ISCSI_IBFT_FIND && SCSI && SCSI_LOWLEVEL
-	default	n
+	default n
 	help
 	  This option enables support for detection and exposing of iSCSI
 	  Boot Firmware Table (iBFT) via sysfs to userspace. If you wish to
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 190be0b..96badaa 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -79,7 +79,7 @@ config EFI_PARAMS_FROM_FDT
 	help
 	  Select this config option from the architecture Kconfig if
 	  the EFI runtime support gets system table address, memory
-          map address, and other parameters from the device tree.
+	  map address, and other parameters from the device tree.
 
 config EFI_RUNTIME_WRAPPERS
 	bool
-- 
1.9.1

