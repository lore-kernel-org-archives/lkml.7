Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBAB2251E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257216;
	bh=mDSqcvomL2gb4VEyadcdfVadEksYJhKaDzb+RgGpEqw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Cy8xyWCTsyPGOWsKlv5QOHKTQebLtkQ7lcN+6tjL4PxdPyUZcXJgkgFPi4uVwgFc3
	 mVNm/03qeCx7OTzEe57+N4nUd/AnSvRlwwZn7T7CESXA1sgNY+INZIsrZBPgHwPysi
	 gEVJ0SDaNCPxYxaT2KpKZU5H+Mns5JJQh16GIuV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfKTNkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbfKTNkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:14 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1E022506;
        Wed, 20 Nov 2019 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257213;
        bh=mDSqcvomL2gb4VEyadcdfVadEksYJhKaDzb+RgGpEqw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ysj+KYqAPrP3OArO/4E02LlWFMG5pIk+Fw/D9HnzOIYrMSCdNUkDwSOtUbhQzkTpQ
         FDQZyQrlyphn74dd6dJ1Xy1TELSWuXMTX+chFMs6Iw+9G5xIShvuUeGQAlqATy0RK/
         A2AByklkG+0pLMnGSV3srfYSaypaL4lnaPoGS9Oc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/mellanox: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:09 +0800
Message-Id: <20191120134009.14222-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/platform/mellanox/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 386336d1e48b..56e037623b29 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -41,19 +41,19 @@ config MLXBF_TMFIFO
 	depends on VIRTIO_CONSOLE && VIRTIO_NET
 	help
 	  Say y here to enable TmFifo support. The TmFifo driver provides
-          platform driver support for the TmFifo which supports console
-          and networking based on the virtio framework.
+	  platform driver support for the TmFifo which supports console
+	  and networking based on the virtio framework.
 
 config MLXBF_BOOTCTL
 	tristate "Mellanox BlueField Firmware Boot Control driver"
 	depends on ARM64
 	depends on ACPI
 	help
-          The Mellanox BlueField firmware implements functionality to
-          request swapping the primary and alternate eMMC boot partition,
-          and to set up a watchdog that can undo that swap if the system
-          does not boot up correctly. This driver provides sysfs access
-          to the userspace tools, to be used in conjunction with the eMMC
-          device driver to do necessary initial swap of the boot partition.
+	  The Mellanox BlueField firmware implements functionality to
+	  request swapping the primary and alternate eMMC boot partition,
+	  and to set up a watchdog that can undo that swap if the system
+	  does not boot up correctly. This driver provides sysfs access
+	  to the userspace tools, to be used in conjunction with the eMMC
+	  device driver to do necessary initial swap of the boot partition.
 
 endif # MELLANOX_PLATFORM
-- 
2.17.1

