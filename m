Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C6C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A81324D3D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559635067;
	bh=Kr8ly81JxS5zgnxUlI9HS2VCWq8bOoEzhc0n69Sgnc8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=w68ueZykX8m4M93XOajlFQ1nyRCczhDxH57+Akja3M3MyCThHByHZpJevTPDphj/v
	 kySZslA5LgHZlntFiFheLTxHHXEPgNhra6xmbyEgQDmO9NDJidTbW5/DkeviblpCv2
	 vcETKl75Z/DAWn8RxgjdsEAZUNB4+3KF9rSD+Qps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfFDH5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfFDH5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:57:45 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5DBD24D4B;
        Tue,  4 Jun 2019 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635065;
        bh=Kr8ly81JxS5zgnxUlI9HS2VCWq8bOoEzhc0n69Sgnc8=;
        h=From:To:Cc:Subject:Date:From;
        b=JOpCayegzxbObXW+tee2fulfmIREZiRJQcYtOPA4LO3qFZAsk92RGSaNMDg+Q9i3L
         ehVPOz3PZWWI0zPsg3FtO4CdWEe0lWyztz6rK+A4FKABQ18YDDWjXr0+cL+UHx+xJC
         3GgITGPCq/c0c8UbTp0JFPkwm3DN1O5PvZiUHeIw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] parisc: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:57:39 +0200
Message-Id: <1559635059-20644-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/parisc/configs/712_defconfig           | 1 -
 arch/parisc/configs/a500_defconfig          | 1 -
 arch/parisc/configs/b180_defconfig          | 1 -
 arch/parisc/configs/c3000_defconfig         | 1 -
 arch/parisc/configs/c8000_defconfig         | 1 -
 arch/parisc/configs/default_defconfig       | 1 -
 arch/parisc/configs/generic-32bit_defconfig | 1 -
 7 files changed, 7 deletions(-)

diff --git a/arch/parisc/configs/712_defconfig b/arch/parisc/configs/712_defconfig
index ccc109761f44..d3e3d94e90c3 100644
--- a/arch/parisc/configs/712_defconfig
+++ b/arch/parisc/configs/712_defconfig
@@ -34,7 +34,6 @@ CONFIG_INET_DIAG=m
 CONFIG_NETFILTER=y
 CONFIG_LLC2=m
 CONFIG_NET_PKTGEN=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/parisc/configs/a500_defconfig b/arch/parisc/configs/a500_defconfig
index 5acb93dcaabf..a8859496b0b9 100644
--- a/arch/parisc/configs/a500_defconfig
+++ b/arch/parisc/configs/a500_defconfig
@@ -70,7 +70,6 @@ CONFIG_IP_DCCP=m
 # CONFIG_IP_DCCP_CCID3 is not set
 CONFIG_LLC2=m
 CONFIG_NET_PKTGEN=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/parisc/configs/b180_defconfig b/arch/parisc/configs/b180_defconfig
index 83ffd161aec5..0cae9664bf67 100644
--- a/arch/parisc/configs/b180_defconfig
+++ b/arch/parisc/configs/b180_defconfig
@@ -24,7 +24,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
diff --git a/arch/parisc/configs/c3000_defconfig b/arch/parisc/configs/c3000_defconfig
index 8d41a73bd71b..6c29b841735c 100644
--- a/arch/parisc/configs/c3000_defconfig
+++ b/arch/parisc/configs/c3000_defconfig
@@ -32,7 +32,6 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETFILTER=y
 CONFIG_NET_PKTGEN=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/parisc/configs/c8000_defconfig b/arch/parisc/configs/c8000_defconfig
index 900b00084953..507f0644fcf8 100644
--- a/arch/parisc/configs/c8000_defconfig
+++ b/arch/parisc/configs/c8000_defconfig
@@ -57,7 +57,6 @@ CONFIG_IP_DCCP=m
 CONFIG_TIPC=m
 CONFIG_LLC2=m
 CONFIG_DNS_RESOLVER=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/parisc/configs/default_defconfig b/arch/parisc/configs/default_defconfig
index 52c9050a7c5c..6a91cc2623e8 100644
--- a/arch/parisc/configs/default_defconfig
+++ b/arch/parisc/configs/default_defconfig
@@ -44,7 +44,6 @@ CONFIG_INET6_AH=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_IPCOMP=y
 CONFIG_LLC2=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index a8f9bbef0975..18b072a47a10 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -47,7 +47,6 @@ CONFIG_INET_ESP=m
 CONFIG_INET_DIAG=m
 CONFIG_LLC2=m
 # CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
-- 
2.7.4

