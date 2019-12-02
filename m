Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CEBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668F420881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="X39EcDwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLBPjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:39:07 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:33802 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfLBPjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1575301134;
        bh=qxhDF0663v1hbvbZByeK69uarzcMA+FhFaj7j+FZi1M=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=X39EcDwtdvb1mbB0zPxP+C+ZyfwzT/uPbezVmrJk+6gY0Kwl838ZmbHNS4eyzBtLH
         5Xbrg8xKbJ90MCH86H1eVvfaUEnVR3T0v6+LnT9gOiIb9nGyIP+6xno87v4mox4u18
         kQnUEh/ft4hqmfes/UHOgK0+glCe5yHOwQGOnUHk=
X-QQ-mid: esmtp4t1575301131t81f1i73m
Received: from Home-PC.lan (unknown [39.180.30.185])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 02 Dec 2019 23:38:49 +0800 (CST)
X-QQ-SSF: 0100000000000040C7101F00000000O
X-QQ-FEAT: EUGmOqWjSYKrlczS1C5GpZ8p2d1quYLjG/gMMWe9CgTsVmZYPXb7FBtwYAbDH
        B0wgDV/bUXf1oOmaOAuDJS347kNatFUsZjkHcMQIp92g7q/WDdD/7eAmRsWVK4TYJx5Dfrv
        hDs60f4EYOEM9jI+mjaKtjTgD1be5qn+jau4+ZaF1q6Lf6uycP5d04KSzv2WVdzb/EudUb/
        75M9jx2HUWY6bGlBdZrMGAMpv/j8F0g7/oeSF59eWuN5aoDiP6/7v1uwRL7pLcsnzOTt+7+
        mbtaO2RkIfF4w4kJmbHS8StZOk7irllV8QsA==
X-QQ-GoodBg: 0
From:   Jack Chen <redchenjs@foxmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jack Chen <redchenjs@live.com>
Subject: [PATCH] ARM: dts: rockchip: Add missing cpu operating points for rk3288-tinker
Date:   Mon,  2 Dec 2019 23:35:40 +0800
Message-Id: <20191202153540.26143-1-redchenjs@foxmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Chen <redchenjs@live.com>

The Tinker Board / S devices use a special chip variant called rk3288-c
and use different operating points with a higher max frequency.

So add the missing operating points for Tinker Board / S devices, also
increase the vdd_cpu regulator-max-microvolt to 1400000 uV so that the
cpu can operate at 1.8 GHz.

Signed-off-by: Jack Chen <redchenjs@live.com>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 81e4e953d4a4..09e83b3d5e7d 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -113,6 +113,17 @@
 	cpu0-supply = <&vdd_cpu>;
 };
 
+&cpu_opp_table {
+	opp-1704000000 {
+		opp-hz = /bits/ 64 <1704000000>;
+		opp-microvolt = <1350000>;
+	};
+	opp-1800000000 {
+		opp-hz = /bits/ 64 <1800000000>;
+		opp-microvolt = <1400000>;
+	};
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_MAC>;
 	assigned-clock-parents = <&ext_gmac>;
@@ -175,7 +186,7 @@
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1350000>;
+				regulator-max-microvolt = <1400000>;
 				regulator-name = "vdd_arm";
 				regulator-ramp-delay = <6000>;
 				regulator-state-mem {
-- 
2.24.0



