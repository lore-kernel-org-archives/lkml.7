Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6434D204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963107;
	bh=lSq9TkYQvYlDFNHR9A6gTyaodc/RHtHX1TC/GRmg0mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SWl51cmKgrC6z6+7Q9uzIirHN4yKU8L5Fz6+ma/AxOcu6dNgSbLpxD91M2mFmM5Tw
	 /Zzz/BgWXpKHl33y+6i14bFTGN+B9tMYXCljRJYfg053tFj99X9oKZaiQtW791qMq1
	 fhvmkVXyrFxErBUHv1it2WjHFUUmAh6Q0cyz9BC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfDVT60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbfDVTsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70DF218FE;
        Mon, 22 Apr 2019 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962501;
        bh=lSq9TkYQvYlDFNHR9A6gTyaodc/RHtHX1TC/GRmg0mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPw+8DYKzSGHjURln87fp+TjMeOJXnRqF/i29iWgaYzqmoiM4fZ2bpNJPqvaNRIzB
         r0w1CzUCTu6MISFK0th1K1a6il7aDWuvZchmzd9vIKIinjA7HCCdZ611nnLKfnlXi4
         4q4sQu4r++TyX6PAn0qjMF1ZF2gUcOuu5f1q4wGE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 24/43] ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi
Date:   Mon, 22 Apr 2019 15:47:08 -0400
Message-Id: <20190422194727.12495-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>

[ Upstream commit 41b37f4c0fa67185691bcbd30201cad566f2f0d1 ]

This patch fixes a spelling typo.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Fixes: cc42603de320 ("ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7 initial support")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 7ca291e9dbdb..80f1b3fb6abc 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -222,7 +222,7 @@
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	vmcc-supply = <&reg_sd3_vmmc>;
 	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-	bus-witdh = <4>;
+	bus-width = <4>;
 	no-1-8-v;
 	status = "okay";
 };
@@ -233,7 +233,7 @@
 	pinctrl-1 = <&pinctrl_usdhc4_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc4_200mhz>;
 	vmcc-supply = <&reg_sd4_vmmc>;
-	bus-witdh = <8>;
+	bus-width = <8>;
 	no-1-8-v;
 	non-removable;
 	status = "okay";
-- 
2.19.1

