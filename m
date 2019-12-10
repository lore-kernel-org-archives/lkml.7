Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6FC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0412077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLJMon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:44:43 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:60958 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbfLJMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:44:43 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ieesZ-0004w5-Vj; Tue, 10 Dec 2019 13:44:40 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xBACicTS005661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 10 Dec 2019 13:44:38 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH 1/3] arm64: dts: rockchip: Remove always-on properties from
 regulator nodes on rk3399-roc-pc.
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: five technologies GmbH
Message-ID: <f985665c-86c0-1657-14f8-f77e2ce5a3f7@fivetechno.de>
Date:   Tue, 10 Dec 2019 13:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1575981883;34bf8aa0;
X-HE-SMSGID: 1ieesZ-0004w5-Vj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulators don't need the always-on property, remove it.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
  arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts | 2 --
  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi          | 3 ---
  2 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
index 2c9c13a0fca9..2db9d32ad54a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
@@ -32,8 +32,6 @@ vcc3v3_pcie: vcc3v3-pcie {
  		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
  		pinctrl-names = "default";
  		pinctrl-0 = <&vcc3v3_pcie_en>;
-		regulator-always-on;
-		regulator-boot-on;
  		regulator-min-microvolt = <3300000>;
  		regulator-max-microvolt = <3300000>;
  		vin-supply = <&dc_12v>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 9a1ce3a4ae12..8e01b04144b7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -176,7 +176,6 @@ vcc5v0_host: vcc5v0-host-regulator {
  		pinctrl-names = "default";
  		pinctrl-0 = <&vcc5v0_host_en &hub_rst>;
  		regulator-name = "vcc5v0_host";
-		regulator-always-on;
  		vin-supply = <&vcc_sys>;
  	};
  
@@ -198,7 +197,6 @@ vcc_sys: vcc-sys {
  		pinctrl-names = "default";
  		pinctrl-0 = <&vcc_sys_en>;
  		regulator-name = "vcc_sys";
-		regulator-always-on;
  		regulator-boot-on;
  		regulator-min-microvolt = <5000000>;
  		regulator-max-microvolt = <5000000>;
@@ -392,7 +390,6 @@ regulator-state-mem {
  
  			vcc_sdio: LDO_REG4 {
  				regulator-name = "vcc_sdio";
-				regulator-always-on;
  				regulator-boot-on;
  				regulator-min-microvolt = <1800000>;
  				regulator-max-microvolt = <3000000>;
-- 
2.24.0
