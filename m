Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7049EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E222081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=iris.mystia.org header.i=@iris.mystia.org header.b="M7b5EZya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfCGQ1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:27:21 -0500
Received: from lyra.margatroid.com ([118.27.33.189]:46138 "EHLO
        lyra.margatroid.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:27:20 -0500
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 11:27:19 EST
From:   Tomohiro Mayama <parly-gh@iris.mystia.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris.mystia.org;
        s=lyra-20180701; t=1551975511;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding; bh=8IXl5Zk+sg1YxsIfV7dpJEnm/gJGF4AT0ouhK3bdB1E=;
        b=M7b5EZyagrSDKgJfBBRIG1mm3Cd7AgAOpo2US2mIy6TIYPdHrxcziA4k6p0DWo2s4y2kH+
        +5ZQvt4dxDhEM09oNhlkx20FVLaNvmN6ovW60cooDLro+FngRMetw31DSKbqq4dpHXI3Yq
        muayiFEdmRfl8bYpaSNgrFpfAe/BcgTqERb7wrw8xftmk3/Ax3WhiyYM1tQKyJteMrtCUf
        sKeyDLJAXqiAw9VhfUXDHVJMnLWoS0hyfkj7nX2+Iql0unqw5EymRoxxCGEWvic1goU8J3
        huFHSDZWDeGFRwgNNXo2zwQxTqRQ2X0SNecTU5FOLNvekCoC1zio2z5zatFKUQ==
Subject: [PATCH] arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on
 rk3328-rock64
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <4e9800cd-ac6d-9eb8-60d4-8e4b1aa761b9@iris.mystia.org>
Date:   Fri, 8 Mar 2019 01:18:33 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes USB ports functioning again.

Signed-off-by: Tomohiro Mayama <parly-gh@iris.mystia.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 21107d0f4378..7f365e448867 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -45,8 +45,7 @@
 
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
-- 
2.21.0

