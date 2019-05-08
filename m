Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4E8C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652A321019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MfvNU5LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEHDmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 23:42:23 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:20228
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfEHDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 23:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/zUq08HnW7dhwD6miK7ZR98RL0VOqWKdF+9oKHCrtw=;
 b=MfvNU5LGdRwsjpkmWxI8KmVv3Vs9WDmXq40V8x1I7F2mKEO4mhVx/8skF+5MAK9krJcwTlkg/wjxkAXlCj8fWllfwMnHjskjBs14VGb7uUE7bMxzrKQtO9r++N2anMxpUuDqrbgCrhHl7IgPK0VyWFe8HZK9SarCu9MaBJxq5+U=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2733.eurprd04.prod.outlook.com (10.175.22.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 8 May 2019 03:42:19 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::9889:fa82:4172:14df]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::9889:fa82:4172:14df%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 03:42:13 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>, Kay-Liu <liuk@cetca.net.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCHv2 1/2] ARM: dts: imx6sx: Use MX6SX_CLK_ENET for
 fec 'ahb' clock
Thread-Topic: [EXT] Re: [PATCHv2 1/2] ARM: dts: imx6sx: Use MX6SX_CLK_ENET for
 fec 'ahb' clock
Thread-Index: AQHVAmkSkfnHjuPrDUuL+rGIVj8MEqZcLD7wgAABdICABCF2AIAAS6QQ
Date:   Wed, 8 May 2019 03:42:12 +0000
Message-ID: <VI1PR0402MB3600C57B5922EC20D87DF913FF320@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1556190530-19541-1-git-send-email-liuk@cetca.net.cn>
 <CAOMZO5BbA6oq8okTR-r800k4XY76XxxEdufd1mjcV6HdTpVotA@mail.gmail.com>
 <AM0PR04MB421133A3F3C6B534B6ECEA7880370@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <VI1PR0402MB360058CE70AD60C116EE0634FF370@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <CAOMZO5CSaRZEiaqxBTcBhaYjRLxMjb6Boyy0eO6OAEFBPv3_Kw@mail.gmail.com>
In-Reply-To: <CAOMZO5CSaRZEiaqxBTcBhaYjRLxMjb6Boyy0eO6OAEFBPv3_Kw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71f75e2-0754-41d6-1d7e-08d6d367284d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2733;
x-ms-traffictypediagnostic: VI1PR0402MB2733:
x-microsoft-antispam-prvs: <VI1PR0402MB2733BF7F84DB9E963392C06BFF320@VI1PR0402MB2733.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(102836004)(6506007)(305945005)(8676002)(6436002)(6116002)(1411001)(11346002)(446003)(6246003)(8936002)(74316002)(7416002)(53546011)(3846002)(68736007)(81156014)(81166006)(186003)(99286004)(25786009)(7696005)(54906003)(14454004)(256004)(2906002)(26005)(86362001)(14444005)(52536014)(7736002)(71190400001)(229853002)(76176011)(55016002)(71200400001)(4326008)(476003)(9686003)(486006)(66446008)(53936002)(316002)(6916009)(33656002)(73956011)(66946007)(76116006)(66476007)(66556008)(64756008)(5660300002)(4744005)(478600001)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2733;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZSAMTL0OwWaYPbDHFGtgOyBO1Pgg2Rrs7t9a/Rx3oTiDjK290TxKgzq/NeT5oKQuFjHJsA+d32m8AEaBYdKtW2k21N8via+30Mh5qY5g+AWIxOBtn5yFKW3OB1d8TmOZXkmF+LJDHU8YPpRN0zRenWo6DpRd/zqpl7wSCaIQDInDq96SzMrgQnYjZoV+UUWPCzP4I5tZ8k+Cs4vCRhucDLrzg/gy7/ACm2mDgt57JPx2YYnHCvUXRa6FvRMfekUNQW8Xk3NJSRep5tWqqgzrisP9GdM6spbXOdqf8mfokQZgX1jUdYJYcCDcerOpBy5c7X/sL6T3GPJ/Lq4Oy/g84UdZwfRk51n7B9TEsmR/V6sxVXFk59niZkt7VFaVaktEZEpPpvJnXyNf/2MWchxQVgw2SosfdtP8PJlG3VZZdsc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f75e2-0754-41d6-1d7e-08d6d367284d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 03:42:12.9527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBIaSBBbmR5LA0KPiAN
Cj4gT24gU3VuLCBNYXkgNSwgMjAxOSBhdCA1OjE1IEFNIEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5A
bnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE5hY2sgdGhlIHBhdGNoICENCj4gPg0KLi4uDQo+ID4g
U2Vjb25kbHksICBmb3IgeW91ciBpc3N1ZSB5b3UgY2F1Z2h0LCB3aGljaCB3YXMgZml4ZWQgYnkg
cGF0Y2g6DQo+ID4gY29tbWl0IGQ3YzNhMjA2ZTYzMzhlNGNjZGYwMzA3MTlkZWMwMjhlMjZhNTIx
ZDUNCj4gPiBBdXRob3I6IEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCj4gPiBEYXRl
OiAgIFR1ZSBBcHIgOSAwMzo0MDo1NiAyMDE5ICswMDAwDQo+ID4NCj4gPiAgICAgbmV0OiBmZWM6
IG1hbmFnZSBhaGIgY2xvY2sgaW4gcnVudGltZSBwbQ0KPiANCj4gV291bGQgdGhpcyBhbHNvIGZp
eCB0aGUgY2FzZSB3aGVyZSBwb3dlciBtYW5hZ2VtZW50IHN1cHBvcnQgaXMgZGlzYWJsZWQ/DQo+
IA0KPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHRoZSBleHBsYW5hdGlvbiBmcm9tIEtheS1M
aXUgaGUgd291bGQgc3RpbGwgc2VlIGENCj4gaGFuZyBpbiB0aGUgY2FzZSB3aGVuIFBNIGlzIGRp
c2FibGVkLg0KPiANCj4gVGhhbmtzDQpGcm9tIGN1cnJlbnQgZGVzaWduLCBpdCBzdGlsbCB3b3Jr
IGV2ZW4gaWYgZGlzYWJsZSBQTS4NClBsZWFzZSBkb3VibGUgY2hlY2sgaXQuDQoNCkFuZHkNCg==
