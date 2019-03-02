Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37180C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0707F20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCBQhN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:37:13 -0500
Received: from mail-oln040092069045.outbound.protection.outlook.com ([40.92.69.45]:33444
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfCBQhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:37:13 -0500
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (10.152.8.58) by AM5EUR02HT006.eop-EUR02.prod.protection.outlook.com
 (10.152.8.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.21; Sat, 2 Mar
 2019 16:37:10 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.8.59) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21 via Frontend Transport; Sat, 2 Mar 2019 16:37:10 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1665.015; Sat, 2 Mar 2019
 16:37:09 +0000
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
Subject: [PATCH] arm64: dts: rockchip: enable HDMI CEC on rk3328
Thread-Topic: [PATCH] arm64: dts: rockchip: enable HDMI CEC on rk3328
Thread-Index: AQHU0RYu2eJLuC9eMUiiVuYYeBrNDw==
Date:   Sat, 2 Mar 2019 16:37:09 +0000
Message-ID: <AM3PR03MB0966D220C0FEB19CBAE0D913AC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0003.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::16) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:4DEDE77BF02F45B20F2AF837D1202C1A2F9B472CC4B6752B0A95EDFF48386340;UpperCasedChecksum:2BAF331CD583558FA71575CA33985254FCB778FE3D239564CBC7618C43C068D7;SizeAsReceived:7696;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [UejiD69iJkSg2wDg6SXFEKj/gFMWItvC]
x-microsoft-original-message-id: <20190302163648.9997-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT006;
x-ms-traffictypediagnostic: AM5EUR02HT006:
x-microsoft-antispam-message-info: 6kSSLolsGzky4Nm6Opx6PHIWtH9j/4RiD/kCff+PW2KuPlkKq64rZ+XuVHzQzFle
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d85fc37-c009-4249-4229-08d69f2d505e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 16:37:09.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables HDMI CEC on RK3328 devices

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 81cc3c996e2a..fcb196212e8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -657,9 +657,11 @@
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_HDMI>,
-			 <&cru SCLK_HDMI_SFC>;
+			 <&cru SCLK_HDMI_SFC>,
+			 <&cru SCLK_RTC32K>;
 		clock-names = "iahb",
-			      "isfr";
+			      "isfr",
+			      "cec";
 		phys = <&hdmiphy>;
 		phy-names = "hdmi";
 		pinctrl-names = "default";
-- 
2.17.1

