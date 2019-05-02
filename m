Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F3BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD5F2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811047;
	bh=5gLCUtPlgb6hs75ZALfG5QUZSaVgK2jJsYzhOTnA9Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pG39Q6uFZFY7nP9I3iykuFeet7TFl+gwqbp16OZaihBgZ+U4b8FRabMlfSMv6JFPk
	 R0idBzO8v9PtQhMxzSg8GJNngIXnuZPSdW3zVTlb8q29YUpNOqHduzxGxjYxr12Ce4
	 l5yyCOf5bGnkHnCzbZggAXq8pk2rlUQ72c2y4j6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfEBPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbfEBPaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:30:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410572081C;
        Thu,  2 May 2019 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811045;
        bh=5gLCUtPlgb6hs75ZALfG5QUZSaVgK2jJsYzhOTnA9Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbRIMRnq6KC2KlXGcL2G1d7x9hMVe6YuL2HvVBpIG3YEbbMXb5YMz4wuKjjSWO9jb
         LCV7bIteSr1hqwsfZ3N+jWfXAvcM8jy2oKihJu7neDHJ4H3QDxoJ8/75Y7ZRXKnSs1
         ox0ykh7jEqrIbEXLh5+unus8kq+83UipTSmXjj7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 053/101] ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi
Date:   Thu,  2 May 2019 17:20:55 +0200
Message-Id: <20190502143343.219839823@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



