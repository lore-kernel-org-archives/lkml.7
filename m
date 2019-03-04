Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F79C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D669320818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cbbe4j0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCDCrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:47:55 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:60613
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfCDCry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqCSHNhdMF2x71Mbaopfc4wbyinKr+JMtBfvxshZ80I=;
 b=Cbbe4j0K+Bpwbz9HL+Xwrf9ws+njPbsJg1EVs+TisxuQtzJJdi/abmt0LmZuajTBKvsiaFhlEJmbZk0P1NJmAeublZ4fkC5J1j1/uGNVRPREJl0aL58wZGgOrO6QL9cikk95qxWB5YtZOo7ycFzIfgwQ+JM1rnvKYwbyogDeSr8=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB1581.eurprd04.prod.outlook.com (10.164.84.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 02:47:49 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::c9ed:484:795a:6f4f%4]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 02:47:49 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Subject: RE: [PATCH] arm64: dts: ls1088a: add one more thermal zone node
Thread-Topic: [PATCH] arm64: dts: ls1088a: add one more thermal zone node
Thread-Index: AQHUzLcsX0H4/jtIiECZ5EbSvyRnV6X2zpOAgAQBLWA=
Date:   Mon, 4 Mar 2019 02:47:49 +0000
Message-ID: <VI1PR04MB4333637E16596E72E3F340EFF3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190225030049.20401-1-andy.tang@nxp.com>
 <20190301133805.GQ26041@dragon>
In-Reply-To: <20190301133805.GQ26041@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 427e4213-3a20-4346-e853-08d6a04bca46
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1581;
x-ms-traffictypediagnostic: VI1PR04MB1581:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUIxNTgxOzIzOlBzd3M1akRrZmU3QnNoY2JUV1Q0UUMwMjd2?=
 =?gb2312?B?NGJwYUxmZ0lrUmdhcDVCUDZrSEZkY3hzeXFrdXlRdFZWdWJSTW9iVnRXYUNq?=
 =?gb2312?B?RzU5ZGVZZy9hMXVNUzMrbGNKN0ttOHFoN1dtZUpNSFh3UG9tSllXQjVqdzdV?=
 =?gb2312?B?VWV5YVhWbi9KWndLQkFuOWJ6b2hRaEFJZVhyRGRIQXEwMWkrSDllQks1Zmpx?=
 =?gb2312?B?SUErUGg0Q1dxYStHS3AyMEhDRElzVzVzTXRGQWVNa1laMHAyb3RvM3ZxQ0FX?=
 =?gb2312?B?ckxUcEFsQkpERlprKzNuOS9CVWhFMGZzMm1rbit2bU1KZXphZ1VscEczZk5E?=
 =?gb2312?B?TC9VckRSdk5oaFJRSnhhdVFMUGlENmtjR3ZnWW03T2FuN2ZGWnZKZXBHdjNG?=
 =?gb2312?B?akpsYzNCWXJBaXNKSDZnRWhkMVlBL2JaR1NvQ2dZZ2NCMExQMDBKMUl0MGRJ?=
 =?gb2312?B?QmZiaE5NUVR6cGs1OXdPYlNpRzhnKzRzRmEySjZUM1VvUWFtWjVQYmt0a2RL?=
 =?gb2312?B?ak1XN0hBVXZBNGh6L0ROVlJyM0xYOTNNbG4zbmZPbE9lWGFSZHlYS1NpYjAx?=
 =?gb2312?B?Z1FYUWJVTThNTXd0d1FTL3NUNi9QRDdla2VjY0UydkxpTmQ3S21kOE41RG10?=
 =?gb2312?B?d0FjN2w4eTRieDFBWjY0QnFlSzRBeGJQNkJGa2g2M21OUnQ0OU43U1JXa2R4?=
 =?gb2312?B?bWVEdnVtQXhuZCs3MVU3M0c0T3lMWUdSUTc4eDd1MEhqTlVZTkQ5R29Wc1hM?=
 =?gb2312?B?ZHZuU1grYkpyUUdQSkpiNW1XdnlTbnJEYnU1bGdVc0o2VGp5WFFyZ0xkMWt4?=
 =?gb2312?B?MER0WTIyUG5nL1M1VkdlbWN1aDhjbUJGVjV4MkQwZk9LT0V6b2ZoZTZlb1NL?=
 =?gb2312?B?UGVIWWx6RlNYWFhsOWtlYWxVMHF0NjQ1SGRMTFRQZTlZL3JBU3FlWjhxV21G?=
 =?gb2312?B?cXdSNVlOejNOcDNLNUZYb0IycWloeTZZSlJJcEk3Um90V2o5NjNTdkRjbldj?=
 =?gb2312?B?azNJWkd3bmxoTHMzbUhBcldhVmpWMGdTOWJLYStGQ1dOOU9mdHJoTzdCTy9u?=
 =?gb2312?B?UmxvalFKRzF1ejFPV3VvbVRaUFBucis5ekxYb1RVT3VoZDhiaWFZL2FvR3Rk?=
 =?gb2312?B?WXdXeXZCT0xlMXBKR3p2YWpraHFDTWZuQ09Db21pbGVCK0xEL2lzRlRCVUZV?=
 =?gb2312?B?Sldha3JqQVZmbVNxclFjaXhPbnhORlFWRmZRZ3VnN2RyZXo5RWY3cGlJN2ZB?=
 =?gb2312?B?V3JBN1RaSlZGZGhGN1AyeFIvcWdCT1FjQ0hadDg2REpwRGloK2hDYW54Y0ov?=
 =?gb2312?B?b0V2STQwNzgxdmxab0lwSDVEZzFYQ3FJV0w3b2l0QVd1bitzWC95ZW0xV0tF?=
 =?gb2312?B?cXE3ekhVWDNwY0RxVXdPNE9sOEdxT040K3BRTmwvdXQ2YnQyTjlxUjhnQmdG?=
 =?gb2312?B?YXdPamNINlAyc2VJeXZ1RUJBKytRU1JMcEZPLzRLMGJzRUdRdkJLOGVtMXlx?=
 =?gb2312?B?SjBLRWxYZDlPTmlqM0xCNmdjYXB2dThIOXFhSmh1VXdJYXc0T2lHZm41UFY0?=
 =?gb2312?B?aXZtVG44S25TWVYyQUZxUWxGczVXL0d3YzJuazBKRTdtSklEN2NpMlhmQmpu?=
 =?gb2312?B?ek9EaHMwN3A4KzFOazV5THRnZW53cDVBbnl2alVia0w1dXF1Y2E2ei83T0sy?=
 =?gb2312?B?OHB3WEgxeUhjSEhWeUMrTldjR0JmODZKRFk3Y0JZR2dCVTYxYmloNmlPc0l5?=
 =?gb2312?Q?8BSt7rt887qsw+33bios1PPSOeOLNfM4WADIY=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB15811AF58F92F6BE9B9CE50AF3710@VI1PR04MB1581.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(13464003)(68736007)(106356001)(4326008)(55016002)(86362001)(105586002)(6116002)(3846002)(25786009)(66066001)(33656002)(186003)(76176011)(7696005)(6506007)(53546011)(52536013)(229853002)(6916009)(102836004)(26005)(54906003)(5660300002)(6246003)(478600001)(74316002)(53936002)(9686003)(476003)(486006)(14454004)(44832011)(97736004)(8936002)(2906002)(305945005)(7416002)(81156014)(8676002)(14444005)(256004)(81166006)(6436002)(11346002)(71200400001)(446003)(99286004)(71190400001)(316002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1581;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: teXZrrELT8QUhBLVVvjfoR5JixDQ1HAk2j49ZOWc/BGU3XdLXiedC3lNHM0NjBy6IBeUAQAQZ5gj2Lu9pKCMOzIqZwAP5SVyDGCjGi7Vso79gjYScy8MCWq9zn/9UrLKrphzQZj6vR5PcLxfHVBrW+nQQhIGtHtbjyoWE2ronMDKqH0htj7e5PfWcUNX6m2undip2sPMKV9+UCA1T/KODp7a8aHZfr8rbH9WvZifleSdMSKp40gKsyu8n4MbI5Q6a0CmdYOL1IMRN9beMxW7Q+qc24n+lf3sx1+vRr86ld3+HLapEyBc8YOzCOsrq/rooGW0ZWcVfi7wvZmWbjQE4K7B7voJAEod7pDbG0cc58f6y0ZOq+TZxsTI2qy7FD+m7jh914joJm6bc1jLysa9Ru5EF4YjO2JD27ND3BATYow=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e4213-3a20-4346-e853-08d6a04bca46
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 02:47:49.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOoz1MIxyNUgMjE6MzgNCj4gVG86IEFuZHkg
VGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsNCj4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgcnVpLnpoYW5nQGludGVsLmNvbTsgZWR1
YmV6dmFsQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhcm02NDogZHRzOiBsczEw
ODhhOiBhZGQgb25lIG1vcmUgdGhlcm1hbCB6b25lIG5vZGUNCj4gDQo+IE9uIE1vbiwgRmViIDI1
LCAyMDE5IGF0IDExOjAwOjQ5QU0gKzA4MDAsIFl1YW50aWFuIFRhbmcgd3JvdGU6DQo+ID4gTHMx
MDg4YSBoYXMgMiB0aGVybWFsIHNlbnNvcnMuIFRoaXMgcGF0Y2ggYWRkcyB0aGUgc2Vjb25kIG5v
ZGUgdG8gZHRzDQo+ID4gdG8gZW5hYmxlIGl0Lg0KPiANCj4gQ2FuIHlvdSBlbGFib3JhdGUgb24g
dGhlc2UgMiB0aGVybWFsIHNlbnNvcnMvem9uZXMsIGNjdSBhbmQgcGx0Pw0KPiANCk9LLCB0aGFu
a3MuDQoNCkJSLA0KQW5keSAgDQoNCj4gU2hhd24NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZdWFudGlhbiBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEuZHRzaSB8ICAgNDMNCj4gKysrKysr
KysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwODhhLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1sczEwODhhLmR0c2kNCj4gPiBpbmRleCA2NjExMzdmLi45ZjUyYmM5IDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwODhh
LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDg4
YS5kdHNpDQo+ID4gQEAgLTEyOSwxOSArMTI5LDE5IEBADQo+ID4gIAl9Ow0KPiA+DQo+ID4gIAl0
aGVybWFsLXpvbmVzIHsNCj4gPiAtCQljcHVfdGhlcm1hbDogY3B1LXRoZXJtYWwgew0KPiA+ICsJ
CWNjdSB7DQo+ID4gIAkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDAwPjsNCj4gPiAgCQkJ
cG9sbGluZy1kZWxheSA9IDw1MDAwPjsNCj4gPiAgCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZ0bXUg
MD47DQo+ID4NCj4gPiAgCQkJdHJpcHMgew0KPiA+IC0JCQkJY3B1X2FsZXJ0OiBjcHUtYWxlcnQg
ew0KPiA+ICsJCQkJY2N1X2FsZXJ0OiBjY3UtYWxlcnQgew0KPiA+ICAJCQkJCXRlbXBlcmF0dXJl
ID0gPDg1MDAwPjsNCj4gPiAgCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiA+ICAJCQkJCXR5
cGUgPSAicGFzc2l2ZSI7DQo+ID4gIAkJCQl9Ow0KPiA+DQo+ID4gLQkJCQljcHVfY3JpdDogY3B1
LWNyaXQgew0KPiA+ICsJCQkJY2N1X2NyaXQ6IGNjdS1jcml0IHsNCj4gPiAgCQkJCQl0ZW1wZXJh
dHVyZSA9IDw5NTAwMD47DQo+ID4gIAkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gPiAgCQkJ
CQl0eXBlID0gImNyaXRpY2FsIjsNCj4gPiBAQCAtMTUwLDcgKzE1MCw0MiBAQA0KPiA+DQo+ID4g
IAkJCWNvb2xpbmctbWFwcyB7DQo+ID4gIAkJCQltYXAwIHsNCj4gPiAtCQkJCQl0cmlwID0gPCZj
cHVfYWxlcnQ+Ow0KPiA+ICsJCQkJCXRyaXAgPSA8JmNjdV9hbGVydD47DQo+ID4gKwkJCQkJY29v
bGluZy1kZXZpY2UgPQ0KPiA+ICsJCQkJCQk8JmNwdTAgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVS
TUFMX05PX0xJTUlUPiwNCj4gPiArCQkJCQkJPCZjcHUxIFRIRVJNQUxfTk9fTElNSVQNCj4gVEhF
Uk1BTF9OT19MSU1JVD4sDQo+ID4gKwkJCQkJCTwmY3B1MiBUSEVSTUFMX05PX0xJTUlUDQo+IFRI
RVJNQUxfTk9fTElNSVQ+LA0KPiA+ICsJCQkJCQk8JmNwdTMgVEhFUk1BTF9OT19MSU1JVA0KPiBU
SEVSTUFMX05PX0xJTUlUPiwNCj4gPiArCQkJCQkJPCZjcHU0IFRIRVJNQUxfTk9fTElNSVQNCj4g
VEhFUk1BTF9OT19MSU1JVD4sDQo+ID4gKwkJCQkJCTwmY3B1NSBUSEVSTUFMX05PX0xJTUlUDQo+
IFRIRVJNQUxfTk9fTElNSVQ+LA0KPiA+ICsJCQkJCQk8JmNwdTYgVEhFUk1BTF9OT19MSU1JVA0K
PiBUSEVSTUFMX05PX0xJTUlUPiwNCj4gPiArCQkJCQkJPCZjcHU3IFRIRVJNQUxfTk9fTElNSVQN
Cj4gVEhFUk1BTF9OT19MSU1JVD47DQo+ID4gKwkJCQl9Ow0KPiA+ICsJCQl9Ow0KPiA+ICsJCX07
DQo+ID4gKw0KPiA+ICsJCXBsdCB7DQo+ID4gKwkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwx
MDAwPjsNCj4gPiArCQkJcG9sbGluZy1kZWxheSA9IDw1MDAwPjsNCj4gPiArCQkJdGhlcm1hbC1z
ZW5zb3JzID0gPCZ0bXUgMT47DQo+ID4gKw0KPiA+ICsJCQl0cmlwcyB7DQo+ID4gKwkJCQlwbHRf
YWxlcnQ6IHBsdC1hbGVydCB7DQo+ID4gKwkJCQkJdGVtcGVyYXR1cmUgPSA8ODUwMDA+Ow0KPiA+
ICsJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ID4gKwkJCQkJdHlwZSA9ICJwYXNzaXZlIjsN
Cj4gPiArCQkJCX07DQo+ID4gKw0KPiA+ICsJCQkJcGx0X2NyaXQ6IHBsdC1jcml0IHsNCj4gPiAr
CQkJCQl0ZW1wZXJhdHVyZSA9IDw5NTAwMD47DQo+ID4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAw
PjsNCj4gPiArCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCj4gPiArCQkJCX07DQo+ID4gKwkJCX07
DQo+ID4gKw0KPiA+ICsJCQljb29saW5nLW1hcHMgew0KPiA+ICsJCQkJbWFwMCB7DQo+ID4gKwkJ
CQkJdHJpcCA9IDwmcGx0X2FsZXJ0PjsNCj4gPiAgCQkJCQljb29saW5nLWRldmljZSA9DQo+ID4g
IAkJCQkJCTwmY3B1MCBUSEVSTUFMX05PX0xJTUlUDQo+IFRIRVJNQUxfTk9fTElNSVQ+LA0KPiA+
ICAJCQkJCQk8JmNwdTEgVEhFUk1BTF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPiwNCj4g
PiAtLQ0KPiA+IDEuNy4xDQo+ID4NCg==
