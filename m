Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794E6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F62020721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306377;
	bh=hP9QwzT6ZwRLhfD/DXx27e0A7cjRZxa8afZINF8p38Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wO7l98kufnXermSVpefo/IyT6BZXb25bpNTo9yi+cdIrRQg/rTUdZvkUy4rJXaLwE
	 prCEhoDZfQz5XHkPcGZ7myqtjn74yMBfrQ/3f47xqlzZHwcKqioht1vnBvrkW5nwpu
	 jRQZcfvoG0qO7aK8YL3+ACtBU8/MtxD4b4TAHrZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfKUDTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUDTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:33 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4115A20898;
        Thu, 21 Nov 2019 03:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306373;
        bh=hP9QwzT6ZwRLhfD/DXx27e0A7cjRZxa8afZINF8p38Y=;
        h=From:To:Cc:Subject:Date:From;
        b=QF9IhtRXQC86MALc1no6f7fLDXGIygB/vggDHK1CYZKygIHLtRtCjBIHbmEZNUmyd
         a6RWMTohj30Y2vC009DexGfDyp+h9gNKWfsQvSduNQMXKc7UuI3hoHYkD3sgEvI29R
         HsAFCUkIE2oJ/kNJAiFAi+Z+yEmCBw8nQ5EsmZBA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:30 +0100
Message-Id: <1574306370-29529-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/iommu/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0b9d78a0f3ac..c4486db105af 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -82,7 +82,7 @@ config IOMMU_DEBUGFS
 config IOMMU_DEFAULT_PASSTHROUGH
 	bool "IOMMU passthrough by default"
 	depends on IOMMU_API
-        help
+	help
 	  Enable passthrough by default, removing the need to pass in
 	  iommu.passthrough=on or iommu=pt through command line. If this
 	  is enabled, you can still disable with iommu.passthrough=off
@@ -91,8 +91,8 @@ config IOMMU_DEFAULT_PASSTHROUGH
 	  If unsure, say N here.
 
 config OF_IOMMU
-       def_bool y
-       depends on OF && IOMMU_API
+	def_bool y
+	depends on OF && IOMMU_API
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-- 
2.7.4

