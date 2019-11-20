Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CAEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD6D2251E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257233;
	bh=eR+fEgTISyeCzxxA55ZkRGlbyJFlVVtN8MJ84DTdjM0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cQJhbBVB7TpL0Fpg07APMRuBTzeROU7ygbs3DENjivbQcjHjVR9qfZbfO0UYzqhYa
	 /LXkDUcCi4K1O7p1ils93ANyfVFbwdzFVNHoCGqutAQOE/D1TliqJzx5SKtx4acnaE
	 Bv5tjoFm0JodeHmDt6nAbRVuoiwWCD2ilNitVLfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfKTNkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfKTNka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:30 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E0FB2251E;
        Wed, 20 Nov 2019 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257230;
        bh=eR+fEgTISyeCzxxA55ZkRGlbyJFlVVtN8MJ84DTdjM0=;
        h=From:To:Cc:Subject:Date:From;
        b=Vtf1uYh99RfpglRZIrXy+zGFPcatZMTtNOjnqnnatq9/7lO7KtQ3VPO3HSS4yklvc
         mK0Sbwz/kNfobqs6OIEhCSX269u1ASc2Gnaf5rxt33K6n2+M0/cGISeLLf/iLDKd0L
         ikIVdA1nAGnjaqzzUVeZW6d/395+p3bZ80KY4zMU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] phy: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:25 +0800
Message-Id: <20191120134026.14392-1-krzk@kernel.org>
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
 drivers/phy/hisilicon/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 534e393a09b3..6a591bb84031 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -38,9 +38,9 @@ config PHY_HISI_INNO_USB2
        select GENERIC_PHY
        select MFD_SYSCON
        help
-         Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
-         USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
-         USB host port to accept one USB device.
+	 Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
+	 USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
+	 USB host port to accept one USB device.
 
 config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
-- 
2.17.1

