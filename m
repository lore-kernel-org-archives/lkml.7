Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC251C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4D217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="istUHVib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfDYG5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:57:35 -0400
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:46833
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDYG5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa5UJstmpqGoE/d1L4fsTERqxf3Y5QrYB4rvQdRgjJ4=;
 b=istUHVibs/iPE5PyaNjFpTpYHeaCLkye9eMk2ClsuvOcwZUfC4NXWuW7C+sl1ahlXTS6cWyKPNu6rhsmguQCZDK+ZxSeQUWYlU3uFyes24O/2LX5XnsqDuRncTbKKFkYnhw8OEcaa3YBoSwbicx7dvsVUBXMgNGgfKxbHgY9zhU=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB3119.eurprd04.prod.outlook.com (10.170.229.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Thu, 25 Apr 2019 06:56:51 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 06:56:51 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [EXT] Re: [PATCH] arm64: drivers: clk: qoriq: increase array size
 of cmux_to_group
Thread-Topic: [EXT] Re: [PATCH] arm64: drivers: clk: qoriq: increase array
 size of cmux_to_group
Thread-Index: AQHU+q0FP2+bGnUPHkiQJgHncASgPKZL83mAgAB6SPA=
Date:   Thu, 25 Apr 2019 06:56:51 +0000
Message-ID: <VI1PR04MB4800C3011CA048CE5CD1E465F33D0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1556117426-26878-1-git-send-email-vabhav.sharma@nxp.com>
 <155614807592.15276.17299738374776352204@swboyd.mtv.corp.google.com>
In-Reply-To: <155614807592.15276.17299738374776352204@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e87b25-2995-42ae-89a0-08d6c94b320d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3119;
x-ms-traffictypediagnostic: VI1PR04MB3119:
x-microsoft-antispam-prvs: <VI1PR04MB3119D617E160330AA28B0AB1F33D0@VI1PR04MB3119.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(13464003)(189003)(199004)(2906002)(53936002)(14444005)(229853002)(478600001)(25786009)(9686003)(4326008)(2201001)(81166006)(8676002)(81156014)(186003)(68736007)(6506007)(53546011)(6116002)(86362001)(14454004)(102836004)(476003)(26005)(8936002)(446003)(3846002)(11346002)(54906003)(76176011)(76116006)(97736004)(99286004)(71190400001)(66066001)(66446008)(66556008)(6246003)(256004)(110136005)(71200400001)(6436002)(316002)(66476007)(486006)(55016002)(7736002)(2501003)(52536014)(74316002)(5660300002)(7696005)(64756008)(44832011)(305945005)(73956011)(66946007)(33656002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3119;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xcY0D/nKM8uIqUxjhE2w3eAkFFxnhLlSIqk66LGCIiBvzzhSlAAYYvu+nD2d4IhSRqwsIfli2I1NXPfjzCgLcfcLAW7muhMXNNcQ4wmUd+46Upe5MeS+tWkiRWmP0sNZ9bV01TBwJh/oXlCbgTpdHehdocW8p2NB80H+52NOXIwz4adUD1arowKVJiDRCwh5BRabdnXHYVZvKKhDVt6C3cVGzLLbjkazVena3XnHhcfji5paBGpROWN2E1HcvRbwLmvBtS84iJBgo6GTDkhzenNP8z+KMmvuSuqQS5Wg741pZygz7ASIdvwtPzS7DrFAG7F0RIisiH1FSd5m81GznwYJBcjnsAIsjwJDyafXfDFuC//0/P0hJV0jfNGbo3+j/YRYiNIaEAf7/tAJzSl4N8+73FBPtBfcbUQqs+Fwe60=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e87b25-2995-42ae-89a0-08d6c94b320d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 06:56:51.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjUsIDIwMTkgNDo1MSBB
TQ0KPiBUbzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgVmFiaGF2IFNoYXJtYQ0KPiA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBDYzog
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4gPHlvZ2VzaG5h
cmF5YW4uZ2F1ckBueHAuY29tPjsgVmFiaGF2IFNoYXJtYQ0KPiA8dmFiaGF2LnNoYXJtYUBueHAu
Y29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBhcm02NDogZHJpdmVyczogY2xrOiBx
b3JpcTogaW5jcmVhc2UgYXJyYXkgc2l6ZSBvZg0KPiBjbXV4X3RvX2dyb3VwDQo+IA0KPiBDYXV0
aW9uOiBFWFQgRW1haWwNCj4gDQo+IFlvdXIgc3ViamVjdCBzaG91bGQgYmUgImNsazogcW9yaXE6
IEluY3JlYXNlIGFycmF5IHNpemUgb2YgY211eF90b19ncm91cCINCk9rLCBJIHdpbGwgdXBkYXRl
IGl0DQo+IA0KPiBRdW90aW5nIFZhYmhhdiBTaGFybWEgKDIwMTktMDQtMjQgMDc6NTA6MTMpDQo+
ID4gRnJvbTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiA+DQo+
ID4gSW5jcmVhc2Ugc2l6ZSBvZiBjbXV4X3RvX2dyb3VwIGFycmF5LCB0byBhY2NvbWRhdGUgZW50
cnkgb2YNCj4gPiAtMSB0ZXJtaW5hdGlvbi4NCj4gPg0KPiA+IEFkZGVkIC0xLCB0ZXJtaW5hdGVk
LCBlbnRyeSBmb3IgNDA4MF9jbXV4X2dycFguDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb2dl
c2ggR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
VmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiA+IEFja2VkLWJ5OiBTY290
dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pg0KPiA+IEFja2VkLWJ5OiBTdGVwaGVuIEJveWQgPHNi
b3lkQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1xb3JpcS5jIHwg
NCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9kcml2
ZXJzL2Nsay9jbGstcW9yaXEuYyBpbmRleA0KPiA+IDEyMTJhOWIuLmY2NjA2Y2YgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9j
bGstcW9yaXEuYw0KPiA+IEBAIC03OSw3ICs3OSw3IEBAIHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5m
byB7DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgY2xvY2tnZW5fbXV4aW5mbyAqY211eF9ncm91
cHNbMl07DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgY2xvY2tnZW5fbXV4aW5mbyAqaHdhY2Nl
bFtOVU1fSFdBQ0NFTF07DQo+ID4gICAgICAgICB2b2lkICgqaW5pdF9wZXJpcGgpKHN0cnVjdCBj
bG9ja2dlbiAqY2cpOw0KPiA+IC0gICAgICAgaW50IGNtdXhfdG9fZ3JvdXBbTlVNX0NNVVhdOyAv
KiAtMSB0ZXJtaW5hdGVzIGlmIGZld2VyIHRoYW4NCj4gTlVNX0NNVVggKi8NCj4gPiArICAgICAg
IGludCBjbXV4X3RvX2dyb3VwW05VTV9DTVVYKzFdOyAvKiBhcnJheSBzaG91bGQgYmUgLTENCj4g
PiArIHRlcm1pbmF0ZWQgKi8NCj4gDQo+IFBsZWFzZSBwdXQgc3BhY2UgYXJvdW5kIHRoYXQgKy4N
Ck9rLCBJIHdpbGwgdXBkYXRlIGl0DQo+IA0KPiA+ICAgICAgICAgdTMyIHBsbF9tYXNrOyAgIC8q
IDEgPDwgbiBiaXQgc2V0IGlmIFBMTCBuIGlzIHZhbGlkICovDQo+ID4gICAgICAgICB1MzIgZmxh
Z3M7ICAgICAgLyogQ0dfeHh4ICovDQo+ID4gIH07DQo+ID4gQEAgLTYwMSw3ICs2MDEsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGNsb2NrZ2VuX2NoaXBpbmZvIGNoaXBpbmZvW10gPSB7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgJnA0MDgwX2NtdXhfZ3JwMSwgJnA0MDgwX2NtdXhfZ3Jw
Mg0KPiA+ICAgICAgICAgICAgICAgICB9LA0KPiA+ICAgICAgICAgICAgICAgICAuY211eF90b19n
cm91cCA9IHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAwLCAwLCAwLCAwLCAxLCAxLCAx
LCAxDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgMCwgMCwgMCwgMCwgMSwgMSwgMSwgMSwg
LTENCj4gPiAgICAgICAgICAgICAgICAgfSwNCj4gPiAgICAgICAgICAgICAgICAgLnBsbF9tYXNr
ID0gMHgxZiwNCj4gPiAgICAgICAgIH0sDQo+IA0KPiBEaWQgeW91IHdhbnQgdGhpcyBwYXRjaCB0
byBnbyB0aHJvdWdoIGNsayB0cmVlPyBJIHNlZW0gdG8gaGF2ZSBhY2tlZCBpdCwNCj4gd2hpY2gg
SSBkb24ndCByZW1lbWJlci4gVXN1YWxseSB3aGVuIEkgYWNrIHNvbWV0aGluZyBJIGFzc3VtZSBp
dCdzIGdvaW5nDQo+IHRocm91Z2ggc29tZSBvdGhlciB0cmVlLg0KWWVzICwgcGxlYXNlIGhlbHAg
dG8gbWVyZ2UgaXQNClRoaXMgUGF0Y2ggd2FzIHNlbnQgZWFybGllciBhcyBhIHBhcnQgb2YgYWRk
aW5nIE5YUCBMWDIxNjBBIFNvQyBzdXBwb3J0LCByZXZpZXdlZCBhbmQgYWNrZWQgYnV0IGRyb3Bw
ZWQgZHVyaW5nIG1lcmdlIHdpbmRvdy4gU28gSSBicmVhayB0aGUgY2xvY2sgcGF0Y2hlcyBpbnRv
IHR3byBwYXRjaCB0byBsZXQgY2xrIG1haW50YWluZXJzIG1lcmdlIGl0Lg0K
