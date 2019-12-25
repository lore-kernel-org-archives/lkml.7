Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F58C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710742063A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLYCFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:05:50 -0500
Received: from mx22.baidu.com ([220.181.50.185]:58410 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfLYCFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:05:50 -0500
Received: from BC-Mail-EX08.internal.baidu.com (unknown [172.31.51.48])
        by Forcepoint Email with ESMTPS id 18716B98A2156D52D209;
        Wed, 25 Dec 2019 10:05:46 +0800 (CST)
Received: from BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) by
 BC-Mail-EX08.internal.baidu.com (172.31.51.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 25 Dec 2019 10:05:45 +0800
Received: from BC-Mail-Ex03.internal.baidu.com (172.31.51.43) by
 BJHW-Mail-Ex02.internal.baidu.com (10.127.64.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 25 Dec 2019 10:05:45 +0800
Received: from BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) by
 BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) with mapi id
 15.01.1531.010; Wed, 25 Dec 2019 10:05:45 +0800
From:   "Jim,Yan" <jimyan@baidu.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?B?SF0gaW9tbXUvdnQtZDogRG9uJ3QgcmVqZWN0IG52bWUgaG9zdCBkdWUgdG8g?=
 =?utf-8?Q?scope_mismatch?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlvbW11?=
 =?utf-8?B?L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhvc3QgZHVlIHRvIHNjb3BlIG1p?=
 =?utf-8?Q?smatch?=
Thread-Index: AdW6BKk3WRIzqftPRCuhhluvn9v6Mv//tuqA//9dBfCAAPa3gP//eOkwgAF7SQD//3mpQA==
Date:   Wed, 25 Dec 2019 02:05:45 +0000
Message-ID: <eccacec618c04a58be66809a541a95bf@baidu.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
 <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
 <062f5fd1611940b083ec34603eca94e1@baidu.com>
 <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
In-Reply-To: <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.92]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex02_2019-12-25 10:05:45:837
x-baidu-bdmsfe-viruscheck: BJHW-Mail-Ex02_GRAY_Inside_WithoutAtta_2019-12-25
 10:05:45:822
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BC-Mail-EX08_2019-12-25 10:05:45:930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEx1IEJhb2x1IFtt
YWlsdG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTnlubQx
MuaciDI15pelIDEwOjAxDQo+IOaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT47
IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+DQo+IOaKhOmAgTogaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4g5Li76aKYOiBSZTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlv
bW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lDQo+IGhvc3QgZHVlIHRvIHNjb3BlIG1pc21hdGNo
DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDIwMTkvMTIvMjUgOTo1MiwgSmltLFlhbiB3cm90ZToNCj4g
PiBIaSwNCj4gPg0KPiA+PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4+IOWPkeS7tuS6ujog
THUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+IOWPkemAgeaX
tumXtDogMjAxOeW5tDEy5pyIMjTml6UgMTk6MjcNCj4gPj4g5pS25Lu25Lq6OiBKaW0sWWFuIDxq
aW15YW5AYmFpZHUuY29tPjsgSmVycnkgU25pdHNlbGFhcg0KPiA+PiA8anNuaXRzZWxAcmVkaGF0
LmNvbT4NCj4gPj4g5oqE6YCBOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiDkuLvpopg6IFJlOiDnrZTlpI06IOetlOWk
jTog562U5aSNOiBbUEFUQ0hdIGlvbW11L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhvc3QNCj4g
ZHVlIHRvDQo+ID4+IHNjb3BlIG1pc21hdGNoDQo+ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+PiBP
biAyMDE5LzEyLzI0IDE2OjE4LCBKaW0sWWFuIHdyb3RlOg0KPiA+Pj4+Pj4gRm9yIGJvdGggY2Fz
ZXMsIGEgcXVpcmsgZmxhZyBzZWVtcyB0byBiZSBtb3JlIHJlYXNvbmFibGUsIHNvIHRoYXQNCj4g
Pj4+Pj4+IHVucmVsYXRlZCBkZXZpY2VzIHdpbGwgbm90IGJlIGltcGFjdGVkLg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+IEJlc3QgcmVnYXJkcywNCj4gPj4+Pj4+IGJhb2x1DQo+ID4+Pj4+IEhpIEJhb2x1
LA0KPiA+Pj4+PiAJVGhhbmtzIGZvciB5b3VyIGFkdmljZS4gQW5kIEkgbW9kaWZ5IHRoZSBwYXRj
aCBhcyBmb2xsb3cuDQo+ID4+Pj4gSSBqdXN0IHBvc3RlZCBhIHBhdGNoIGZvciBib3RoIE5URyBh
bmQgTlZNRSBjYXNlcy4gQ2FuIHlvdSBwbGVhc2UNCj4gPj4+PiB0YWtlIGENCj4gPj4gbG9vaz8N
Cj4gPj4+PiBEb2VzIGl0IHdvcmsgZm9yIHlvdT8NCj4gPj4+Pg0KPiA+Pj4+IEJlc3QgcmVnYXJk
cywNCj4gPj4+PiBiYW9sdQ0KPiA+Pj4+DQo+ID4+PiBJIGhhdmUgdGVzdGVkIHlvdXIgcGF0Y2gu
IEl0IGRvZXMgd29yayBmb3IgbWUuIEJ1dCBJIHByZWZlciBteQ0KPiA+Pj4gc2Vjb25kIHZlcnNp
b24sDQo+ID4+IGl0IGlzIG1vcmUgZmxleGlibGUsIGFuZCBtYXkgdXNlIGZvciBzaW1pbGFyIHVu
a25vd24gZGV2aWNlcy4NCj4gPj4+DQo+ID4+DQo+ID4+IEkgZGlkbid0IGdldCB5b3VyIHBvaW50
LiBEbyB5b3UgbWluZCBleHBsYWluaW5nIHdoeSBpdCdzIG1vcmUgZmxleGlibGU/DQo+ID4+DQo+
ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gQmFvbHUNCj4gPiBGb3IgZXhhbXBsZSwgYW4gdW5rbm93
biBkZXZpY2UgaGFzIGEgbm9ybWFsIFBDSSBoZWFkZXIgYW5kIGJyaWRnZSBzY29wZQ0KPiBhbmQg
YSBjbGFzcyBvZiBQQ0lfQ0xBU1NfQlJJREdFX1BDSS4NCj4gPiBUaGVzZSBkZXZpY2VzIGRvIGhh
dmUgYSBjbGFzcyBvZiBQQ0lfQkFTRV9DTEFTU19CUklER0UgaW4gY29tbW9uLg0KPiANCj4gVGhp
cyBpcyBub3QgYSBjb21tb24gY2FzZS4gSXQncyBvbmx5IGZvciBkZXZpY2VzIG9uIHRoZSBtYXJr
ZXRpbmcgYW5kIGhhcmQgZm9yDQo+IHRoZSBWVC1kIHVzZXJzIHRvIGdldCBpdCBmaXhlZCBpbiB0
aGUgT0VNIGZpcm13YXJlLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBCYW9sdQ0KDQpHb3QgaXQu
IFRoZW4gSSBhbSBPSyB3aXRoIHRoaXMgcGF0Y2guIEkgaGF2ZSB0ZXN0ZWQgaXQgeWVzdGVyZGF5
LiBJdCBkb2VzIHdvcmsgZm9yIG1lLiANClRoYW5rcy4NCg0KSmltDQo=
