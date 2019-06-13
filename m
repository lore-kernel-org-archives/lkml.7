Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22520C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F4620673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cde/w2Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392945AbfFMQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:42:58 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:40931
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730494AbfFMGrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvBbFKBXHONrnVYItC+/7DGk+khFnJxUBlWCKnPmSg8=;
 b=Cde/w2Q/TvAyC5cbd9DRBJyH7maB7u5Z5Ipc9NxmCyT5jKYVilFN7dm3oRhI4cxpL2GiXURpL3kY93bVf/mbXMicRWCZTmFl2riy8oaht5RJELX2JigjnWOOOSJ7e+aOdo0CjY0Rm/oMuETwcKz/6D6CIqRWIm6o1QyxGJ99Hds=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5440.eurprd04.prod.outlook.com (20.178.121.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 06:47:04 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0%6]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 06:47:04 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Topic: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Index: AQHU+/zGE8MPZcMnA0GP8h3OejDbYKZ1N2hwgAOwrbCAIIYIgA==
Date:   Thu, 13 Jun 2019 06:47:03 +0000
Message-ID: <VI1PR04MB43335E626999BA8F7A1811EAF3EF0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <1556261624-20504-1-git-send-email-vabhav.sharma@nxp.com>
 <AM6PR04MB4789787C4AB0613B1CF53DBCF3070@AM6PR04MB4789.eurprd04.prod.outlook.com>
 <VI1PR04MB4800AAC6A29E0F1001808CE8F3010@VI1PR04MB4800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4800AAC6A29E0F1001808CE8F3010@VI1PR04MB4800.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744f9d66-9d51-4803-403a-08d6efcaf1f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5440;
x-ms-traffictypediagnostic: VI1PR04MB5440:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB54405B7B28F3106208C35D61F3EF0@VI1PR04MB5440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:419;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(13464003)(189003)(199004)(66556008)(6306002)(102836004)(478600001)(476003)(53546011)(6436002)(74316002)(11346002)(446003)(52536014)(2906002)(305945005)(55016002)(68736007)(229853002)(5660300002)(8676002)(7696005)(66066001)(486006)(110136005)(44832011)(966005)(86362001)(6116002)(66946007)(3846002)(66476007)(73956011)(76116006)(6506007)(4326008)(76176011)(64756008)(66446008)(14444005)(256004)(8936002)(14454004)(81166006)(71200400001)(25786009)(316002)(9686003)(33656002)(186003)(6246003)(7736002)(71190400001)(99286004)(54906003)(26005)(81156014)(53936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5440;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /W6KR0fGzfoMgSih3T11zBonBoe5ZY2t9oUdDoBTQMmUD+UeEbCIUaxDplq0Z/AqSzb0Gi2+S3sVRq26qFM96uOghET85WpmBJLB2u/sQLwiF4haXyqG3pm3iaRvdfs3SIj7yJ/i8GXQwGK6EkSl+cCDGajnRyZUelQC+ckhLLQDQqJjBZoIEL68L9VcsjCsEPvJZFiMgrhK9p9SyQfmr8dKeuS1RhWgDnbFr0S2aT9VJblvG/r3eZ9JYwgxt6/kd/17JbVWDdWSqjEUICBtzLMGrS0R23VfE2LseFgkmELIxvKB0mkLDqPx7mvXlypyZzLidBNZKGqFvx58RNB5u+Q7FlHPc15jr48/J3OBNS6imDYhXyiMeLuKR8lxrRCXPgp370cSmRhmvJDstbVNghaUN2NQqUNsXl9C++J46N4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f9d66-9d51-4803-403a-08d6efcaf1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 06:47:03.9672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andy.tang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwgTXR1cnF1ZXR0ZSwNCg0KV2hvIHdpbGwgYXBwbHkgdGhpcyBwYXRjaD8gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDkxODQwNy8NCkFsbCB0aGUgY29tbWVu
dHMgYXJlIGFkZHJlc3NlZCBhbmQgZ290IGFja2VkIGJ5Og0KQWNrZWQtYnk6IFNjb3R0IFdvb2Qg
PG9zc0BidXNlcnJvci5uZXQ+DQpBY2tlZC1ieTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwu
b3JnPg0KQWNrZWQtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+DQoN
CkNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgaXQ/DQoNCkJSLA0KQW5keQ0KDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmFiaGF2IFNoYXJtYQ0KPiBTZW50OiAyMDE55bm0
NeaciDIz5pelIDIyOjA1DQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRA
a2VybmVsLm9yZw0KPiBDYzogbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNib3lkQGtlcm5lbC5v
cmc7IEFuZHkgVGFuZw0KPiA8YW5keS50YW5nQG54cC5jb20+OyBZb2dlc2ggTmFyYXlhbiBHYXVy
DQo+IDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2
NF0gY2xrOiBxb3JpcTogYWRkIHN1cHBvcnQgZm9yIGx4MjE2MGENCj4gDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBWYWJoYXYgU2hhcm1hDQo+ID4gU2VudDogVHVl
c2RheSwgTWF5IDIxLCAyMDE5IDExOjE0IEFNDQo+ID4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gc2JveWRAa2VybmVsLm9y
Zw0KPiA+IENjOiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgQW5keSBUYW5nIDxhbmR5LnRhbmdA
bnhwLmNvbT47IFlvZ2VzaA0KPiA+IE5hcmF5YW4gR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54
cC5jb20+DQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2NF0gY2xrOiBxb3JpcTogYWRkIHN1cHBv
cnQgZm9yIGx4MjE2MGENCj4gPg0KPiA+IEhlbGxvIFN0ZXBoZW4sDQo+ID4gSSBoYXZlIGluY29y
cG9yYXRlZCByZXZpZXcgY29tbWVudHMgZnJvbQ0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcGF0Y2gvMTA5MTcxNzEvDQo+IEhlbGxvIE1haW50YWluZXJzLA0KPiBBbGwgdGhlIGNv
bW1lbnRzIGFyZSBhZGRyZXNzZWQsIENhbiB5b3UgcGxlYXNlIHRha2UgdGhlIHBhdGNoPw0KPiBQ
bGVhc2Ugc2VlIHRoaXMgaXMgZXNzZW50aWFsIGZvciBuZXcgaGFyZHdhcmUgc3VwcG9ydC4NCj4g
DQo+IFJlZ2FyZHMsDQo+IFZhYmhhdg0KPiA+DQo+ID4gQSBnZW50bGUgcmVtaW5kZXIgdG8gYXBw
bHkgdGhlIHBhdGNoDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDkx
ODQwNy8uDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFZhYmhhdg0KPiA+DQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNo
YXJtYUBueHAuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBBcHJpbCAyNiwgMjAxOSAxMjoyNCBQ
TQ0KPiA+ID4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPiA+IENjOiBzYm95ZEBrZXJuZWwub3JnOyBtdHVycXVldHRlQGJheWxp
YnJlLmNvbTsgVmFiaGF2IFNoYXJtYQ0KPiA+ID4gPHZhYmhhdi5zaGFybWFAbnhwLmNvbT47IEFu
ZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+OyBZb2dlc2gNCj4gPiBOYXJheWFuDQo+ID4gPiBH
YXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2
NF0gY2xrOiBxb3JpcTogYWRkIHN1cHBvcnQgZm9yIGx4MjE2MGENCj4gPiA+DQo+ID4gPiBBZGQg
Y2xvY2tnZW4gc3VwcG9ydCBhbmQgY29uZmlndXJhdGlvbiBmb3IgTlhQIFNvQyBseDIxNjBhIHdp
dGgNCj4gPiA+IGNvbXBhdGlibGUgcHJvcGVydHkgYXMgImZzbCxseDIxNjBhLWNsb2NrZ2VuIi4N
Cj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUYW5nIFl1YW50aWFuIDxhbmR5LnRhbmdAbnhw
LmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdh
dXJAbnhwLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5z
aGFybWFAbnhwLmNvbT4NCj4gPiA+IEFja2VkLWJ5OiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3Iu
bmV0Pg0KPiA+ID4gQWNrZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4g
PiA+IEFja2VkLWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiA+
ID4gLS0tDQo+ID4gPiBDaGFuZ2VzIGZvciB2NDoNCj4gPiA+IC0gSW5jb3Jwb3JhdGVkIHJldmll
dyBjb21tZW50cyBmcm9tIFN0ZXBoZW4gQm95ZA0KPiA+ID4NCj4gPiA+IENoYW5nZXMgZm9yIHYz
Og0KPiA+ID4gLSBJbmNvcnBvcmF0ZWQgcmV2aWV3IGNvbW1lbnRzIG9mIFJhZmFlbCBKLiBXeXNv
Y2tpDQo+ID4gPiAtIFVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UNCj4gPiA+DQo+ID4gPiBDaGFuZ2Vz
IGZvciB2MjoNCj4gPiA+IC0gU3ViamVjdCBsaW5lIHVwZGF0ZWQNCj4gPiA+DQo+ID4gPiAgZHJp
dmVycy9jbGsvY2xrLXFvcmlxLmMgfCAxMiArKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9jbGstcW9yaXEuYyBiL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jIGluZGV4DQo+ID4gPiAz
ZDUxZDdjLi4xYTE1MjAxIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXFvcmlx
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jDQo+ID4gPiBAQCAtNTcwLDYg
KzU3MCwxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsb2NrZ2VuX2NoaXBpbmZvIGNoaXBpbmZv
W10gPQ0KPiB7DQo+ID4gPiAgCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElBTiwN
Cj4gPiA+ICAJfSwNCj4gPiA+ICAJew0KPiA+ID4gKwkJLmNvbXBhdCA9ICJmc2wsbHgyMTYwYS1j
bG9ja2dlbiIsDQo+ID4gPiArCQkuY211eF9ncm91cHMgPSB7DQo+ID4gPiArCQkJJmNsb2NrZ2Vu
Ml9jbXV4X2NnYTEyLCAmY2xvY2tnZW4yX2NtdXhfY2diDQo+ID4gPiArCQl9LA0KPiA+ID4gKwkJ
LmNtdXhfdG9fZ3JvdXAgPSB7DQo+ID4gPiArCQkJMCwgMCwgMCwgMCwgMSwgMSwgMSwgMSwgLTEN
Cj4gPiA+ICsJCX0sDQo+ID4gPiArCQkucGxsX21hc2sgPSAweDM3LA0KPiA+ID4gKwkJLmZsYWdz
ID0gQ0dfVkVSMyB8IENHX0xJVFRMRV9FTkRJQU4sDQo+ID4gPiArCX0sDQo+ID4gPiArCXsNCj4g
PiA+ICAJCS5jb21wYXQgPSAiZnNsLHAyMDQxLWNsb2NrZ2VuIiwNCj4gPiA+ICAJCS5ndXRzX2Nv
bXBhdCA9ICJmc2wscW9yaXEtZGV2aWNlLWNvbmZpZy0xLjAiLA0KPiA+ID4gIAkJLmluaXRfcGVy
aXBoID0gcDIwNDFfaW5pdF9wZXJpcGgsIEBAIC0xNDI3LDYgKzE0MzgsNyBAQA0KPiA+ID4gQ0xL
X09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMxMDQzYSwNCj4gPiA+ICJmc2wsbHMxMDQzYS1j
bG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+ID4gQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xv
Y2tnZW5fbHMxMDQ2YSwgImZzbCxsczEwNDZhLWNsb2NrZ2VuIiwNCj4gPiA+IGNsb2NrZ2VuX2lu
aXQpOyAgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHMxMDg4YSwNCj4gPiA+ICJmc2ws
bHMxMDg4YS0gY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiA+IENMS19PRl9ERUNMQVJF
KHFvcmlxX2Nsb2NrZ2VuX2xzMjA4MGEsDQo+ID4gPiAiZnNsLGxzMjA4MGEtY2xvY2tnZW4iLCBj
bG9ja2dlbl9pbml0KTsNCj4gPiA+ICtDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9seDIx
NjBhLCAiZnNsLGx4MjE2MGEtY2xvY2tnZW4iLA0KPiA+ID4gK2Nsb2NrZ2VuX2luaXQpOw0KPiA+
ID4gIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3AyMDQxLCAiZnNsLHAyMDQxLWNsb2Nr
Z2VuIiwNCj4gPiA+IGNsb2NrZ2VuX2luaXQpOyBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dl
bl9wMzA0MSwNCj4gPiA+ICJmc2wscDMwNDEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4g
PiA+IENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3A0MDgwLCAiZnNsLHA0MDgwLWNsb2Nr
Z2VuIiwNCj4gPiA+IGNsb2NrZ2VuX2luaXQpOw0KPiA+ID4gLS0NCj4gPiA+IDIuNy40DQoNCg==
