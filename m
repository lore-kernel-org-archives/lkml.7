Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5264C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE432146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518769;
	bh=QSdhKLOCJdi1nDRDrfplSOxXx5/mnCvmw6p4a8jvB24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fbh0PipRzZkvie7bPxPwVYDeeOtE+XOVODjQY9mAnvOQLFbPhStBvxQhHiOXQQX27
	 fDsognsE0hDKg2xj7f9JXg8uU1WU9vhzTlxSPinj9Zwnnk147bBLWQupU/0Ac0FzeS
	 Aprdo7OWrxCHLL9GA4RoDK9Lr8mppBgTISHTG1LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLPRws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfLPRwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:52:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B9221775;
        Mon, 16 Dec 2019 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518765;
        bh=QSdhKLOCJdi1nDRDrfplSOxXx5/mnCvmw6p4a8jvB24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4hAJ9Kiupev5khp+gNXXvDybt/I358vgU85N6QRp5Jt8Y+M0AIsV+PTtwNGQb39F
         tG6q0mzHZk6hdn9KbD95KBhE+kBtFzcN4hdubt8Ybad7RFiJ8N2oC0DAbklO30+gwX
         Bc1GBwn957MrgcAO4CEqVV0cjQEapZPdhA3tuwW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 056/267] ARM: dts: exynos: Use Samsung SoC specific compatible for DWC2 module
Date:   Mon, 16 Dec 2019 18:46:22 +0100
Message-Id: <20191216174854.609482572@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 6035cbcceb069f87296b3cd0bc4736ad5618bf47 ]

DWC2 hardware module integrated in Samsung SoCs requires some quirks to
operate properly, so use Samsung SoC specific compatible to notify driver
to apply respective fixes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index aa06a02c3ff59..5ba6622549097 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -359,7 +359,7 @@
 		};
 
 		hsotg: hsotg@12480000 {
-			compatible = "snps,dwc2";
+			compatible = "samsung,s3c6400-hsotg", "snps,dwc2";
 			reg = <0x12480000 0x20000>;
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBOTG>;
-- 
2.20.1



