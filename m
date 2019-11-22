Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A853C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E831520718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419326;
	bh=aluBxgyG66rH0miEhxbojvxTsEkxqtA5iSpzk78LF4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1H+lu6Zfq0+ycpwnisGBdTQJz1kGoqWyzfv/kGIHJcwdTxL7/3u5MjAAnhLotV5h5
	 bftAMKav+besAAYKMEgWQFMXIhI18ex57/FaSTyYrq8+D6vIIGaMRSMBiVlwFX8UL7
	 XkUfZnosm1eV1q15PcMmfzCxFb13s2woLHjxjpWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfKVKmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:42:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbfKVKmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:42:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8696820718;
        Fri, 22 Nov 2019 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419321;
        bh=aluBxgyG66rH0miEhxbojvxTsEkxqtA5iSpzk78LF4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwAdwVAr6pI/SnY/obOXlZcdd/pVlKfDeRpyCuhXdSAsqbeGr6XVP77ariYkjG4TP
         6j5Bf+vAF7umKVyxwDiR/yWT1/zv6uol2QoAdYqYfOplk9RHEgEDS8K19rrMLDS77K
         T4ulnvU4fSo+qleE5+7LXg0wwtFTIDq2rRoJ9GdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 027/222] ARM: dts: exynos: Fix sound in Snow-rev5 Chromebook
Date:   Fri, 22 Nov 2019 11:26:07 +0100
Message-Id: <20191122100840.453330640@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
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
index 90560c316f644..cb986175b69b4 100644
--- a/arch/arm/boot/dts/exynos5250-snow-rev5.dts
+++ b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
@@ -23,6 +23,14 @@
 
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
 
@@ -34,6 +42,9 @@
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



