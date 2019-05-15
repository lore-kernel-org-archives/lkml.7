Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55879C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c6zIa4VU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEOBaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:30:07 -0400
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:62087
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfEOBaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnkLQ//3Uw4Ium7jl9Pfo7yGvbtaVSrK1bgcAho8OiE=;
 b=c6zIa4VUiWTZifJld5WfVPHoV6qNlff8YE4YOyxH7Fw0VtkrICUctZOJUzdjR8oRtbyKVEKAShN2M0U0t+mwutANqWbx40DQpMGlK5yHe5wp0TUwzTZiKmsImJAemMZZhxgP6S+/0qqWQez5kNdVqC2WvTI5sEBZz+2LR5oEDeg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 01:30:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 01:30:03 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/3] arm64: dts: imx8mm: add clock for SNVS RTC node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mm: add clock for SNVS RTC node
Thread-Index: AQHVCr23b/8pEQWmM0qanbhPyODOvQ==
Date:   Wed, 15 May 2019 01:30:02 +0000
Message-ID: <1557883490-22360-3-git-send-email-Anson.Huang@nxp.com>
References: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7066e137-6ebf-435c-7ad3-08d6d8d4da33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-antispam-prvs: <DB3PR0402MB3724A6C4169C2486C325BA03F5090@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(316002)(256004)(50226002)(81166006)(4326008)(6512007)(8936002)(71190400001)(5660300002)(110136005)(71200400001)(52116002)(2906002)(86362001)(6506007)(386003)(68736007)(81156014)(25786009)(99286004)(102836004)(4744005)(36756003)(186003)(6116002)(3846002)(476003)(486006)(26005)(2201001)(76176011)(11346002)(2616005)(446003)(53936002)(64756008)(73956011)(66446008)(66476007)(66556008)(66946007)(2501003)(478600001)(14454004)(6436002)(305945005)(66066001)(7736002)(6486002)(8676002)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bt9jZMpTOUnECQ7XaSjBjmdRcKQigdUVN73Wr4qyXCE9J8iS7fmUfbmImO7RqO9fJmvBJ1VTDM9t3HaO5riVnhZYd6vzSOMDJkA8uwBvw2lU97q0wdBXf32EWgPxAlFnKiUnd+EXiChKBRlHlg2tn+iJkGL+2PIVcDWxIQm8m8+1cK2L8Mm8bNUQyz1DTY5nqbNdmRxNDOYT52D/gcm4GajrgejiOE/xbqmgDw4f/1mDNgW8JEfMtjhKUT+aSEPXcQnmIzRNLJTX0eRHEAMDWEvlwv1zZG/pf9tK/OqExv79CC4MVfdObK3ZrTSJCIjZ76RclW1Aka2XpSumCFVjTiGrMuZdNnhJtbbsGtr3gMJKTiwj1DpVUHXC8UTuuc7E5h+ZarV7b7+h0fyL+OHw9sCjnB/KFu4wmSj3PsmVIMc=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FCAB47B1A7E4F942BA29A9D00D07C47F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7066e137-6ebf-435c-7ad3-08d6d8d4da33
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 01:30:02.9740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM has clock gate for SNVS module, add clock info to SNVS
RTC node for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index f32d4e9..a357d82 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -341,6 +341,8 @@
 					offset =3D <0x34>;
 					interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+					clocks =3D <&clk IMX8MM_CLK_SNVS_ROOT>;
+					clock-names =3D "snvs-rtc";
 				};
=20
 				snvs_pwrkey: snvs-powerkey {
--=20
2.7.4

