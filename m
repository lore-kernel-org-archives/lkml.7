Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE4C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36319206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLYCkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:40:32 -0500
Received: from mx21.baidu.com ([220.181.3.85]:33230 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfLYCkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:40:32 -0500
Received: from BC-Mail-Ex32.internal.baidu.com (unknown [172.31.51.26])
        by Forcepoint Email with ESMTPS id 58E7010A89C5D8227D06;
        Wed, 25 Dec 2019 10:40:26 +0800 (CST)
Received: from BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) by
 BC-Mail-Ex32.internal.baidu.com (172.31.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 25 Dec 2019 10:40:26 +0800
Received: from BC-Mail-Ex03.internal.baidu.com (172.31.51.43) by
 BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 25 Dec 2019 10:40:25 +0800
Received: from BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) by
 BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) with mapi id
 15.01.1531.010; Wed, 25 Dec 2019 10:40:25 +0800
From:   "Jim,Yan" <jimyan@baidu.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhv?=
 =?utf-8?Q?st_due_to_scope_mismatch?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?B?SF0gaW9tbXUvdnQtZDogRG9uJ3QgcmVqZWN0IG52bWUgaG9zdCBkdWUgdG8g?=
 =?utf-8?Q?scope_mismatch?=
Thread-Index: AdW6BKk3WRIzqftPRCuhhluvn9v6Mv//tuqA//9dBfCAAPa3gP//eOkwgAF7SQD//3mpQAASFHaA//95fSA=
Date:   Wed, 25 Dec 2019 02:40:25 +0000
Message-ID: <e809db0aa1b945aa99daadc08eff8270@baidu.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
 <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
 <062f5fd1611940b083ec34603eca94e1@baidu.com>
 <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
 <eccacec618c04a58be66809a541a95bf@baidu.com>
 <f5ceee32-4a21-a09c-1e1b-d3f0539ace4c@linux.intel.com>
In-Reply-To: <f5ceee32-4a21-a09c-1e1b-d3f0539ace4c@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.92]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex02_2019-12-25 10:40:26:123
x-baidu-bdmsfe-viruscheck: BJHW-Mail-Ex02_GRAY_Inside_WithoutAtta_2019-12-25
 10:40:26:107
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BC-Mail-Ex32_2019-12-25 10:40:26:284
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEx1IEJhb2x1IFtt
YWlsdG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTnlubQx
MuaciDI15pelIDEwOjM4DQo+IOaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT47
IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+DQo+IOaKhOmAgTogYmFvbHUu
bHVAbGludXguaW50ZWwuY29tOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiDnrZTlpI06IOetlOWk
jTog562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBpb21tdS92dC1kOiBEb24ndCByZWpl
Y3QNCj4gbnZtZSBob3N0IGR1ZSB0byBzY29wZSBtaXNtYXRjaA0KPiANCj4gSGksDQo+IA0KPiBP
biAxMi8yNS8xOSAxMDowNSBBTSwgSmltLFlhbiB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+PiAt
LS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4+IOWPkeS7tuS6ujogTHUgQmFvbHUgW21haWx0bzpi
YW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+IOWPkemAgeaXtumXtDogMjAxOeW5tDEy5pyI
MjXml6UgMTA6MDENCj4gPj4g5pS25Lu25Lq6OiBKaW0sWWFuIDxqaW15YW5AYmFpZHUuY29tPjsg
SmVycnkgU25pdHNlbGFhcg0KPiA+PiA8anNuaXRzZWxAcmVkaGF0LmNvbT4NCj4gPj4g5oqE6YCB
OiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiA+PiDkuLvpopg6IFJlOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06
IFtQQVRDSF0gaW9tbXUvdnQtZDogRG9uJ3QgcmVqZWN0DQo+IG52bWUgaG9zdA0KPiA+PiBkdWUg
dG8gc2NvcGUgbWlzbWF0Y2gNCj4gPj4NCj4gPj4gSGksDQo+ID4+DQo+ID4+IE9uIDIwMTkvMTIv
MjUgOTo1MiwgSmltLFlhbiB3cm90ZToNCj4gPj4+IEhpLA0KPiA+Pj4NCj4gPj4+PiAtLS0tLemC
ruS7tuWOn+S7ti0tLS0tDQo+ID4+Pj4g5Y+R5Lu25Lq6OiBMdSBCYW9sdSBbbWFpbHRvOmJhb2x1
Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gPj4+PiDlj5HpgIHml7bpl7Q6IDIwMTnlubQxMuaciDI0
5pelIDE5OjI3DQo+ID4+Pj4g5pS25Lu25Lq6OiBKaW0sWWFuIDxqaW15YW5AYmFpZHUuY29tPjsg
SmVycnkgU25pdHNlbGFhcg0KPiA+Pj4+IDxqc25pdHNlbEByZWRoYXQuY29tPg0KPiA+Pj4+IOaK
hOmAgTogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPj4+PiDkuLvpopg6IFJlOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBb
UEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lDQo+IGhvc3QNCj4gPj4gZHVlIHRv
DQo+ID4+Pj4gc2NvcGUgbWlzbWF0Y2gNCj4gPj4+Pg0KPiA+Pj4+IEhpLA0KPiA+Pj4+DQo+ID4+
Pj4gT24gMjAxOS8xMi8yNCAxNjoxOCwgSmltLFlhbiB3cm90ZToNCj4gPj4+Pj4+Pj4gRm9yIGJv
dGggY2FzZXMsIGEgcXVpcmsgZmxhZyBzZWVtcyB0byBiZSBtb3JlIHJlYXNvbmFibGUsIHNvDQo+
ID4+Pj4+Pj4+IHRoYXQgdW5yZWxhdGVkIGRldmljZXMgd2lsbCBub3QgYmUgaW1wYWN0ZWQuDQo+
ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IEJlc3QgcmVnYXJkcywNCj4gPj4+Pj4+Pj4gYmFvbHUNCj4g
Pj4+Pj4+PiBIaSBCYW9sdSwNCj4gPj4+Pj4+PiAJVGhhbmtzIGZvciB5b3VyIGFkdmljZS4gQW5k
IEkgbW9kaWZ5IHRoZSBwYXRjaCBhcyBmb2xsb3cuDQo+ID4+Pj4+PiBJIGp1c3QgcG9zdGVkIGEg
cGF0Y2ggZm9yIGJvdGggTlRHIGFuZCBOVk1FIGNhc2VzLiBDYW4geW91IHBsZWFzZQ0KPiA+Pj4+
Pj4gdGFrZSBhDQo+ID4+Pj4gbG9vaz8NCj4gPj4+Pj4+IERvZXMgaXQgd29yayBmb3IgeW91Pw0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IEJlc3QgcmVnYXJkcywNCj4gPj4+Pj4+IGJhb2x1DQo+ID4+Pj4+
Pg0KPiA+Pj4+PiBJIGhhdmUgdGVzdGVkIHlvdXIgcGF0Y2guIEl0IGRvZXMgd29yayBmb3IgbWUu
IEJ1dCBJIHByZWZlciBteQ0KPiA+Pj4+PiBzZWNvbmQgdmVyc2lvbiwNCj4gPj4+PiBpdCBpcyBt
b3JlIGZsZXhpYmxlLCBhbmQgbWF5IHVzZSBmb3Igc2ltaWxhciB1bmtub3duIGRldmljZXMuDQo+
ID4+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBJIGRpZG4ndCBnZXQgeW91ciBwb2ludC4gRG8geW91IG1p
bmQgZXhwbGFpbmluZyB3aHkgaXQncyBtb3JlIGZsZXhpYmxlPw0KPiA+Pj4+DQo+ID4+Pj4gQmVz
dCByZWdhcmRzLA0KPiA+Pj4+IEJhb2x1DQo+ID4+PiBGb3IgZXhhbXBsZSwgYW4gdW5rbm93biBk
ZXZpY2UgaGFzIGEgbm9ybWFsIFBDSSBoZWFkZXIgYW5kIGJyaWRnZQ0KPiA+Pj4gc2NvcGUNCj4g
Pj4gYW5kIGEgY2xhc3Mgb2YgUENJX0NMQVNTX0JSSURHRV9QQ0kuDQo+ID4+PiBUaGVzZSBkZXZp
Y2VzIGRvIGhhdmUgYSBjbGFzcyBvZiBQQ0lfQkFTRV9DTEFTU19CUklER0UgaW4gY29tbW9uLg0K
PiA+Pg0KPiA+PiBUaGlzIGlzIG5vdCBhIGNvbW1vbiBjYXNlLiBJdCdzIG9ubHkgZm9yIGRldmlj
ZXMgb24gdGhlIG1hcmtldGluZyBhbmQNCj4gPj4gaGFyZCBmb3IgdGhlIFZULWQgdXNlcnMgdG8g
Z2V0IGl0IGZpeGVkIGluIHRoZSBPRU0gZmlybXdhcmUuDQo+ID4+DQo+ID4+IEJlc3QgcmVnYXJk
cywNCj4gPj4gQmFvbHUNCj4gPg0KPiA+IEdvdCBpdC4gVGhlbiBJIGFtIE9LIHdpdGggdGhpcyBw
YXRjaC4gSSBoYXZlIHRlc3RlZCBpdCB5ZXN0ZXJkYXkuIEl0IGRvZXMgd29yaw0KPiBmb3IgbWUu
DQo+ID4gVGhhbmtzLg0KPiANCj4gQ2FuIEkgYWRkIHlvdXIgVGVzdGVkLWJ5Pw0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBCYW9sdQ0KDQpZZXMuIE9mIGNvdXJzZS4gDQoNCkJlc3QgcmVnYXJkcywN
CkppbQ0K
