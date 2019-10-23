Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094CCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBCB21A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bzu+5NXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391696AbfJWMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:44:25 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:37282 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390091AbfJWMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E08CDC0DD8;
        Wed, 23 Oct 2019 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571834664; bh=ZcoQHaJCsVkCE5RhwttSmWvzQBoFPZ3b82TxdfmMyE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzu+5NXGeDDLrBXEToGv8q7MTsKVOwQFlFML3XvnhmQ9nuxgplm6rw6zOScJubQNl
         hMicOSLnNBp2DaKOSKzFfkjapkMxlzmZ9wPCj5VTvNwBedNN8vdaiVlte7+Fplh2qu
         dJU896NjwZXCLOKOBYnUMSNND9XZAIOmVvLqdrnDlLeZXjIU1mtxYz1CEjEi39EL8i
         2p45TTHiFf0txjLDKZ1p5NnD4rqJvi2ZFtT2ehQ0dMX5BTMAwsYIoUYAXIG/0p89Bz
         5Nw/ps0r8RccaR44RPn/5EXS6FayQAhKEdaHg1QR1y4oEFYzsKlkELTF4B0IO5S5mI
         v6GYUOzAc+4dw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 40B62A005F;
        Wed, 23 Oct 2019 12:44:22 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/8] ARC: regenerate nSIM and HAPS defconfigs
Date:   Wed, 23 Oct 2019 15:44:10 +0300
Message-Id: <20191023124417.5770-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
References: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/configs/haps_hs_defconfig     | 10 ++--------
 arch/arc/configs/haps_hs_smp_defconfig | 12 +++---------
 arch/arc/configs/nsim_700_defconfig    |  7 ++-----
 arch/arc/configs/nsim_hs_defconfig     |  8 ++------
 arch/arc/configs/nsim_hs_smp_defconfig | 10 +++-------
 5 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index 47ff8a97e42d..e22f40612089 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -4,6 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
@@ -15,13 +16,9 @@ CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_ARC_BUILTIN_DTB_NAME="haps_hs"
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ISA_ARCV2=y
-CONFIG_ARC_BUILTIN_DTB_NAME="haps_hs"
-CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -30,9 +27,6 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index 9685fd5f57a4..ff4fcd7640a4 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -4,6 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
@@ -16,15 +17,11 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_SMP=y
+CONFIG_ARC_BUILTIN_DTB_NAME="haps_hs_idu"
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ISA_ARCV2=y
-CONFIG_SMP=y
-CONFIG_ARC_BUILTIN_DTB_NAME="haps_hs_idu"
-CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -33,9 +30,6 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 2b9b11474640..9b2653b0b349 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
@@ -17,13 +18,10 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_ISA_ARCOMPACT=y
+CONFIG_ARC_BUILTIN_DTB_NAME="nsim_700"
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARC_BUILTIN_DTB_NAME="nsim_700"
-CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -39,7 +37,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_NETDEVICES=y
 CONFIG_ARC_EMAC=y
 CONFIG_LXT_PHY=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/arc/configs/nsim_hs_defconfig b/arch/arc/configs/nsim_hs_defconfig
index bab3dd255841..60ad81769565 100644
--- a/arch/arc/configs/nsim_hs_defconfig
+++ b/arch/arc/configs/nsim_hs_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
@@ -16,17 +17,13 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs"
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ISA_ARCV2=y
-CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs"
-CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -39,7 +36,6 @@ CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/arc/configs/nsim_hs_smp_defconfig b/arch/arc/configs/nsim_hs_smp_defconfig
index 90d2d50fb8dc..c7a29adfc147 100644
--- a/arch/arc/configs/nsim_hs_smp_defconfig
+++ b/arch/arc/configs/nsim_hs_smp_defconfig
@@ -2,6 +2,7 @@
 # CONFIG_SWAP is not set
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
@@ -14,18 +15,14 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_SMP=y
+CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs_idu"
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ISA_ARCV2=y
-CONFIG_SMP=y
-CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs_idu"
-CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -38,7 +35,6 @@ CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-- 
2.21.0

