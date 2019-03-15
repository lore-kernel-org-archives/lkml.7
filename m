Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0679AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF17120854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JdFlV7XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfCOM4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:56:11 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:38317
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbfCOM4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVY+Pu4UHnKTy5M9cmUcY0HcfMXrDGpnKNhbQ38zX4s=;
 b=JdFlV7XLD4MaWk5Sna9BraeH1gy7MQH5CMIXU14V6D+cqltKDP0MwihUsvIdJgk7wcA7DJ+kH2oVvi2ELPSDRyrS6MVUUU2ssJoheCjNgakbgXqxmD+o4XYVBN0F4TWdxcgeDpFtaU1r38o45Qv87ndF3nmJA8edUioFH1lHVS4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4785.eurprd04.prod.outlook.com (20.176.215.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 12:56:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 12:56:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Topic: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Index: AQHU2Xv1SFnRc4p0SkOOn59vTkEkO6YMepnAgAAsWEA=
Date:   Fri, 15 Mar 2019 12:56:06 +0000
Message-ID: <AM0PR04MB4481232D83340F894644673C88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <AM0PR04MB4211DC74D7E72F886A4333D680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211DC74D7E72F886A4333D680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [121.236.246.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6fc4e69-b0a5-471f-46d5-08d6a94596ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4785;
x-ms-traffictypediagnostic: AM0PR04MB4785:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB478543F4986F5A8F5638900688440@AM0PR04MB4785.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(13464003)(11346002)(186003)(486006)(316002)(478600001)(14444005)(476003)(25786009)(2201001)(446003)(81156014)(2906002)(86362001)(256004)(110136005)(44832011)(8676002)(8936002)(74316002)(6116002)(81166006)(53546011)(6506007)(7736002)(26005)(102836004)(305945005)(3846002)(2501003)(966005)(229853002)(68736007)(52536014)(33656002)(5660300002)(14454004)(66066001)(99286004)(76176011)(71190400001)(6436002)(105586002)(6246003)(55016002)(53936002)(4326008)(9686003)(6306002)(106356001)(97736004)(7696005)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4785;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f1ueyDpRMV5rne7l3l+4XqU6PJjdve+q+2rZHzUPQMRwCvk1gWCUZUVm0SYKdBCygcsu+tUmco6RbeO8fQcI1Bxif34ijmcRQqtv5JwRrOHc5EBMQQNAQbPlZI5ABmWsGrpVQ0OsM24FEAmnN8TDXlhww4roCLiUSCHLOP4f2wvBpqdiNhjqw0EmExDtzndzMa3wsOzdGWQ7JP48u8/0mx2UsBCbyBF94/NbxF6pRNKpJXSUrLlhPEU7axkLpEjW/3jsb51x//J+1z5yS5TTu/8LHPVRfrOcYFwyFLY0H2VesDxxn8Y/4DOmXxpMHiLxGfomSHXOSTA0xS38uoPWhr7EgTJB64pS6v+HweN+0bnVfECYD9C8XF+xUhkRIrA4l43ouziBbi4f8TEqpmmDgkN/lwnp825tT3khFzubT70=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fc4e69-b0a5-471f-46d5-08d6a94596ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 12:56:06.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWlzaGVuZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaXNo
ZW5nIERvbmcNCj4gU2VudDogMjAxOcTqM9TCMTXI1SAxODoxNw0KPiBUbzogUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0Bu
eHAuY29tPjsNCj4gYXJuZEBhcm5kYi5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiB2YW4uZnJlZW5p
eEBnbWFpbC5jb20NCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIEFSTTogaW14OiBkcm9wIHVu
ZWNjZXNzYXJ5DQo+IG9mX3BsYXRmb3JtX2RlZmF1bHRfcG9wdWxhdGUNCj4gDQo+ID4gRnJvbTog
UGVuZyBGYW4NCj4gPg0KPiA+ICJhcmNoX2luaXRjYWxsX3N5bmMob2ZfcGxhdGZvcm1fZGVmYXVs
dF9wb3B1bGF0ZV9pbml0KTsiIGNvdWxkIGJlIHVzZWQNCj4gPiB0byBwb3B1bGF0ZSB0aGUgZGV2
aWNlIHRyZWUsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2FsbA0KPiA+IG9mX3BsYXRmb3JtX2RlZmF1
bHRfcG9wdWxhdGUgaW4gbWFjaGluZSBjb2RlLg0KPiA+DQo+ID4gVGVzdGVkIG9uIGkuTVg2US1T
REIgaS5NWDZTTC1FVksgaS5NWDZVTC1FVksgYm9hcmQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vbWFj
aC1pbXgvbWFjaC1pbXg2cS5jICB8IDIgLS0NCj4gPiBhcmNoL2FybS9tYWNoLWlteC9tYWNoLWlt
eDZzbC5jIHwgMiAtLQ0KPiA+IGFyY2gvYXJtL21hY2gtaW14L21hY2gtaW14NnN4LmMgfCAyIC0t
DQo+ID4gYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2dWwuYyB8IDEgLQ0KPiA+ICA0IGZpbGVz
IGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1pbXgvbWFjaC1pbXg2cS5jDQo+ID4gYi9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDZx
LmMgaW5kZXggN2Q4MGEwYWU3MjNjLi42NTUzOThjMjAyNTYNCj4gPiAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDZxLmMNCj4gPiArKysgYi9hcmNoL2FybS9tYWNo
LWlteC9tYWNoLWlteDZxLmMNCj4gPiBAQCAtMjc4LDggKzI3OCw2IEBAIHN0YXRpYyB2b2lkIF9f
aW5pdCBpbXg2cV9pbml0X21hY2hpbmUodm9pZCkNCj4gPg0KPiA+ICAJaW14NnFfZW5ldF9waHlf
aW5pdCgpOw0KPiA+DQo+ID4gLQlvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlKE5VTEwsIE5V
TEwsIHBhcmVudCk7DQo+ID4gLQ0KPiANCj4gVGhpcyBzbGlnaHRseSBjaGFuZ2UgdGhlIGRldmlj
ZSByZWdpc3RlciBzZXF1ZW5jZSBhcyB3ZWxsIGFzIHBvc3NpYmxlIGRyaXZlcg0KPiBwcm9iZSBz
ZXF1ZW5jZSBhcyBhIGNvbnNlcXVlbmNlLg0KDQpUaGlzIHBhdGNoIGlzIGluc3BpcmVkIGZyb20g
cGF0Y2g6DQoNCmNvbW1pdCA4NTBiZWEyMzM1ZTQyNzgwYTA3NTJhNzU4NjBkM2ZiY2MzZDEyZDZl
DQpBdXRob3I6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbT4NCkRhdGU6
ICAgV2VkIEp1biAxIDE0OjUyOjU2IDIwMTYgKzA4MDANCg0KICAgIGFybTogUmVtb3ZlIHVubmVj
ZXNzYXJ5IG9mX3BsYXRmb3JtX3BvcHVsYXRlIHdpdGggZGVmYXVsdCBtYXRjaCB0YWJsZQ0KDQog
ICAgQWZ0ZXIgcGF0Y2ggIm9mL3BsYXRmb3JtOiBBZGQgY29tbW9uIG1ldGhvZCB0byBwb3B1bGF0
ZSBkZWZhdWx0IGJ1cyIsDQogICAgaXQgaXMgcG9zc2libGUgZm9yIGFyY2ggY29kZSB0byByZW1v
dmUgdW5uZWNlc3NhcnkgY2FsbGVycyBvZg0KICAgIG9mX3BsYXRmb3JtX3BvcHVsYXRlIHdpdGgg
ZGVmYXVsdCBtYXRjaCB0YWJsZS4NCg0KPiANCj4gT3JpZ2luYWxseSBkZXZpY2VzIGFyZSByZWdp
c3RlcmVkIGluIGFyY2hfaW5pdGNhbGwuIE5vdyBpdCB3aWxsIGJlIGEgYml0IGxhdGVyIGluDQo+
IGFyY2hfaW5pdGNhbGxfc3luYyBhbmQgdGhpcyBtYXkgY2F1c2UgYSBiaXQgcmlzayBpZiB0aGUg
Y29kZSB1bmRlciB0aGUNCj4gZGVmYXVsdF9wb3B1bGF0ZSB3YW50IHRvIGFjY2VzcyB0aGUgZGV2
aWNlIHNlcnZpY2UgcHJvdmlkZWQgYnkgZWFybHkgcHJvYmUuDQo+IA0KPiBQcm9iYWJseSBpdCdz
IG1vcmUgc2FmZSB0byBsZWF2ZSBhcyBpdCBpcyB1bmxlc3MgeW91IGNhbiBkb3VibGUgY29uZmly
bSB0aGVyZSdyZQ0KPiBubyBzdWNoIGNvZGUgZGVwZW5kcyBvbiBhY2Nlc3NpbmcgZWFybHkgcHJv
YmVkIGRldmljZXMgYXMgZm9sbG93cyBiZWZvcmUgd2UNCj4gY2FuIG1ha2UgdGhlIGNoYW5nZS4N
Cg0KVGhpcyBoYXMgYmVlbiBib290IHRlc3RlZCBvbiA2US1TREIvNlVMLUVWSy82U0wtRVZLIGJv
YXJkLg0KRm9yIGkuTVgsIEkgb25seSBzZWUgcGluY3RybCBkcml2ZXIgdXNlIGFyY2hfaW5pdGNh
bGwgZnJvbSB0aGUgbGluaywNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVz
dC9pZGVudC9hcmNoX2luaXRjYWxsDQoNCkZyb20gbXkgYm9vdCB0ZXN0LCB0aGUgcGluY3RybCBk
cml2ZXIgcHJvYmUgd2lsbCBiZSBkZWxheWVkIGEgYml0LCBidXQgSSBkbw0Kbm90IHNlZSBpc3N1
ZXMuDQoNClRoZSBjb21tb24gY29kZSBpcyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIG9uZSB0
aGluZyBuZWVkIHRvIGNvbnNpZGVyDQppcyB0aGUgb2ZfaW9tbXVfaW5pdCBhbmQgc3dpb3RsYl9s
YXRlX2luaXQgb24gYWFyY2g2NC4gTXkgcGF0Y2gNCmlzIG9ubHkgZm9yIGkuTVg2LzcsIHNvIEkg
dGhpbmsgdGhlcmUgaXMgbm8gc3VjaCBpc3N1ZS4NCmNvbW1pdCA0NGE3MTg1YzJhZTYzODNjODhm
ZjViMWVmMmUyOTY5ZjM1ZDdiOGI3DQpBdXRob3I6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndh
bmdAaHVhd2VpLmNvbT4NCkRhdGU6ICAgV2VkIEp1biAxIDE0OjUyOjU0IDIwMTYgKzA4MDANCg0K
ICAgIG9mL3BsYXRmb3JtOiBBZGQgY29tbW9uIG1ldGhvZCB0byBwb3B1bGF0ZSBkZWZhdWx0IGJ1
cw0KDQogICAgVGhlIGFyY2ggY29kZSBjYWxscyBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIHdpdGgg
ZGVmYXVsdCBtYXRjaCB0YWJsZQ0KICAgIHdoZW4gaXQgd2FudHMgdG8gcG9wdWxhdGUgZGVmYXVs
dCBidXMuDQoNCiAgICBUaGlzIHBhdGNoIGludHJvZHVjZSBhIG5ldyBvZl9wbGF0Zm9ybV9kZWZh
dWx0X3BvcHVsYXRlX2luaXQoKSBhbmQgbWFrZSBpdA0KICAgIGFyY2hfaW5pdGNhbGxfc3luYyhp
dCBzaG91bGQgYmUgbGF0ZXIgdGhhbiBzb21lIGlvbW11IGNvbmZpZ3JhdGlvbiwgZWcsDQogICAg
b2ZfaW9tbXVfaW5pdCgpIGFuZCBzd2lvdGxiX2xhdGVfaW5pdCBpbiBhcm02NCksIHRoZW4gd2Ug
Y2FuIGZpbmlzaCBhYm92ZQ0KICAgIGpvYiBpbiBjb21tb24gbWV0aG9kLg0KDQogICAgSW4gb3Jk
ZXIgdG8gYXZvaWQgdGhlIGRlZmF1bHQgYnVzIGJlaW5nIHBvcHVsYXRlZCB0d2ljZSwgc2ltcGx5
IGNoZWNraW5nDQogICAgdGhlIGZsYWcgb2YgYnVzIG5vZGUgd2hldGhlciBoYXMgYmUgc2V0IE9G
X1BPUFVMQVRFRF9CVVMgb3Igbm90Lg0KDQogICAgQWZ0ZXIgdGhhdCwgd2UgY2FuIHNhZmVseSBy
ZW1vdmUgdGhlIGNhbGxlciBpbiBhcmNoIGNvZGUuDQoNCiAgICBCdHcsIGFkZCBkZWJ1ZyBwcmlu
dCBpbiBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpLCBhbmQgdXNlIF9fZnVuY19fIHRvDQogICAgcHJp
bnQgZnVuY3Rpb24ncyBuYW1lIG9mIG9mX3BsYXRmb3JtX2J1c19jcmVhdGUoKS4NCg0KDQpUaGFu
a3MsDQpQZW5nLg0KDQo+IA0KPiA+ICAJaW14X2FuYXRvcF9pbml0KCk7DQo+ID4gIAljcHVfaXNf
aW14NnEoKSA/ICBpbXg2cV9wbV9pbml0KCkgOiBpbXg2ZGxfcG1faW5pdCgpOw0KPiA+ICAJaW14
NnFfMTU4OF9pbml0KCk7DQo+IA0KPiBSZWdhcmRzDQo+IERvbmcgQWlzaGVuZw0KPiANCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2c2wuYw0KPiA+IGIvYXJjaC9h
cm0vbWFjaC1pbXgvbWFjaC1pbXg2c2wuYyBpbmRleCA5OWJlNDIyNTI5N2EuLjk3NDNiZGJiNjhm
YQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14L21hY2gtaW14NnNsLmMN
Cj4gPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDZzbC5jDQo+ID4gQEAgLTU2LDgg
KzU2LDYgQEAgc3RhdGljIHZvaWQgX19pbml0IGlteDZzbF9pbml0X21hY2hpbmUodm9pZCkNCj4g
PiAgCWlmIChwYXJlbnQgPT0gTlVMTCkNCj4gPiAgCQlwcl93YXJuKCJmYWlsZWQgdG8gaW5pdGlh
bGl6ZSBzb2MgZGV2aWNlXG4iKTsNCj4gPg0KPiA+IC0Jb2ZfcGxhdGZvcm1fZGVmYXVsdF9wb3B1
bGF0ZShOVUxMLCBOVUxMLCBwYXJlbnQpOw0KPiA+IC0NCj4gPiAgCWlmIChjcHVfaXNfaW14NnNs
KCkpDQo+ID4gIAkJaW14NnNsX2ZlY19pbml0KCk7DQo+ID4gIAlpbXhfYW5hdG9wX2luaXQoKTsN
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2c3guYw0KPiA+IGIv
YXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2c3guYyBpbmRleCA3ZjUyZDliMWU4YTQuLjE5Yjlm
MmRkMzA5ZQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14L21hY2gtaW14
NnN4LmMNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDZzeC5jDQo+ID4gQEAg
LTcyLDggKzcyLDYgQEAgc3RhdGljIHZvaWQgX19pbml0IGlteDZzeF9pbml0X21hY2hpbmUodm9p
ZCkNCj4gPiAgCWlmIChwYXJlbnQgPT0gTlVMTCkNCj4gPiAgCQlwcl93YXJuKCJmYWlsZWQgdG8g
aW5pdGlhbGl6ZSBzb2MgZGV2aWNlXG4iKTsNCj4gPg0KPiA+IC0Jb2ZfcGxhdGZvcm1fZGVmYXVs
dF9wb3B1bGF0ZShOVUxMLCBOVUxMLCBwYXJlbnQpOw0KPiA+IC0NCj4gPiAgCWlteDZzeF9lbmV0
X2luaXQoKTsNCj4gPiAgCWlteF9hbmF0b3BfaW5pdCgpOw0KPiA+ICAJaW14NnN4X3BtX2luaXQo
KTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2dWwuYw0KPiA+
IGIvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg2dWwuYyBpbmRleCA2Y2I4YTIyYjYxN2QuLmM1
N2I5ZGY3OTFiMQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14L21hY2gt
aW14NnVsLmMNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDZ1bC5jDQo+ID4g
QEAgLTY1LDcgKzY1LDYgQEAgc3RhdGljIHZvaWQgX19pbml0IGlteDZ1bF9pbml0X21hY2hpbmUo
dm9pZCkNCj4gPiAgCWlmIChwYXJlbnQgPT0gTlVMTCkNCj4gPiAgCQlwcl93YXJuKCJmYWlsZWQg
dG8gaW5pdGlhbGl6ZSBzb2MgZGV2aWNlXG4iKTsNCj4gPg0KPiA+IC0Jb2ZfcGxhdGZvcm1fZGVm
YXVsdF9wb3B1bGF0ZShOVUxMLCBOVUxMLCBwYXJlbnQpOw0KPiA+ICAJaW14NnVsX2VuZXRfaW5p
dCgpOw0KPiA+ICAJaW14X2FuYXRvcF9pbml0KCk7DQo+ID4gIAlpbXg2dWxfcG1faW5pdCgpOw0K
PiA+IC0tDQo+ID4gMi4xNi40DQoNCg==
