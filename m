Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2B9C28EB2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789FC20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tYZKiwj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFFKbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:31:32 -0400
Received: from mail-eopbgr140101.outbound.protection.outlook.com ([40.107.14.101]:41966
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFFKbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw38QVd8e3bSUoZjM49NbJC8vym0ck2Fdr8+B28hSAs=;
 b=tYZKiwj3R7n1/KEFGOAlimKHLD5qL2xAbrtm2SJfAi24mCuhkKVL9i/AT9OOq3eF6+/QSDThkpnGFUOAWM7nwrRhbaNw4esbmu1jPlo+pozStJr4aqd7o5NWyrU06kOSx1DYaL967MQFuwaqTc1bw/bn9Mq1OQ+RQ1yOEPaBOiw=
Received: from AM4PR05MB3299.eurprd05.prod.outlook.com (10.170.126.28) by
 AM4PR05MB3299.eurprd05.prod.outlook.com (10.170.126.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 10:31:27 +0000
Received: from AM4PR05MB3299.eurprd05.prod.outlook.com
 ([fe80::9534:6aaa:4981:7f1d]) by AM4PR05MB3299.eurprd05.prod.outlook.com
 ([fe80::9534:6aaa:4981:7f1d%7]) with mapi id 15.20.1943.023; Thu, 6 Jun 2019
 10:31:27 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
Thread-Topic: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
Thread-Index: AQHVHEcZX+CmVGVmsUG2ShHZLDLIl6aObW2A
Date:   Thu, 6 Jun 2019 10:31:27 +0000
Message-ID: <dc983cea041c3bbe354a62eb30a92b4c3d2734d6.camel@toradex.com>
References: <20190606090612.16685-1-igor.opaniuk@gmail.com>
In-Reply-To: <20190606090612.16685-1-igor.opaniuk@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [194.105.145.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44654840-a8d5-468d-5ca1-08d6ea6a21e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM4PR05MB3299;
x-ms-traffictypediagnostic: AM4PR05MB3299:
x-microsoft-antispam-prvs: <AM4PR05MB3299348B8E892AE9595DC44AFB170@AM4PR05MB3299.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39850400004)(189003)(199004)(36756003)(66066001)(25786009)(229853002)(4326008)(53936002)(76176011)(446003)(8936002)(99286004)(6512007)(6246003)(110136005)(54906003)(316002)(2906002)(91956017)(3846002)(73956011)(76116006)(6116002)(44832011)(71200400001)(478600001)(26005)(186003)(14444005)(256004)(64756008)(66556008)(476003)(2616005)(66446008)(66476007)(305945005)(11346002)(81156014)(7736002)(6436002)(5660300002)(66946007)(118296001)(486006)(6506007)(6486002)(102836004)(2201001)(8676002)(81166006)(7416002)(68736007)(14454004)(86362001)(2501003)(71190400001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR05MB3299;H:AM4PR05MB3299.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +M06av3T1YTe+8ATcVv5zRj2WoRLYIHL/4fKuUWaAvx5pZt64vK+gb1pdjv6ZGnI+9x9ZX6pRxna2tsHasyCXhDKfP4uG47KXIrCQ6xj+ZOU5qgsnfhJHDoVdzibfcP9M/Dle7ipqITh+J4Yyp7MCRId/N0zcvvhRxkTWfiKjq6UuuNQYy1zuTO8nAmlLFHNFu4Qo9qrgP/vUAddYBc9q57VowIx+E0TPGSWxkf1VlO2HYKvb21Bg+qxwrpMMDAU4XUdbHL2wikJm9Yee2nbGOs7NM2FDbK0ojQWi52JcLeXfea3fcLBWbQlCLjKK6FqclSPIZJMBmpSZlCUKZPSfFvEBZSTPvLN1KCc9c4py3WAaAvg5+uUOEQgvtYMl3g2w/9Jp/rFANl81nTINHY8wD1JQjkRLKJvtblUeo5gJhU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A1C860EC93D44449ED1A15C1557280A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44654840-a8d5-468d-5ca1-08d6ea6a21e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 10:31:27.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: marcel.ziswiler@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA2LTA2IGF0IDEyOjA2ICswMzAwLCBJZ29yIE9wYW5pdWsgd3JvdGU6DQo+
IEZyb206IElnb3IgT3Bhbml1ayA8aWdvci5vcGFuaXVrQHRvcmFkZXguY29tPg0KPiANCj4gQWxs
b3dzIHRvIHVzZSB0aGUgU0QgaW50ZXJmYWNlIGF0IGEgaGlnaGVyIHNwZWVkIG1vZGUgaWYgdGhl
IGNhcmQNCj4gc3VwcG9ydHMgaXQuIEZvciB0aGlzIHRoZSBzaWduYWxpbmcgdm9sdGFnZSBpcyBz
d2l0Y2hlZCBmcm9tIDMuM1YgdG8NCj4gMS44ViB1bmRlciB0aGUgdXNkaGMxJ3MgZHJpdmVycyBj
b250cm9sLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtA
dG9yYWRleC5jb20+DQoNClJldmlld2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3
aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5k
dHNpICAgICAgICAgICAgICAgICAgfCAgNCArKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2
dWxsLWNvbGlicmktZXZhbC12My5kdHNpIHwgMTEgKysrKysrKysrLS0NCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpICAgICAgICAgfCAgNiArKysrKysNCj4gIDMgZmls
ZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZ1bC5kdHNpDQo+IGluZGV4IGZjMzg4Yjg0YmYyMi4uOTFhMGNlZDQ0ZTI3IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2dWwuZHRzaQ0KPiBAQCAtODU3LDYgKzg1Nyw4IEBADQo+ICAJCQkJCSA8
JmNsa3MgSU1YNlVMX0NMS19VU0RIQzE+LA0KPiAgCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtfVVNE
SEMxPjsNCj4gIAkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAiYWhiIiwgInBlciI7DQo+ICsJCQkJ
ZnNsLHR1bmluZy1zdGVwPSA8Mj47DQo+ICsJCQkJZnNsLHR1bmluZy1zdGFydC10YXAgPSA8MjA+
Ow0KPiAgCQkJCWJ1cy13aWR0aCA9IDw0PjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiAgCQkJfTsNCj4gQEAgLTg3MCw2ICs4NzIsOCBAQA0KPiAgCQkJCQkgPCZjbGtzIElNWDZVTF9D
TEtfVVNESEMyPjsNCj4gIAkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAiYWhiIiwgInBlciI7DQo+
ICAJCQkJYnVzLXdpZHRoID0gPDQ+Ow0KPiArCQkJCWZzbCx0dW5pbmctc3RlcD0gPDI+Ow0KPiAr
CQkJCWZzbCx0dW5pbmctc3RhcnQtdGFwID0gPDIwPjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiAgCQkJfTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwt
Y29saWJyaS1ldmFsLXYzLmR0c2kNCj4gaW5kZXggMDA2NjkwZWE5OGMwLi43ZGM3NzcwY2Y1MmMg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ldmFsLXYz
LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMu
ZHRzaQ0KPiBAQCAtMTQ1LDEzICsxNDUsMjAgQEANCj4gIH07DQo+ICANCj4gICZ1c2RoYzEgew0K
PiAtCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IiwgInN0YXRlXzEwMG1oeiIsICJzdGF0ZV8yMDBtaHoiLA0KPiAic2xlZXAiOw0KPiAgCXBp
bmN0cmwtMCA9IDwmcGluY3RybF91c2RoYzEgJnBpbmN0cmxfc252c191c2RoYzFfY2Q+Ow0KPiAt
CW5vLTEtOC12Ow0KPiArCXBpbmN0cmwtMSA9IDwmcGluY3RybF91c2RoYzFfMTAwbWh6ICZwaW5j
dHJsX3NudnNfdXNkaGMxX2NkPjsNCj4gKwlwaW5jdHJsLTIgPSA8JnBpbmN0cmxfdXNkaGMxXzEw
MG1oeiAmcGluY3RybF9zbnZzX3VzZGhjMV9jZD47DQo+ICsJcGluY3RybC0zID0gPCZwaW5jdHJs
X3VzZGhjMSAmcGluY3RybF9zbnZzX3VzZGhjMV9zbGVlcF9jZD47DQo+ICAJY2QtZ3Bpb3MgPSA8
JmdwaW81IDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gIAlkaXNhYmxlLXdwOw0KPiAgCXdha2V1cC1z
b3VyY2U7DQo+ICAJa2VlcC1wb3dlci1pbi1zdXNwZW5kOw0KPiAgCXZtbWMtc3VwcGx5ID0gPCZy
ZWdfM3YzPjsNCj4gKwl2cW1tYy1zdXBwbHkgPSA8JnJlZ19zZDFfdm1tYz47DQo+ICsJc2QtdWhz
LXNkcjEyOw0KPiArCXNkLXVocy1zZHIyNTsNCj4gKwlzZC11aHMtc2RyNTA7DQo+ICsJc2QtdWhz
LXNkcjEwNDsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2dWxsLWNvbGlicmkuZHRzaQ0KPiBpbmRleCA5YWQxZGExNTk3NjguLmQ1NjcyOGYwM2Mz
NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kN
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gQEAgLTU0
NSw2ICs1NDUsMTIgQEANCj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+ICsJcGluY3RybF9zbnZzX3Vz
ZGhjMV9zbGVlcF9jZDogc252cy11c2RoYzEtY2QtZ3JwLXNscCB7DQo+ICsJCWZzbCxwaW5zID0g
PA0KPiArCQkJTVg2VUxMX1BBRF9TTlZTX1RBTVBFUjBfX0dQSU81X0lPMDAJMHgwDQo+ICsJCT47
DQo+ICsJfTsNCj4gKw0KPiAgCXBpbmN0cmxfc252c193aWZpX3Bkbjogc252cy13aWZpLXBkbi1n
cnAgew0KPiAgCQlmc2wscGlucyA9IDwNCj4gIAkJCU1YNlVMTF9QQURfQk9PVF9NT0RFMV9fR1BJ
TzVfSU8xMQkweDE0DQo=
