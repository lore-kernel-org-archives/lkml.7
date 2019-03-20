Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20872184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sD4SQU83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfCTIoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:44:24 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:37215
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfCTIoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=646lobx939WW+eel3TBR4QiYq9nx86Ysv2PFkBC03X0=;
 b=sD4SQU83vNE/Y5F0nSbIggwR46+o0xW+eCLXSisLzbad5P+QpWtP4KdQ77kY5tNG2t3Ad4eq59KDUhqKdYcRj7x27f0DwOdFehoay8G7FoDC23waJzVaCCymKm0+klmlF4k28sC3e7DwRrCqMmMrYSnG8zVsS6eAuymHL/4/nds=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4510.eurprd04.prod.outlook.com (20.177.54.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Wed, 20 Mar 2019 08:44:19 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f%4]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 08:44:19 +0000
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
Thread-Index: AQHU0jo9yDvlWMWO2EezapwWi7PmgaX7AH0AgAAEh0CABOLvAIABESAQgACE+ACAAALKMIASxdSAgAAGQzA=
Date:   Wed, 20 Mar 2019 08:44:18 +0000
Message-ID: <VI1PR04MB433351C20A9863EEF21A2504F3410@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
 <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190320081853.GE4980@dragon>
In-Reply-To: <20190320081853.GE4980@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28ea5c78-cc24-4aff-6ada-08d6ad103e0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4510;
x-ms-traffictypediagnostic: VI1PR04MB4510:
x-microsoft-antispam-prvs: <VI1PR04MB45105D6FCD4DDD0E19619008F3410@VI1PR04MB4510.eurprd04.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(13464003)(7736002)(4326008)(446003)(105586002)(478600001)(86362001)(305945005)(74316002)(33656002)(14454004)(93886005)(68736007)(97736004)(2906002)(71190400001)(71200400001)(44832011)(8676002)(25786009)(11346002)(26005)(106356001)(76176011)(486006)(52536014)(6916009)(476003)(186003)(81156014)(6246003)(81166006)(7696005)(99286004)(53936002)(5660300002)(9686003)(102836004)(53546011)(6506007)(229853002)(7416002)(316002)(54906003)(66066001)(256004)(14444005)(8936002)(55016002)(6436002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4510;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tkSxZvCzkk9f2X2oMM4vXI+TBeREIFxibHYl2KKRgJEf+4PWuwH68cmIwrRYIIoSuMN9cKh/8EAeqSHLgmiEtfK8cC/FQIHQPbazpZTtvYCY4IYVN7kf1OP00HlF8zukQ3GavSoyj1h25FnhqQiN7Kd2/jLgHODPrSEmb6GtYuAtPDJPtH6jVDcOi8jcFKnHzH8HvO5DCUtNmhZi996UT0AKN4yVDhlcdwQsF5b8PMdrVhJrU4k07NRoRKOyFrEWlBF/nrK68qYy8awipt/ChNKLBI2wUMyL3jEckIv8HtxeZ6JIvmmHwaRGwVaCUv7VMoixTcua4qOcbnAwPlWSsh4fHMCRtFLe3uICammITTzKpk9zer9P9B0XgABL05SoJLkY08/czCQ810SDFw+Sq4MqLSBm1GSUdVuncnvRCXA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ea5c78-cc24-4aff-6ada-08d6ad103e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 08:44:19.0546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0M+aciDIw5pelIDE2OjE5
DQo+IFRvOiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBDYzogRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+
Ow0KPiBlZHViZXp2YWxAZ21haWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IHJ1aS56aGFuZ0Bp
bnRlbC5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyXSBhcm02NDogZHRzOiBsczEwODhhOiBhZGQgb25lIG1vcmUgdGhl
cm1hbCB6b25lIG5vZGUNCj4gDQo+IE9uIEZyaSwgTWFyIDA4LCAyMDE5IGF0IDA5OjU3OjA5QU0g
KzAwMDAsIEFuZHkgVGFuZyB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxp
bmFyby5vcmc+DQo+ID4gPiBTZW50OiAyMDE55bm0M+aciDjml6UgMTc6MjgNCj4gPiA+IFRvOiBB
bmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPg0KPiA+ID4gQ2M6IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgcm9iaCtkdEBrZXJu
ZWwub3JnOw0KPiA+ID4gbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBydWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tDQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyXSBhcm02NDogZHRzOiBsczEwODhhOiBhZGQgb25lIG1vcmUgdGhlcm1h
bA0KPiA+ID4gem9uZSBub2RlDQo+ID4gPg0KPiA+ID4gT24gMDgvMDMvMjAxOSAwMzowNywgQW5k
eSBUYW5nIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+ID4+IEZyb206IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fu
b0BsaW5hcm8ub3JnPg0KPiA+ID4gPj4gU2VudDogMjAxOeW5tDPmnIg35pelIDE3OjE1DQo+ID4g
PiA+PiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT47IFNoYXduIEd1bw0KPiA+ID4g
Pj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+ID4gPiA+PiBDYzogTGVvIExpIDxsZW95YW5nLmxp
QG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4gPiA+PiBtYXJrLnJ1dGxhbmRAYXJt
LmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4gPiA+PiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+
ID4gPiA+PiBlZHViZXp2YWxAZ21haWwuY29tDQo+ID4gPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyXSBhcm02NDogZHRzOiBsczEwODhhOiBhZGQgb25lIG1vcmUgdGhlcm1hbA0KPiA+ID4gPj4g
em9uZSBub2RlDQo+ID4gPiA+Pg0KPiA+ID4gPj4+Pj4gUFM6IEluIG9yZGVyIHRvIGtlZXAgY29u
c2lzdGVuY3kgdG8gdGhlIGZpcnN0IHRoZXJtYWwtem9uZQ0KPiA+ID4gPj4+Pj4gbm9kZSwgdGhl
cmUgd2lsbCBiZSAiV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMiIHdhcm5pbmdzLg0K
PiA+ID4gPj4+Pj4NCj4gPiA+ID4+Pj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHMxMDg4YS5kdHNpIHwgICA0Mw0KPiA+ID4gPj4+PiArKysrKysrKysrKysrKysrKysrKyst
LQ0KPiA+ID4gPj4+Pj4gIDEgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4+Pj4+DQo+ID4gPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEuZHRzaQ0KPiA+ID4gPj4+Pj4gYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDg4YS5kdHNpDQo+ID4gPiA+Pj4+PiBp
bmRleCA2NjExMzdmLi45ZjUyYmM5IDEwMDY0NA0KPiA+ID4gPj4+Pj4gLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEuZHRzaQ0KPiA+ID4gPj4+Pj4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEuZHRzaQ0KPiA+ID4gPj4+
Pj4gQEAgLTEyOSwxOSArMTI5LDE5IEBADQo+ID4gPiA+Pj4+PiAgCX07DQo+ID4gPiA+Pj4+Pg0K
PiA+ID4gPj4+Pj4gIAl0aGVybWFsLXpvbmVzIHsNCj4gPiA+ID4+Pj4+IC0JCWNwdV90aGVybWFs
OiBjcHUtdGhlcm1hbCB7DQo+ID4gPiA+Pj4+PiArCQljY3Ugew0KPiA+ID4gPj4+Pg0KPiA+ID4g
Pj4+PiBJcyB0aGlzIGNoYW5nZSByZWFsbHkgbmVjZXNzYXJ5PyAgV2hhdCBkb2VzICdjY3UnIHN0
YW5kIGZvcj8NCj4gPiA+ID4+PiBJIHRoaW5rIHNvLiBjY3Ugc3RhbmRzIGZvciBjb3JlIGNsdXN0
ZXIgdW5pdC4gY3B1IGlzIHRvbyBnZW5lcmFsLg0KPiA+ID4gPj4+IE9uIHNvbWUgcGxhdGZvcm1z
LCB0aGVyZSBhcmUgbW9yZSB0aGFuIG9uZSBjb3JlIGNsdXN0ZXJzLg0KPiA+ID4gPj4+IEF0IGxl
YXN0IHdlIHNob3VsZCBjaGFuZ2UgaXQgdG8gImNvcmUgY2x1c3RlciIgaWYgc2hvcnQgZm9ybSBp
cw0KPiA+ID4gPj4+IG5vdA0KPiA+ID4gYXBwcm9wcmlhdGUuDQo+ID4gPiA+Pg0KPiA+ID4gPj4g
SWYgdGhlIHNlbnNvciBpcyBhIHRoZSBjbHVzdGVyIGxldmVsLCAnY2x1c3RlcicgaXMgZW5vdWdo
LiBJTUhPLA0KPiA+ID4gPj4gbm8gbmVlZCB0byBnaXZlIGEgZGVzY3JpcHRpb24gb2Ygd2hhdCBj
b250YWlucyB0aGUgY2x1c3RlciwNCj4gPiA+ID4+IG90aGVyd2lzZSB5b3Ugd2lsbCBlbmQgdXAg
d2l0aCBhICdjb3JlLWdwdS1jbHVzdGVyLWwyJyBuYW1lLg0KPiA+ID4gPiBJZiBjbHVzdGVyIGlz
IHNwZWNpZmljIHRvIGNvcmUsIHdlIGNhbiB1c2UgY2x1c3RlciBpbnN0ZWFkLiBCdXQgSSBkb24n
dCB0aGluaw0KPiBzby4NCj4gPiA+ID4gQ2x1c3RlciBtYXkgcmVmZXIgdG8gImNvcmUgY2x1c3Rl
ciIsICJHUFUgY2x1c3RlciIgZXRjLg0KPiA+ID4gPiBTbywgSSB0aGluayAiY29yZS1jbHVzdGVy
IiBpcyBvay4NCj4gPiA+ID4gSWYgY29yZSB3YXMgZGl2aWRlZCB0byBzZXZlcmFsIGNsdXN0ZXJz
LCB3ZSBjYW4gbmFtZSBpdCBhcw0KPiA+ID4gPiAiY29yZS1jbHVzdGVyMSIsDQo+ID4gPiAiY29y
ZS1jbHVzdGVyMiIgZXRjLg0KPiA+ID4gPiBJZiBHUFUgd2FzIGRpdmlkZWQgdG8gc2V2ZXJhbCBj
bHVzdGVycyB3ZSBjYW4gbmFtZSBpdCBhcw0KPiA+ID4gPiAiZ3B1LWNsdXN0ZXIxIiwNCj4gPiA+
ICJncHUtY2x1c3RlcjIiIGV0Yy4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gSGkgQW5keSwNCj4gPiA+
DQo+ID4gPiBJIHRoaW5rIHRoZXJlIGlzIGEgY29uZnVzaW9uIGFyb3VuZCB0aGUgJ2NwdScgdGVy
bSBhbmQgJ2NsdXN0ZXInLg0KPiA+ID4NCj4gPiA+IEFSTSB3b3VsZCBsaWtlIHRvIHNlZSB0aGUg
J2NsdXN0ZXInIHdvcmQgdG8gZGlzYXBwZWFyLCBzbyB3aGVuZXZlcg0KPiA+ID4gcG9zc2libGUg
d2Ugc2hvdWxkIGF2b2lkIGl0Lg0KPiA+ID4NCj4gPiA+IEZyb20gdGhlIGhhcmR3YXJlIHNpZGUs
ICdDUFUnIGlzIHVzdWFsbHkgdXNlZCB0byBkZXNjcmliZSB0aGUNCj4gPiA+IHBoeXNpY2FsIGNo
aXAgY29udGFpbmluZyB0aGUgY29yZXMrY2FjaGUuDQo+ID4gPg0KPiA+ID4gRnJvbSB0aGUgc29m
dHdhcmUgc2lkZSwgJ0NQVScgaXMgdXN1YWxseSB1c2VkIHRvIGRlc2NyaWJlIHRoZQ0KPiA+ID4g
bG9naWNhbCBwcm9jZXNzIHVuaXQsIGFrYSBhIGNvcmUgb3IgYSBoeXBlci10aHJlYWQuDQo+ID4g
Pg0KPiA+ID4gQXMgd2UgYXJlIGluIHRoZSBEVCwgc28gZGVzY3JpYmluZyB0aGUgaGFyZHdhcmUs
IHRoZSBDUFUgcmVmZXJzIHRvDQo+ID4gPiB0aGUgZ3JvdXANCj4gPiA+IGNvcmVzK2NhY2hlcy4N
Cj4gPiA+DQo+ID4gPiBGcm9tIG15IFBPViwgdXNpbmcgJ2NwdScgZm9yIHRoZSBncm91cCBvZiBj
b3JlcyBhbmQgJ2dwdScgZm9yIHRoZQ0KPiA+ID4gZ3JhcGhpYyBzb3VuZHMgb2ssIGFuZCBzbyBm
YXIgdGhhdCBpcyB3aGF0IGlzIHVzZWQgZm9yIHRoZSBvdGhlciBwbGF0Zm9ybXMuDQo+ID4gPg0K
PiA+ID4gSWYgeW91IGNoYW5nZSB0aGUgbmFtZSwgdGhhdCBtYXkgZ2l2ZSB0aGUgZmVlbGluZyB0
aGVyZSBpcyBzb21ldGhpbmcNCj4gPiA+IHNwZWNpYWwgd2l0aCB0aG9zZSB0aGVybWFsIHpvbmVz
Lg0KPiA+DQo+ID4gVGhhbmtzIERhbmllbCBmb3IgeW91ciBkZXRhaWxlZCBleHBsYW5hdGlvbnMu
DQo+ID4NCj4gPiBCdXQgYXMgeW91IHNhaWQgJ0NQVScgaXMgdXN1YWxseSB1c2VkIHRvIGRlc2Ny
aWJlIHRoZSBwaHlzaWNhbCBjaGlwLg0KPiANCj4gSGVyZSBpcyBob3cgSSB3b3VsZCB1bmRlcnN0
YW5kIERhbmllbCdzIGNvbW1lbnRzOg0KPiANCj4gICBDUFUgPSBjb3JlcyArIGNhY2hlcw0KPiAg
IHBoeXNpY2FsIGNoaXAgPSBTb0MgPSBDUFUgKyBHUFUgKyBwZXJpcGhlcmFscyAuLi4NCg0KQWdy
ZWUuDQoNCj4gDQo+ID4gU28gaWYgd2UgbmFtZSBpdCBhcyBDUFUsIGl0IHNvdW5kcyBsaWtlIHRo
aXMgdGVtcGVyYXR1cmUgc2Vuc29yIGlzIG1vbml0b3JpbmcNCj4gdGhlIHdob2xlIGNoaXAuDQo+
ID4gVGhhdCdzIG5vdCB0cnVlIGluIG91ciBjYXNlLg0KPiA+DQo+ID4gVGFrZSBsczIwODhhIGZv
ciBleGFtcGxlOg0KPiA+IEluIGxzMjA4OGEgU29DLCB0aGVyZSBhcmUgNyB0ZW1wZXJhdHVyZSBz
ZW5zb3JzLiBQbGVhc2Ugbm90ZSB0aGF0IHRoZXkgYXJlIGFsbA0KPiBsb2NhdGVkIGluIFNvQy4N
Cj4gPiBUaGUgcGxhY2VtZW50IG9mIHRoZSB0ZW1wZXJhdHVyZSBzZW5zb3JzIGFyZSBzaG93ZWQg
YmVsb3c6DQo+ID4NCj4gPiBTZW5zb3IgSUQJCXBsYWNlbWVudA0KPiA+IDEJCQlERFIgY29udHJv
bGxlciAxDQo+ID4gMgkJCUREUiBjb250cm9sbGVyIDINCj4gPiAzCQkJRERSIGNvbnRyb2xsZXIg
Mw0KPiA+IDQJCQljb3JlIGNsdXN0ZXIgMQ0KPiA+IDUgCQkJY29yZSBjbHVzdGVyIDINCj4gPiA2
IAkJCWNvcmUgY2x1c3RlciAzDQo+ID4gNyAJCQljb3JlIGNsdXN0ZXIgNA0KPiA+DQo+ID4gQXBw
YXJlbnRseSB1c2luZyBDUFUgb3IgQ1BVLWNsdXN0ZXIgaXMgbm90IGFwcHJvcHJpYXRlLiBDb3Jl
LWNsdXN0ZXIgaXMgYmV0dGVyLg0KPiANCj4gU28gdXNpbmcgQ1BVIGlzIGFwcHJvcHJpYXRlIGZv
ciBtZSwgbGVzcyBjb25mdXNpbmcsIG1vcmUgY29uc2lzdGVudCB3aXRoIG90aGVyDQo+IHBsYXRm
b3Jtcy4NCldoYXQgYWJvdXQgY29yZSBjbHVzdGVyPyBXZSBjYW4ndCBuYW1lIGl0IGNwdTAsIGNw
dTEgZXRjIEkgdGhpbmsuDQoNCkJSLA0KQW5keQ0KPiANCj4gU2hhd24NCg==
