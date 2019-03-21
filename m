Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D039218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCjLCrdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCUBFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:05:35 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:59606
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbfCUBFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqy7JRd8UngjUVQq/p1ohL+pwznsSIU3E2ayRLRVSvE=;
 b=CCjLCrdVAs+AUNHWJo52kjMaLUIF+3n1LB5v8WdpBqNxKS3gFcBt28N+3lu+YsLv0JGsQnyR+V6JjApQ64ZFbHSTRgbMOBznKAOlHUj/5ZEHBfJjg/g3E/y8E50EoUPUApVh88DxKivfFyajmvfOlF/joKb8eRmmsbKAZ8yE+EI=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5872.eurprd04.prod.outlook.com (20.178.205.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 01:05:30 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f%4]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 01:05:29 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Thread-Topic: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Thread-Index: AQHU0jo9yDvlWMWO2EezapwWi7PmgaX7AH0AgAAEh0CABOLvAIABESAQgACE+ACAAALKMIASxdSAgAAGQzCAAGbFgIAAqpeA
Date:   Thu, 21 Mar 2019 01:05:29 +0000
Message-ID: <VI1PR04MB4333256C38E6DEDD3E0F303AF3420@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
 <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190320081853.GE4980@dragon>
 <VI1PR04MB433351C20A9863EEF21A2504F3410@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190320144907.GC8337@dragon>
In-Reply-To: <20190320144907.GC8337@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e40a523-eb90-4abb-f8b0-08d6ad994fc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5872;
x-ms-traffictypediagnostic: VI1PR04MB5872:
x-microsoft-antispam-prvs: <VI1PR04MB5872B2F5EFA433E361CC3272F3420@VI1PR04MB5872.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(13464003)(189003)(7696005)(5660300002)(14454004)(81166006)(8676002)(229853002)(99286004)(6436002)(6246003)(6916009)(81156014)(55016002)(71190400001)(54906003)(76176011)(52536014)(186003)(53936002)(26005)(71200400001)(11346002)(68736007)(476003)(74316002)(97736004)(93886005)(4326008)(8936002)(478600001)(316002)(446003)(66066001)(7736002)(6116002)(53546011)(86362001)(6506007)(256004)(3846002)(305945005)(102836004)(25786009)(2906002)(9686003)(33656002)(106356001)(486006)(44832011)(105586002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5872;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X/tBhz5XsEf3kkaWRd8ZcjvbEZ2tKOWwsVEjGzio/egaN5lAoYZolZLdn7FC0uHoykHyQCX6VVGSCgHmmJN7sUCEGqUiv+EkRRrFETmUVPMCWW+5LXEs9KWqTu4PY8+mRBMwooHXbeGaSsXBhq9rljgnjkf7IxzMIbrD0A3Hpi2tq2ZxGqqWV1EyEK0Tv4YdsD9JMYvuO3td8rQWolR4f3fxXkCoDtVT+6PHdhoSMJke46xoQwT5y5O8Tx15aAuUpr5VOXcccUqOfKBYL0eBwA3x8xP6yArnJ+hD1cs3AK5A2cwIWw4D51GdiZ8Xba5tL6XHoZb/e3AVKENYvNWcs6d8ZBV44piQfzNLqhm6Zf56ZD0I1brRrVpChv2oNahI1fb38eLnTTIHSZzUqVM9wLQNkwt6wMIgTUC80rxKFEU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e40a523-eb90-4abb-f8b0-08d6ad994fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 01:05:29.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOoz1MIyMMjVIDIyOjQ5DQo+IFRvOiBBbmR5
IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBDYzogRGFuaWVsIExlemNhbm8gPGRhbmllbC5s
ZXpjYW5vQGxpbmFyby5vcmc+OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+Ow0KPiBlZHViZXp2
YWxAZ21haWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyXSBhcm02NDogZHRzOiBsczEwODhhOiBhZGQgb25lIG1vcmUgdGhlcm1hbCB6b25lIG5v
ZGUNCj4gDQo+IE9uIFdlZCwgTWFyIDIwLCAyMDE5IGF0IDA4OjQ0OjE4QU0gKzAwMDAsIEFuZHkg
VGFuZyB3cm90ZToNCj4gPiA+ID4gU2Vuc29yIElECQlwbGFjZW1lbnQNCj4gPiA+ID4gMQkJCURE
UiBjb250cm9sbGVyIDENCj4gPiA+ID4gMgkJCUREUiBjb250cm9sbGVyIDINCj4gPiA+ID4gMwkJ
CUREUiBjb250cm9sbGVyIDMNCj4gPiA+ID4gNAkJCWNvcmUgY2x1c3RlciAxDQo+ID4gPiA+IDUg
CQljb3JlIGNsdXN0ZXIgMg0KPiA+ID4gPiA2IAkJY29yZSBjbHVzdGVyIDMNCj4gPiA+ID4gNyAJ
CWNvcmUgY2x1c3RlciA0DQo+ID4gPiA+DQo+ID4gPiA+IEFwcGFyZW50bHkgdXNpbmcgQ1BVIG9y
IENQVS1jbHVzdGVyIGlzIG5vdCBhcHByb3ByaWF0ZS4gQ29yZS1jbHVzdGVyIGlzDQo+IGJldHRl
ci4NCj4gPiA+DQo+ID4gPiBTbyB1c2luZyBDUFUgaXMgYXBwcm9wcmlhdGUgZm9yIG1lLCBsZXNz
IGNvbmZ1c2luZywgbW9yZSBjb25zaXN0ZW50DQo+ID4gPiB3aXRoIG90aGVyIHBsYXRmb3Jtcy4N
Cj4gPiBXaGF0IGFib3V0IGNvcmUgY2x1c3Rlcj8gV2UgY2FuJ3QgbmFtZSBpdCBjcHUwLCBjcHUx
IGV0YyBJIHRoaW5rLg0KPiANCj4gSG1tLCB5ZXMsIHRoYXQgd291bGQgYmUgZXZlbiBtb3JlIGNv
bmZ1c2luZy4gIFdoYXQgYWJvdXQgY3B1LXRoZXJtYWwtMSwNCj4gY3B1LXRoZXJtYWwtMiAuLi4/
DQpDcHUtdGhlcm1hbC14IGNhbid0IGNoYW5nZSBhbnl0aGluZyBiZXR0ZXIgdGhhbiBjcHVYLiBJ
dCBjYW4ndCByZWZsZWN0IHRoZSBjb25jZXB0IG9mIENMVVNURVIuDQpJIHByZWZlciB0byB1c2Ug
Y29yZS1jbHVzdGVyLiBJdCBpcyBhIHdpbGQgYWNjZXB0ZWQgdGVybSBpbiBBUk0gZWNvc3lzdGVt
Lg0KDQpCUiwNCkFuZHkNCj4gDQo+IFNoYXduDQo=
