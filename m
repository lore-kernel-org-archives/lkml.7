Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2593C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306A720679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dv2b3Y5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDYNMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:12:35 -0400
Received: from mail-eopbgr820042.outbound.protection.outlook.com ([40.107.82.42]:30513
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfDYNMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSa7NpACzcEjuIEgD3bWjqgM5AEFh4Do6Tj54+ecbcY=;
 b=dv2b3Y5QFMKZYpodmrd/UhWcMbOmJINEdNG5+/uf2UaJuji7wK9N06Pn8KMLMHUOK0OH841cNmKL+AEUilCRkMjfRFmb22YwMyrWpbjCJMsuo7ruoBAm/0ijgA6F/Y7/Tc4wPgfgtqYIN+rB2DbxRK96g13kE08zgrVRkOmUM44=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2731.namprd12.prod.outlook.com (20.176.118.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 13:12:29 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::c96d:c1dd:fd7a:ffd6]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::c96d:c1dd:fd7a:ffd6%4]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 13:12:29 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH net-next] amd-xgbe: Mark expected switch fall-throughs
Thread-Topic: [PATCH net-next] amd-xgbe: Mark expected switch fall-throughs
Thread-Index: AQHU+rgGgWv1Qho1SUuKqNVzktWrWKZM250A
Date:   Thu, 25 Apr 2019 13:12:28 +0000
Message-ID: <bfb7c017-e7df-5fa3-d946-32ee3b94fa53@amd.com>
References: <20190424160823.GA20314@embeddedor>
In-Reply-To: <20190424160823.GA20314@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:805:8e::36) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4163fe81-26fb-4130-6565-08d6c97faafa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2731;
x-ms-traffictypediagnostic: DM6PR12MB2731:
x-microsoft-antispam-prvs: <DM6PR12MB2731781F0AF4737DBE05EC91EC3D0@DM6PR12MB2731.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(26005)(76176011)(66946007)(256004)(66446008)(73956011)(5660300002)(6436002)(64756008)(66556008)(7736002)(305945005)(14454004)(71200400001)(229853002)(66476007)(4326008)(6246003)(8676002)(25786009)(6116002)(53936002)(3846002)(81166006)(71190400001)(36756003)(478600001)(81156014)(186003)(54906003)(6512007)(110136005)(2906002)(14444005)(52116002)(316002)(2616005)(86362001)(53546011)(31696002)(97736004)(31686004)(8936002)(6486002)(11346002)(486006)(476003)(99286004)(102836004)(446003)(66066001)(386003)(6506007)(68736007)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2731;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: byNdkQRO/iJgpZvYGvdYTDwKCcy6SpPb+Bl5xI3m2WSd3pg2+68ek7QbAHXiugZElUcRWTO7KJztcykZLoZv7O3aeALG1ZCx9fSRFHWeUBIEjx4BuEb/5pOotbhFyldbxaR2F1bCp9djrvj3auZkqX4E767pTUaczXs/idmu1Jf8nKi5v40/3r1gxrC+YsAe41CEFOEh+b+8SM4OMnqnJgtX5basKAHGgvZ2hb9AlLU8JVs7ZVNEJVEehERWFPTQqGTMaW7bOAtvlUJjo2S/WbG2lIlXkTFXDcK3wj4qgD0DgmhwFpInP6Exv4rxVVKs3kBDRFsSLBeqc3/FhlqrmlNsn2nA9tX7+SzuFVn7T6Ziaa1UW2r7T6j2x0IqNmcdlTFzAOmfCvScOlTYzcar2mqRZcQjjg+u1bAatw8iBKc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81E8965B143D8D43AFE3E70AD1DFC43B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4163fe81-26fb-4130-6565-08d6c97faafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 13:12:28.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNC8xOSAxMTowOCBBTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gSW4gcHJl
cGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBzd2l0Y2gN
Cj4gY2FzZXMgd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guDQo+IA0KPiBU
aGlzIHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZ3M6DQo+IA0KPiBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1kL3hnYmUveGdiZS1kcnYuYzoxMjk6
DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtZHJ2LmM6IEluIGZ1bmN0aW9u
IOKAmHhnYmVfc2V0X2h3dHN0YW1wX3NldHRpbmdz4oCZOg0KPiBkcml2ZXJzL25ldC9ldGhlcm5l
dC9hbWQveGdiZS94Z2JlLWNvbW1vbi5oOjEzOTI6OTogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQg
bWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQo+ICAgKF92YXIpIHw9
ICgoKF92YWwpICYgKCgweDEgPDwgKF93aWR0aCkpIC0gMSkpIDw8IChfaW5kZXgpKTsgXA0KPiAg
IH5+fn5+fn5efn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1kL3hnYmUveGdiZS1jb21tb24uaDoxNDE5OjI6
IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTRVRfQklUU+KAmQ0KPiAgIFNFVF9CSVRT
KChfdmFyKSwgICAgICBcDQo+ICAgXn5+fn5+fn4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1k
L3hnYmUveGdiZS1kcnYuYzoxNjE0OjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhY
R01BQ19TRVRfQklUU+KAmQ0KPiAgICBYR01BQ19TRVRfQklUUyhtYWNfdHNjciwgTUFDX1RTQ1Is
IFRTVkVSMkVOQSwgMSk7DQo+ICAgIF5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2FtZC94Z2JlL3hnYmUtZHJ2LmM6MTYxNjoyOiBub3RlOiBoZXJlDQo+ICAgY2FzZSBIV1RT
VEFNUF9GSUxURVJfUFRQX1YxX0w0X0VWRU5UOg0KPiAgIF5+fn4NCj4gSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtZHJ2LmM6MTI5Og0KPiBk
cml2ZXJzL25ldC9ldGhlcm5ldC9hbWQveGdiZS94Z2JlLWNvbW1vbi5oOjEzOTI6OTogd2Fybmlu
ZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3Vn
aD1dDQo+ICAgKF92YXIpIHw9ICgoKF92YWwpICYgKCgweDEgPDwgKF93aWR0aCkpIC0gMSkpIDw8
IChfaW5kZXgpKTsgXA0KPiAgIH5+fn5+fn5efn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1kL3hnYmUveGdi
ZS1jb21tb24uaDoxNDE5OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTRVRfQklU
U+KAmQ0KPiAgIFNFVF9CSVRTKChfdmFyKSwgICAgICBcDQo+ICAgXn5+fn5+fn4NCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvYW1kL3hnYmUveGdiZS1kcnYuYzoxNjI1OjM6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyDigJhYR01BQ19TRVRfQklUU+KAmQ0KPiAgICBYR01BQ19TRVRfQklUUyht
YWNfdHNjciwgTUFDX1RTQ1IsIFRTVkVSMkVOQSwgMSk7DQo+ICAgIF5+fn5+fn5+fn5+fn5+DQo+
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtZHJ2LmM6MTYyNzoyOiBub3RlOiBo
ZXJlDQo+ICAgY2FzZSBIV1RTVEFNUF9GSUxURVJfUFRQX1YxX0w0X1NZTkM6DQo+ICAgXn5+fg0K
PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1kL3hnYmUveGdi
ZS1kcnYuYzoxMjk6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtY29tbW9u
Lmg6MTM5Mjo5OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2lt
cGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAoX3ZhcikgfD0gKCgoX3ZhbCkgJiAoKDB4MSA8PCAo
X3dpZHRoKSkgLSAxKSkgPDwgKF9pbmRleCkpOyBcDQo+ICAgfn5+fn5+fl5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9hbWQveGdiZS94Z2JlLWNvbW1vbi5oOjE0MTk6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvIOKAmFNFVF9CSVRT4oCZDQo+ICAgU0VUX0JJVFMoKF92YXIpLCAgICAgIFwNCj4gICBe
fn5+fn5+fg0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9hbWQveGdiZS94Z2JlLWRydi5jOjE2MzY6
Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFhHTUFDX1NFVF9CSVRT4oCZDQo+ICAg
IFhHTUFDX1NFVF9CSVRTKG1hY190c2NyLCBNQUNfVFNDUiwgVFNWRVIyRU5BLCAxKTsNCj4gICAg
Xn5+fn5+fn5+fn5+fn4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1kL3hnYmUveGdiZS1kcnYu
YzoxNjM4OjI6IG5vdGU6IGhlcmUNCj4gICBjYXNlIEhXVFNUQU1QX0ZJTFRFUl9QVFBfVjFfTDRf
REVMQVlfUkVROg0KPiAgIF5+fn4NCj4gDQo+IFdhcm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdp
bXBsaWNpdC1mYWxsdGhyb3VnaD0zDQo+IA0KPiBOb3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1
bGFyIGNhc2UsIHRoZSBjb2RlIGNvbW1lbnRzIGFyZSBtb2RpZmllZA0KPiBpbiBhY2NvcmRhbmNl
IHdpdGggd2hhdCBHQ0MgaXMgZXhwZWN0aW5nIHRvIGZpbmQuDQo+IA0KPiBUaGlzIHBhdGNoIGlz
IHBhcnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUNCj4gLVdpbXBsaWNpdC1mYWxs
dGhyb3VnaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rh
dm9AZW1iZWRkZWRvci5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1kL3hn
YmUveGdiZS1kcnYuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2FtZC94Z2JlL3hnYmUtZHJ2LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWQveGdiZS94
Z2JlLWRydi5jDQo+IGluZGV4IDBjYzkxMWY5MjhiMS4uM2RkMGNlY2RkYmE4IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWQveGdiZS94Z2JlLWRydi5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtZHJ2LmMNCj4gQEAgLTE2MTIsNyArMTYx
Miw3IEBAIHN0YXRpYyBpbnQgeGdiZV9zZXRfaHd0c3RhbXBfc2V0dGluZ3Moc3RydWN0IHhnYmVf
cHJ2X2RhdGEgKnBkYXRhLA0KPiAgCS8qIFBUUCB2MiwgVURQLCBhbnkga2luZCBvZiBldmVudCBw
YWNrZXQgKi8NCj4gIAljYXNlIEhXVFNUQU1QX0ZJTFRFUl9QVFBfVjJfTDRfRVZFTlQ6DQo+ICAJ
CVhHTUFDX1NFVF9CSVRTKG1hY190c2NyLCBNQUNfVFNDUiwgVFNWRVIyRU5BLCAxKTsNCj4gLQkv
KiBQVFAgdjEsIFVEUCwgYW55IGtpbmQgb2YgZXZlbnQgcGFja2V0ICovDQo+ICsJCS8qIEZhbGwg
dGhyb3VnaCAtIHRvIFBUUCB2MSwgVURQLCBhbnkga2luZCBvZiBldmVudCBwYWNrZXQgKi8NCg0K
SWYgdGhlIGNvbXBpbGVyIGRvZXNuJ3QgaGF2ZSBhIHByb2JsZW0gd2l0aCBhZGRpbmcganVzdCBh
biBpbmRlbnRlZA0KIkZhbGwgdGhyb3VnaCIgY29tbWVudCBhbmQgbGVhdmluZyB0aGUgb3JpZ2lu
YWwgY29tbWVudCBpbiBwbGFjZSwgSSB3b3VsZA0KcHJlZmVyIHRoYXQuIEl0IHNlZW1zIGNsZWFy
ZXIgdG8gbWUuDQoNClRoYW5rcywNClRvbQ0KDQo+ICAJY2FzZSBIV1RTVEFNUF9GSUxURVJfUFRQ
X1YxX0w0X0VWRU5UOg0KPiAgCQlYR01BQ19TRVRfQklUUyhtYWNfdHNjciwgTUFDX1RTQ1IsIFRT
SVBWNEVOQSwgMSk7DQo+ICAJCVhHTUFDX1NFVF9CSVRTKG1hY190c2NyLCBNQUNfVFNDUiwgVFNJ
UFY2RU5BLCAxKTsNCj4gQEAgLTE2MjMsNyArMTYyMyw3IEBAIHN0YXRpYyBpbnQgeGdiZV9zZXRf
aHd0c3RhbXBfc2V0dGluZ3Moc3RydWN0IHhnYmVfcHJ2X2RhdGEgKnBkYXRhLA0KPiAgCS8qIFBU
UCB2MiwgVURQLCBTeW5jIHBhY2tldCAqLw0KPiAgCWNhc2UgSFdUU1RBTVBfRklMVEVSX1BUUF9W
Ml9MNF9TWU5DOg0KPiAgCQlYR01BQ19TRVRfQklUUyhtYWNfdHNjciwgTUFDX1RTQ1IsIFRTVkVS
MkVOQSwgMSk7DQo+IC0JLyogUFRQIHYxLCBVRFAsIFN5bmMgcGFja2V0ICovDQo+ICsJCS8qIEZh
bGwgdGhyb3VnaCAtIHRvIFBUUCB2MSwgVURQLCBTeW5jIHBhY2tldCAqLw0KPiAgCWNhc2UgSFdU
U1RBTVBfRklMVEVSX1BUUF9WMV9MNF9TWU5DOg0KPiAgCQlYR01BQ19TRVRfQklUUyhtYWNfdHNj
ciwgTUFDX1RTQ1IsIFRTSVBWNEVOQSwgMSk7DQo+ICAJCVhHTUFDX1NFVF9CSVRTKG1hY190c2Ny
LCBNQUNfVFNDUiwgVFNJUFY2RU5BLCAxKTsNCj4gQEAgLTE2MzQsNyArMTYzNCw3IEBAIHN0YXRp
YyBpbnQgeGdiZV9zZXRfaHd0c3RhbXBfc2V0dGluZ3Moc3RydWN0IHhnYmVfcHJ2X2RhdGEgKnBk
YXRhLA0KPiAgCS8qIFBUUCB2MiwgVURQLCBEZWxheV9yZXEgcGFja2V0ICovDQo+ICAJY2FzZSBI
V1RTVEFNUF9GSUxURVJfUFRQX1YyX0w0X0RFTEFZX1JFUToNCj4gIAkJWEdNQUNfU0VUX0JJVFMo
bWFjX3RzY3IsIE1BQ19UU0NSLCBUU1ZFUjJFTkEsIDEpOw0KPiAtCS8qIFBUUCB2MSwgVURQLCBE
ZWxheV9yZXEgcGFja2V0ICovDQo+ICsJCS8qIEZhbGwgdGhyb3VnaCAtIHRvIFBUUCB2MSwgVURQ
LCBEZWxheV9yZXEgcGFja2V0ICovDQo+ICAJY2FzZSBIV1RTVEFNUF9GSUxURVJfUFRQX1YxX0w0
X0RFTEFZX1JFUToNCj4gIAkJWEdNQUNfU0VUX0JJVFMobWFjX3RzY3IsIE1BQ19UU0NSLCBUU0lQ
VjRFTkEsIDEpOw0KPiAgCQlYR01BQ19TRVRfQklUUyhtYWNfdHNjciwgTUFDX1RTQ1IsIFRTSVBW
NkVOQSwgMSk7DQo+IA0K
