Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABC9C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF46B218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962232;
	bh=RrBrW3bQ+IVgoMw70L7aHGUNGA2w4cBL1rbSAQDMiJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLfP3D1NCB8xZ775/7Y/dJFFhRvUIX1HOCHjsT+YCSb82bOhcdB/0Z4lW41nAHaq/
	 ua4CpheAhyqvpQ3n4HtVxIaaZ6ipmUjVALsKWgHByfxgxV792GzlkLBC0J7KAlYh1T
	 kyQAUrd5BJKdg87oOY+Adp7WIlBuyLhUoXn3jqgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfDVTnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfDVTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E054218E0;
        Mon, 22 Apr 2019 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962227;
        bh=RrBrW3bQ+IVgoMw70L7aHGUNGA2w4cBL1rbSAQDMiJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wdy1fBii4UzB5dRPHVhhdVvh1IefhEpjaIXlyKMSJmqoGLWXumc+7UMrVLkYVulzB
         BHq2OpsA3x+5aEC5rhy2hNVsi5ffgjmmoCYACc4ph5iB1+BJLZpMwz/Lu9eX/MrKnJ
         A1PaeAj84KtyquY0SNbPBkopbhfb0wKfV0fXjQv8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 48/98] ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi
Date:   Mon, 22 Apr 2019 15:41:15 -0400
Message-Id: <20190422194205.10404-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
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
index 1d1b4bd0670f..a4217f564a53 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -264,7 +264,7 @@
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	vmcc-supply = <&reg_sd3_vmmc>;
 	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-	bus-witdh = <4>;
+	bus-width = <4>;
 	no-1-8-v;
 	status = "okay";
 };
@@ -275,7 +275,7 @@
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

