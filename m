Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A27BC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19588205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfHNIEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:04:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55153 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:04:08 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7E83toI020012, This message is accepted by code: ctaloc0852
Received: from RS-CAS01.realsil.com.cn (RSFS1.realsil.com.cn[172.29.17.2](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7E83toI020012
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 14 Aug 2019 16:03:56 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS01.realsil.com.cn
 ([::1]) with mapi id 14.03.0439.000; Wed, 14 Aug 2019 16:03:55 +0800
From:   =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Max Chou" <max.chou@realtek.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogYnR1c2I6IEZpeCBzdXNw?= =?utf-8?Q?end_issue_for_Realtek_devices?=
Thread-Topic: [PATCH v2] Bluetooth: btusb: Fix suspend issue for Realtek
 devices
Thread-Index: AQHVSSoXcj83mYj970uYtopmxf680qb3PuqAgABXdACAArxqUA==
Date:   Wed, 14 Aug 2019 08:03:54 +0000
Message-ID: <0551C926975A174EA8972327741C7889EE81192D@RS-MBS01.realsil.com.cn>
References: <20190802120217.GA8712@toshiba>
 <A83A0A38-8AC8-4662-BBC1-3B48B707E97B@holtmann.org>
 <CAKdAkRQP8DBbpdfA6yFZK6THw5eVUbdr+QnVQMkm-mLyEp5brg@mail.gmail.com>
In-Reply-To: <CAKdAkRQP8DBbpdfA6yFZK6THw5eVUbdr+QnVQMkm-mLyEp5brg@mail.gmail.com>
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

SGkgRG1pdHJ5LA0KSXQncyBvbmx5IGZvciBSZWFsdGVrIGRldmljZXMuDQpJZiBSZWFsdGVrIGRl
dmljZSBmaXJtd2FyZSByZWNlaXZlcyBTRVRfRkVBVFVSRShkZXZpY2UgcmVtb3RlIHdha2V1cCkg
dXNiIGNtZCBkdXJpbmcgdXNiIGlzIHN1c3BlbmRpbmcsIGl0IHdpbGwgcmVtYWlucyBpbiBzdXNw
ZW5kIHN0YXRlLg0KT3RoZXJ3aXNlLCBmaXJtd2FyZSB3aWxsIGRyb3AgaXRzZWxmIGFuZCBkZXZp
Y2Ugd2lsbCBjb25zdW1lIGxlc3MgcG93ZXIuIEJ1dCB3aGVuIGhvc3QgcmVzdW1lcywgaXQgbmVl
ZHMgdG8gcmVsb2FkIGZpcm13YXJlLiBJdCBjYW4gYmUgYWNjb21wbGlzaGVkIGJ5IHNldHRpbmcg
dXNiIHJlc2V0IHJlc3VtZSBmb3IgZGV2aWNlLg0KDQpUaGFua3MsDQpCUnMuDQoNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2Ml0gQmx1ZXRvb3RoOiBidHVzYjogRml4IHN1c3BlbmQgaXNzdWUgZm9y
IFJlYWx0ZWsgZGV2aWNlcw0KPiANCj4gT24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgOTozNiBBTSBN
YXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
SGkgQWxleCwNCj4gPg0KPiA+ID4gRnJvbSB0aGUgcGVyc3BlY3RpdmUgb2YgY29udHJvbGxlciwg
Z2xvYmFsIHN1c3BlbmQgbWVhbnMgdGhlcmUgaXMgbm8NCj4gPiA+IFNFVF9GRUFUVVJFIChERVZJ
Q0VfUkVNT1RFX1dBS0VVUCkgYW5kIGNvbnRyb2xsZXIgd291bGQgZHJvcA0KPiB0aGUNCj4gPiA+
IGZpcm13YXJlLiBJdCB3b3VsZCBjb25zdW1lIGxlc3MgcG93ZXIuIFNvIHdlIHNob3VsZCBub3Qg
c2VuZCB0aGlzIGtpbmQNCj4gPiA+IG9mIFNFVF9GRUFUVVJFIHdoZW4gaG9zdCBnb2VzIHRvIHN1
c3BlbmQgc3RhdGUuDQo+ID4gPiBPdGhlcndpc2UsIHdoZW4gbWFraW5nIGRldmljZSBlbnRlciBz
ZWxlY3RpdmUgc3VzcGVuZCwgaG9zdCBzaG91bGQNCj4gc2VuZA0KPiA+ID4gU0VUX0ZFQVRVUkUg
dG8gbWFrZSBzdXJlIHRoZSBmaXJtd2FyZSByZW1haW5zLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggTHUgPGFsZXhfbHVAcmVhbHNpbC5jb20uY24+DQo+ID4gPiAtLS0NCj4gPiA+
IGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4gLQ0KPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiB0aGlzIG9uZSBkb2VzbuKAmXQgYXBwbHkgY2xlYW5seSB0
byBibHVldG9vdGgtbmV4dC4gQ2FuIHlvdSBwbGVhc2Ugc2VuZCBhDQo+IHZlcnNpb24gdGhhdCBk
b2VzLg0KPiANCj4gSXMgdGhpcyBhIGNoaXAgaXNzdWUgb3Igc3lzdGVtIGlzc3VlPyBJLmUuIGlm
IGluIHNvbWUgc3lzdGVtIEJUDQo+IGNvbnRyb2xsZXIgaXMgd2lyZWQgc28gdGhhdCBpdCBsb3Nl
cyBwb3dlciBvdmVyIHN5c3RlbSBzdXNwZW5kLCB0aGlzDQo+IGlzIHF1aXRlIGRpZmZlcmVudCBm
b3JtIGNoaXAgaXRzZWxmIGxvc2luZyBmaXJtd2FyZSBpbiBjZXJ0YWluDQo+IHNpdHVhdGlvbnMs
IGFuZCB0aGlzIHNtZWxscyBsaWtlIGEgc3lzdGVtIGlzc3VlIGFuZCB0aHVzIG5lZWRzIHRvIGJl
DQo+IGFkZHJlc3NlZCBvbiBzeXN0ZW0gbGV2ZWwuDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAtLQ0K
PiBEbWl0cnkNCj4gDQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVm
b3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
