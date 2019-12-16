Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E4FC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734B206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfLPOTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:19:54 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:44058 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfLPOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:19:54 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id eeKr2100V5USYZQ01eKrXF; Mon, 16 Dec 2019 15:19:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1igrDz-0005tN-LX; Mon, 16 Dec 2019 15:19:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1igrDz-0001JT-JW; Mon, 16 Dec 2019 15:19:51 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.5-rc2
Date:   Mon, 16 Dec 2019 15:19:50 +0100
Message-Id: <20191216141950.5006-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Remove CONFIG_CRYPTO_BLAKE2B=m (auto-selected by BTRFS_FS since
    commit 78f926f72e43e4b9 ("btrfs: add Kconfig dependency for
    BLAKE2B").
	-CONFIG_CRYPTO_BLAKE2B=m

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be combined with "m68k: defconfig: Update defconfigs for v5.5-rc1".
---
 arch/m68k/configs/amiga_defconfig    | 1 -
 arch/m68k/configs/apollo_defconfig   | 1 -
 arch/m68k/configs/atari_defconfig    | 1 -
 arch/m68k/configs/bvme6000_defconfig | 1 -
 arch/m68k/configs/hp300_defconfig    | 1 -
 arch/m68k/configs/mac_defconfig      | 1 -
 arch/m68k/configs/multi_defconfig    | 1 -
 arch/m68k/configs/mvme147_defconfig  | 1 -
 arch/m68k/configs/mvme16x_defconfig  | 1 -
 arch/m68k/configs/q40_defconfig      | 1 -
 arch/m68k/configs/sun3_defconfig     | 1 -
 arch/m68k/configs/sun3x_defconfig    | 1 -
 12 files changed, 12 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 998c6b8c2747da84..0a6ba8e5a39ac342 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -575,7 +575,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 5b9c1fd92714141c..6d9fa08ef6d0e35c 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -531,7 +531,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index a2cb5010a9e49401..65bd096f89e7ee04 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -564,7 +564,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index a8bba75a8eafc1a1..789cad50f64ab334 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -524,7 +524,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index e43008bccb19c5be..aa4a8e0a18389b35 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -533,7 +533,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 4e6d99040afa0906..5172398c38047f1e 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -555,7 +555,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 9dc979672b2913cc..14c31ca056417625 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -641,7 +641,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 617c331c56bfa0d2..f68287e5c0d83f3e 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -523,7 +523,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 43984f89bf1f3602..da79ec7b77ae1fe1 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -524,7 +524,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index acf8ba47f641ff32..d93bd23d0e735e41 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -542,7 +542,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 835b55d616b2d3aa..5ef9e17dcd51788a 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -526,7 +526,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 0e09561d13f4b334..bf96a6a15ec4d684 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -525,7 +525,6 @@ CONFIG_CRYPTO_KEYWRAP=m
 CONFIG_CRYPTO_ADIANTUM=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
-CONFIG_CRYPTO_BLAKE2B=m
 CONFIG_CRYPTO_BLAKE2S=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD128=m
-- 
2.17.1

