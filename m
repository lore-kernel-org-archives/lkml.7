Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9020CA9EBF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB1921906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YAyY0a5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbfJWMos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:44:48 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:37284 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391686AbfJWMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 72D9CC0DDE;
        Wed, 23 Oct 2019 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571834664; bh=9bNHRLE5N78H1xT78BVFMS/DIn9uGRWP5TXcJX4sEgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAyY0a5+qAz2eP0iUTxvt4Ud9f3r/rU4QOEuODemZpHqsd6lElGstWiV4Naz+ca7l
         esqMd1GWPdc/+1M0jinS95b5CWBKOHcEeRvVBtSp/Z6BBfbNIYZr0VjihXJxusl+wZ
         YVIfyAE5k7LH9zmUDyGcwUEoVt0/3zBNCFiC6+4Q7fXj15j0X61LxKysIIOJOgSjaA
         KFn2vq6NbHR34cSOHdYPzlwHwLyBNL57rC1J+lNk7c8xxSiDR7b3IbV+s3UnkE6Mm9
         2gfB17/XgWccZuQCbNuaFCg5ps0RBM6buMJCDe8XDqtXNQcLat3346Q7cqMDhJfX7m
         HSkStNGXbjmJg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id BE8B3A0063;
        Wed, 23 Oct 2019 12:44:22 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/8] ARC: HAPS: cleanup defconfigs from unused IO-related options
Date:   Wed, 23 Oct 2019 15:44:11 +0300
Message-Id: <20191023124417.5770-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
References: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have any peripherals on HAPS which may require FB or
input_devices support. So get rid of them.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/configs/haps_hs_defconfig     | 9 +++------
 arch/arc/configs/haps_hs_smp_defconfig | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index e22f40612089..33b7a402b6bd 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -48,9 +48,9 @@ CONFIG_VIRTIO_NET=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
-CONFIG_MOUSE_PS2_TOUCHKIT=y
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIO_ARC_PS2=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -60,9 +60,6 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_VIRTIO_MMIO=y
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index ff4fcd7640a4..5586511a00bf 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -49,9 +49,9 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
-CONFIG_MOUSE_PS2_TOUCHKIT=y
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIO_ARC_PS2=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -61,9 +61,6 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_IOMMU_SUPPORT is not set
-- 
2.21.0

