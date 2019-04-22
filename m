Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3634FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39AB20643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963325;
	bh=1Ml4YIYhPWOXP7H/X+zub5MkQ25BFnwgMfMccRfKK+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=miq2kHadphT8Re50HSfEPm6MO7RBwAZ6373c1irtP8GKiUjN8EMITO3MLMdsd2mOd
	 5WotKT8qAB/Iu3s3f36yYbqh8gYHs7Gpvoq6P3Ta4VH6K/cyrs+m5O1VDallS7zX5o
	 nZmShxBtFvPHqCpTsNYMRe3Ymj1WgACaX/cDI3P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfDVTqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbfDVTqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDF221902;
        Mon, 22 Apr 2019 19:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962399;
        bh=1Ml4YIYhPWOXP7H/X+zub5MkQ25BFnwgMfMccRfKK+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTwnte/GoP6HsEp50VZW3CSZ7AsJgi41DZJkJDHtjIv2uCFe5wRWq90LZUtRV+M4X
         S4GvWHrZXq+9rumMg0p339XK2xxsOh9n5j6hi5z3sJkLSAGRkhXnVqNnGP79yckpPP
         /P8YawC91qI13GebFwaMea/H27BHHpYi7s2MkaEM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 37/68] ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi
Date:   Mon, 22 Apr 2019 15:44:45 -0400
Message-Id: <20190422194516.11634-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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
index acc3b11fba2a..cde3025d9603 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -298,7 +298,7 @@
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	vmcc-supply = <&reg_sd3_vmmc>;
 	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-	bus-witdh = <4>;
+	bus-width = <4>;
 	no-1-8-v;
 	status = "okay";
 };
@@ -309,7 +309,7 @@
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

