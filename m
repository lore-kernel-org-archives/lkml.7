Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4628CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ABF20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCBRA3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:00:29 -0500
Received: from mail-oln040092068044.outbound.protection.outlook.com ([40.92.68.44]:6402
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfCBRA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:00:29 -0500
Received: from AM5EUR02FT035.eop-EUR02.prod.protection.outlook.com
 (10.152.8.57) by AM5EUR02HT219.eop-EUR02.prod.protection.outlook.com
 (10.152.9.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.21; Sat, 2 Mar
 2019 17:00:25 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.8.58) by
 AM5EUR02FT035.mail.protection.outlook.com (10.152.8.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21 via Frontend Transport; Sat, 2 Mar 2019 17:00:25 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1665.015; Sat, 2 Mar 2019
 17:00:25 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] arm64: dts: rockchip: add leds node on rk3328-rock64
Thread-Topic: [PATCH 2/3] arm64: dts: rockchip: add leds node on rk3328-rock64
Thread-Index: AQHU0RluaSgsyo/73UmRn2IHPp5WoQ==
Date:   Sat, 2 Mar 2019 17:00:25 +0000
Message-ID: <AM3PR03MB0966B42785AF2CF8A5CB39BCAC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <20190302165641.10905-1-jonas@kwiboo.se>
In-Reply-To: <20190302165641.10905-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0015.eurprd04.prod.outlook.com
 (2603:10a6:206:1::28) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:76CA04E884DC068B1AEAC4397BFBE305F0C23135E16C39C1F31455D91C7E5DEF;UpperCasedChecksum:3838A9C9B983DAE0FCA8D7BD03610489632A1345BF8B2ABD6923282E3C1FFC55;SizeAsReceived:7827;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [dKoON8yenBTOHEy8UhW9+hUlpAJOJP6H]
x-microsoft-original-message-id: <20190302170016.11010-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT219;
x-ms-traffictypediagnostic: AM5EUR02HT219:
x-microsoft-antispam-message-info: G4jYwftw9aqK5XLaUm3BJQnpmz1eNOK3Qi6DU4906p9PBJOWQyb2nre0NQfuTO2l
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe0b1a8-cd9c-4e6a-b7db-08d69f309087
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 17:00:25.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add led nodes on Rock64.
Use heartbeat trigger for the red standby led and
use mmc0 trigger for the white power led.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 8f3e4b7d55c9..c4031b7718fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -65,6 +65,20 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		standby {
+			gpios = <&rk805 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		power {
+			gpios = <&rk805 1 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "mmc0";
+		};
+	};
+
 	sound {
 		compatible = "audio-graph-card";
 		label = "rockchip,rk3328";
@@ -157,6 +171,8 @@
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk805-clkout2";
+		gpio-controller;
+		#gpio-cells = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int_l>;
 		rockchip,system-power-controller;
-- 
2.17.1

