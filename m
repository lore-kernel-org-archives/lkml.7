Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D0C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF9E206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWKa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:30:27 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:36920 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfLWKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:30:27 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id hNWP2100E5USYZQ06NWPRd; Mon, 23 Dec 2019 11:30:23 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ijKyl-0000x0-C6; Mon, 23 Dec 2019 11:30:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ijKyl-0002RX-Ad; Mon, 23 Dec 2019 11:30:23 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.5-rc3
Date:   Mon, 23 Dec 2019 11:30:22 +0100
Message-Id: <20191223103022.9350-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Move CONFIG_EARLY_PRINTK.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be combined with "m68k: defconfig: Update defconfigs for v5.5-rc1"
and "m68k: defconfig: Update defconfigs for v5.5-rc2".
---
 arch/m68k/configs/amiga_defconfig    | 2 +-
 arch/m68k/configs/apollo_defconfig   | 2 +-
 arch/m68k/configs/atari_defconfig    | 2 +-
 arch/m68k/configs/bvme6000_defconfig | 2 +-
 arch/m68k/configs/hp300_defconfig    | 2 +-
 arch/m68k/configs/mac_defconfig      | 2 +-
 arch/m68k/configs/multi_defconfig    | 2 +-
 arch/m68k/configs/mvme147_defconfig  | 2 +-
 arch/m68k/configs/mvme16x_defconfig  | 2 +-
 arch/m68k/configs/q40_defconfig      | 2 +-
 arch/m68k/configs/sun3x_defconfig    | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 0a6ba8e5a39ac342..e1134c3e0b69d5d3 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -624,6 +624,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -655,4 +656,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 6d9fa08ef6d0e35c..484cb1643df1719d 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -580,6 +580,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -611,4 +612,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 65bd096f89e7ee04..c372f00c4a1f0797 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -614,6 +614,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -645,4 +646,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 789cad50f64ab334..bee9263a409c4e18 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -573,6 +573,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -604,4 +605,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index aa4a8e0a18389b35..c8847a8bcbd6d23f 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -582,6 +582,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -613,4 +614,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 5172398c38047f1e..303ffafd9cad0d60 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -604,6 +604,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -635,4 +636,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 14c31ca056417625..89a704226cd9e4e5 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -690,6 +690,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -721,4 +722,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index f68287e5c0d83f3e..f62c1f4d03a0330e 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -572,6 +572,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -603,4 +604,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index da79ec7b77ae1fe1..58dcad26a7513222 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -573,6 +573,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -604,4 +605,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index d93bd23d0e735e41..5d3c28d1d545b4a0 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -591,6 +591,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -622,4 +623,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index bf96a6a15ec4d684..22e1accc60a3e110 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -574,6 +574,7 @@ CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
+CONFIG_EARLY_PRINTK=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_REED_SOLOMON_TEST=m
@@ -605,4 +606,3 @@ CONFIG_TEST_KMOD=m
 CONFIG_TEST_MEMCAT_P=m
 CONFIG_TEST_STACKINIT=m
 CONFIG_TEST_MEMINIT=m
-CONFIG_EARLY_PRINTK=y
-- 
2.17.1

