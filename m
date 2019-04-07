Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F2C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51D21901
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="JAfASmFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDGQFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 12:05:37 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:33476 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfDGQFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 12:05:36 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2019 12:05:35 EDT
Received: from localhost.localdomain (80-110-119-101.cgn.dynamic.surfer.at [80.110.119.101])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7A267C1B9A;
        Sun,  7 Apr 2019 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1554652739; bh=QR00LtWv8/eoQ1jFUpVKmnz8LHOduZ1ATvV/Pnuo9is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JAfASmFl53Bq6XoR06DpM4eAw3rOlr7L/yIS3+kmNGXjGaoy8QUqyiSHLi9oBg4oD
         2zugPZzJIRQx4UARpTIKBu30vf+Fjzo2wjEsQqoPD53gcaAN6HN4DsXbyEQ9AYUJNy
         dX6sg8xlLio/hd/GFwZesBO35QdsrFPKPPkQBuGw=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 3/3] ARM: dts: msm8974-FP2: Add vibration motor
Date:   Sun,  7 Apr 2019 17:58:42 +0200
Message-Id: <20190407155841.27354-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190407155841.27354-1-luca@z3ntu.xyz>
References: <20190407155841.27354-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
index 643c57f84818..bf402ae39226 100644
--- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
@@ -50,6 +50,12 @@
 		};
 	};
 
+	vibrator {
+		compatible = "gpio-vibrator";
+		enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+		vcc-supply = <&pm8941_l18>;
+	};
+
 	smd {
 		rpm {
 			rpm_requests {
-- 
2.21.0

