Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E15C4649A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4870218BC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pXDl6Uz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfGEIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:45:56 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:47606
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfGEIpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCJRNFr+ZRQ2tZdH+teH8WJqIIDbvg3Gp0rEh+z/Lf8=;
 b=pXDl6Uz5Dmmj/9cqLLwDMwFXDpQM6DUSIcPBFclKJdE8Lv15twvC5Nv71pv6HcOvVaoY3Hjzw1nVvRx7TXufG9N25Z05MMPmku4GJHdiLCm2fQvHFJKhXjL5tS0ADgahsaXbAQft9PX+aSzOBfIw9U9drLBDRLV37vaa5M1Gqno=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3849.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Fri, 5 Jul 2019 08:45:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.019; Fri, 5 Jul 2019
 08:45:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Thread-Topic: [PATCH V3 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Thread-Index: AQHVMk5T8ePkVlGuXEKfzs7Ixfs7tqa6PluAgADs2ZCAAIApAIAAC+ug
Date:   Fri, 5 Jul 2019 08:45:49 +0000
Message-ID: <DB3PR0402MB391618C464533111AB8DAEDCF5F50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704094416.4757-1-Anson.Huang@nxp.com>
         <1562235363.6641.10.camel@pengutronix.de>
         <DB3PR0402MB39167B9A3CFAE6D8798B3CAEF5F50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <1562313748.4291.3.camel@pengutronix.de>
In-Reply-To: <1562313748.4291.3.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a66bfed7-d9b0-4e77-107d-08d701252e50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3849;
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-microsoft-antispam-prvs: <DB3PR0402MB3849D7A3F9A2A49BEE8EB2C6F5F50@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(189003)(199004)(25786009)(52536014)(305945005)(7696005)(11346002)(476003)(81156014)(5660300002)(4326008)(486006)(7736002)(99286004)(446003)(7416002)(64756008)(66476007)(66556008)(68736007)(73956011)(66446008)(66946007)(81166006)(76116006)(316002)(66066001)(110136005)(33656002)(14454004)(9686003)(86362001)(6246003)(2906002)(2201001)(55016002)(6116002)(3846002)(6436002)(8936002)(478600001)(53936002)(71200400001)(229853002)(8676002)(71190400001)(44832011)(2501003)(186003)(256004)(14444005)(102836004)(74316002)(76176011)(6506007)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3849;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4vlis5INfC+NWDWMM41DeoLyHaplpzIkcwRZdv7yKezIhHPfxzkwuLyGgxbRy0XiITAph96Y5u9UvKiYIKJWpEWLiVldA6Hi3d56wep8obFjniuWJJQ2mFWmsrk792cPdf+M7AN3qco83rtGN8o6p+UMgZQ/cuJdCKoE7AszNe3BY3cY+sv9RUfDL3YlIcsIVMua1O+ZZQqcslX0/uUxMmIqY2G6OsCpaM7+j3j21XXuSqWdcITLiNZ6lF7Mqm3DLzZTsmUI2ojf+nDE6jl42pWml6Yfj95L30+d6CZzM6SCtdHt0aiXXopeFoOyQZVANBj4U89GKZWswmm5TdAlwgxa1MIdzHb4OudweMhIgV92r6s+M5Ou1oCNWRqburRgJ0eDB5olYZLHYlC5YnS5c4e1Qm8zmtHx9vqMA1rMRLw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66bfed7-d9b0-4e77-107d-08d701252e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 08:45:49.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWxpcHANCg0KPiBPbiBGcmksIDIwMTktMDctMDUgYXQgMDA6MjYgKzAwMDAsIEFuc29u
IEh1YW5nIHdyb3RlOg0KPiA+IEhpLCBQaGlsaXBwDQo+ID4NCj4gPiA+IE9uIFRodSwgMjAxOS0w
Ny0wNCBhdCAxNzo0NCArMDgwMCwgQW5zb24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiA+ID4g
RnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+
IGkuTVg4TU0gY2FuIHJldXNlIGkuTVg4TVEncyByZXNldCBkcml2ZXIsIHVwZGF0ZSB0aGUgY29t
cGF0aWJsZQ0KPiA+ID4gPiBwcm9wZXJ0eSBhbmQgcmVsYXRlZCBpbmZvIHRvIHN1cHBvcnQgaS5N
WDhNTS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIFYyOg0K
PiA+ID4gPiAJLSBBZGQgc2VwYXJhdGUgbGluZSBmb3IgaS5NWDhNTSBpbiBjYXNlIGFueXRoaW5n
IGRpZmZlcmVudCBsYXRlcg0KPiA+ID4gPiBmb3INCj4gPiA+DQo+ID4gPiBpLk1YOE1NLg0KPiA+
ID4gPiAtLS0NCj4gPiA+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNl
dC9mc2wsaW14Ny1zcmMudHh0IHwgNg0KPiA+ID4gPiArKysrLS0NCj4gPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+
IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVzZXQvZnNsLGlteDctc3JjLnR4dA0KPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14Ny1zcmMudHh0DQo+ID4gPiA+IGluZGV4IDEzZTA5NTEu
LmMyNDg5ZTQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZXNldC9mc2wsaW14Ny1zcmMudHh0DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14Ny1zcmMudHh0DQo+ID4gPiA+IEBA
IC04LDYgKzgsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgLSBjb21wYXRpYmxl
Og0KPiA+ID4gPiAgCS0gRm9yIGkuTVg3IFNvQ3Mgc2hvdWxkIGJlICJmc2wsaW14N2Qtc3JjIiwg
InN5c2NvbiINCj4gPiA+ID4gIAktIEZvciBpLk1YOE1RIFNvQ3Mgc2hvdWxkIGJlICJmc2wsaW14
OG1xLXNyYyIsICJzeXNjb24iDQo+ID4gPiA+ICsJLSBGb3IgaS5NWDhNTSBTb0NzIHNob3VsZCBi
ZSAiZnNsLGlteDhtbS1zcmMiLCAiZnNsLGlteDhtcS1zcmMiLA0KPiA+ID4NCj4gPiA+ICJzeXNj
b24iDQo+ID4gPiA+ICAtIHJlZzogc2hvdWxkIGJlIHJlZ2lzdGVyIGJhc2UgYW5kIGxlbmd0aCBh
cyBkb2N1bWVudGVkIGluIHRoZQ0KPiA+ID4gPiAgICBkYXRhc2hlZXQNCj4gPiA+ID4gIC0gaW50
ZXJydXB0czogU2hvdWxkIGNvbnRhaW4gU1JDIGludGVycnVwdCBAQCAtNDYsNSArNDcsNiBAQCBF
eGFtcGxlOg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiAgRm9yIGxpc3Qgb2YgYWxsIHZhbGlk
IHJlc2V0IGluZGljZXMgc2VlDQo+ID4gPiA+IC08ZHQtYmluZGluZ3MvcmVzZXQvaW14Ny1yZXNl
dC5oPiBmb3IgaS5NWDcgYW5kDQo+ID4gPiA+IC08ZHQtYmluZGluZ3MvcmVzZXQvaW14OG1xLXJl
c2V0Lmg+IGZvciBpLk1YOE1RDQo+ID4gPiA+ICs8ZHQtYmluZGluZ3MvcmVzZXQvaW14Ny1yZXNl
dC5oPiBmb3IgaS5NWDcsDQo+ID4gPiA+ICs8ZHQtYmluZGluZ3MvcmVzZXQvaW14OG1xLXJlc2V0
Lmg+IGZvciBpLk1YOE1RIGFuZA0KPiA+ID4gPiArPGR0LWJpbmRpbmdzL3Jlc2V0L2lteDhtcS1y
ZXNldC5oPiBmb3IgaS5NWDhNTQ0KPiA+ID4NCj4gPiA+IFRoZSBsYXN0IGxpbmUgaXMgbWlzbGVh
ZGluZywgYXMgdGhhdCBmaWxlIGNvbnRhaW5zIHJlc2V0IGluZGljZXMNCj4gPiA+IHRoYXQgYXJl
IGludmFsaWQgZm9yIGkuTVg4TU0uDQo+ID4NCj4gPiBXaGF0IGlzIHlvdXIgc3VnZ2VzdGlvbiBh
Ym91dCB0aGlzIGxpbmU/DQo+IA0KPiBJIHdvdWxkIHByZWZlciB0byBhZGQgYW4gaW14OG1tLXJl
c2V0Lmggd2l0aCBvbmx5IHRoZSBleGlzdGluZyByZXNldCBiaXRzLA0KPiB1c2luZyB0aGUgSU1Y
OE1NX1JFU0VUXyBwcmVmaXguwqBUaGF0IHdvdWxkIG1ha2UgaXQgZWFzeSB0byBzcG90IGVycm9y
cyBpbg0KPiB0aGUgZHRzaSAoYW55dGhpbmcgc3RhcnRpbmcgd2l0aCBJTVg4TVFfIGlzIHBvdGVu
dGlhbGx5IHdyb25nKS4NCj4gDQo+ID4gSnVzdCBOT1QgY2hhbmdlIGl0Pw0KPiANCj4gVGhlIGNo
YW5nZSBpcyBnb29kIGluIHByaW5jaXBsZS4gSXQganVzdCBzaG91bGQgcG9pbnQgdG8gYW4gaW14
OG1tLSByZXNldC5oIHdpdGgNCj4gb25seSB0aGUgZXhpc3RpbmcgcmVzZXRzIG9uIGkuTVg4TU0s
IG9yIGlteDhtcS1yZXNldC5oIHNob3VsZCBiZSBtb2RpZmllZCB0bw0KPiBhY3R1YWxseSBtYWtl
IGNsZWFyIHdoaWNoIHJlc2V0cyBhcmUgdmFsaWQgb24gaS5NWDhNTS4NCj4gDQo+ID4gT3IgYWRk
aW5nIGEgbmV3IGZpbGXCoGlteDhtbS1yZXNldC5oIGJ1dCBzdGlsbCB1c2UgdGhlIElNWDhNUV9S
RVNFVF8gYXMNCj4gPiBwcmVmaXggPw0KPiANCj4gSSBkb24ndCB0aGluayB5b3Ugc2hvdWxkIHJl
ZGVmaW5lIHRoZSBzYW1lIG1hY3JvcyBpbiBpbXg4bW0tcmVzZXQuaC4gSW4gdGhpcw0KPiBjYXNl
IHVzaW5nIElNWDhNTV9SRVNFVF8gd291bGQgYmUgYmV0dGVyLg0KPiANCj4gPiBPciBrZWVwIHdo
YXQgSSBjaGFuZ2VkLCBidXQgYWRkaW5nIHNvbWUgY29tbWVudHMgaW4gdGhvc2UgbWFjcm9zIHRo
YXQNCj4gPiBpLk1YOE1NIGRvZXMgTk9UIHN1cHBvcnQ/DQo+IA0KPiBUaGF0IHdvdWxkIGJlIGFj
Y2VwdGFibGUgYXMgd2VsbC4NCg0KSSB3aWxsIGdvIHRoaXMgd2F5LCB0aGFua3MgZm9yIHN1Z2dl
c3Rpb24uDQoNCkFuc29uLg0KDQo+IA0KPiByZWdhcmRzDQo+IFBoaWxpcHANCg==
