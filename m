Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35183C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3838222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077846;
	bh=wPJ8Eff7+YJjxgaQlzD1lfkJRng/4VLIGf6uMqVMwxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOTJFbft2OGXLDE1stVQbNCMt4wtbpcx5JMapZNfovdIOKOCpeSL7Vl59ZjILoW95
	 goEzAoQqnN69ZeETOvukeBt/3otTq1XwYi42blETGMGEQeYEvTOHHD3kk1wd6wan8G
	 zgauf+lnSdaCO4j6aNMF1OWxLNmqOHwVOjKEiq1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbfLKPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:24:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732777AbfLKPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:23:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6561622B48;
        Wed, 11 Dec 2019 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077838;
        bh=wPJ8Eff7+YJjxgaQlzD1lfkJRng/4VLIGf6uMqVMwxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZwvCCVM+GVfiaEVGME276GaOS9XtprO+G3EVzKNVCfOM4e5Uibm1iymz7LaNGCln
         zL2uwtjQe0NKnN7kGe3jYbEQMmPAxPrqFnx7FFDxytBN4RXUzItpD54+o1kD0Lf2jK
         eekM3MtGZLW73N5KrL2KeVRnTdu4rCt6KONllMVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 153/243] ARM: dts: mmp2: fix the gpio interrupt cell number
Date:   Wed, 11 Dec 2019 16:05:15 +0100
Message-Id: <20191211150349.499772685@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 400583983f8a8e95ec02c9c9e2b50188753a87fb ]

gpio-pxa uses two cell to encode the interrupt source: the pin number
and the trigger type. Adjust the device node accordingly.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/mmp2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 47e5b63339d18..e95deed6a7973 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -180,7 +180,7 @@
 				clocks = <&soc_clocks MMP2_CLK_GPIO>;
 				resets = <&soc_clocks MMP2_CLK_GPIO>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 				ranges;
 
 				gcb0: gpio@d4019000 {
-- 
2.20.1



