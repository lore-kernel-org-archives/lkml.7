Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8AF2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S5GSCHnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCDRds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:33:48 -0500
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:5536
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfCDRdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpIuBcTQGl6Afml3qil5bw1sM28kj/Byf0N9cMFIiaQ=;
 b=S5GSCHnB2N2IVEbRF6679rXf6Rateh5YAu8hcTj8ZFt1PmjbGTkQnBHtsJH/oA3vkx/5f+pdUW85UlRiH/hCw9bD+Gj7xhdG9YFA0AUYl9AoNR0EzFJEj6hSoCfbP2LXifWcV8Mbe4UDmxMT8GpK/60p9/PoRWT6KC7i1yc2W5c=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4520.eurprd04.prod.outlook.com (20.176.243.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 17:33:43 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::a4a8:ea0:40f6:5162]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::a4a8:ea0:40f6:5162%3]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 17:33:43 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
CC:     Coly Li <colyli@suse.de>, Federico Vaga <federico.vaga@vaga.pv.it>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "harryxiyou@gmail.com" <harryxiyou@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@zh-kernel.org" <linux-kernel@zh-kernel.org>
Subject: RE: [PATCH 01/20] docs/zh_CN: add disclaimer file
Thread-Topic: [PATCH 01/20] docs/zh_CN: add disclaimer file
Thread-Index: AQHU0lKQzuFmAQT00UCQM8j+2JkFKaX7G0BWgACfzoA=
Date:   Mon, 4 Mar 2019 17:33:43 +0000
Message-ID: <AM6PR04MB586370DDB6E73A43673339568F710@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
 <20190304035744.155203-2-alex.shi@linux.alibaba.com>
 <b2cb92de-ef4a-d628-0dd3-76d8d1b953d0@linux.alibaba.com>
 <CADRPPNSjf4P14bwUMsa10XzBUVLszx4iMsL6gk-XQ0x3vTFr+g@mail.gmail.com>
 <e342a3fa-20f6-46cd-4240-8403fa1aa736@linux.alibaba.com>
In-Reply-To: <e342a3fa-20f6-46cd-4240-8403fa1aa736@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7262c07d-5de6-4e8f-d551-08d6a0c78c84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4520;
x-ms-traffictypediagnostic: AM6PR04MB4520:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NTIwOzIzOmtKQm11djE2Y2RnQXJ3RjdZNGx4OEg4azBp?=
 =?utf-8?B?M3g0QjZVd0lnTXprODJCNnNHQVZHTDBrYVlZallidENtc3plMmdCMHVnT1pm?=
 =?utf-8?B?YWdJVktiSGFLN2pEWDBVdG9oMjBndzViazNUajk4NnA0NGh5TGpMdi9jOWRB?=
 =?utf-8?B?S1BiZER4RWpqUjdaamtQL21JN2ZyQWJ3a2dBNGZTcXZyTHpTaHg1dWRMamsz?=
 =?utf-8?B?Vi9wTEZ4dXdyWS9TM3liNkI3YmthQmUzeHRKYWttdlE5cjR3TzI1L0UzTnRY?=
 =?utf-8?B?Qzl4eHp0cW92aUZRcGp6aExCL1IwcDlVdlVwVEpHblpaZFRsb2I0RUZkVjJj?=
 =?utf-8?B?YmQzcUo2SkJ3eTcva1p6a1o5NjJoaXpqWU9BUlRSeDRkUW0vZHd3MDNSQUR3?=
 =?utf-8?B?RFB2Q2luL05lWUxBV3pGNDVmeVJQS2c3elNKTCtWWlRWSXlCZVVNaGkrc3FF?=
 =?utf-8?B?OUQxTHhnclg2b0tYV2kvRnR0OG9JSFROdmpaZkpZQzRRdEVQR3lFb1hRUU00?=
 =?utf-8?B?RCt4ZnJSTUlMZThsN051VHFMRGpvN1g5YnpNc3FaYnNNS2Z2YXpCbGxDRVF1?=
 =?utf-8?B?TXBhbkFJNTdCSUY4MkVPTFo1RC9UeWtJNjNTNFBQV2dzSDFndGdqa1JtdUhI?=
 =?utf-8?B?Z1hZb3h3NVpwRjRzdWpodm9EYUpuS1MycnNBcWpQNTlERHR1S1kvVGIvWlBM?=
 =?utf-8?B?ZFdIMXdtYUE4L0ZORjcvcnNhK0pBaVh3eG1HQjJPb2d1MlVjTVhndGJkTVI5?=
 =?utf-8?B?Z1NrZXVtSHlTVDY5S0d2RTFqOWtYdG40dSsyczJ0NjVoWDFXRjQ1eDI5eEJm?=
 =?utf-8?B?TDhsSG0zTFZOcDVnRlR2MEV4Q0ZyQlVFVmNEWGU0OWE0bE9tWE9qcVBuOWw4?=
 =?utf-8?B?WGorbWxQTjZldkRxdGJKNFlyaTExQ1dwTTI5blBpMEp6d3NnUWRORXk0dWJj?=
 =?utf-8?B?bk8rR2NqM1l0ZDBYSHpidGNTeGZtM3ViMnM3bjIyejBXMlVQdEdsc1ZYbEE1?=
 =?utf-8?B?K0tGck1uOUZUMHBKNG1RbGg4S0ZUM3E1S2dNeEg3TEVlV0VzcmlUL0tRN2V5?=
 =?utf-8?B?S1QzazBRRDhxTTBEUFQyTno3dnIyZWJiQjRCY2RRa0IwZmZrdXZIbHg5ZVM1?=
 =?utf-8?B?UU1yR01KQThnSk9JS0MrYkZ3M0xHakN6S2MrVXVRc0JQaTNtZVg0K0hXaG1n?=
 =?utf-8?B?TW9FSUdyTTlLWmw2a0pQSFpuS1JwU0phVy9TMlpqTnRmcTNLR3N2RjQ4RkdB?=
 =?utf-8?B?WjF3ak5rSzhwU2tZNDdIbzI1S3ZrY1VyUlNhOXhWVkNJc3BmcmE1UG5zaFR6?=
 =?utf-8?B?WGUrOUt1dGl4VDN2YlI3eGdVRFRkOEY2dmtodThCUkJncDFPaHVqVGJFUTZx?=
 =?utf-8?B?azU3K0l5U1pIaXQ4azNhblVkdlcxR2JKUlVmTlVveitEdXBYelJ1MUkwZzdN?=
 =?utf-8?B?R3RwMnFWWFhFYzN2N3dBZVgxbFRkUDlqekhUQzhxZktUdVcxdXNiTHoxYWUr?=
 =?utf-8?B?WGZGWFJvYkxKcUl5NnQwL2RROVV0TUc4eEpua0g4c3BXTmFFZXV6MU9vaUZn?=
 =?utf-8?B?MlRDcTE3NzdKdTFJeEZJVi8vbWNsR3BwbmxKRWJ1RWhXKzY0aEFXRUROYUpW?=
 =?utf-8?B?ZFJNcEtoQ3ZOMUYwVWFrWW1vNmN4di9ndE1TUFFsK2c3YWZpTkQzRlNOWnJI?=
 =?utf-8?B?b25WdHdVbzJka0psVStSb1hXVmtWSnkzbnJXdUlHTEFyZWU0dzhzZ2xiWlAz?=
 =?utf-8?B?R0toNjlkTlMxTVQ1dlptLzFEZUNsYmhQcEZZU1VyaVlkNjJuY2dJVWIrSnRa?=
 =?utf-8?B?WVV6a3diVTM0VkJLelpJOHNFeWcxcExkSEFTUUlqQlBwcEFlR2xrRlFLWmZs?=
 =?utf-8?Q?h5yd+70e6Ow=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB4520B844D0E3BF41D4EB35A98F710@AM6PR04MB4520.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(13464003)(189003)(199004)(486006)(105586002)(14454004)(478600001)(81156014)(81166006)(8676002)(106356001)(446003)(476003)(7416002)(11346002)(54906003)(316002)(93886005)(74316002)(68736007)(33656002)(966005)(6916009)(97736004)(66066001)(186003)(7736002)(8936002)(305945005)(14444005)(256004)(26005)(71200400001)(71190400001)(25786009)(6246003)(102836004)(53546011)(6506007)(6436002)(86362001)(5660300002)(45080400002)(6116002)(53936002)(55016002)(2906002)(9686003)(229853002)(6306002)(76176011)(3846002)(52536013)(99286004)(7696005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4520;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zp3SPgRc/S/rwRSVzKc6tgOutvT32y2RrLjlNpyx625KJqwT2HOMOBpo9e6U8h2zX8VDx1QUVNZa09PYGllNcxF3IjLHdi5rd2/QCHLyG2jqwHXGmbZfS82HSR0PMQM+8zdB9h/QJaNIBLeZ/ZGjjPeJbbpx8BbqJuyaqiGyBhgvjNy+6/KKD2FP8RZlfRmtgXMmxNxEeu3fe2ScabHbKBVuUokcb2egbsTBS0gH/Il6kY1rz+62H1H0021IkcMg9CAGxQKhjP/5JWhJJkyfnlqxnSCitutc6avv04cZNPgwmnp+1uNiEgrLdKFZWmYfUCD5gGyx+UgDajizaDd439uo0A3DF9AKafE46pRJWGT5Mgl0k03N9Hb6xlQvRgRHKZBMvQyr2yJCafIjb/vcaXgOHg9vOoKR+C7uEuICNYA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7262c07d-5de6-4e8f-d551-08d6a0c78c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 17:33:43.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBTaGkgPGFsZXgu
c2hpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDQsIDIwMTkgMTo1
OCBBTQ0KPiBUbzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IENjOiBDb2x5IExpIDxj
b2x5bGlAc3VzZS5kZT47IEZlZGVyaWNvIFZhZ2EgPGZlZGVyaWNvLnZhZ2FAdmFnYS5wdi5pdD47
DQo+IEZlbmdndWFuZyBXdSA8ZmVuZ2d1YW5nLnd1QGludGVsLmNvbT47IExpIFplZmFuDQo+IDxs
aXplZmFuQGh1YXdlaS5jb20+OyBTaGF3biBHdW8gPHNoYXduLmd1b0BsaW5hcm8ub3JnPjsNCj4g
Y29yYmV0QGx3bi5uZXQ7IGhhcnJ5eGl5b3VAZ21haWwuY29tOyBsaW51eC1kb2NAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHpo
LWtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMS8yMF0gZG9jcy96aF9DTjogYWRk
IGRpc2NsYWltZXIgZmlsZQ0KPiANCj4gSGkgTGVvLg0KPiANCj4gRG8geW91IGtub3cgb3RoZXJz
JyBlbWFpbCBhZGRyZXNzIGV4Y2VwdCB5b3Vyc2VsZi4gSSBndWVzcyBsZW95YW5nLmxpIGlzIHNh
bWUNCj4gb25lIGFzIG1haWx0bzpsZW9Aemgta2VybmVsLm9yZywgaXMgdGhpcyByaWdodD8gOikN
Cg0KSGkgQWxleCwNCg0KSSB3aWxsIHRyeSB0byBnZXQgdGhlIG5ldyBlbWFpbCBhZGRyZXNzZXMg
Zm9yIG90aGVycyB0b28uICAgWWVzLiAgQnV0IHByb2JhYmx5IEkgd2lsbCB1c2UgYSBwcml2YXRl
IGVtYWlsIGZvciB0aGlzIGluc3RlYWQgb2YgdGhlIGNvbXBhbnkgZW1haWwuIPCfmIoNCg0KPiAN
Cj4gVGhhbmtzDQo+IEFsZXgNCj4gT24gMjAxOS8zLzQgMjozMCDkuIvljYgsIExpIFlhbmcgd3Jv
dGU6DQo+IA0KPiANCj4gT24gTW9uLCBNYXIgNCwgMjAxOSBhdCAxMjoyMyBBTSBBbGV4IFNoaQ0K
PiA8bWFpbHRvOmFsZXguc2hpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gQlRXLCBDb3Ji
ZXQsDQo+IA0KPiBTb21lIG9mIGVtYWlsIGFkZHJlc3MgYXJlIHVudXNlZCBhbmQNCj4gaHR0cHM6
Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJG
JTJGemgtDQo+IGtlcm5lbC5vcmcmZGF0YT0wMiU3QzAxJTdDbGVveWFuZy5saSU0MG54cC5jb20l
N0M2YjY0NzIxYjEyNjk0NGRlDQo+IDgzNWMwOGQ2YTA3NzEzNzklN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdDNjMNCj4gNjg3MjgzMDYzNDAyNDQxMiZzZGF0YT1j
TW5GalJqQXpvZGg1SWdGVmFadlpwbVhOWGZIYiUyRndXQ1R4d3QNCj4gdCUyRk82ZTQlM0QmcmVz
ZXJ2ZWQ9MCB3ZWIgc2l0ZSBhcmUgdW51c2VkIGFuZCBvbiBzYWxlLiBUaGF0IGFyZToNCj4gDQo+
IFRoZSB3ZWJzaXRlIGhhcyBiZWVuIGRvd24gZm9yIGEgd2hpbGUgYW5kIHdvbuKAmXQgYmUgcmVv
cGVuLsKgIEJ1dCB3ZSBjYW4NCj4gZGVmaW5pdGVseSB1cGRhdGUgdGhlc2UgZW1haWwgYWRkcmVz
c2VzLg0KPiANCj4gDQoNCg==
