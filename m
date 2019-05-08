Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BAC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E94214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEfbEoDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEHCUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:20:36 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:7141
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbfEHCUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkGu+ZAj2f8A42LZtes4F3XRje7/QFYPujJaRohJHtc=;
 b=aEfbEoDO72RTzxodq2sfJ717gTxVmSJfIM08BBgo90pWIHEZKuTIf0eO6llpQgdoGTaIjiqBbEX8jyrTIWc65BHmazXe8WKP1vvAwCAv9J93kDk5SU8C2ul68syw7gi0r6IxP6EAVc+ltRryF9i0AUQn7mQdY7ZAzbSrADyzRwc=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2707.eurprd04.prod.outlook.com (10.175.39.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 8 May 2019 02:20:30 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51%9]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 02:20:30 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
Thread-Topic: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
Thread-Index: AQHU+/SBIFirjMEfrESTZvW0Hl61haZW+m4AgAhvTQCAAIVkAIAAnZJg
Date:   Wed, 8 May 2019 02:20:30 +0000
Message-ID: <AM5PR0402MB286549DC56A28B010CE711D6F1320@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190426055558.44544-1-ran.wang_1@nxp.com>
 <20190501235410.GA25492@bogus>
 <AM5PR0402MB286539A070BDEEDFC3304F0EF1310@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <CAL_Jsq+tmUCjZw7ybhKTGg0NNfc+JsOQ30vArfHzdw14XoWm5A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+tmUCjZw7ybhKTGg0NNfc+JsOQ30vArfHzdw14XoWm5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c646c35-1039-4651-a251-08d6d35bbe3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2707;
x-ms-traffictypediagnostic: AM5PR0402MB2707:
x-microsoft-antispam-prvs: <AM5PR0402MB2707620F4F12985109DF16EEF1320@AM5PR0402MB2707.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(71200400001)(8936002)(7736002)(305945005)(486006)(68736007)(102836004)(476003)(446003)(11346002)(81166006)(81156014)(8676002)(52536014)(66476007)(186003)(55016002)(66446008)(66946007)(229853002)(6916009)(76116006)(26005)(73956011)(66556008)(64756008)(14444005)(256004)(6436002)(66066001)(316002)(54906003)(9686003)(6246003)(53936002)(71190400001)(86362001)(74316002)(4326008)(33656002)(25786009)(3846002)(6116002)(7696005)(5660300002)(6506007)(53546011)(99286004)(478600001)(76176011)(2906002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2707;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RUgc7oUaOD01uyeURvkwMrKyBioa9MDGSsor94PyvFY+652UTchl1WjuzqAYl8sWkvLWViK5nz1IEcnf3IolhiB+eqHVjLdIMX8hja8VE1eWMrUHSBi1crt+DUCPaSb8sgnM7SXCvCDl3YcGp9tVoW/TcVbOog2KkOWp6mPLzyyaUyJnag4Pt9l6KUzlQC66TrD9fcETPGTE0eCNjFTEJ1YmwLc11L4sK/DAABREzNJzhvwLjxKlTkTBVfax0xENHvF7dW3FkSTa1tqVPgF0KVL0u8h0iIGF/L1tWD+vXx9nkkTlP9RrnY2ekaSsnu3QIgljSKbA6Ca6pJsJDkOiWWUE0Ijxkxwyl6Mv5NQ6E6nD+NMP0+696Lkc75bI8PBIxveskZDgdvJJmJ+aewQr8agch1SeW4Jdr9ayYNyEffk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c646c35-1039-4651-a251-08d6d35bbe3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 02:20:30.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiBXZWRuZXNkYXksIE1heSAwOCwgMjAxOSAwMDo0MCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+IA0KPiBPbiBUdWUsIE1heSA3LCAyMDE5IGF0IDM6NDggQU0gUmFuIFdhbmcgPHJh
bi53YW5nXzFAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBSb2IsDQo+ID4NCj4gPiBPbiBU
aHVyc2RheSwgTWF5IDAyLCAyMDE5IDA3OjU0IFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4NCj4g
PiA+IE9uIEZyaSwgQXByIDI2LCAyMDE5IGF0IDA1OjU0OjI2QU0gKzAwMDAsIFJhbiBXYW5nIHdy
b3RlOg0KPiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMgVVNCIGR0IG5vZGVzIGZvciBMUzEwMjhBLg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiA+ID4gICAtIFJl
bmFtZSBub2RlIGZyb20gdXNiM0AuLi4gdG8gdXNiQC4uLiB0byBtZWV0IERUU3BlYw0KPiA+ID4g
Pg0KPiA+ID4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRz
aSB8ICAgMjANCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGVzIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5k
dHNpDQo+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0
c2kNCj4gPiA+ID4gaW5kZXggOGRkMzUwMS4uMTg4Y2ZiOCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiA+ID4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQo+ID4g
PiA+IEBAIC0xNDQsNiArMTQ0LDI2IEBADQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgY2xv
Y2tzID0gPCZzeXNjbGs+Ow0KPiA+ID4gPiAgICAgICAgICAgICB9Ow0KPiA+ID4gPg0KPiA+ID4g
PiArICAgICAgICAgICB1c2IwOnVzYkAzMTAwMDAwIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgIF4gc3BhY2UgbmVlZGVkDQo+ID4NCj4gPiBZZXMsIHdpbGwgdXBkYXRlIHRoaXMgaW4gbmV4
dCB2ZXJzaW9uLg0KPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZT0g
InNucHMsZHdjMyI7DQo+ID4gPg0KPiA+ID4gTmVlZHMgYW4gU29DIHNwZWNpZmljIGNvbXBhdGli
bGUuDQo+ID4NCj4gPiBEbyB5b3UgbWVhbiBjaGFuZ2UgY29tcGF0aWJsZSB0byAic25wcyxkd2Mz
IiwgImZzbCxsczEwMjhhLWR3YzMiID8NCj4gDQo+IFdlbGwsIHRoYXQncyB0aGUgd3Jvbmcgb3Jk
ZXIsIGJ1dCB5ZXMuDQoNCk9LLCB3aWxsIHVwZGF0ZSB0aGlzLg0KIA0KPiA+IEFzIEkga25vdywg
c28gZmFyIHRoZXJlIGlzIG5vIFNvQyBzcGVjaWZpYyBwcm9ncmFtbWluZyBmb3IgdGhpcyBJUCwg
c28NCj4gPiBkbyB5b3UgdGhpbmsgaXQncyBzdGlsbCBuZWNlc3NhcnkgdG8gYWRkIGl0Pw0KPiAN
Cj4gWWVzLiBBbGwgdGhlIGJ1Z3MgYW5kIHF1aXJrcyBhcmUgZGlzY292ZXJlZCBhbHJlYWR5Pw0K
DQpZZXMsIHNvIGZhciBJIGRvbid0IHJlY2VpdmUgYW55IFNvQyBzcGVjaWZpYyBkZWZlY3QgcmVw
b3J0LCBJIHRoaW5rIGl0J3MgZmluZS4NCiBXaWxsIHdvcmsgb3V0IG5leHQgdmVyc2lvbiBwYXRj
aCwgdGhhbmtzIGZvciB5b3VyIHRpbWUuDQoNClJlZ2FyZHMsDQpSYW4NCg0K
