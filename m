Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3538C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F69521904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="a7tLNC/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfCVHpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:45:40 -0400
Received: from mail-eopbgr60131.outbound.protection.outlook.com ([40.107.6.131]:38021
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbfCVHpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7Vaay0emSeN3KjfxFebU51NHqOZMOvqPb1CbdwOeFk=;
 b=a7tLNC/2scepRw/UmOHuYL/vzBFedE/7Z9RTbiHsxo/8ZziHSDR9aYciKNE9A8XPQwmq0wCi0INX0C+QekjSdu4heAvASDvAIMeeqP/DMzUJ7C3p7D52drQNLrgcvxz0ibamnhKMa5LlIMlTdCfseXjnV2qoDS4i5GlKDoGXAF4=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1584.EURPRD10.PROD.OUTLOOK.COM (10.165.191.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 07:45:35 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 07:45:35 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Topic: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Thread-Index: AQHU1PaDftXKRmjpAUe9LFJjLfS9raYUlMMAgAG4fwD///7hgIABEGQA
Date:   Fri, 22 Mar 2019 07:45:35 +0000
Message-ID: <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
 <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
In-Reply-To: <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:7:28::17) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a59f0f95-ff0a-4cd3-0d80-08d6ae9a5e35
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1584;
x-ms-traffictypediagnostic: VI1PR10MB1584:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-microsoft-antispam-prvs: <VI1PR10MB1584BD142F6DE3FD5FC9A65C8A430@VI1PR10MB1584.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39850400004)(396003)(136003)(376002)(199004)(189003)(486006)(446003)(2616005)(476003)(11346002)(36756003)(74482002)(3846002)(6116002)(42882007)(6246003)(8936002)(8976002)(105586002)(68736007)(6486002)(106356001)(6436002)(229853002)(53936002)(6512007)(6306002)(52116002)(99286004)(2906002)(14454004)(44832011)(76176011)(26005)(81156014)(186003)(81166006)(386003)(6506007)(53546011)(102836004)(31686004)(71200400001)(97736004)(478600001)(71190400001)(72206003)(966005)(7416002)(305945005)(14444005)(25786009)(8676002)(4326008)(7736002)(31696002)(54906003)(66066001)(110136005)(93886005)(5660300002)(256004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1584;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t2pD1pylgfFZh8jxjU9+ZRJrIhT+eXjiD3/m5VKtNJm+5IMM4XWAxMNwAsutJWwhL7YSxEZldNAF27ECCJ6Epz5Ec/UkVoaoC2Sq3gYZwgHi8EQOrUrhPdXDQzN6XZRpvDQ7XEIuklshxyw0jtQ7QNGhM5hlp2718qUyWcDCDp/1jFFqybJPhboXDtisMZR0NFnnvKgKEB4Jc73ABjynsYULD/bDSlXW/5V9inV1rcZDj2qe5adVrA2snmzxqFj6Y5SpPOEdREJ6xjKI3f1xg1wzQ9iaYiWK4OU1voVq0gr9KMW9YIRuALQu82qva7sh980PNBO+v1P+PlrySb+iWJskT3IFQjPtQZWWXRRCVXymvQqDAMG8cBKgH8RE1GzJb0NkSQdLzNlBbIQ7mmqcztyZLOgY25nnlgqJvATFjJc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D531D7E441FA478805BD354C2CF6EF@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f0f95-ff0a-4cd3-0d80-08d6ae9a5e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 07:45:35.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEvMDMvMjAxOSAxNi4zMCwgTWFyYyBLbGVpbmUtQnVkZGUgd3JvdGU6DQo+IE9uIDMvMjEv
MTkgMzozNCBQTSwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4+IE9uIDIwLzAzLzIwMTkgMTQu
MTgsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOg0KPj4+IE9uIDMvNy8xOSA0OjAwIFBNLCBSYXNt
dXMgVmlsbGVtb2VzIHdyb3RlOg0KPj4+PiBXaGlsZSB0cnlpbmcgdG8gYWRkIHN1cHBvcnQgZm9y
IHRoZSBGbGV4Y2FuIG1vZHVsZXMgb24gdGhlIE1QQzgzMDksDQo+Pj4+IEknbSBoaXR0aW5nIEVU
SU1FRE9VVCBpbiBmbGV4Y2FuX2NoaXBfZGlzYWJsZSgpLiBXaXRoIHRoaXMsIHByb2JpbmcNCj4+
Pj4gc3VjY2VlZHMuIENoZWNraW5nIHRoZSBsZWZ0b3ZlciB2YWx1ZSBvZiB0aW1lb3V0IHdpdGgg
YSBwcmltaXRpdmUNCj4+Pj4NCj4+Pj4gICBwcl9lcnIoIiVzOiB0aW1lb3V0PT0lZFxuIiwgX19m
dW5jX18sIHRpbWVvdXQpOw0KPj4+Pg0KPj4+PiBhZnRlciB0aGUgbG9vcCBpbiBjaGlwX2Rpc2Fi
bGUoKSB0eXBpY2FsbHkgc2hvd3MgdmFsdWVzIGFyb3VuZCAxMi0xNCwNCj4+Pj4gaS5lLiBzdWdn
ZXN0aW5nIHRoYXQgaXQgdGFrZXMgYWJvdXQgMTEwLTEzMCB1cyBmb3IgdGhlIExQTV9BQ0sgYml0
IHRvDQo+Pj4+IGFwcGVhci4gU28gYSB0aW1lb3V0IHZhbHVlIG9mIGFib3V0IHR3aWNlIHRoYXQg
c2VlbXMgcmVhc29uYWJsZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogUmFzbXVzIFZpbGxl
bW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+Pj4NCj4+PiBJJ3ZlIHNjaGVkdWxl
ZCB0aGUgcGF0Y2ggYnkgSm9ha2ltIFpoYW5nOg0KPj4+DQo+Pj4gICAgIDlkYWVkODlhZThhMyBj
YW46IGZsZXhjYW46IGZpeCB0aW1lb3V0IHdoZW4gc2V0IHNtYWxsIGJpdHJhdGUNCj4+Pg0KPj4+
IHRoYXQgZG91YmxlcyB0aGUgdGltZW91dCB0byAxMDAuDQo+Pg0KPj4gRWgsIG9rLCBidXQgdGhh
dCdzIG5vdCBzdWZmaWNpZW50IGZvciB0aGUgTVBDODMwOSAoSSB0cmllZCB3aXRoIDEwMCBhdA0K
Pj4gZmlyc3QsIGJ1dCBhcyBJIHdyaXRlIHRoZSBtaW5pbWFsbHkgd29ya2luZyB0aW1lb3V0IHZh
bHVlIHR1cm5zIG91dCB0bw0KPj4gYmUgYWJvdXQgMTQwIHVzKS4gRG8geW91IHdhbnQgbWUgdG8g
c2VuZCBhbm90aGVyIHBhdGNoIG9uIHRvcCBvZg0KPj4gOWRhZWQ4OWFlOGEzLCBvciBob3cgc2hv
dWxkIEkgaW50ZXJwcmV0IHRoZSBhYm92ZT8NCj4gDQo+IENhbiB5b3UgcHJvcG9zZSBhbiB1cGRh
dGVkIGNvbW1pdCBtZXNzYWdlIGZvciBKb2FraW0gWmhhbmcncyBwYXRjaD8NCj4gDQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21rbC9saW51eC1jYW4u
Z2l0L2NvbW1pdC8/aD10ZXN0aW5nJmlkPTlkYWVkODlhZThhM2ZjNDRjY2QyYjJiYjljM2M0ZDNl
MzQzMTkwNGQNCj4gDQo+IEknbGwgYWRkIGl0IGJ5IGhhbmQgYW5kIGluY3JlYXNlIHRoZSB0aW1l
b3V0IHRvIDI1MC4gT2s/DQoNClNvdW5kcyBmaW5lLiBJbiBvcmRlciBub3QgdG8gY2hhbmdlIEpv
YWtpbSdzIGNvbW1pdCBsb2cgdG9vIG11Y2gsIGhvdw0KYWJvdXQgYWRkaW5nIHNvbWV0aGluZyBs
aWtlICh3aXRoIHlvdXIgaW5pdGlhbHMsIHNpbmNlIHlvdSdyZSBuZXh0IGluDQp0aGUgc2lnbi1v
ZmYgY2hhaW4pDQoNCltta2w6IE1lYW53aGlsZSwgUmFzbXVzIFZpbGxlbW9lcyByZXBvcnRlZCB0
aGF0IGV2ZW4gd2l0aCBhIHRpbWVvdXQgb2YNCjEwMCwgZmxleGNhbl9wcm9iZSgpIGZhaWxzIG9u
IHRoZSBNUEM4MzA5LCB3aGljaCByZXF1aXJlcyBhIHZhbHVlIG9mIGF0DQpsZWFzdCAxNDAgdG8g
d29yayByZWxpYWJseS4gMjUwIHdvcmtzIGZvciBldmVyeW9uZS5dDQoNCj8gRmVlbCBmcmVlIHRv
IGVkaXQgYXMgeW91IHdpc2guDQoNClRoYW5rcywNClJhc211cw0K
