Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A2520811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xhwmaUbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCHJ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:57:18 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:37697
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfCHJ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUvy+Y9G4P/jigRhXkL4TCC6d10Nz/X47cjLIMPKCbY=;
 b=xhwmaUbq1NTAGcWp4/Faw/ELIFAVqhYB9yUUoPbrlGU82ptrH5lKtKSLwXJfmCOvEeBSFaHWAP66RckKEVZHMovIc/JH94taWbXBerHBLuD6HuLqXPsBY4SAkQ1KmR2Lxu22U5RzL5lsTW6Agn9/bf5ClLOwgIQkBwokQjk9+2w=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB3981.eurprd04.prod.outlook.com (10.171.182.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 09:57:10 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f%4]) with mapi id 15.20.1686.018; Fri, 8 Mar 2019
 09:57:09 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
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
Subject: RE: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Thread-Topic: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Thread-Index: AQHU0jo9yDvlWMWO2EezapwWi7PmgaX7AH0AgAAEh0CABOLvAIABESAQgACE+ACAAALKMA==
Date:   Fri, 8 Mar 2019 09:57:09 +0000
Message-ID: <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
In-Reply-To: <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daf6b28e-065c-494e-a2a6-08d6a3ac6e4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3981;
x-ms-traffictypediagnostic: VI1PR04MB3981:
x-ms-exchange-purlcount: 3
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUIzOTgxOzIzOnZjd1h6U2FRaE1TdXViQ0tTTitqUnR2YUEr?=
 =?gb2312?B?QlJqMDBGajBETXFhdUhPMGpwaTBNaHZZYzVTNWZDQzJnc3dFUzZvcytJZDB4?=
 =?gb2312?B?T3JtWG1jdWFRbjV2UGkrbFJUa3RtUU45QmtiekFveTcvMzBXTGFBTitJai8y?=
 =?gb2312?B?bG5zbTZoQzZDTUpKUU9hY2VCbWo5dnF4QnhLSjJIdjhsS0w0ZWp1dUtKZDA3?=
 =?gb2312?B?YUI2eUMveVl3aEREZVBQTWZuZEpaSk1EQlp3bVl2OWF0b2pKNURKbi91bVY5?=
 =?gb2312?B?ZUdmRHFFWURKWE0vN1dGbUs1NnRzVXVWemNXeTU2Z3ZkY2VkS25tTGZhZVBk?=
 =?gb2312?B?cUhTUExSZEhtckdvSXhlZndQdUpJNUVVaVhqV0VRYXFKQVN3aFhnN1RQRVdz?=
 =?gb2312?B?MFNGR280ZG9IZWYxdDArRE9xQ00rRDdKY3FVRXN4eG54MkVlajlZOUhuZGNM?=
 =?gb2312?B?VXBDU0paYkRmMXRkeGdIM0JVdVB4bHVGTmdIbW0yVytzQ1lFVForT3RPaG5o?=
 =?gb2312?B?MkRBbStETVBHeXl4MlZMNzJ6ZGo5NFozUnBGTHNESVBpd2JoaGtHdmtEWU1D?=
 =?gb2312?B?UDNnU0NtTk02NGZvOFpIUWFqeTd5eWRhYU9nVFVLYkdDQ1loVkFNWmVRYXpB?=
 =?gb2312?B?YXF6UzJIdlVSTEl0NHlJVjlXbXJoaVp5U0Jmc29UNGx1UnI5VDIwdWR5cHVi?=
 =?gb2312?B?bkFHSW9ldEtmckV2ems4d2FUMHRTVld2eVhNSEpEbG5qSXVQNjhob3U1dk1V?=
 =?gb2312?B?VHV0MXN5NktES3JyQUs3bXRMM2VvaDJ3MTVuWUpyTTRDMDJjMmdmOVhGT1lC?=
 =?gb2312?B?UzhTOXFsTzYwNmZrc2Q0WlNWai9rb1dmL2xVRkNGSjNLSUc3RnJyWlROWDJL?=
 =?gb2312?B?L090b1pXcWdJbEEzVWNEbEI1QU5ndXdkWmtWWkxjb2NoWFBJWGlGT0ZJd3BJ?=
 =?gb2312?B?SnoyY0pZOGNURDYxZUFxWjRLNExaVWRadWtERmhZTzhOUFhiYXA2U1VORVll?=
 =?gb2312?B?YlZBaVBVenEwWVNWTTRqOFE4b3AyZE0wOXowMk5yL3NrbUZuR2VmdHBIU2ZH?=
 =?gb2312?B?dWFtMFVqQk5uYVFFVWg2UUtmOEhnY0lOS0FFanc2RnFabWZhZVhmc1lUNmxO?=
 =?gb2312?B?dlBOQnduR3poZ2N4VzVQRlZwbFRIVVNSZ2NuY0ZHbjlnOHFWVXpIc2VTTGgr?=
 =?gb2312?B?UXFqWC9nZ0VkSkhoZ0JlUVdCZWh2bHZURmVtRGd5MDF1Z2JEckNQMXd6R21v?=
 =?gb2312?B?VUt4Y2xCTnpzUlNodEhiRklaNnhQalZmNWdWS0k5bTZoY2FQV0VqVzFJSTdt?=
 =?gb2312?B?WVpQejJCY0FCeDZVTzBRcmVvU0g5c09MNjZyZ3lRUDEvcUVGS3A3WXlBY0ww?=
 =?gb2312?B?b1pIY1ovV2VzSUdkV21LcEJTYStLcVlCTUpjOG03V1FTTzM0ZU5qcmp1UjZ1?=
 =?gb2312?B?UDd3bzJVWDNxcGNUbG5DUXFRbGFMSHQ3SzBXY1ZYSk5wWFZjMldZS2NhRkFH?=
 =?gb2312?B?c3JQZnl1ckRlQm9RT3ZTclRVdk9wSWdpeStPNGZYR25jTGpjUGtiYi9MbVRR?=
 =?gb2312?B?NnB1bU8rb1ZNR09ZWi9uOC9OckhmK2VMelllOUhIMnFpY2dpTmpDeEJnWVpr?=
 =?gb2312?B?RU1iRzJxYkdpT2wwZlNEUG9XcUoyQjdnNWtDU2tJN1ZFalVKVEhiSEpuSHFH?=
 =?gb2312?B?YmovYWdWa1psZVY3VVAxU2J4c2plVVJhczlFMlFmb2xWbWUvczVKa1hXeGxV?=
 =?gb2312?B?QitpZE1lcFkxSHU3M2ZoOGIwaTlCeXB4Nkp1a1JUZXFuN3V3VjU4SkF6L1Jy?=
 =?gb2312?B?RE85ZnpXbVUybTdMdGRPb1VDaXFUMyt1T01UWW0vY3dBRlE9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB3981007E29A47B45AF8F0750F34D0@VI1PR04MB3981.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(13464003)(486006)(478600001)(256004)(52536013)(110136005)(14454004)(316002)(476003)(76176011)(7696005)(6506007)(93886005)(44832011)(11346002)(446003)(5660300002)(14444005)(54906003)(3846002)(6116002)(2906002)(81156014)(66066001)(86362001)(97736004)(7736002)(99286004)(53936002)(6306002)(55016002)(9686003)(8676002)(81166006)(6246003)(33656002)(53546011)(8936002)(229853002)(305945005)(25786009)(6436002)(102836004)(106356001)(105586002)(7416002)(74316002)(4326008)(68736007)(186003)(71200400001)(26005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3981;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OrPQ9FAKcKoCE9McWNZTnntomEmTjDOdhhYfzTMJzeINi6tN6rEm2Ur+ASgzrrvz4wrDJv7BIsnYrh7CBdutcD1tXbggGc/DPY8HmZzBf9p7hRtFiujrUJhVXR6WlOEU6g6q09N78ktZ7rc4UT1pQw0EEQHNPFSVNUhEV6HoCrG5BKxy3MekjWpneyXcmNHhMctju2BeLpujLvLtFuEdLjb6RswKKB0lhLlxSq4fiiFZiVL2YZXFxydKgYRLuVvJIYvMzLJJbgODZF+r4vkJk20hZuxuxmL5UQo3bfP4vjaPWAJgmR8kjm7Ax4M0QVexqVUiftUrvk8e17mNcTx7ZGFgcFxegqqECy3zRTz3GeSJshYpmfTrZCJJJTYdNTm5V+M+cKZ1MGVbs9saT/+OwAJ5t/GC/6wIBT1LNwrAHO8=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf6b28e-065c-494e-a2a6-08d6a3ac6e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 09:57:09.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIExlemNhbm8g
PGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMTnE6jPUwjjI1SAxNzoyOA0K
PiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9A
a2VybmVsLm9yZz4NCj4gQ2M6IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgcm9iaCtkdEBr
ZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBydWkuemhhbmdA
aW50ZWwuY29tOw0KPiBlZHViZXp2YWxAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djJdIGFybTY0OiBkdHM6IGxzMTA4OGE6IGFkZCBvbmUgbW9yZSB0aGVybWFsIHpvbmUgbm9kZQ0K
PiANCj4gT24gMDgvMDMvMjAxOSAwMzowNywgQW5keSBUYW5nIHdyb3RlOg0KPiA+DQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRGFuaWVsIExlemNhbm8g
PGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+ID4+IFNlbnQ6IDIwMTnE6jPUwjfI1SAxNzox
NQ0KPiA+PiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT47IFNoYXduIEd1byA8c2hh
d25ndW9Aa2VybmVsLm9yZz4NCj4gPj4gQ2M6IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsg
cm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+PiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgtcG1Admdlci5r
ZXJuZWwub3JnOyBydWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tDQo+ID4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGFybTY0OiBkdHM6IGxzMTA4OGE6IGFkZCBvbmUgbW9y
ZSB0aGVybWFsDQo+ID4+IHpvbmUgbm9kZQ0KPiA+Pg0KPiA+Pj4+PiBQUzogSW4gb3JkZXIgdG8g
a2VlcCBjb25zaXN0ZW5jeSB0byB0aGUgZmlyc3QgdGhlcm1hbC16b25lIG5vZGUsDQo+ID4+Pj4+
IHRoZXJlIHdpbGwgYmUgIldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzIiB3YXJuaW5n
cy4NCj4gPj4+Pj4NCj4gPj4+Pj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
czEwODhhLmR0c2kgfCAgIDQzDQo+ID4+Pj4gKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+
Pj4gIDEgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
Pj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1sczEwODhhLmR0c2kNCj4gPj4+Pj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHMxMDg4YS5kdHNpDQo+ID4+Pj4+IGluZGV4IDY2MTEzN2YuLjlmNTJiYzkgMTAwNjQ0
DQo+ID4+Pj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwODhh
LmR0c2kNCj4gPj4+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxz
MTA4OGEuZHRzaQ0KPiA+Pj4+PiBAQCAtMTI5LDE5ICsxMjksMTkgQEANCj4gPj4+Pj4gIAl9Ow0K
PiA+Pj4+Pg0KPiA+Pj4+PiAgCXRoZXJtYWwtem9uZXMgew0KPiA+Pj4+PiAtCQljcHVfdGhlcm1h
bDogY3B1LXRoZXJtYWwgew0KPiA+Pj4+PiArCQljY3Ugew0KPiA+Pj4+DQo+ID4+Pj4gSXMgdGhp
cyBjaGFuZ2UgcmVhbGx5IG5lY2Vzc2FyeT8gIFdoYXQgZG9lcyAnY2N1JyBzdGFuZCBmb3I/DQo+
ID4+PiBJIHRoaW5rIHNvLiBjY3Ugc3RhbmRzIGZvciBjb3JlIGNsdXN0ZXIgdW5pdC4gY3B1IGlz
IHRvbyBnZW5lcmFsLg0KPiA+Pj4gT24gc29tZSBwbGF0Zm9ybXMsIHRoZXJlIGFyZSBtb3JlIHRo
YW4gb25lIGNvcmUgY2x1c3RlcnMuDQo+ID4+PiBBdCBsZWFzdCB3ZSBzaG91bGQgY2hhbmdlIGl0
IHRvICJjb3JlIGNsdXN0ZXIiIGlmIHNob3J0IGZvcm0gaXMgbm90DQo+IGFwcHJvcHJpYXRlLg0K
PiA+Pg0KPiA+PiBJZiB0aGUgc2Vuc29yIGlzIGEgdGhlIGNsdXN0ZXIgbGV2ZWwsICdjbHVzdGVy
JyBpcyBlbm91Z2guIElNSE8sIG5vDQo+ID4+IG5lZWQgdG8gZ2l2ZSBhIGRlc2NyaXB0aW9uIG9m
IHdoYXQgY29udGFpbnMgdGhlIGNsdXN0ZXIsIG90aGVyd2lzZQ0KPiA+PiB5b3Ugd2lsbCBlbmQg
dXAgd2l0aCBhICdjb3JlLWdwdS1jbHVzdGVyLWwyJyBuYW1lLg0KPiA+IElmIGNsdXN0ZXIgaXMg
c3BlY2lmaWMgdG8gY29yZSwgd2UgY2FuIHVzZSBjbHVzdGVyIGluc3RlYWQuIEJ1dCBJIGRvbid0
IHRoaW5rIHNvLg0KPiA+IENsdXN0ZXIgbWF5IHJlZmVyIHRvICJjb3JlIGNsdXN0ZXIiLCAiR1BV
IGNsdXN0ZXIiIGV0Yy4NCj4gPiBTbywgSSB0aGluayAiY29yZS1jbHVzdGVyIiBpcyBvay4NCj4g
PiBJZiBjb3JlIHdhcyBkaXZpZGVkIHRvIHNldmVyYWwgY2x1c3RlcnMsIHdlIGNhbiBuYW1lIGl0
IGFzICJjb3JlLWNsdXN0ZXIxIiwNCj4gImNvcmUtY2x1c3RlcjIiIGV0Yy4NCj4gPiBJZiBHUFUg
d2FzIGRpdmlkZWQgdG8gc2V2ZXJhbCBjbHVzdGVycyB3ZSBjYW4gbmFtZSBpdCBhcyAiZ3B1LWNs
dXN0ZXIxIiwNCj4gImdwdS1jbHVzdGVyMiIgZXRjLg0KPiANCj4gDQo+IEhpIEFuZHksDQo+IA0K
PiBJIHRoaW5rIHRoZXJlIGlzIGEgY29uZnVzaW9uIGFyb3VuZCB0aGUgJ2NwdScgdGVybSBhbmQg
J2NsdXN0ZXInLg0KPiANCj4gQVJNIHdvdWxkIGxpa2UgdG8gc2VlIHRoZSAnY2x1c3Rlcicgd29y
ZCB0byBkaXNhcHBlYXIsIHNvIHdoZW5ldmVyIHBvc3NpYmxlIHdlDQo+IHNob3VsZCBhdm9pZCBp
dC4NCj4gDQo+IEZyb20gdGhlIGhhcmR3YXJlIHNpZGUsICdDUFUnIGlzIHVzdWFsbHkgdXNlZCB0
byBkZXNjcmliZSB0aGUgcGh5c2ljYWwgY2hpcA0KPiBjb250YWluaW5nIHRoZSBjb3JlcytjYWNo
ZS4NCj4gDQo+IEZyb20gdGhlIHNvZnR3YXJlIHNpZGUsICdDUFUnIGlzIHVzdWFsbHkgdXNlZCB0
byBkZXNjcmliZSB0aGUgbG9naWNhbCBwcm9jZXNzDQo+IHVuaXQsIGFrYSBhIGNvcmUgb3IgYSBo
eXBlci10aHJlYWQuDQo+IA0KPiBBcyB3ZSBhcmUgaW4gdGhlIERULCBzbyBkZXNjcmliaW5nIHRo
ZSBoYXJkd2FyZSwgdGhlIENQVSByZWZlcnMgdG8gdGhlIGdyb3VwDQo+IGNvcmVzK2NhY2hlcy4N
Cj4gDQo+IEZyb20gbXkgUE9WLCB1c2luZyAnY3B1JyBmb3IgdGhlIGdyb3VwIG9mIGNvcmVzIGFu
ZCAnZ3B1JyBmb3IgdGhlIGdyYXBoaWMNCj4gc291bmRzIG9rLCBhbmQgc28gZmFyIHRoYXQgaXMg
d2hhdCBpcyB1c2VkIGZvciB0aGUgb3RoZXIgcGxhdGZvcm1zLg0KPiANCj4gSWYgeW91IGNoYW5n
ZSB0aGUgbmFtZSwgdGhhdCBtYXkgZ2l2ZSB0aGUgZmVlbGluZyB0aGVyZSBpcyBzb21ldGhpbmcg
c3BlY2lhbA0KPiB3aXRoIHRob3NlIHRoZXJtYWwgem9uZXMuDQoNClRoYW5rcyBEYW5pZWwgZm9y
IHlvdXIgZGV0YWlsZWQgZXhwbGFuYXRpb25zLg0KDQpCdXQgYXMgeW91IHNhaWQgJ0NQVScgaXMg
dXN1YWxseSB1c2VkIHRvIGRlc2NyaWJlIHRoZSBwaHlzaWNhbCBjaGlwLg0KU28gaWYgd2UgbmFt
ZSBpdCBhcyBDUFUsIGl0IHNvdW5kcyBsaWtlIHRoaXMgdGVtcGVyYXR1cmUgc2Vuc29yIGlzIG1v
bml0b3JpbmcgdGhlIHdob2xlIGNoaXAuDQpUaGF0J3Mgbm90IHRydWUgaW4gb3VyIGNhc2UuDQoN
ClRha2UgbHMyMDg4YSBmb3IgZXhhbXBsZToNCkluIGxzMjA4OGEgU29DLCB0aGVyZSBhcmUgNyB0
ZW1wZXJhdHVyZSBzZW5zb3JzLiBQbGVhc2Ugbm90ZSB0aGF0IHRoZXkgYXJlIGFsbCBsb2NhdGVk
IGluIFNvQy4NClRoZSBwbGFjZW1lbnQgb2YgdGhlIHRlbXBlcmF0dXJlIHNlbnNvcnMgYXJlIHNo
b3dlZCBiZWxvdzoNCg0KU2Vuc29yIElECQlwbGFjZW1lbnQNCjEJCQlERFIgY29udHJvbGxlciAx
DQoyCQkJRERSIGNvbnRyb2xsZXIgMg0KMwkJCUREUiBjb250cm9sbGVyIDMNCjQJCQljb3JlIGNs
dXN0ZXIgMQ0KNSAJCQljb3JlIGNsdXN0ZXIgMg0KNiAJCQljb3JlIGNsdXN0ZXIgMw0KNyAJCQlj
b3JlIGNsdXN0ZXIgNA0KDQpBcHBhcmVudGx5IHVzaW5nIENQVSBvciBDUFUtY2x1c3RlciBpcyBu
b3QgYXBwcm9wcmlhdGUuIENvcmUtY2x1c3RlciBpcyBiZXR0ZXIuDQoNCldoYXQgZG8geW91IHRo
aW5rPw0KDQpCUiwNCkFuZHkNCj4gDQo+IA0KPiANCj4gDQo+IC0tDQo+IA0KPiA8aHR0cHM6Ly9l
bWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJG
d3d3LmwNCj4gaW5hcm8ub3JnJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbmR5LnRhbmclNDBueHAu
Y29tJTdDMDYxOWQyYzg3ZTUNCj4gYTQxMmQ4OGQxMDhkNmEzYTg2NTBlJTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMA0KPiAlN0M2MzY4NzYzNDA5Nzk1Mjc1MDMmYW1w
O3NkYXRhPWpYZElLaENJd1B4bVRsbUtvVmU0aUhDcHZwTXhMVkZaDQo+IFViTEIzOWlUUlo4JTNE
JmFtcDtyZXNlcnZlZD0wPiBMaW5hcm8ub3JnIKmmIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvcg0K
PiBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy4NCj4gZmFj
ZWJvb2suY29tJTJGcGFnZXMlMkZMaW5hcm8mYW1wO2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0
MG54cC5jDQo+IG9tJTdDMDYxOWQyYzg3ZTVhNDEyZDg4ZDEwOGQ2YTNhODY1MGUlN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1DQo+IGMzMDE2MzUlN0MwJTdDMCU3QzYzNjg3NjM0MDk3OTUyNzUw
MyZhbXA7c2RhdGE9eW5acnI0ZnJNUFhYd2VnUQ0KPiB3SjBrQVN4c0s4UWpoQ2ZCN09rMkQ1WjF5
RWMlM0QmYW1wO3Jlc2VydmVkPTA+IEZhY2Vib29rIHwNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aXR0ZQ0KPiBy
LmNvbSUyRiUyMyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0MG54
cC5jb20lNw0KPiBDMDYxOWQyYzg3ZTVhNDEyZDg4ZDEwOGQ2YTNhODY1MGUlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYNCj4gMzUlN0MwJTdDMCU3QzYzNjg3NjM0MDk3OTUyNzUwMyZh
bXA7c2RhdGE9cVBRRk1wbnpoZ1lkUzFJWGJQMEZjDQo+IHdKb005cjVxMEwxQlg4SkxUS1dXbzgl
M0QmYW1wO3Jlc2VydmVkPTA+IFR3aXR0ZXIgfA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3LmwNCj4gaW5hcm8u
b3JnJTJGbGluYXJvLWJsb2clMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2FuZHkudGFuZyU0MG54cC5j
b20lNw0KPiBDMDYxOWQyYzg3ZTVhNDEyZDg4ZDEwOGQ2YTNhODY1MGUlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYNCj4gMzUlN0MwJTdDMCU3QzYzNjg3NjM0MDk3OTUyNzUwMyZhbXA7
c2RhdGE9VTVIMFdjMmh3a0hFMG9LVEE2SA0KPiBWYlE0UWRFbUJmWiUyRkMlMkZIbDJpdDBiek5V
JTNEJmFtcDtyZXNlcnZlZD0wPiBCbG9nDQoNCg==
