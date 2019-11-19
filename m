Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB37DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7967120692
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143831;
	bh=DCGoM8RFU/85m16B7mGU3/4vxVxz030aYpVZQqpMOeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sUp2mIOWEUtnBVj+zg8WZJtgo9Smv04vtBnNdlhCK6OnuwSw+g5FJfSnbGyJlnm3T
	 /XTHZENFVZ1lSg6mTdncP7dy6E6scC8z3Hdu/OMNIQbI6Aldpj1qW3lQ7t200Foun4
	 W4nORQBFfO6NUvV1hEWdhGkepSwGn3FlCVNx+Cwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfKSGKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbfKSF01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:26:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A7721939;
        Tue, 19 Nov 2019 05:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141187;
        bh=DCGoM8RFU/85m16B7mGU3/4vxVxz030aYpVZQqpMOeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHqgLKP9KWJyB7pw9afdrVKJyX+kkXOIGCbWlBHzkaBYAXe3k44i+REB8kBUhbKBi
         3i2Yx/58Yff07gxRbrK2nZr5k/FNRxLGJWdolrCKmIa+GDBuGmo1oDqLbawi8mlhHx
         NrTEJSwlMleSmWT73S1nhXTSXYvcQyctY7qZp0hk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/422] ARM: dts: exynos: Fix sound in Snow-rev5 Chromebook
Date:   Tue, 19 Nov 2019 06:14:31 +0100
Message-Id: <20191119051404.368327480@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 64858773d78e820003a94e5a7179d368213655d6 ]

This patch adds missing properties to the CODEC and sound nodes, so the
audio will work also on Snow rev5 Chromebook. This patch is an extension
to the commit e9eefc3f8ce0 ("ARM: dts: exynos: Add missing clock and
DAI properties to the max98095 node in Snow Chromebook")
and commit 6ab569936d60 ("ARM: dts: exynos: Enable HDMI audio on Snow
Chromebook").  It has been reported that such changes work fine on the
rev5 board too.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[krzk: Fixed typo in phandle to &max98090]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5250-snow-rev5.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-rev5.dts b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
index 0348b1c49a691..7cbfc6f1f4b8f 100644
--- a/arch/arm/boot/dts/exynos5250-snow-rev5.dts
+++ b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
@@ -20,6 +20,14 @@
 
 		samsung,model = "Snow-I2S-MAX98090";
 		samsung,audio-codec = <&max98090>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98090 0>, <&hdmi>;
+		};
 	};
 };
 
@@ -31,6 +39,9 @@
 		interrupt-parent = <&gpx0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98090_irq>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
+		#sound-dai-cells = <1>;
 	};
 };
 
-- 
2.20.1



