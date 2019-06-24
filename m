Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55993C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2576020663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BY8r3PHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfFXH3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:29:07 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:22698
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfFXH3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcUMMlk2T6FCv3ooxkAw1KBcFem5h9ljJ6hTfF7mie8=;
 b=BY8r3PHnQK6EYOsagGY5TaXi5Nu/yg8eIMSbgAcLrrL/3nRa4DqRfr9OJMxk0hNyCYDckMfdiE3EgmZfkYUWJnBlBn6stwTivVyAZdnOub9CBU4C/jCUM4ayaOEaERgwLQAQzofFlBobg5wPUqkZj0LqFKNsIMRMe8clWCkZM+U=
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com (20.177.35.159) by
 AM6PR04MB6008.eurprd04.prod.outlook.com (20.178.95.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 24 Jun 2019 07:28:59 +0000
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::9c87:7753:43b9:6d4a]) by AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::9c87:7753:43b9:6d4a%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 07:28:59 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "matti.vaittinen@fi.rohmeurope.com" 
        <matti.vaittinen@fi.rohmeurope.com>,
        "andradanciu1997@gmail.com" <andradanciu1997@gmail.com>
CC:     Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Richard Hu <richard.hu@technexion.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "sriram.dash@nxp.com" <sriram.dash@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH] arm64: dts: fsl: wandboard: Add a device tree for the
 PICO-PI-IMX8M
Thread-Topic: [RFC PATCH] arm64: dts: fsl: wandboard: Add a device tree for
 the PICO-PI-IMX8M
Thread-Index: AQHVJ2zohKcPnCfCB0KClMsEZavGNKaqUz+AgAAa4AA=
Date:   Mon, 24 Jun 2019 07:28:59 +0000
Message-ID: <0c09227705b9f06bff3dc4341538968cba6c6cd0.camel@nxp.com>
References: <20190620133252.31373-1-andradanciu1997@gmail.com>
         <20190624055247.GA10377@localhost.localdomain>
In-Reply-To: <20190624055247.GA10377@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d82dec5c-3901-4ea2-7d95-08d6f8759ff7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6008;
x-ms-traffictypediagnostic: AM6PR04MB6008:
x-ms-exchange-purlcount: 2
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB6008AD728D9AC83C9A0E2008F9E00@AM6PR04MB6008.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(199004)(189003)(478600001)(6116002)(229853002)(66476007)(6436002)(53936002)(36756003)(66066001)(4744005)(186003)(71200400001)(11346002)(8676002)(316002)(66946007)(81166006)(8936002)(73956011)(54906003)(64756008)(91956017)(66556008)(110136005)(66446008)(2616005)(7416002)(71190400001)(102836004)(99286004)(2501003)(68736007)(118296001)(14454004)(6306002)(5660300002)(76116006)(81156014)(44832011)(966005)(26005)(305945005)(76176011)(6486002)(4326008)(6246003)(6512007)(6506007)(256004)(25786009)(446003)(50226002)(7736002)(2906002)(86362001)(3846002)(486006)(476003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6008;H:AM6PR04MB5207.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b21gff9GuunTJrKJ1KvNg5vwRS7TCjosqW6RRG69idaeJa4u6SYJcPuxLw7cOcc/0zUuPiZ4Wxk0S10SKSPA/u+dq3kt0ISQK+iTXGtijhxrfa1Rad+f1jO1+g4OvPdgyfhKUMbf2oVf26T6w1PK23ygGtyzpRixuwme7WP0BhfHKjVIcSLVtK6lyFuonuH59zth+nGTPW32qsYNrVHONNTDdX4h35usjknVVbBMa/I549rX9KoGRug3pieEVAoKjWTc4ReqHB16cdxjeA6wYE4/J2ku5jdB7++Cobtgzqf7CDTlYZgcNwUSWyvOi7rtulWd0g9vBU4k0zx3tjQVVsEL4eiGe3IfUvxxuudxZMIHcj9RDlJzUbnQfgGa60bChL4ptmxmJ3ngLN40FrT9skgYnNVUjVkul5PFggl9g4E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1F1956BB4511F4DAD550F85FF77E2C0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82dec5c-3901-4ea2-7d95-08d6f8759ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 07:28:59.7463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDA4OjUyICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+IEhlbGxvIFJpY2hhcmQsDQo+IA0KPiBOaWNlIHRvIHNlZSB5b3UgdXBzdHJlYW1pbmcgdGhp
cyEgVGh1bWJzIHVwIQ0KPiANCj4gSnVzdCBmZXcgcmVtYXJrcyB0byBwbWljIG5vZGUgZnJvbSBt
ZToNCj4gDQo+IA0KDQpUaGFua3MgYSBsb3QgTWF0dGkgZm9yIHJldmlldy4gSSBhbSB3b3JraW5n
IHRvZ2V0aGVyIHdpdGggQW5kcmENCmZvciBhIEdvb2dsZSBTdW1tZXIgb2YgQ29kZSBwcm9qZWN0
LiANCg0KVGhlIGZpcnN0IHN0ZXAgb2YgdGhlIHByb2plY3QgaXMgdG8gaGF2ZSBQSUNPLVBJLUlN
WDhNIHdvcmtpbmcgd2l0aA0KdGhlIHVwc3RyZWFtIGtlcm5lbC4NCg0KU28sIHdlIHRvb2sgdGhl
IHBhdGNoZXMgZnJvbSBodHRwczovL2dpdGh1Yi5jb20vd2FuZGJvYXJkLW9yZyB0cmltbWVkDQp0
aGVtIHRvIGhhdmUgYmFzaWMgYm9vdCBzdXBwb3J0IGFuZCBzZW50IHRoZW0gZm9yIHJldmlldy4N
Cg0KV2Ugd2lsbCB0cnkgdG8gYWRkcmVzcyBhbGwgeW91ciBjb21tZW50cyBpbiB2Mi4gVGhhbmtz
IGFnYWluIGZvcg0KcmV2aWV3IQ0KDQpBZGRpbmcgbGludXgtaW14IG1haWxpbmcgbGlzdC4gDQoN
CkZvciBjb250ZXh0OiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS82LzIwLzQ4Nw0KDQpEYW5p
ZWwuDQo=
