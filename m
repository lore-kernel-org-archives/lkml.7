Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A12C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9752084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfHNHdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:33:31 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53337 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfHNHdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:33:31 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7E7XOR1013132, This message is accepted by code: ctaloc0852
Received: from RS-CAS01.realsil.com.cn (rsl1.realsil.com.cn[172.29.17.2](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7E7XOR1013132
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 14 Aug 2019 15:33:24 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS01.realsil.com.cn
 ([::1]) with mapi id 14.03.0439.000; Wed, 14 Aug 2019 15:33:20 +0800
From:   =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogYnR1c2I6IEZpeCBzdXNw?= =?utf-8?Q?end_issue_for_Realtek_devices?=
Thread-Topic: [PATCH v2] Bluetooth: btusb: Fix suspend issue for Realtek
 devices
Thread-Index: AQHVSSoXcj83mYj970uYtopmxf680qb3PuqAgAMTiBA=
Date:   Wed, 14 Aug 2019 07:33:20 +0000
Message-ID: <0551C926975A174EA8972327741C7889EE81189A@RS-MBS01.realsil.com.cn>
References: <20190802120217.GA8712@toshiba>
 <A83A0A38-8AC8-4662-BBC1-3B48B707E97B@holtmann.org>
In-Reply-To: <A83A0A38-8AC8-4662-BBC1-3B48B707E97B@holtmann.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.36.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY2VsLA0KT2theSwgSSB3aWxsIHNlbmQgYSB2ZXJzaW9uIGZvciBibHVldG9vdGgtbmV4
dC4NCg0KVGhhbmtzLA0KQlJzLg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIEJsdWV0b290
aDogYnR1c2I6IEZpeCBzdXNwZW5kIGlzc3VlIGZvciBSZWFsdGVrIGRldmljZXMNCj4gDQo+IEhp
IEFsZXgsDQo+IA0KPiA+IEZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIGNvbnRyb2xsZXIsIGdsb2Jh
bCBzdXNwZW5kIG1lYW5zIHRoZXJlIGlzIG5vDQo+ID4gU0VUX0ZFQVRVUkUgKERFVklDRV9SRU1P
VEVfV0FLRVVQKSBhbmQgY29udHJvbGxlciB3b3VsZCBkcm9wIHRoZQ0KPiA+IGZpcm13YXJlLiBJ
dCB3b3VsZCBjb25zdW1lIGxlc3MgcG93ZXIuIFNvIHdlIHNob3VsZCBub3Qgc2VuZCB0aGlzIGtp
bmQNCj4gPiBvZiBTRVRfRkVBVFVSRSB3aGVuIGhvc3QgZ29lcyB0byBzdXNwZW5kIHN0YXRlLg0K
PiA+IE90aGVyd2lzZSwgd2hlbiBtYWtpbmcgZGV2aWNlIGVudGVyIHNlbGVjdGl2ZSBzdXNwZW5k
LCBob3N0IHNob3VsZCBzZW5kDQo+ID4gU0VUX0ZFQVRVUkUgdG8gbWFrZSBzdXJlIHRoZSBmaXJt
d2FyZSByZW1haW5zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBMdSA8YWxleF9sdUBy
ZWFsc2lsLmNvbS5jbj4NCj4gPiAtLS0NCj4gPiBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIHwg
MzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+IDEgZmlsZSBjaGFuZ2Vk
LCAzMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gdGhpcyBvbmUgZG9lc27i
gJl0IGFwcGx5IGNsZWFubHkgdG8gYmx1ZXRvb3RoLW5leHQuIENhbiB5b3UgcGxlYXNlIHNlbmQg
YQ0KPiB2ZXJzaW9uIHRoYXQgZG9lcy4NCj4gDQo+IFJlZ2FyZHMNCj4gDQo+IE1hcmNlbA0KPiAN
Cj4gDQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50
aW5nIHRoaXMgZS1tYWlsLg0K
