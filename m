Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B000EC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779C5218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IedyWXku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfDXC7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 22:59:52 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:53927
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfDXC7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 22:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3Ev37pyr660KlUzvzbD/vrqlr3dOPmVh3e667g6dPc=;
 b=IedyWXkuD3gyjWPXFSmh+Hcgccf6mozRN9sFPJ4QK2a2im7lPD19V61w2IulFfI3YR9GFctf4Sk5ImE7bJlttGbjoaIVbiqBFZ1ORovZ0hmgVBFL/mEFyk2v8YbAhP/tU6rH8Up/AOAzffA1Sm+iRidAYHolHPf4Sij2LdMg3sM=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5983.eurprd04.prod.outlook.com (20.178.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.19; Wed, 24 Apr 2019 02:59:45 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 02:59:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct
 SDMA script for SPI5 core"
Thread-Topic: [EXT] Re: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct
 SDMA script for SPI5 core"
Thread-Index: AQHU+duJhg3FYZIDo06xOgy8G5yNgqZJxroAgADXW4A=
Date:   Wed, 24 Apr 2019 02:59:45 +0000
Message-ID: <1556074411.11321.1.camel@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
         <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
         <CAOMZO5C5Sc0=_Jsb_CW-Vf9_Zka7OaA66uo3OPB4NsHzo92T3A@mail.gmail.com>
In-Reply-To: <CAOMZO5C5Sc0=_Jsb_CW-Vf9_Zka7OaA66uo3OPB4NsHzo92T3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 083590dd-64b8-436b-6a2f-08d6c860e806
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5983;
x-ms-traffictypediagnostic: VI1PR04MB5983:
x-microsoft-antispam-prvs: <VI1PR04MB5983F04E76B03278C60D762C893C0@VI1PR04MB5983.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39850400004)(396003)(346002)(136003)(189003)(199004)(316002)(4326008)(102836004)(68736007)(99286004)(256004)(66946007)(73956011)(2501003)(66066001)(5640700003)(66556008)(8936002)(91956017)(54906003)(64756008)(6506007)(66476007)(66446008)(2351001)(6512007)(81166006)(50226002)(81156014)(1361003)(76176011)(97736004)(53546011)(1730700003)(86362001)(6436002)(76116006)(53936002)(71200400001)(1411001)(14454004)(4744005)(6486002)(7416002)(476003)(446003)(305945005)(71190400001)(25786009)(8676002)(2616005)(7736002)(11346002)(6246003)(3846002)(6916009)(103116003)(478600001)(2906002)(36756003)(186003)(229853002)(5660300002)(486006)(26005)(6116002)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5983;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cwkrRzE+7QpftZDFbhicup2HGUIHA3feNaWTCtSvj652vitL4zzlGr1Zex+3m5lK0i9s8iYC36IzFeTM25/ZcAZDRjfDOg6skP/hjrN29TfYQ/rkzo67Zy1pHCGwCCZTH8D+ExexTqAbn9/huzNAtmXaanRbtZx/2hBQY13788exTk4H0+4fdZUdaBLp7lGVGFKpbDKHUSlrQxSW5PvU+n1ril/4X+Kws+wjvX2Uqflpl6xTWA2eZUvyi9zYv7q837KKCqk0vjjCeuHaEZW7I/mDi9BeoERjdERvUNYrWsx4QWxcq5ZWhlHL5v3yKrdCtePiC3BX9woQ2N/jBcoxzNytXiJqyDnoIF85lzome39z63LUavviwXH9cEjaoZ5+G8fkLi4AGLSsLQefVpvv38LnfAzrvlq3zjw2vZiJ32M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <691EB444F5402145BBF3E5159D367C23@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083590dd-64b8-436b-6a2f-08d6c860e806
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 02:59:45.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yMyBhdCAxMTowMiAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gSGkg
Um9iaW4sDQo+IA0KPiBPbiBUdWUsIEFwciAyMywgMjAxOSBhdCAxMDo1MCBBTSBSb2JpbiBHb25n
IDx5aWJpbi5nb25nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IFRoaXMgcmV2
ZXJ0cyBjb21taXQgZGYwNzEwMWUxYzRhMjllODIwZGYwMmY5OTg5YTA2Njk4OGIxNjBlNi4NCj4g
WW91IG5lZWQgdG8gcHJvdmlkZSBhIGRldGFpbGVkIGV4cGxhbmF0aW9uIGluIHRoZSBjb21taXQg
bG9nIGFzIHRvDQo+IHdoeQ0KPiB0aGUgcmV2ZXJ0IGlzIG5lZWRlZC4NCk9rYXksIHdpbGwgYWRk
cmVzcyB5b3VyIGNvbW1lbnRzIGludG8gVjIu
