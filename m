Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9576C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E962075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FcSdihHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfEWDW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 23:22:58 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:48611
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728237AbfEWDW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 23:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0rtOIBIqBF899Xf1I66bwMTzGs+Lq9hq0oUhmkYebo=;
 b=FcSdihHYjyznr9CIru/7rz09Zn0VC4TM4l2pZRcgrqYFWUPxbEV9U3eeSS8lo227O1RJz2c0sh5BwPZP0MdeZkBsBBtmqrtnE6KBR0LZ60siZFo3AsNzHfCaw5uu/Zunuf9HFdBPtki72EHL8YuieEcMRjBhiQ4vwsbVrU2xGAM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6676.eurprd04.prod.outlook.com (20.179.255.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 23 May 2019 03:22:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 03:22:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Topic: [PATCH V5 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Index: AQHVEGblzlrg+sJQ0UyXeIb9I0g1x6Z4DK/g
Date:   Thu, 23 May 2019 03:22:53 +0000
Message-ID: <AM0PR04MB4211D3E1C91551964062C7C180010@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1558505898-722-1-git-send-email-Anson.Huang@nxp.com>
 <1558505898-722-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1558505898-722-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efa89dc6-da16-4479-caa3-08d6df2df1a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6676;
x-ms-traffictypediagnostic: AM0PR04MB6676:
x-microsoft-antispam-prvs: <AM0PR04MB6676C3984456FBA85696DC4380010@AM0PR04MB6676.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(186003)(44832011)(305945005)(8936002)(5660300002)(81156014)(7736002)(8676002)(25786009)(71200400001)(2201001)(71190400001)(74316002)(55016002)(81166006)(229853002)(316002)(26005)(11346002)(33656002)(446003)(256004)(66946007)(73956011)(4326008)(3846002)(76116006)(6116002)(52536014)(2501003)(558084003)(476003)(66066001)(2906002)(486006)(66556008)(64756008)(66446008)(66476007)(14454004)(6246003)(9686003)(110136005)(6506007)(99286004)(478600001)(6436002)(68736007)(7696005)(53936002)(102836004)(86362001)(76176011)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6676;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /lO6POIA9DwaRblDkWBnw9GfuHTiN4+moCkOtdGTOCm8TKniEYg89JsdGyDsMX35ByThqjMZIgTthGbn176C+p36lg6KCqg/VlKYGcdpO75e1ZGGpqRVUPrVFEtsQUVgO4dwv7/A+6tEHwsPAH6ltym1hKRpQiZlvRFjHC/EU3OT6HPVlu/DTiYNO0vmj0TSkMk3B0RmAFBadyWS2BlYtv1lytSbiZFO15wvgfd3p2rMcQGKxKVnaJqlyTjJrnsbqnh+dXUn/wiJ4sB+c3MUIEq+KFU1q2ImRDvKa3e5aFO5CG1SYOlC7Go7By78tQHV6KTD5rHqb5ZF46RlWmuGYfb3Dz4XYDvWIyZJ6S22+CYL/w/d9ZHSOfN7dO+C73ofq7oqtGRdRSO7uq5UPg8ChqYimnqQ4KK8ifvuL2EPV3M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa89dc6-da16-4479-caa3-08d6df2df1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 03:22:53.9587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyMiwgMjAxOSAyOjI0
IFBNDQo+IA0KPiBUaGlzIHBhdGNoIHNlbGVjdHMgQ09ORklHX0lNWF9TQ1VfU09DIGJ5IGRlZmF1
bHQgdG8gc3VwcG9ydCBpLk1YIHN5c3RlbQ0KPiBjb250cm9sbGVyIHVuaXQgU29DIGluZm8gZHJp
dmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0K
DQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
