Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD5EC17440
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888EB21848
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355429;
	bh=CGJbKln3Rkg2sxB7qY0MAuLx3+hEzsvt48vMiraYkKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yVhTE4FbgbFrc1qGlXXhRYP/+VmACpSRM0eQl7Cd7phtLFmuwKoLEqZCfiuqnnXkL
	 c6uWY8NYfTAvMLWE5CrsTjebt7QFKoAX/ntonzw0gpC83YNTCTalm+Szbp+6ZXv4b/
	 9imLXb7+YAG/x/lu5BaoKNeDBvxYWS7rXA11rDF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfKJDK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbfKJCoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B02521655;
        Sun, 10 Nov 2019 02:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353842;
        bh=CGJbKln3Rkg2sxB7qY0MAuLx3+hEzsvt48vMiraYkKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkkOtPuh3D9aHujc6Y70hHLwYQm9ujsLtTRrTR44dj0Bq5Iyo3wgIlDxh/aLFGTMH
         Lx2Rcj4WKJRq0Qhs+BhAkphEyIzNkbcgVurYq8Rwbg9Ov8BHXKMtMGS9NXt2mCHEAM
         ZRvN74fPrmZIxTqSvLcJNODB7F34LMgJJtjcbEEU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 130/191] ARM: dts: meson8b: odroidc1: enable the SAR ADC
Date:   Sat,  9 Nov 2019 21:39:12 -0500
Message-Id: <20191110024013.29782-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit fd6643142a0c5ab4d423ed7173a0be414d509214 ]

Odroid-C1 exposes ADC channels 0 and 1 on the GPIO headers. NOTE: Due
to the SoC design these are limited to 1.8V (instead of 3.3V like all
other pins).
Enable the SAR ADC to enable voltage measurements on these pins.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 8fdeeffecbdbc..8a09071d712a5 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -153,6 +153,11 @@
 	pinctrl-names = "default";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vcc_1v8>;
+};
+
 &sdio {
 	status = "okay";
 
-- 
2.20.1

