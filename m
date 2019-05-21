Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D382173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6pFOh46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEUIJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:09:29 -0400
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:21639
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbfEUIJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfRVySqbmJywbAD2MzEMSSYmTNe8oT41Id7MVJ84npE=;
 b=A6pFOh46J0THMIzpVLjrxizWX/y4Ws/quWRohY1hDiWbK0mVyMDaJ21zEmEaAXt1RATvSjRdbbrrIsXVcGkePTWDl1SKgapqrec4cT3ccbwZmQ57Ux71C6u6m1IS6z7Cw1/O7Rh8Hz45TMpVvrpNmpVWZtkVaOsPAui/tpThzCw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 08:09:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 08:09:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mq: Add gpio alias
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add gpio alias
Thread-Index: AQHVCgXcX4QYJXCP60mxd4H1AV7MJKZ1RDsAgAAAijA=
Date:   Tue, 21 May 2019 08:09:24 +0000
Message-ID: <DB3PR0402MB3916375ABA4F49AD69899C0FF5070@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557804533-18194-1-git-send-email-Anson.Huang@nxp.com>
 <20190521080647.GB15856@dragon>
In-Reply-To: <20190521080647.GB15856@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 774c6fd9-c807-4643-f95a-08d6ddc3a331
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-microsoft-antispam-prvs: <DB3PR0402MB37554530BF6602D4738A0413F5070@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(13464003)(6246003)(478600001)(446003)(6916009)(44832011)(11346002)(7736002)(186003)(2906002)(102836004)(86362001)(68736007)(66066001)(305945005)(25786009)(81166006)(14454004)(4326008)(6506007)(76116006)(53546011)(53936002)(229853002)(7416002)(8936002)(66476007)(66556008)(64756008)(66446008)(73956011)(66946007)(5660300002)(256004)(52536014)(9686003)(99286004)(54906003)(6436002)(476003)(76176011)(71190400001)(71200400001)(8676002)(3846002)(33656002)(6116002)(316002)(7696005)(81156014)(26005)(74316002)(55016002)(486006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ALIXtnMHPZVTcrNQVFAjS4/viemT7ont72Tb8aTjpm/i5Q106/Vn0opzMCjjftAjX4vbtAx+gquyK4mIOa63qA5aSERh8Q6mT90T4XpNOgsw90QAGBmPPqNL6pmyMJCvEg6uepCZkISqOTcXnF0F+v6LbkcpBme03L3RmVnHvsGg8ray2BiLKOvffEEK9pPM9tyTVbRk9oTZzD9CStRfo9fGfdkN+ZWVIKAoUwu+jzJwFrCU/ZStiunp1TQgDR7E9PCqjJbMyQFkexoNKm5iw/CpD8zrbbaDGRhcgt7KRI2rdcx7IoeLtqYpQyeetwJjwYYlvjBtgIpvpWXnC5Wv6qTN/GrLVhoemvJjclQlHshcPYhe+bZItKQwCvArj1QbNKdiCb5VuMTCZScOGEr+TI21Anr72K0WPOUYEIPPUcU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774c6fd9-c807-4643-f95a-08d6ddc3a331
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 08:09:24.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIFttYWlsdG86c2hhd25ndW9Aa2VybmVsLm9yZ10NCj4gU2VudDogVHVlc2RheSwgTWF5IDIx
LCAyMDE5IDQ6MDcgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0K
PiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54cC5j
b20+OyBhbmRyZXcuc21pcm5vdkBnbWFpbC5jb207DQo+IGNjYWlvbmVAYmF5bGlicmUuY29tOyBh
bmd1c0Bha2tlYS5jYTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBhcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGFybTY0OiBkdHM6IGlteDhtcTogQWRkIGdwaW8gYWxpYXMNCj4gDQo+IE9uIFR1ZSwgTWF5
IDE0LCAyMDE5IGF0IDAzOjMzOjU2QU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEFk
ZCBpLk1YOE1RIEdQSU8gYWxpYXMgZm9yIGtlcm5lbCBHUElPIGRyaXZlciB1c2FnZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSB8IDUg
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCj4gPiBpbmRleCA2ZDYz
NWJhLi5kZjMzNjcyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1xLmR0c2kNCj4gPiBAQCAtMzAsNiArMzAsMTEgQEANCj4gPiAgCQlzcGkwID0gJmVjc3Bp
MTsNCj4gPiAgCQlzcGkxID0gJmVjc3BpMjsNCj4gPiAgCQlzcGkyID0gJmVjc3BpMzsNCj4gPiAr
CQlncGlvMCA9ICZncGlvMTsNCj4gDQo+IFBsZWFzZSBrZWVwIHRoZSBsaXN0IGFscGhhYmV0aWNh
bGx5IHNvcnRlZC4NCg0KT0ssIHdpbGwgc2VuZCBWMiB0byBmaXggaXQuDQoNCkFuc29uLg0KDQo+
IA0KPiBTaGF3bg0KPiANCj4gPiArCQlncGlvMSA9ICZncGlvMjsNCj4gPiArCQlncGlvMiA9ICZn
cGlvMzsNCj4gPiArCQlncGlvMyA9ICZncGlvNDsNCj4gPiArCQlncGlvNCA9ICZncGlvNTsNCj4g
PiAgCX07DQo+ID4NCj4gPiAgCWNraWw6IGNsb2NrLWNraWwgew0KPiA+IC0tDQo+ID4gMi43LjQN
Cj4gPg0K
