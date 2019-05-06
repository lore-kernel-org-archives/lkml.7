Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2283BC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65FF205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DNUCz3+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEFImB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:42:01 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:15424
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfEFImB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV5mny6LY+hppywAbIR4nDXrLFrVHQI/f3F2bo6Uvog=;
 b=DNUCz3+dfmmfDeMU3YCH+Cfd9EqSnqDyMG7DdOB+LbRroyD9fB44MnWIX4oSPc3DUjNNycGnYDaTlTSHsU7UaN+i0L8c/kcdMRW9Z/dlxvVYuxEOWTMb3VQDGBr6ACiIYkIVa8RHP7ROGxgAqEoSEGcqmxmkQ1Uajr97inqgLl4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5521.eurprd04.prod.outlook.com (20.178.112.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Mon, 6 May 2019 08:41:57 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:41:57 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] ARM: dts: imx6qdl: Assign corresponding clocks
 instead of dummy clock
Thread-Topic: [PATCH 2/2] ARM: dts: imx6qdl: Assign corresponding clocks
 instead of dummy clock
Thread-Index: AQHVA7uNN1AtkzSGk0aPTBIep6X3lqZdx23Q
Date:   Mon, 6 May 2019 08:41:57 +0000
Message-ID: <AM0PR04MB42117C838DF3C29056AB94CA80300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557112911-17115-1-git-send-email-Anson.Huang@nxp.com>
 <1557112911-17115-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557112911-17115-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fd062ea-bf41-4d18-3a2e-08d6d1feb2f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5521;
x-ms-traffictypediagnostic: AM0PR04MB5521:
x-microsoft-antispam-prvs: <AM0PR04MB5521FC148F7E827C493A98E680300@AM0PR04MB5521.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:204;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(8936002)(71200400001)(71190400001)(7736002)(2201001)(44832011)(102836004)(26005)(68736007)(446003)(11346002)(476003)(81166006)(81156014)(8676002)(486006)(558084003)(66476007)(55016002)(229853002)(76116006)(66446008)(73956011)(66946007)(52536014)(64756008)(66556008)(6436002)(256004)(186003)(9686003)(53936002)(2501003)(86362001)(74316002)(305945005)(4326008)(33656002)(25786009)(6246003)(66066001)(99286004)(3846002)(6116002)(5660300002)(6506007)(7696005)(478600001)(76176011)(2906002)(110136005)(14454004)(316002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5521;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KIkdIBRUP+XTKNDiSFVu1p75bOgFkox2iieRtBTBcGVCZdz9sUmGqGXlDPMlgtfwkWEPQVb1njNmP3jP1pApnOmUfiO9gUuOJMhnYW8WNqXl2ybK/nK/6t7Cvcz0uOanOoTl9BZ6kQGXyF3/vA67xr9IJMj5j/SEcuLTdn85bwmMkC0FHO2ZRvzb6WK/fkv5k40+nnHFLZkk6jk9DbnZMwGdUwTSR1JgeslJsqqNv0Do9dxg1rAtvPvUeAyx2sRkEVgiUBKBTshEu79Z6l+LmHaHMFoyLDZEMWlAMGkCIuhrBiOLWZQ6A34DOLvvzTDKmI1kFz+/jlB6s+GtYmH670vTOEwdtecm3dsYnSZONSHR+Jdqb2FZ5UUxToKtNGG7xr2BTrbISWLlDzzowmsgbOD2eNz0YoJdUjj0ZQauxCg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd062ea-bf41-4d18-3a2e-08d6d1feb2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:41:57.2876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBNb25kYXksIE1heSA2LCAyMDE5IDExOjI3IEFN
DQo+IA0KPiBpLk1YNlEvREwncyBXRE9HcyB1c2UgSU1YNlFETF9DTEtfSVBHIGFzIGNsb2NrIHJv
b3QsIGFzc2lnbg0KPiBJTVg2UURMX0NMS19JUEcgdG8gdGhlbSBpbnN0ZWFkIG9mIElNWDZRRExf
Q0xLX0RVTU1ZLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
