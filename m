Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA992133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIcNQbP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfDKICF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:02:05 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:58436
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbfDKICE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQiYKAZtWWanJOrY9Asi0gXWI6W+6IPhnRltgBk1yGo=;
 b=mIcNQbP7oNwR7zOLlGx9tyBh8HO0T88OeiYn5XFe+m0RfL/hI4m5cjfCdIVigY33gHZD8WpfVx7VH5txmzSmXbtjqUwGko1EMJ9517PmlO82uYtXpJt19vQYgazfHg/c6pecawQfWW5gyrv8Xc5uhIcaUT+Mqb0ifJUvbsIurLA=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5773.eurprd04.prod.outlook.com (20.178.127.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 11 Apr 2019 08:01:56 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::b821:e46f:63e4:7b13]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::b821:e46f:63e4:7b13%3]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 08:01:56 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Subject: RE: [PATCH v4] arm64: dts: ls1088a: add one more thermal zone node
Thread-Topic: [PATCH v4] arm64: dts: ls1088a: add one more thermal zone node
Thread-Index: AQHU6DwH2AhWFp3fPkOzSEzzKH5KeqYrTYiAgAta/8A=
Date:   Thu, 11 Apr 2019 08:01:55 +0000
Message-ID: <VI1PR04MB433392E5E650435B0D06AFFFF32F0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190401032905.32711-1-andy.tang@nxp.com>
 <273bb946-8659-8e50-6598-3cffa6dff9f5@linaro.org>
In-Reply-To: <273bb946-8659-8e50-6598-3cffa6dff9f5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f49899d0-c310-4c17-6d75-08d6be53f75c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5773;
x-ms-traffictypediagnostic: VI1PR04MB5773:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <VI1PR04MB5773C6839A73A2E78BF5991AF32F0@VI1PR04MB5773.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(13464003)(446003)(14454004)(486006)(508600001)(476003)(11346002)(44832011)(2501003)(316002)(25786009)(54906003)(110136005)(4326008)(305945005)(7736002)(74316002)(71200400001)(8676002)(6246003)(53936002)(6306002)(9686003)(256004)(81166006)(8936002)(81156014)(99286004)(55016002)(2906002)(7696005)(68736007)(71190400001)(3846002)(33656002)(6116002)(86362001)(7416002)(105586002)(106356001)(14444005)(6436002)(186003)(53546011)(6506007)(97736004)(229853002)(76176011)(5660300002)(66066001)(26005)(102836004)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5773;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ec+gARdz798Y38aLXzg9P4o1pxGDJgdywcfDWMIGGRGVyzNjY442in8IZqtZHoa5pkuRhZ5URk7OJWsFlr8bq2wV8To4QxPEWDIIzMIbwIZqm7GiBgiiD0HVAsFD9+dWaaIlig2tyVAwLS+eB+lVpai9X+e/H3VfzqkHM/QVR0IzRpObO5ujuy57biiXIVQ3tmiO6WiPum49K2hvR31/0+HFc9MLjz4d4iU4WoDVm4mx8/U7k8cys/Z7QPk9eYqORRJnryE8PVv+i64xv4yVY1JxPQ4OJRa8pxU5oviiB4LPrtb4G2lwu7misZROwD7NEf/hiSQaO0XOcv6zHK9fv2esLcFEJDwyQ3ycMRPcNcYIpck8JLxE3xB2dy67zcgpVxMz2c4QBbK64T/A9R6qbQB+Y+iZcrJ7hHnROCc0WTM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49899d0-c310-4c17-6d75-08d6be53f75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 08:01:56.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFu
aWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMTnlubQ0
5pyINOaXpSAxMDozNQ0KPiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT47IHNoYXdu
Z3VvQGtlcm5lbC5vcmcNCj4gQ2M6IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgcm9iaCtk
dEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBydWkuemhh
bmdAaW50ZWwuY29tOw0KPiBlZHViZXp2YWxAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjRdIGFybTY0OiBkdHM6IGxzMTA4OGE6IGFkZCBvbmUgbW9yZSB0aGVybWFsIHpvbmUgbm9k
ZQ0KPiA+ICsJCQkJCQk8JmNwdTEgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlU
PiwNCj4gPiArCQkJCQkJPCZjcHUyIFRIRVJNQUxfTk9fTElNSVQNCj4gVEhFUk1BTF9OT19MSU1J
VD4sDQo+ID4gKwkJCQkJCTwmY3B1MyBUSEVSTUFMX05PX0xJTUlUDQo+IFRIRVJNQUxfTk9fTElN
SVQ+LA0KPiA+ICsJCQkJCQk8JmNwdTQgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJ
TUlUPiwNCj4gPiArCQkJCQkJPCZjcHU1IFRIRVJNQUxfTk9fTElNSVQNCj4gVEhFUk1BTF9OT19M
SU1JVD4sDQo+ID4gKwkJCQkJCTwmY3B1NiBUSEVSTUFMX05PX0xJTUlUDQo+IFRIRVJNQUxfTk9f
TElNSVQ+LA0KPiA+ICsJCQkJCQk8JmNwdTcgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05P
X0xJTUlUPjsNCj4gPiArCQkJCX07DQo+IA0KPiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gYXNzaWdu
IHRoZSBzYW1lIGNvb2xpbmcgZGV2aWNlcyB0byB0d28gZGlmZmVyZW50IHRoZXJtYWwNCj4gem9u
ZXMgcnVubmluZyBkaWZmZXJlbnQgaW5zdGFuY2VzIG9mIGdvdmVybm9yID8NCkV2ZW4gdGhvdWdo
IEkgZGlkbid0IGZpbmQgYW55IGVycm9yIHdoZW4gdGVzdCwgSSBkbyB0aGluayBpdCBpcyBpbmFw
cHJvcHJpYXRlLg0KDQpCUiwNCkFuZHkNCj4gDQo+ID4gKwkJCX07DQo+ID4gKwkJfTsNCj4gPiAr
DQo+ID4gKwkJcGxhdGZvcm0tdGhlcm1hbCB7DQo+ID4gKwkJCXBvbGxpbmctZGVsYXktcGFzc2l2
ZSA9IDwxMDAwPjsNCj4gPiArCQkJcG9sbGluZy1kZWxheSA9IDw1MDAwPjsNCj4gPiArCQkJdGhl
cm1hbC1zZW5zb3JzID0gPCZ0bXUgMT47DQo+ID4gKw0KPiA+ICsJCQl0cmlwcyB7DQo+ID4gKwkJ
CQlwbGF0Zm9ybV9hbGVydDogcGxhdGZvcm0tYWxlcnQgew0KPiA+ICsJCQkJCXRlbXBlcmF0dXJl
ID0gPDg1MDAwPjsNCj4gPiArCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+ICsJCQkJCXR5
cGUgPSAicGFzc2l2ZSI7DQo+ID4gKwkJCQl9Ow0KPiA+ICsNCj4gPiArCQkJCXBsYXRmb3JtX2Ny
aXQ6IHBsYXRmb3JtLWNyaXQgew0KPiA+ICsJCQkJCXRlbXBlcmF0dXJlID0gPDk1MDAwPjsNCj4g
PiArCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+ICsJCQkJCXR5cGUgPSAiY3JpdGljYWwi
Ow0KPiA+ICsJCQkJfTsNCj4gPiArCQkJfTsNCj4gPiArDQo+ID4gKwkJCWNvb2xpbmctbWFwcyB7
DQo+ID4gKwkJCQltYXAwIHsNCj4gPiArCQkJCQl0cmlwID0gPCZwbGF0Zm9ybV9hbGVydD47DQo+
ID4gIAkJCQkJY29vbGluZy1kZXZpY2UgPQ0KPiA+ICAJCQkJCQk8JmNwdTAgVEhFUk1BTF9OT19M
SU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPiwNCj4gPiAgCQkJCQkJPCZjcHUxIFRIRVJNQUxfTk9f
TElNSVQNCj4gVEhFUk1BTF9OT19MSU1JVD4sDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiANCj4gPGh0
dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNB
JTJGJTJGd3d3Lmxpbg0KPiBhcm8ub3JnJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRhbmcl
NDBueHAuY29tJTdDZTFiNzA0ODMyZWEzNA0KPiA2YWU3Mzg0MDhkNmI4YTYyODNmJTdDNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3Qw0KPiA2MzY4OTk0MjExMTA0NDE1
NzQmYW1wO3NkYXRhPUM3bXJVenRPYmtITVp5cUVKZzUzaDk5U2RJd2VKU2VLaGk4bA0KPiAlMkJR
cFVRaEElM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvcg0KPiBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3
LmZhYw0KPiBlYm9vay5jb20lMkZwYWdlcyUyRkxpbmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5k
eS50YW5nJTQwbnhwLmNvbQ0KPiAlN0NlMWI3MDQ4MzJlYTM0NmFlNzM4NDA4ZDZiOGE2MjgzZiU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzANCj4gMTYzNSU3QzAlN0MwJTdDNjM2ODk5NDIx
MTEwNDQxNTc0JmFtcDtzZGF0YT1QeGolMkJsZmMlMkZDMUtpUUJEMA0KPiBrelRqUUdUMkFnakNi
WWxjWGhuc2NXVGI2cHclM0QmYW1wO3Jlc2VydmVkPTA+IEZhY2Vib29rIHwNCj4gPGh0dHBzOi8v
ZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJG
dHdpdHRlci5jDQo+IG9tJTJGJTIzISUyRmxpbmFyb29yZyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5k
eS50YW5nJTQwbnhwLmNvbSU3Q2UNCj4gMWI3MDQ4MzJlYTM0NmFlNzM4NDA4ZDZiOGE2MjgzZiU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1DQo+ICU3QzAlN0MwJTdDNjM2ODk5NDIx
MTEwNDQxNTc0JmFtcDtzZGF0YT1ZSlFSZ01Ud2NHJTJCM0gxZyUyRlgNCj4gaDN6YXclMkJYeThP
ZGxzdEw1QUg0UjBlWG1OOCUzRCZhbXA7cmVzZXJ2ZWQ9MD4gVHdpdHRlciB8DQo+IDxodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
Rnd3dy5saW4NCj4gYXJvLm9yZyUyRmxpbmFyby1ibG9nJTJGJmFtcDtkYXRhPTAyJTdDMDElN0Nh
bmR5LnRhbmclNDBueHAuY29tJTdDDQo+IGUxYjcwNDgzMmVhMzQ2YWU3Mzg0MDhkNmI4YTYyODNm
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2Mw0KPiA1JTdDMCU3QzAlN0M2MzY4OTk0
MjExMTA0NDE1NzQmYW1wO3NkYXRhPXJsa082bWtIZ2RhbThLMlJUd3NPZg0KPiA4RXhQRjJLUnkl
MkZyTXd3eXNoUkJLQWclM0QmYW1wO3Jlc2VydmVkPTA+IEJsb2cNCg0K
