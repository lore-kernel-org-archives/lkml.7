Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37482068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401779;
	bh=zfH7E1dQ0QMkwOWmVhltnebB7TPcOcSQTtCRkRBoYr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yNVogq9az8vw8AMLPcTw1zH4fuDmLAS+uSHZf7CVclGAUD7nVatTPAvUlv8Cj2j2/
	 FoeMW+3xIbZSPV1x1pWOSacsHRDh2zckNRXNnbByKyq8ZPhHk7tFlXGvus0sFa/qS2
	 Mp0wojDw+mQfp2YwbaqVnjvchx95mN0JmGmXq6Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKVFti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfKVFtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:49:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E8082068F;
        Fri, 22 Nov 2019 05:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401771;
        bh=zfH7E1dQ0QMkwOWmVhltnebB7TPcOcSQTtCRkRBoYr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtmvHCf5DPy5iMwKue2/+woJ2/VJOEVw2wuMYMQFPVOXfKeLpcE8hXEpjF46NN+cB
         xKyvvnirPUx5XaUwk8sb3+aCRGzL16RTOlhK9VABu2zeMZq/iRbi8DQYgI7baADJRd
         kwNedyIXQwVGLcgQ65jKAjkZpEPofIHi1vELPyp8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 021/219] ARM: dts: imx53-voipac-dmm-668: Fix memory node duplication
Date:   Fri, 22 Nov 2019 00:45:53 -0500
Message-Id: <20191122054911.1750-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 998a84c27a7f3f9133d32af64e19c05cec161a1a ]

imx53-voipac-dmm-668 has two memory nodes, but the correct representation
would be to use a single one with two reg entries - one for each RAM chip
select, so fix it accordingly.

Reported-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index f83a8c62ea531..d595034f3f1bf 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -17,12 +17,8 @@
 
 	memory@70000000 {
 		device_type = "memory";
-		reg = <0x70000000 0x20000000>;
-	};
-
-	memory@b0000000 {
-		device_type = "memory";
-		reg = <0xb0000000 0x20000000>;
+		reg = <0x70000000 0x20000000>,
+		      <0xb0000000 0x20000000>;
 	};
 
 	regulators {
-- 
2.20.1

