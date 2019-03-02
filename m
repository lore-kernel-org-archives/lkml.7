Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E80FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2642C20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfCBRDS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:03:18 -0500
Received: from mail-oln040092068043.outbound.protection.outlook.com ([40.92.68.43]:4942
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfCBRDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:03:18 -0500
Received: from AM5EUR02FT035.eop-EUR02.prod.protection.outlook.com
 (10.152.8.58) by AM5EUR02HT187.eop-EUR02.prod.protection.outlook.com
 (10.152.9.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.21; Sat, 2 Mar
 2019 17:03:14 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.8.58) by
 AM5EUR02FT035.mail.protection.outlook.com (10.152.8.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21 via Frontend Transport; Sat, 2 Mar 2019 17:03:14 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1665.015; Sat, 2 Mar 2019
 17:03:14 +0000
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
Subject: [PATCHi 3/3] arm64: dts: rockchip: add ir-receiver node on
 rk3328-rock64
Thread-Topic: [PATCHi 3/3] arm64: dts: rockchip: add ir-receiver node on
 rk3328-rock64
Thread-Index: AQHU0RnSV41nMhS4dkaA96HAG2l7fQ==
Date:   Sat, 2 Mar 2019 17:03:14 +0000
Message-ID: <AM3PR03MB0966D9984EDA595D2888DC25AC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <20190302165641.10905-1-jonas@kwiboo.se>
In-Reply-To: <20190302165641.10905-1-jonas@kwiboo.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:206:1::24) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:90CC59655BF4AC12BDE79A7BC8AD6A80D278E372D49882EB116904F51CBF40F2;UpperCasedChecksum:094575092B066C72A5C6703ECD90F54E8A235E6C80771144E3189F5A40DFFD35;SizeAsReceived:7834;Count:51
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [OeEbGXKAatZLcbLOL17bwcjSC84gHXwR]
x-microsoft-original-message-id: <20190302170305.11065-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 51
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT187;
x-ms-traffictypediagnostic: AM5EUR02HT187:
x-microsoft-antispam-message-info: RKekIZF/GCb6HL4hM/iNS00YAkTvWLvsehIQX/rZLbaRQOckKHPJQHVCV1s0yrp4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e223b9e2-3587-40bf-2c0f-08d69f30f50f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 17:03:14.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ir-receiver node to enable on-board IR on Rock64.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index c4031b7718fc..25d0f57254fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -79,6 +79,13 @@
 		};
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&ir_int>;
+		pinctrl-names = "default";
+	};
+
 	sound {
 		compatible = "audio-graph-card";
 		label = "rockchip,rk3328";
@@ -297,6 +304,12 @@
 };
 
 &pinctrl {
+	ir {
+		ir_int: ir-int {
+			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.17.1

