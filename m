Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB34C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381DE233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566572110;
	bh=fr4N7dB86WBDn85mKUGsngUXYt3sdawwdc92J+rXkWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tzFgD4qbdAnJ9GDnyjGkRBkbPaCTEVcqjhRHMEJxW4mfiFTfhuDrF33HQD7tWF0g6
	 WmtA0T+ujSnI/dlvqBpiLN62o7iJ+1l9dxLzmb4qqiRHuCxG6Jz2L76j5H4+IyieMn
	 5MuY9pQZwin1XapYA+faFnLvSA+Bg9JZP0ArzjzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436472AbfHWOzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395561AbfHWOzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:55:05 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636AD23400;
        Fri, 23 Aug 2019 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572104;
        bh=fr4N7dB86WBDn85mKUGsngUXYt3sdawwdc92J+rXkWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoOCQjHM0KeE2TlrDTobHhS0ycIkCQjbx2vZ3RMN3+iemKTa4o4h0wygW+7u0awyn
         Lkj8uNUwKQ5+ELt0Int6Ut40AasNinoloHvDzIzxJQ5h2zpTfOjPXRu7l+MLp92jWj
         ezkYzvX3AqomxcAAa0iDzc3F/j/GGN/PQPhnMg1o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     notify@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RFC 9/9] ARM: dts: exynos: Remove not accurate secondary ADC compatible
Date:   Fri, 23 Aug 2019 16:53:56 +0200
Message-Id: <20190823145356.6341-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823145356.6341-1-krzk@kernel.org>
References: <20190823145356.6341-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos3250 ADC has its own compatible because of differences from
other Exynos SoCs.  Therefore it is not entirely compatible with
samsung,exynos-adc-v2.  Remove the samsung,exynos-adc-v2.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 5659c4a10729..784818490376 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -450,8 +450,7 @@
 		};
 
 		adc: adc@126c0000 {
-			compatible = "samsung,exynos3250-adc",
-				     "samsung,exynos-adc-v2";
+			compatible = "samsung,exynos3250-adc";
 			reg = <0x126C0000 0x100>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "adc", "sclk";
-- 
2.17.1

