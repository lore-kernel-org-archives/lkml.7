Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D020657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfCKNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:21:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfCKNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:44 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MoNyA-1gjfL23FAe-00ok1j for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 099/114] drivers: block: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:51 +0100
Message-Id: <1552310346-7629-100-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:K5BDvCM3Ac068gfGaFJtWZ9WVD12Q+3LWeBlnpF8vDo0WEWR6PF
 ai+Lqv8/ETLtVPUAmUcKPckf1KJherXtnwEvq5Us7eanPzbNVArKgEE/3yQMIfeiYo5qV/T
 zai8QnzzgwxmKLOIZUjpqqsJuTEtMKbZTs4K/Zj7wyrrKdh+5eHUKAMgjFhJInYnQwhv543
 VyG3PVcYLQjLao4VXoOmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJQm5+wEpLE=:hiyA4raOrrJZ1uGCpNp1Zo
 JR4ONkuVO6QzSufJjGgcYVp0IbFxQxezw8cEEfoPqC3B/SFg1Gs1a4UjsHZaCdhw3anPLuWc+
 aXbE0OpBYbloLWlGUle7ajuKmYI6IBS7Ll0gXOE4eieg6UcDAOdypNw/3nNCB9KmRMb6B2PoY
 LtjmOs+sIBTjVp7NcCBxtlzF9MAmwpZJCGLi/ftjViYH02Um749kuLi0Y9jTB291XrPPOP4iv
 qz8yP1hkVMX5a7ia9cAkF2x6pJ2ilBvGziYx52YtGDOGkCv/xxD75smwMXYTaru90KHrJ5Y/N
 rD7SZLpP6z6PY6UM63hqf0J5OvJ5N4uRYPuewQUSi4EhKDtaSdAEURJM3ERJzVJ1Vah04r1S/
 FE4B4kbw8p/mvsR8/7Gac/KjEkt9wP91snrHNw4NpUlxkZtp8+ZNYTcwZRLtYL/hUe3Sn0bAr
 TTLU7pDtuBJFOQCO20qEqND4lGmMYVZ7OdqWgLGbH1fD3LanrWbfl2Fzi+P0VwzBKGCmyt6/+
 AFfMlGm9sd6VmoGWQSsm7X5UgGpKcyFyHF4ruRfEqs4fC5K79gQeH8FGiRTLdyWmsZLIdwEHE
 Gj8FnO1mENUEaIrzm29AfcYhhoSxyvkkSy0jo8s5ipuWRYwKpkv/uTjaHJxbsdItih4YpaAIB
 JQ68NV0vIfDqofjJCaIOzot0g/5W81qkiZW3kbM35g35EKvzjE856ZKwcrHnaLtDmPywucFv5
 HqpZ/HFqDZLjW8rC2gvB+vgcSwoncj4oJNvCwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/block/Kconfig          | 32 ++++++++++++++++----------------
 drivers/block/mtip32xx/Kconfig |  2 +-
 drivers/block/zram/Kconfig     | 20 ++++++++++----------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 20bb4bf..07964cc 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -142,10 +142,10 @@ config BLK_DEV_UBD
 	bool "Virtual block device"
 	depends on UML
 	---help---
-          The User-Mode Linux port includes a driver called UBD which will let
-          you access arbitrary files on the host computer as block devices.
-          Unless you know that you do not need such virtual block devices say
-          Y here.
+	  The User-Mode Linux port includes a driver called UBD which will let
+	  you access arbitrary files on the host computer as block devices.
+	  Unless you know that you do not need such virtual block devices say
+	  Y here.
 
 config BLK_DEV_UBD_SYNC
 	bool "Always do synchronous disk IO for UBD"
@@ -156,16 +156,16 @@ config BLK_DEV_UBD_SYNC
 	  Linux 'Virtual Machine' uses a journalling filesystem and the host
 	  computer crashes.
 
-          Synchronous operation (i.e. always writing data to the host's disk
-          immediately) is configurable on a per-UBD basis by using a special
-          kernel command line option.  Alternatively, you can say Y here to
-          turn on synchronous operation by default for all block devices.
+	  Synchronous operation (i.e. always writing data to the host's disk
+	  immediately) is configurable on a per-UBD basis by using a special
+	  kernel command line option.  Alternatively, you can say Y here to
+	  turn on synchronous operation by default for all block devices.
 
-          If you're running a journalling file system (like reiserfs, for
-          example) in your virtual machine, you will want to say Y here.  If
-          you care for the safety of the data in your virtual machine, Y is a
-          wise choice too.  In all other cases (for example, if you're just
-          playing around with User-Mode Linux) you can choose N.
+	  If you're running a journalling file system (like reiserfs, for
+	  example) in your virtual machine, you will want to say Y here.  If
+	  you care for the safety of the data in your virtual machine, Y is a
+	  wise choice too.  In all other cases (for example, if you're just
+	  playing around with User-Mode Linux) you can choose N.
 
 config BLK_DEV_COW_COMMON
 	bool
@@ -235,7 +235,7 @@ config BLK_DEV_CRYPTOLOOP
 	select CRYPTO_CBC
 	depends on BLK_DEV_LOOP
 	---help---
-	  Say Y here if you want to be able to use the ciphers that are 
+	  Say Y here if you want to be able to use the ciphers that are
 	  provided by the CryptoAPI as loop transformation. This might be
 	  used as hard disk encryption.
 
@@ -287,7 +287,7 @@ config BLK_DEV_SX8
 	tristate "Promise SATA SX8 support"
 	depends on PCI
 	---help---
-	  Saying Y or M here will enable support for the 
+	  Saying Y or M here will enable support for the
 	  Promise SATA SX8 controllers.
 
 	  Use devices /dev/sx8/$N and /dev/sx8/$Np$M.
@@ -430,7 +430,7 @@ config VIRTIO_BLK
 	depends on VIRTIO
 	---help---
 	  This is the virtual block driver for virtio.  It can be used with
-          QEMU based VMMs (like KVM or Xen).  Say Y or M.
+	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 config VIRTIO_BLK_SCSI
 	bool "SCSI passthrough request for the Virtio block driver"
diff --git a/drivers/block/mtip32xx/Kconfig b/drivers/block/mtip32xx/Kconfig
index bf22135..a469dc7 100644
--- a/drivers/block/mtip32xx/Kconfig
+++ b/drivers/block/mtip32xx/Kconfig
@@ -7,4 +7,4 @@ config BLK_DEV_PCIESSD_MTIP32XX
 	tristate "Block Device Driver for Micron PCIe SSDs"
 	depends on PCI
 	help
-          This enables the block driver for Micron PCIe SSDs.
+	  This enables the block driver for Micron PCIe SSDs.
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 1ffc647..b39b402 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,18 +15,18 @@ config ZRAM
 	  See Documentation/blockdev/zram.txt for more information.
 
 config ZRAM_WRITEBACK
-       bool "Write back incompressible or idle page to backing device"
-       depends on ZRAM
-       help
-	 With incompressible page, there is no memory saving to keep it
-	 in memory. Instead, write it out to backing device.
-	 For this feature, admin should set up backing device via
-	 /sys/block/zramX/backing_dev.
+	bool "Write back incompressible or idle page to backing device"
+	depends on ZRAM
+	help
+	  With incompressible page, there is no memory saving to keep it
+	  in memory. Instead, write it out to backing device.
+	  For this feature, admin should set up backing device via
+	  /sys/block/zramX/backing_dev.
 
-	 With /sys/block/zramX/{idle,writeback}, application could ask
-	 idle page's writeback to the backing device to save in memory.
+	  With /sys/block/zramX/{idle,writeback}, application could ask
+	  idle page's writeback to the backing device to save in memory.
 
-	 See Documentation/blockdev/zram.txt for more information.
+	  See Documentation/blockdev/zram.txt for more information.
 
 config ZRAM_MEMORY_TRACKING
 	bool "Track zRam block status"
-- 
1.9.1

