Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E72C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E04420657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfCKNXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MgNlB-1gZX8O1aGt-00htTg for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 089/114] drivers: virtio: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:41 +0100
Message-Id: <1552310346-7629-90-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:zVG/RdFywF7j2KDkEf700Eh/v4jt/YL5Bx/Yix5tPd78u6LAtDM
 8w1HnjhbmPV63FuxBpiI6dqkIjxyaIOkMzEAQFjBmvzBPj8av5MoT0d42SxzubJ8Z2JhcWH
 u9WWFUgSk7E//MMWPfQQZGC33kbjoqRmc/1704v1MkqNfpqVqUygPEnWAjKibyzLOiSrjJw
 y2OjVsIoMVb0CRkj3OFYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8+eyNOZc1SE=:g3CpCaiTrYlDd11P9f7wr2
 7FGQZb86doL1M06l9KO37K+OGRRXy2Zy3/ELgx8H3C8fNC1dasE6OiEYGx4Gr+mMOGg/mwCwY
 zht9xw19QlBdYpVgSYEVXI0Gtz481P69uJbnzps4sI9rNcVDu7mehDLqUc6SoKaGk7cPXjKQ0
 qU/9x/g7gemmMvMzfPG2yFrnU4EmiqHh+IgdhMtMSKbbNocWFMA3oSo0z8P9Wp4I+SY16WOne
 5eJhEFoYEA/yuax9PU34a70hyExAuafBgRKg4roTwdYOeVIT2jAPtvIOasBKBqvskf5hTrMkY
 hc0kUtUfDAwCNAne7ysOYURmUSe3Sw9FmSS6HcQdqIyYkUEquPwBDfVZg1jfbT/DfzjTWaxfB
 8gnyewFcNy5vGJ9IoGjfljykB568vNQbUjP4uZE1hmzvVJ7kHn/ajLU1bu+cwLxlA1lmaqYDx
 3wBB8oaBYNpDjlKMrYKVmTG1hIjMbVePnaVieWQBbD5HYM21TaebUFMkT5pIjVQjnRGHrjFzM
 oyWt/x66OyIf73Bx3L69PUcPEuhjEJ+uS2Tflbw3ouD5MnKM5HI1ANUNVb/A2lepPo4kAwfbP
 zFidqjrMTC8HEWwn1lD7mFGwgicSdQ3dnnOo1DbwsVHAC2OaZEAtIbzaxQW6viezzdZhXQ9EO
 OvUK6i0dq3uwdzyboq4MYtjsF96qh95BY+hxRS1Wcx8BbHpsJlTSiRqB2/xn0b0fa3+459zi7
 e8B4leqZs3i6k9YwsX6lkHJ3jptsBSFOiCgBrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/virtio/Kconfig | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 3589764..390f6e0 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -28,17 +28,17 @@ config VIRTIO_PCI_LEGACY
 	default y
 	depends on VIRTIO_PCI
 	---help---
-          Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
+	  Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
 
 	  This option enables building a transitional driver, supporting
 	  both devices conforming to Virtio 1 specification, and legacy devices.
 	  If disabled, you get a slightly smaller, non-transitional driver,
 	  with no legacy compatibility.
 
-          So look out into your driveway.  Do you have a flying car?  If
-          so, you can happily disable this option and virtio will not
-          break.  Otherwise, leave it set.  Unless you're testing what
-          life will be like in The Future.
+	  So look out into your driveway.  Do you have a flying car?  If
+	  so, you can happily disable this option and virtio will not
+	  break.  Otherwise, leave it set.  Unless you're testing what
+	  life will be like in The Future.
 
 	  If unsure, say Y.
 
@@ -47,40 +47,40 @@ config VIRTIO_BALLOON
 	depends on VIRTIO
 	select MEMORY_BALLOON
 	---help---
-	 This driver supports increasing and decreasing the amount
-	 of memory within a KVM guest.
+	  This driver supports increasing and decreasing the amount
+	  of memory within a KVM guest.
 
-	 If unsure, say M.
+	  If unsure, say M.
 
 config VIRTIO_INPUT
 	tristate "Virtio input driver"
 	depends on VIRTIO
 	depends on INPUT
 	---help---
-	 This driver supports virtio input devices such as
-	 keyboards, mice and tablets.
+	  This driver supports virtio input devices such as
+	  keyboards, mice and tablets.
 
-	 If unsure, say M.
+	  If unsure, say M.
 
- config VIRTIO_MMIO
+config VIRTIO_MMIO
 	tristate "Platform bus driver for memory mapped virtio devices"
 	depends on HAS_IOMEM && HAS_DMA
- 	select VIRTIO
- 	---help---
- 	 This drivers provides support for memory mapped virtio
-	 platform device driver.
+	select VIRTIO
+	---help---
+	  This drivers provides support for memory mapped virtio
+	  platform device driver.
 
- 	 If unsure, say N.
+	  If unsure, say N.
 
 config VIRTIO_MMIO_CMDLINE_DEVICES
 	bool "Memory mapped virtio devices parameter parsing"
 	depends on VIRTIO_MMIO
 	---help---
-	 Allow virtio-mmio devices instantiation via the kernel command line
-	 or module parameters. Be aware that using incorrect parameters (base
-	 address in particular) can crash your system - you have been warned.
-	 See Documentation/admin-guide/kernel-parameters.rst for details.
+	  Allow virtio-mmio devices instantiation via the kernel command line
+	  or module parameters. Be aware that using incorrect parameters (base
+	  address in particular) can crash your system - you have been warned.
+	  See Documentation/admin-guide/kernel-parameters.rst for details.
 
-	 If unsure, say 'N'.
+	  If unsure, say 'N'.
 
 endif # VIRTIO_MENU
-- 
1.9.1

