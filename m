Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949AFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68005206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfLWH7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:59:01 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47846 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLWH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:59:00 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBN7wXfO018451, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBN7wXfO018451
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 23 Dec 2019 15:58:33 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 23 Dec 2019 15:58:33 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 23 Dec 2019 15:58:32 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::a917:b20f:da75:59e0]) by
 RTEXMB01.realtek.com.tw ([fe80::a917:b20f:da75:59e0%6]) with mapi id
 15.01.1779.005; Mon, 23 Dec 2019 15:58:32 +0800
From:   =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
CC:     Oder Chiou <oder_chiou@realtek.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        "yuhsuan@chromium.org" <yuhsuan@chromium.org>,
        =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>,
        "Flove(HsinFu)" <flove@realtek.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: rt5682: Add option to select pulse IRQ in jack detect
Thread-Topic: [alsa-devel] [PATCH] ASoC: rt5682: Add option to select pulse
 IRQ in jack detect
Thread-Index: AQHVtvzRDBA5N3hAWkCQ7XtKRrDDPKfHWn6w
Date:   Mon, 23 Dec 2019 07:58:32 +0000
Message-ID: <55cbcef1d09e43e0aac057b680c25e17@realtek.com>
References: <20191220061220.229679-1-akshu.agrawal@amd.com>
In-Reply-To: <20191220061220.229679-1-akshu.agrawal@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.105]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbYWxzYS1kZXZlbF0gW1BBVENIXSBBU29DOiBydDU2ODI6IEFkZCBvcHRpb24g
dG8gc2VsZWN0IHB1bHNlIElSUSBpbg0KPiBqYWNrIGRldGVjdA0KPiANCj4gU29tZSBTb0MgbmVl
ZCB0byBzZXQgSVJRIHR5cGUgYXMgcHVsc2UgYWxvbmcgd2l0aCBvdGhlciBKRDEgb3B0aW9ucy4N
Cg0KQ291bGQgeW91IGNvbmZpZ3VyZSBHUElPIElSUSBieSBlZGdlIHRyaWdnZXIoYm90aCByaXNp
bmcvZmFsbGluZykgYW5kIHRyeSBhZ2Fpbj8NCkJUVywgdGhlIG1vZGlmaWNhdGlvbiBkb2Vzbid0
IG1ha2Ugc2Vuc2UgdG8gbmFtZSBKRDIuDQoNCj4gU2lnbmVkLW9mZi1ieTogQWtzaHUgQWdyYXdh
bCA8YWtzaHUuYWdyYXdhbEBhbWQuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvc291bmQvcnQ1Njgy
LmggICAgfCAxICsNCj4gIHNvdW5kL3NvYy9jb2RlY3MvcnQ1NjgyLmMgfCAzICsrKw0KPiAgc291
bmQvc29jL2NvZGVjcy9ydDU2ODIuaCB8IDIgKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zb3VuZC9ydDU2ODIuaCBiL2lu
Y2x1ZGUvc291bmQvcnQ1NjgyLmgNCj4gaW5kZXggYmMyYzMxNzM0ZGYxLi42NGNmYTc3ZWM5ZWUg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvc291bmQvcnQ1NjgyLmgNCj4gKysrIGIvaW5jbHVkZS9z
b3VuZC9ydDU2ODIuaA0KPiBAQCAtMjIsNiArMjIsNyBAQCBlbnVtIHJ0NTY4Ml9kbWljMV9jbGtf
cGluIHsNCj4gIGVudW0gcnQ1NjgyX2pkX3NyYyB7DQo+ICAJUlQ1NjgyX0pEX05VTEwsDQo+ICAJ
UlQ1NjgyX0pEMSwNCj4gKwlSVDU2ODJfSkQyLA0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3QgcnQ1Njgy
X3BsYXRmb3JtX2RhdGEgew0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9ydDU2ODIu
YyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQ1NjgyLmMNCj4gaW5kZXggYWU2ZjYxMjFiYzFiLi41MTM1
ZDc3NTczNjEgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvcnQ1NjgyLmMNCj4gKysr
IGIvc291bmQvc29jL2NvZGVjcy9ydDU2ODIuYw0KPiBAQCAtMTAwOSw2ICsxMDA5LDkgQEAgc3Rh
dGljIGludCBydDU2ODJfc2V0X2phY2tfZGV0ZWN0KHN0cnVjdA0KPiBzbmRfc29jX2NvbXBvbmVu
dCAqY29tcG9uZW50LA0KPiAgCX0NCj4gDQo+ICAJc3dpdGNoIChydDU2ODItPnBkYXRhLmpkX3Ny
Yykgew0KPiArCWNhc2UgUlQ1NjgyX0pEMjoNCj4gKwkJcmVnbWFwX3VwZGF0ZV9iaXRzKHJ0NTY4
Mi0+cmVnbWFwLCBSVDU2ODJfSVJRX0NUUkxfMiwNCj4gKwkJCVJUNTY4Ml9KRDFfUFVMU0VfTUFT
SywgUlQ1NjgyX0pEMV9QVUxTRV9FTik7DQo+ICAJY2FzZSBSVDU2ODJfSkQxOg0KPiAgCQlzbmRf
c29jX2NvbXBvbmVudF91cGRhdGVfYml0cyhjb21wb25lbnQsIFJUNTY4Ml9DQkpfQ1RSTF8yLA0K
PiAgCQkJUlQ1NjgyX0VYVF9KRF9TUkMsIFJUNTY4Ml9FWFRfSkRfU1JDX01BTlVBTCk7DQo+IGRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3J0NTY4Mi5oIGIvc291bmQvc29jL2NvZGVjcy9y
dDU2ODIuaA0KPiBpbmRleCAxOGZhYWEyYTQ5YTAuLjQzNGIxYzk3NzhiMiAxMDA2NDQNCj4gLS0t
IGEvc291bmQvc29jL2NvZGVjcy9ydDU2ODIuaA0KPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3J0
NTY4Mi5oDQo+IEBAIC0xMDkxLDYgKzEwOTEsOCBAQA0KPiAgI2RlZmluZSBSVDU2ODJfSkQxX1BP
TF9NQVNLCQkJKDB4MSA8PCAxMykNCj4gICNkZWZpbmUgUlQ1NjgyX0pEMV9QT0xfTk9SCQkJKDB4
MCA8PCAxMykNCj4gICNkZWZpbmUgUlQ1NjgyX0pEMV9QT0xfSU5WCQkJKDB4MSA8PCAxMykNCj4g
KyNkZWZpbmUgUlQ1NjgyX0pEMV9QVUxTRV9NQVNLCQkJKDB4MSA8PCAxMCkNCj4gKyNkZWZpbmUg
UlQ1NjgyX0pEMV9QVUxTRV9FTgkJCSgweDEgPDwgMTApDQo+IA0KPiAgLyogSVJRIENvbnRyb2wg
MyAoMHgwMGI4KSAqLw0KPiAgI2RlZmluZSBSVDU2ODJfSUxfSVJRX01BU0sJCQkoMHgxIDw8IDcp
DQo+IC0tDQo+IDIuMTcuMQ0KPiANCg==
