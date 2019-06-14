Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9022168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EyuS/ynD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfFNNkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:40:07 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:4262
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728033AbfFNNkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jIk0Lp9x2Q9How3PqWJkOTCigNCQFn3MBJEQQGrQbY=;
 b=EyuS/ynDBBae3avflUifCUpxAl33XyaGbshsh1B8HGF6N6vk8iRwOx/ZcPDX6W9os/FongfypWbD4vidLe5qdsBca9JLKz4nblcq/aIJl6Ns5NwRc6JNF6edXnAdLlUTyNX2Dm4bIgdG/OVwB3xglvHFiIdbT8LQZbLCuE153oY=
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.123.141) by
 VI1PR04MB6286.eurprd04.prod.outlook.com (20.179.27.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 13:40:00 +0000
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7]) by VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7%7]) with mapi id 15.20.1965.018; Fri, 14 Jun 2019
 13:40:00 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [EXT] Re: [PATCH 1/2] dt-bindings: display: panel: Add support
 for Raydium RM67191 panel
Thread-Topic: [EXT] Re: [PATCH 1/2] dt-bindings: display: panel: Add support
 for Raydium RM67191 panel
Thread-Index: AQHVIqdz2BzR314q5U6h7v5gaZm/aKabHM8AgAALM4A=
Date:   Fri, 14 Jun 2019 13:40:00 +0000
Message-ID: <1560519599.9328.40.camel@nxp.com>
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com>
         <1560513063-24995-2-git-send-email-robert.chiras@nxp.com>
         <CAOMZO5AMBr0TZip_PRBRPkMZ-d-kVeEOB4-rMTtcfcYtjLrLqw@mail.gmail.com>
In-Reply-To: <CAOMZO5AMBr0TZip_PRBRPkMZ-d-kVeEOB4-rMTtcfcYtjLrLqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d17519c-3b73-4165-3a24-08d6f0cdcc49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6286;
x-ms-traffictypediagnostic: VI1PR04MB6286:
x-microsoft-antispam-prvs: <VI1PR04MB628634B0AE5F9B4E5D4965C5E3EE0@VI1PR04MB6286.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(6916009)(11346002)(476003)(2351001)(2616005)(446003)(6486002)(44832011)(486006)(73956011)(1730700003)(5640700003)(86362001)(81166006)(6436002)(68736007)(229853002)(8676002)(1411001)(81156014)(4326008)(76116006)(7416002)(71200400001)(14444005)(25786009)(256004)(6512007)(53936002)(6246003)(71190400001)(102836004)(26005)(5660300002)(66476007)(66446008)(64756008)(66556008)(3846002)(53546011)(76176011)(6506007)(66946007)(2501003)(50226002)(8936002)(1361003)(54906003)(316002)(186003)(99286004)(36756003)(103116003)(7736002)(305945005)(66066001)(6116002)(2906002)(14454004)(478600001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6286;H:VI1PR04MB5967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hOkP248igM3vFEB7NrCZSHC+ftLXPLeTBoKn/FLgtt0tGRH4EJkA/X6kRciXsvK2evRgC6QR+KMqjM3bD8SWPXLhDzOX9GCf9slqSnWIO6YrgSTNp2BHly61crUGL1wpPSG7Dxr4LUq8Q+gyso3JKXuT6fCM/G6izMy/mJdjM2TWi59bUW3t1SoVmNBX9HygQu0Px0Cgz1rj5J5+U0bQ711dTZ10XzYBjEFZtxFHIaUF5+f77h5owu3UEvCKspBwTg8kxxmmfG1DearHrxRNIBM98VUXXXrrRIu1yuJyAr0AhnO2MI3EUg0zNhBvSs2GkMTBC26pZtdsM0Yp+FJ2GLunZCUCaSAgYYeNVQ0Pflf/fyRpuESh+z3PIpEc5ZltYGV8UpZ9Ryxao4A14ufGX7X1gKr+7ishsXuvjhwgi1U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A18DBB5F78197446B9957E0EF041D354@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d17519c-3b73-4165-3a24-08d6f0cdcc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 13:40:00.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: robert.chiras@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIFZpLCAyMDE5LTA2LTE0IGF0IDA5OjU5IC0wMzAwLCBGYWJpbyBFc3Rl
dmFtIHdyb3RlOg0KPiBPbiBGcmksIEp1biAxNCwgMjAxOSBhdCA4OjUzIEFNIFJvYmVydCBDaGly
YXMgPHJvYmVydC5jaGlyYXNAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4gQWRk
IGR0LWJpbmRpbmdzIGRvY3VtZW50YXRpb24gZm9yIFJheWRpdW0gUk02NzE5MSBEU0kgcGFuZWwu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0IENoaXJhcyA8cm9iZXJ0LmNoaXJhc0Bu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+IMKgLi4uL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvcmF5ZGl1
bSxybTY3MTkxLnR4dMKgwqDCoMKgwqB8IDQyDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3Bh
bmVsL3JheWRpdW0scm02NzE5MS50eHQNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9yYXlkaXVtLHJtNjcx
OTEudA0KPiA+IHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9wYW5lbC9yYXlkaXVtLHJtNjcxOTEudA0KPiA+IHh0DQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi41YTYyNjhkDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKw0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFu
ZWwvcmF5ZGl1bSxybTY3MTkxLnQNCj4gPiB4dA0KPiA+IEBAIC0wLDAgKzEsNDIgQEANCj4gPiAr
UmF5ZGl1bSBSTTY3MTcxIE9MRUQgTENEIHBhbmVsIHdpdGggTUlQSS1EU0kgcHJvdG9jb2wNCj4g
PiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZTrCoMKgwqDC
oMKgwqDCoMKgwqDCoCJyYXlkaXVtLHJtNjcxOTEiDQo+ID4gKy0gcmVnOsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB2aXJ0dWFsIGNoYW5uZWwgZm9yIE1JUEktRFNJIHByb3RvY29s
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtdXN0
IGJlIDwwPg0KPiA+ICstIGRzaS1sYW5lczrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbnVtYmVyIG9m
IERTSSBsYW5lcyB0byBiZSB1c2VkDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBtdXN0IGJlIDwzPiBvciA8ND4NCj4gPiArLSBwb3J0OsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW5wdXQgcG9ydCBub2RlIHdpdGggZW5kcG9pbnQgZGVm
aW5pdGlvbiBhcw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGVmaW5lZCBpbg0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9n
cmFwaC50eHQ7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB0aGUgaW5wdXQgcG9ydCBzaG91bGQgYmUgY29ubmVjdGVkIHRvIGENCj4gPiBNSVBJLURT
SSBkZXZpY2UNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRyaXZlcg0KPiA+ICsNCj4gPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiArLSByZXNl
dC1ncGlvOsKgwqDCoMKgwqDCoMKgwqDCoMKgYSBHUElPIHNwZWMgZm9yIHRoZSBSU1RfQiBHUElP
IHBpbg0KPiByZXNldC1ncGlvcyAod2l0aCB0aGUgcyBpbiB0aGUgZW5kKSBpcyB0aGUgcmVjb21t
ZW5kYXRpb24uDQo+IA0KPiA+IA0KPiA+ICstIGRpc3BsYXktdGltaW5nczrCoMKgwqDCoMKgdGlt
aW5ncyBmb3IgdGhlIGNvbm5lY3RlZCBwYW5lbCBhY2NvcmRpbmcNCj4gPiB0byBbMV0NCj4gVGhp
cyBpcyBub3QgbmVlZGVkLg0KV2VsbCwgSSBrbm93IHRoYXQgdGhlIHBhbmVsIHRpbWluZ3MgYXJl
IGFscmVhZHkgaGFyZC1jb2RlZCBpbnRvIHRoZQ0KZHJpdmVyLCBidXQgb24gODUwRCwgd2UgaGF2
ZSB0d28gZGlzcGxheSBjb250cm9sbGVyczogZUxDRERJRiBhbmQgRENTUy4NCldoaWxlIGVMQ0RJ
RiB3b3JrcyBqdXN0IGZpbmUgd2l0aCB0aGUgZGlzcGxheS10aW1pbmdzIHJlY2VpdmVkIChhbmQN
CnVuZG9jdW1lbnRlZCkgZnJvbSBwYW5lbCB2ZW5kb3IsIHdpdGggRENTUyB3ZSBoYWQgc29tZSBp
c3N1ZXMgYW5kIHdlDQpoYWQgdG8gdHdlYWsgdGhlIGRpc3BsYXktdGltaW5ncy4gVGhpcyBpcyB3
aHkgSSBhZGRlZCB0aGlzIHByb3BlcnR5LA0KZm9yIGEgc3BlY2lhbCBjYXNlIHdoZXJlIHdlIGhh
dmUgdG8gdXNlIGRpZmZlcmVudCB0aW1pbmdzIHdpdGhvdXQNCmNoYW5naW5nIHRoZSBkcml2ZXIg
KGp1c3QgYSBkaWZmZXJlbnQgZHRiIGZpbGUpLiBEbyB5b3UgdGhpbmsgdGhpcyBpcyBhDQpiYWQg
cHJhY3RpY2U/IElmIHllcywgdGhlbiB3aGF0IG1lY2hhbmlzbSBvZiBkb2luZyB0aGF0IGRvIHlv
dQ0KcmVjb21tZW5kPw0KPiANCj4gPiANCj4gPiArLSB2aWRlby1tb2RlOsKgwqDCoMKgwqDCoMKg
wqDCoMKgMCAtIGJ1cnN0LW1vZGUNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoDEgLSBub24tYnVyc3Qgd2l0aCBzeW5jIGV2ZW50DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAyIC0gbm9uLWJ1cnN0IHdp
dGggc3luYyBwdWxzZQ0KPiA+ICsNCj4gPiArWzFdOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9kaXNwbGF5LXRpbWluZy50eHQNCj4gVGhpcyBwYXRoIGRvZXMgbm90
IGV4aXN0Lg0KUmlnaHQuIFdpbGwgdXBkYXRlIHRoZSBwYXRoLg0KPiANCj4gQWxzbywgY291bGQg
eW91IHRyeSB0byBhbGlnbiB0aGVzZSBiaW5kaW5ncyB3aXRoIHRoZSBvbmUgZnJvbQ0KPiByYXlk
aXVtLHJtNjgyMDA/DQo+IA0KPiBUaGVyZSBhcmUgcG93ZXItc3VwcGx5IGFuZCBiYWNrbGlnaHQg
b3B0aW9uYWwgcHJvcGVydGllcyB0aGVyZSwgd2hpY2gNCj4gc2VlbSB1c2VmdWwuDQpUaGlzIHBh
bmVsIGlzIE9MRUQsIHdoaWxlIHRoZSBybTY4MjAwIGlzIExDRCAoZnJvbSB3aGF0IEkndmUgbm90
aWNlZCkuDQpNZWFuaW5nIHRoaXMgcGFuZWwgYmFja2xpZ3RoIGlzIGFsc28gY29udHJvbGxlZCBi
eSB0aGUgRFNJIGNvbnRyb2xsZXIsDQpub3QgYnkgYSBzZXBhcmF0ZSBiYWNrbGlnaHQgTEVEIGRy
aXZlci4NCkkgd2lsbCBjb25zaWRlciwgaW5zdGVhZCwgYWRkaW5nIHN1cHBvcnQgZm9yIGEgcG93
ZXItc3VwcGx5IChpZg0KcG9zc2libGUpLg0KPiANCj4gPiANCj4gPiArDQo+ID4gK0V4YW1wbGU6
DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHBhbmVsQDAgew0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInJheWRpdW0scm02NzE5MSI7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwwPjsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJsX21pcGlfZHNpXzBfMV9lbj47
DQo+IFlvdSBzaG91bGQgYWxzbyBwYXNzIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7IGlmIHlv
dSB1c2UgcGluY3RybC0wLg0KVGhhbmtzLiBXaWxsIGRvIHRoYXQNCj4gDQo+ID4gDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlc2V0LWdwaW8gPSA8JmdwaW8xIDcgR1BJT19B
Q1RJVkVfSElHSD47DQo+IFNob3VsZCBiZSBhY3RpdmUgbG93Lg0KQnV0LCB0aGUgR1BJTyBpcyBh
Y3RpdmUgaGlnaC4=
