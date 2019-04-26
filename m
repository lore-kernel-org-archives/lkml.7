Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCFDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6454520869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="cCzxyprJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfDZTuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:50:17 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:46844 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDZTuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:50:14 -0400
Received: from localhost.localdomain (80-110-119-101.cgn.dynamic.surfer.at [80.110.119.101])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D9A14C534C;
        Fri, 26 Apr 2019 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1556308212; bh=ux5pPXNztCvPFa+LOzVo2tLbZzC7bbAoCxdqqREXPkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cCzxyprJAUTdPU+iP/bwPScC1iioa3ucHGdxKq96k8tqT+IuUo+rNmwWsiPRpQrb8
         q8qT5nPymBaa3y5w9g9O6mpyxYbCD/pfE34LksMkM7GXCx8tLQltluv3UaX4bbPqoa
         UOY/h5uBh18bOLyRiT7U1ZpJJGR3pKRpp1Zvbuy4=
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
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v5 3/3] ARM: dts: msm8974-FP2: Add vibration motor
Date:   Fri, 26 Apr 2019 21:47:47 +0200
Message-Id: <20190426194747.22256-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426194747.22256-1-luca@z3ntu.xyz>
References: <20190426194747.22256-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node describing the vibration motor on the Fairphone 2.

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

