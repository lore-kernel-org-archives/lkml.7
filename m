Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E804DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 03:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A204218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 03:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="djzUGPWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfB1DAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:00:14 -0500
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:44001
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730240AbfB1DAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 22:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8kqMg25enz1EFlXmOfE1rf2yITmzZWMnHyAJT4CpMk=;
 b=djzUGPWc+FM3cv+t1KZ5y3Am2LGOJub6M1hls3pBqH95BwEt8hISpvc4YPJVC+/X8nCTNRA7JBnun6FiqpUxFX+kDzXEShS0Z+xgfuf5ecDnh6fL6dHrfoynajbrjxueDjp484AQr4+zweqJ0u0nQf/H6nTGM7AjxC/8p7qGm3o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 03:00:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 03:00:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHUzwRDJ7uxcAbsqkmFaMlWuVCzvKX0bOMAgAAGAvCAAAD3AIAADGxQ
Date:   Thu, 28 Feb 2019 03:00:08 +0000
Message-ID: <DB3PR0402MB39167B9C2EEA8546CE8FDED5F5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
 <1551316741-7848-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DQM0-rBbWuWa7dZw8es1NbY8DwCGmU4_ZJ2FdFEXYC6Q@mail.gmail.com>
 <DB3PR0402MB391672641C4829C18DA0DB36F5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAOMZO5BXCgj+uqA0xoOFYo3GxbN_HfbFyfQFmNRa4_AHL3nx0g@mail.gmail.com>
In-Reply-To: <CAOMZO5BXCgj+uqA0xoOFYo3GxbN_HfbFyfQFmNRa4_AHL3nx0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71e7f173-2677-474b-1517-08d69d28d904
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3MjE7MjM6eEVlTHlOSVFGK3g2Z0pXM0d4ZWU5Yldm?=
 =?utf-8?B?NUVBd0NqVDdCbkMvRjZLdTA0aHF2dG5MV245Uk05UTh1QkNjUWx5dmsvT1Bh?=
 =?utf-8?B?ZjFkdFZTOFVmeVhUL2VROFhhcHpZai8vOS9qNjVSbW83OEJtK2NNamRJb0pD?=
 =?utf-8?B?STE2WFI2cW91NmZNTHlncndiejV4bDJKK2RGbFI0V1NuM0I4Qm00RjFWN2Uz?=
 =?utf-8?B?SG83YWFWZTVLZnBjNGNsdjVGWXdyeVNoeS9oVVk1ZHZlK1BXUWx6NUtsOHhN?=
 =?utf-8?B?Q1J3MTJuSEloQ2tPZkZUdm0xWldmdWdhaGY0bzBXdzEzbnZFbHQ0cStwUDQy?=
 =?utf-8?B?TGZCR1h1aE04cE9yWkQyLzZjemk4blFxMFBMZmtPLy9OQktkeFd1bk5BR08v?=
 =?utf-8?B?VTM1Qm9WdGdZR1JhTzVxWjl6Wldub3I3TkIxLytoZkhMeHZDVHJkWkZudFBP?=
 =?utf-8?B?LzNrNVZKSDVlTkQ0TXozS2ZVbFdQaFZPMldMZWY4RnliRDBwZUN3R0JiN1Bl?=
 =?utf-8?B?eDF5cndkTVdjcEw2YXlGd0VIUW9sMmJ4L3VIVW1jZHRyUUxuTFdWRlBPNWE0?=
 =?utf-8?B?dFpsWXE2c0hwS3g0eUprVDJZN01yb00wbnQyUWxuQXdUeFQvVFY2MGdkMlZK?=
 =?utf-8?B?Q3V1VnJ1VFRTQWRNdmRzNFgzSVgyaFdWWURzVnJycmN4K0ZaV2xpVEFCL2ph?=
 =?utf-8?B?SjQ0K1JETjJJckpJbytiRlpYQUFBd1NsM0lHdFNUK25kTWEvdWIvS0lDVEF0?=
 =?utf-8?B?MEVCV1hZdmlKZWZ3N1JFV2xaZ1RpdldKTGp1UEEvNDNpZHBGVHkxKzdRblNR?=
 =?utf-8?B?b3FkanpCTlppaSs4VzVPOTNyYjhKVDJaSlYrNHpXYlBkVDNiNTl1RVdqTTBH?=
 =?utf-8?B?d0lFa1BiVk5JZHpZV0lua0N3eUhMWlBpS28xRlJSSXEvT0RrSzdKU1hSaWRL?=
 =?utf-8?B?NURqem5iMFBRbnpwc3B1OUxOZFlVNFp1RGxJY3N0dDVET3hHUVJ5aTJkRXdR?=
 =?utf-8?B?MWJvQjRsSFZib1lCYjlUZ014czRUQ2tUbXRyZHBIc2dIbHRrYmdZZURCcFNn?=
 =?utf-8?B?YVIvalR5UlpnMU1LU0pBODBSYTdwY3dJa3FBd1BXNkFPNlhtYnRCNVVJUkFv?=
 =?utf-8?B?TGJ3azkvcmVMVWFKQmZVZ2EzcHZJeFB3SnRuaDNxTEp5dGNJcjZQMWlndldh?=
 =?utf-8?B?UDZUYTdIZkhnN0xMcng4dkV6SjRuWFlZbDJFZjhjM1BzdERTYkJPWTk0eEZu?=
 =?utf-8?B?ZTVkZm1JVGYwMW1STlZubDVVZ05kdmFNUFhwYUtYT0I2TGhUd1BJdEpqMmEz?=
 =?utf-8?B?dlE0M0NqcWxhcHJjN3pEV1ZDbWE0V0U0TVJsbDA5di9LTlZMdXV2aWIxWC8y?=
 =?utf-8?B?TDA0MjI4dGxMSzltdGZGQzJYL1lqY0FKYkRJSmRkNEpsaXhScUV2bm4zTGZI?=
 =?utf-8?B?VzU2TktWS0pZV0JOOG5DVFZDakZFeW8xdFRmM1ZQWDlGTjhhc0YyczZwaS9t?=
 =?utf-8?B?bnJIUGNWWjJVejU1a1Avbkg4bnhWdVppM2RDbHM1R2N0RTA2V2JucjNpcHd4?=
 =?utf-8?B?ZytGZVJ2TnJKck1idGxHUHNzT1JqcTlGQ044YytBYjlmaTA4dWM2cTU4a1Q4?=
 =?utf-8?B?SDJpTEFDUDVYMk8yMEx4T3c3aDlGUkRCbzBseWRDSXp1bDFidDRuZGlCVmND?=
 =?utf-8?B?Y2FEcFkyM0lIbWhRQi81VzNGd0swSmZPNG4xcGJRb3lQQWZkcmt2T1lqNStP?=
 =?utf-8?B?NzRxdHZKM3ZoaFlrcVlFZ1hmRHhDTldvdXhJc1JoWXRGWW5Zc0VTN0RHUGNv?=
 =?utf-8?B?ZVp5QkpMR0NMTHZwR1pReXFYMjQzVDZDRnZMemkwYzZVUXpjQT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB3721D7EB73363912B5214054F5750@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(13464003)(6246003)(54906003)(486006)(68736007)(11346002)(476003)(4326008)(25786009)(446003)(2906002)(316002)(478600001)(14454004)(93886005)(102836004)(229853002)(256004)(76176011)(55016002)(6346003)(81156014)(9686003)(6436002)(44832011)(6116002)(8936002)(81166006)(99286004)(8676002)(3846002)(53546011)(7736002)(305945005)(7696005)(6506007)(53936002)(66066001)(26005)(97736004)(105586002)(186003)(106356001)(74316002)(86362001)(33656002)(1411001)(52536013)(4744005)(6916009)(71190400001)(5660300002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dN3XwuuoqpEH0YjWL3UQaY7kHtxjVHtdW1GTwr+Ek306F/qYQwESCNnb8IR7/M/CdxG7y1wUmYUbXPLFYlz4U9MReLa0VWr1kT/9xTHSTVWGxl94jcMz7/87qrqzLDC896iujGmjZXqHXDM0YoxjvVQcVF47zmoCGJmWbrjv+cSbh5MNEpKVacXatw3+gcxKOYVODX57sGkPdE9X3mfUjOO6OCI3AYgnZu35gTqDUWTjY7vQxq8Ekd8Ys49b191w+PsH3zviH1aYCvsWY7bwHqtJPH2pjzPSdS2mckbIjvPVbrV3blscGC70DQ60DbkAWF9pdU8u/CCZYTp2SD4z2wG/+YAO5xDHK7ptkB4WbXIbo0sQlUosl0SZuGccF8hqkpUfoOvB+dS8aC1HqKEoS36fbB6PMwkg29XNTBDff4I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e7f173-2677-474b-1517-08d69d28d904
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 03:00:08.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOeW5tDLmnIgyOOaXpSA5OjU3DQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5y
dXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8zXSBBUk06IGR0czogaW14N3VscDogYWRkIG1tZGMgc3Vw
cG9ydA0KPiANCj4gSGkgQW5zb24sDQo+IA0KPiBPbiBXZWQsIEZlYiAyNywgMjAxOSBhdCAxMDo1
NCBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+
IElmIHNvLCBzaG91bGQgSSBjaGFuZ2Ugb3RoZXIgaS5NWDYgU29DcyB3aXRoIHNpbmdsZSBNTURD
IG5vZGUgYXMgd2VsbD8NCj4gPiBSZW1vdmUgdGhlbSBhcyB3ZWxsPw0KPiANCj4gT25seSBpbXg2
cXAgbmVlZHMgdGhlIG1tZGMgbGFiZWwuDQo+IA0KPiBJIGNhbiBzZW5kIGEgcGF0Y2ggcmVtb3Zp
bmcgaXQgZnJvbSB0aGUgb3RoZXIgaS5NWCBTb0NzLCBzbyBkb24ndCBuZWVkIHRvDQo+IHdvcnJ5
IGFib3V0IGl0IGluIHlvdXIgc2VyaWVzLg0KDQpPb3BzLCBJIGFscmVhZHkgc2VudCBvdXQgVjMg
cGF0Y2ggc2VyaWVzIGluY2x1ZGluZyBhbGwgaS5NWCBTb0MgTU1EQyBsYWJlbCByZW1vdmVkIGJl
Zm9yZQ0Kc2VlaW5nIHlvdXIgbWFpbCwgc28geW91IGNhbiByZW1vdmUgaXQgZnJvbSB5b3VyIFRP
RE8gbGlzdCwgcGxlYXNlIGhlbHAgcmV2aWV3IGl0LCB0aGFua3MhDQoNCkFuc29uLg0KDQo+IA0K
PiBUaGFua3MNCg==
