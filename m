Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AED3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02719224FC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257168;
	bh=WxqSkloPNvIniE0B1PNU8Et/vKN6RNMG2IiFN6/e2mA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aBjukz8CwLV07MAxlLIK3c9E61Ejk9K+0II/t5IFjstnK6lhfaPOJiziVv64Mz5Jn
	 127ZzDbJiUtsehNng3O+lktijSnf26VBLKLjqTcxx6biI4w/e7M3eqSbXq8yzSPanw
	 791FPyj6O15g8No6knWAOBQWSeiWP5nSuKhCsQvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfKTNj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfKTNjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:25 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A342224FA;
        Wed, 20 Nov 2019 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257164;
        bh=WxqSkloPNvIniE0B1PNU8Et/vKN6RNMG2IiFN6/e2mA=;
        h=From:To:Cc:Subject:Date:From;
        b=Y7TZ4KjgFZ6iZsKf3fXADVSsXbBnSEvM1WHpXoXZlFnTvrMf9gpXFBft+G+AzBRvj
         dlKzVqlpbYFZoKDZbcO3SB3UTnEIP2uaLHCvILtjduJXmAMKJJeQIOKe1bAGDMWUSx
         PFc3TnB2NuCvbQalMLbptes5BnOo1mo7JCevaRYk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] soc: rockchip: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:20 +0800
Message-Id: <20191120133920.13657-1-krzk@kernel.org>
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
 drivers/soc/rockchip/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index b71b73bf5fc5..3e2057f22bbc 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -15,15 +15,15 @@ config ROCKCHIP_GRF
 	  to make some of them conform to expectations of the kernel.
 
 config ROCKCHIP_PM_DOMAINS
-        bool "Rockchip generic power domain"
-        depends on PM
-        select PM_GENERIC_DOMAINS
-        help
-          Say y here to enable power domain support.
-          In order to meet high performance and low power requirements, a power
-          management unit is designed or saving power when RK3288 in low power
-          mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
+	bool "Rockchip generic power domain"
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, a power
+	  management unit is designed or saving power when RK3288 in low power
+	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
 
-          If unsure, say N.
+	  If unsure, say N.
 
 endif
-- 
2.17.1

