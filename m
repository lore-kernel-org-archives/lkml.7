Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E566C2D0D0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CD52063A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfLYBwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 20:52:49 -0500
Received: from mx21.baidu.com ([220.181.3.85]:43374 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfLYBwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:52:49 -0500
Received: from BJHW-Mail-Ex11.internal.baidu.com (unknown [10.127.64.34])
        by Forcepoint Email with ESMTPS id 0060560D3E4A6E54201B;
        Wed, 25 Dec 2019 09:52:40 +0800 (CST)
Received: from BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) by
 BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 25 Dec 2019 09:52:40 +0800
Received: from BC-Mail-Ex03.internal.baidu.com (172.31.51.43) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 25 Dec 2019 09:52:40 +0800
Received: from BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) by
 BC-Mail-Ex03.internal.baidu.com ([100.100.100.102]) with mapi id
 15.01.1531.010; Wed, 25 Dec 2019 09:52:40 +0800
From:   "Jim,Yan" <jimyan@baidu.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGlvbW11?=
 =?utf-8?B?L3Z0LWQ6IERvbid0IHJlamVjdCBudm1lIGhvc3QgZHVlIHRvIHNjb3BlIG1p?=
 =?utf-8?Q?smatch?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBpb21tdS92dC1kOiBE?=
 =?utf-8?Q?on't_reject_nvme_host_due_to_scope_mismatch?=
Thread-Index: AdW6BKk3WRIzqftPRCuhhluvn9v6Mv//tuqA//9dBfCAAPa3gP//eOkw
Date:   Wed, 25 Dec 2019 01:52:40 +0000
Message-ID: <062f5fd1611940b083ec34603eca94e1@baidu.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
 <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
In-Reply-To: <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.92]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex03_2019-12-25 09:52:40:801
x-baidu-bdmsfe-viruscheck: BJHW-Mail-Ex03_GRAY_Inside_WithoutAtta_2019-12-25
 09:52:40:785
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex11_2019-12-25 09:52:41:032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEx1IEJhb2x1IFtt
YWlsdG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTnlubQx
MuaciDI05pelIDE5OjI3DQo+IOaUtuS7tuS6ujogSmltLFlhbiA8amlteWFuQGJhaWR1LmNvbT47
IEplcnJ5IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+DQo+IOaKhOmAgTogaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4g5Li76aKYOiBSZTog562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBpb21tdS92dC1k
OiBEb24ndCByZWplY3QgbnZtZSBob3N0IGR1ZQ0KPiB0byBzY29wZSBtaXNtYXRjaA0KPiANCj4g
SGksDQo+IA0KPiBPbiAyMDE5LzEyLzI0IDE2OjE4LCBKaW0sWWFuIHdyb3RlOg0KPiA+Pj4+IEZv
ciBib3RoIGNhc2VzLCBhIHF1aXJrIGZsYWcgc2VlbXMgdG8gYmUgbW9yZSByZWFzb25hYmxlLCBz
byB0aGF0DQo+ID4+Pj4gdW5yZWxhdGVkIGRldmljZXMgd2lsbCBub3QgYmUgaW1wYWN0ZWQuDQo+
ID4+Pj4NCj4gPj4+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+Pj4gYmFvbHUNCj4gPj4+IEhpIEJhb2x1
LA0KPiA+Pj4gCVRoYW5rcyBmb3IgeW91ciBhZHZpY2UuIEFuZCBJIG1vZGlmeSB0aGUgcGF0Y2gg
YXMgZm9sbG93Lg0KPiA+PiBJIGp1c3QgcG9zdGVkIGEgcGF0Y2ggZm9yIGJvdGggTlRHIGFuZCBO
Vk1FIGNhc2VzLiBDYW4geW91IHBsZWFzZSB0YWtlIGENCj4gbG9vaz8NCj4gPj4gRG9lcyBpdCB3
b3JrIGZvciB5b3U/DQo+ID4+DQo+ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gYmFvbHUNCj4gPj4N
Cj4gPiBJIGhhdmUgdGVzdGVkIHlvdXIgcGF0Y2guIEl0IGRvZXMgd29yayBmb3IgbWUuIEJ1dCBJ
IHByZWZlciBteSBzZWNvbmQgdmVyc2lvbiwNCj4gaXQgaXMgbW9yZSBmbGV4aWJsZSwgYW5kIG1h
eSB1c2UgZm9yIHNpbWlsYXIgdW5rbm93biBkZXZpY2VzLg0KPiA+DQo+IA0KPiBJIGRpZG4ndCBn
ZXQgeW91ciBwb2ludC4gRG8geW91IG1pbmQgZXhwbGFpbmluZyB3aHkgaXQncyBtb3JlIGZsZXhp
YmxlPw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBCYW9sdQ0KRm9yIGV4YW1wbGUsIGFuIHVua25v
d24gZGV2aWNlIGhhcyBhIG5vcm1hbCBQQ0kgaGVhZGVyIGFuZCBicmlkZ2Ugc2NvcGUgYW5kIGEg
Y2xhc3Mgb2YgUENJX0NMQVNTX0JSSURHRV9QQ0kuIA0KVGhlc2UgZGV2aWNlcyBkbyBoYXZlIGEg
Y2xhc3Mgb2YgUENJX0JBU0VfQ0xBU1NfQlJJREdFIGluIGNvbW1vbi4NCg0KSmltDQo=
