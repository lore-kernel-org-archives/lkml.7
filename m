Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E3C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EC12082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P9aINnVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEFIjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:39:01 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:59239
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfEFIjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcMsBeA98uqArjM9+lstrkc3YGVHAyu3oPsKflV4lcM=;
 b=P9aINnVsiRAvwc3rIC7M1mDZgC4oJQmM3lmzqCuv2rQIdy5HkyucD7hVLHA6WcsCFAocN5VioCkOpgn4q9oY7Fpe6usXCrBRPGx0DVKmRRd0sWj3WAfQzdOwI06utTWoiGC+/DL0JdHd48ZhPE13fCiUSgxEOZo4BAQmZDo013g=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5777.eurprd04.prod.outlook.com (20.178.202.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 08:38:56 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:38:56 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: RE: [PATCH 3/4] defconfig: arm64: enable i.MX8 nvmem driver
Thread-Topic: [PATCH 3/4] defconfig: arm64: enable i.MX8 nvmem driver
Thread-Index: AQHVA0Zq0lMMTqYsu0eS+A3G1K8gPqZdxoXA
Date:   Mon, 6 May 2019 08:38:56 +0000
Message-ID: <AM0PR04MB4211B499C58E61723BE35DA780300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
 <20190505134130.28071-3-peng.fan@nxp.com>
In-Reply-To: <20190505134130.28071-3-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 976de633-4b5b-4eaf-f6f2-08d6d1fe4737
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5777;
x-ms-traffictypediagnostic: AM0PR04MB5777:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB57774CD5B9366F3DE4D073FF80300@AM0PR04MB5777.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(71190400001)(2201001)(71200400001)(25786009)(86362001)(6436002)(316002)(7696005)(76176011)(99286004)(256004)(54906003)(110136005)(3846002)(26005)(186003)(8936002)(6116002)(446003)(11346002)(8676002)(478600001)(81156014)(6506007)(102836004)(81166006)(14454004)(476003)(66066001)(53546011)(486006)(44832011)(68736007)(229853002)(2906002)(33656002)(5660300002)(2501003)(4326008)(7416002)(52536014)(305945005)(9686003)(7736002)(6246003)(74316002)(53936002)(55016002)(66556008)(64756008)(66446008)(66476007)(66946007)(73956011)(76116006)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5777;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ehVFjJE1QDbN1zpOEpKBmk8loMKKxRc+8p7Xx6/5eLljSaNGBZdm432Ot02RY/AsN+f+P8ZwOYB2dxkhZHk6FOvua/ilp71ujMP+gJpAThtmov/I+2yUg/xl/k6Qn/GMRC3zHuj7vxNZvwtkynYaWPgvnUA+eEFvkAcAvfoCavdRhY/KTedU1I2oxfuNDxAw8erj1KLUTUaewHHW8q+JpPUln24VUzjbYvpj82RYJVQV0p87JKp8W2lLse8MFE0/h0xO4VDdtNnAlx2ilX3igiyF0iWIXVjcQomKHJhV+qu4I8KcnoGQlNKhJMYFuRcOqzpML8xc/Q1ekGbqqCiyD91M9ThFhMO5qGVeNQfLNi2NP3od39pV22FR7Xy109w0XpCHiHV6NIEv0dmZG5s0oLsfWESjtaUAfk3LFIpD/FY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976de633-4b5b-4eaf-f6f2-08d6d1fe4737
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:38:56.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5777
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbg0KPiBTZW50OiBTdW5kYXksIE1heSA1LCAyMDE5IDk6MjggUE0NCj4g
U3ViamVjdDogW1BBVENIIDMvNF0gZGVmY29uZmlnOiBhcm02NDogZW5hYmxlIGkuTVg4IG52bWVt
IGRyaXZlcg0KPiANCj4gQnVpbGQgaW4gQ09ORklHX05WTUVNX0lNWF9PQ09UUF9TQ1UuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0KZGVmY29uZmln
OiBhcm02NDogZW5hYmxlIGkuTVg4IFNDVSBvY3RvcCBkcml2ZXINCg0Kb3RoZXJ3aXNlOg0KUmV2
aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMN
CkRvbmcgQWlzaGVuZw0KDQo+IENjOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tPg0KPiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+DQo+IENjOiBT
aGF3biBHdW8gPHNoYXduLmd1b0BsaW5hcm8ub3JnPg0KPiBDYzogQW5keSBHcm9zcyA8YW5keS5n
cm9zc0BsaW5hcm8ub3JnPg0KPiBDYzogTWF4aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290
bGluLmNvbT4NCj4gQ2M6IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD4NCj4gQ2M6IEph
Z2FuIFRla2kgPGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPiBDYzogQmpvcm4gQW5kZXJz
c29uIDxiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZz4NCj4gQ2M6IExlb25hcmQgQ3Jlc3RleiA8
bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+DQo+IENjOiBNYXJjIEdvbnphbGV6IDxtYXJjLncuZ29u
emFsZXpAZnJlZS5mcj4NCj4gQ2M6IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxl
dGJvQGNvbGxhYm9yYS5jb20+DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gLS0tDQo+ICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMSArDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiBp
bmRleCBlYjMxYzIwZTk5MTQuLjlkOGE1MTJmYzNkNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02
NC9jb25maWdzL2RlZmNvbmZpZw0KPiArKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmln
DQo+IEBAIC03NDgsNiArNzQ4LDcgQEAgQ09ORklHX0hJU0lfUE1VPXkNCj4gIENPTkZJR19RQ09N
X0wyX1BNVT15DQo+ICBDT05GSUdfUUNPTV9MM19QTVU9eQ0KPiAgQ09ORklHX05WTUVNX0lNWF9P
Q09UUD15DQo+ICtDT05GSUdfTlZNRU1fSU1YX09DT1RQX1NDVT15DQo+ICBDT05GSUdfUUNPTV9R
RlBST009eQ0KPiAgQ09ORklHX1JPQ0tDSElQX0VGVVNFPXkNCj4gIENPTkZJR19VTklQSElFUl9F
RlVTRT15DQo+IC0tDQo+IDIuMTYuNA0KDQo=
