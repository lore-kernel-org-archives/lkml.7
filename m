Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4E4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CE32071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfKVKze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:55:34 -0500
Received: from mx20.baidu.com ([111.202.115.85]:39054 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730453AbfKVKza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:55:30 -0500
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 05:55:27 EST
Received: from BC-Mail-Ex14.internal.baidu.com (unknown [172.31.51.54])
        by Forcepoint Email with ESMTPS id 5F2AC10F919DB;
        Fri, 22 Nov 2019 18:39:14 +0800 (CST)
Received: from BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) by
 BC-Mail-Ex14.internal.baidu.com (172.31.51.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Fri, 22 Nov 2019 18:39:15 +0800
Received: from BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) by
 BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) with mapi id
 15.01.1713.004; Fri, 22 Nov 2019 18:39:15 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Kan.liang@intel.com" <Kan.liang@intel.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVt2Ml0gd2F0Y2hkb2cvaGFyZGxvY2t1cDogcmVhc3Np?=
 =?gb2312?Q?gn_last=5Ftimestamp_when_enable_nmi_event?=
Thread-Topic: [PATCH][v2] watchdog/hardlockup: reassign last_timestamp when
 enable nmi event
Thread-Index: AQHVhIbsJWHFXEYJak262w7TdcNcAad/qiDwgBeO69A=
Date:   Fri, 22 Nov 2019 10:39:15 +0000
Message-ID: <bfa8ac7ce4794fca99bebcb753648de7@baidu.com>
References: <1571121247-19392-1-git-send-email-lirongqing@baidu.com>
 <2142496f954e4f688056c8cc347369a8@baidu.com>
In-Reply-To: <2142496f954e4f688056c8cc347369a8@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.14]
x-baidu-bdmsfe-datecheck: 1_BC-Mail-Ex14_2019-11-22 18:39:15:620
x-baidu-bdmsfe-viruscheck: BC-Mail-Ex14_GRAY_Inside_WithoutAtta_2019-11-22
 18:39:15:604
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQpUaGFua3MNCi1Sb25nUWluZw0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+
yMs6IExpLFJvbmdxaW5nDQo+ILeiy83KsbzkOiAyMDE5xOoxMdTCN8jVIDE4OjU0DQo+IMrVvP7I
yzogTGksUm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0
aW9uLm9yZzsNCj4gc2VyZ2V5LnNlbm96aGF0c2t5LndvcmtAZ21haWwuY29tOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IEthbi5saWFuZ0BpbnRl
bC5jb20NCj4g1vfM4jogtPC4tDogW1BBVENIXVt2Ml0gd2F0Y2hkb2cvaGFyZGxvY2t1cDogcmVh
c3NpZ24gbGFzdF90aW1lc3RhbXAgd2hlbg0KPiBlbmFibGUgbm1pIGV2ZW50DQo+IA0KPiBQaW5n
DQo+IA0KPiBUaGFua3MNCj4gDQo+IC1MaQ0KPiANCj4gPiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4g
PiC3orz+yMs6IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBbbWFpbHRv
OmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmddILT6se0gTGkgUm9uZ1FpbmcNCj4g
PiC3osvNyrG85DogMjAxOcTqMTDUwjE1yNUgMTQ6MzQNCj4gPiDK1bz+yMs6IGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc7IHNlcmdleS5zZW5vemhhdHNreS53b3JrQGdtYWlsLmNvbTsNCj4gPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7IEthbi5saWFu
Z0BpbnRlbC5jb20NCj4gPiDW98ziOiBbUEFUQ0hdW3YyXSB3YXRjaGRvZy9oYXJkbG9ja3VwOiBy
ZWFzc2lnbiBsYXN0X3RpbWVzdGFtcCB3aGVuDQo+ID4gZW5hYmxlIG5taSBldmVudA0KPiA+DQo+
ID4gbGFzdF90aW1lc3RhbXAgaXMgbm90IGluaXRpYWxpemVkIGFuZCBpcyB6ZXJvIGFmdGVyIGJv
b3QsIG9yIHN0b3AgdG8NCj4gPiBmb3J3YXJkIHdoZW4gbm1pIHdhdGNoZG9nIGlzIGRpc2FibGVk
OyBhbmQgZmFsc2UgcG9zaXRpdmVzIHN0aWxsIGlzDQo+ID4gcG9zc2libGUgd2hlbiByZXN0YXJ0
IE5NSSB0aW1lciBhZnRlciBzdG9wcGluZyAxMjAgc2Vjb25kcw0KPiA+DQo+ID4gc28gcmVhc3Np
Z24gbGFzdF90aW1lc3RhbXAgYWx3YXlzIHdoZW4gZW5hYmxlIG5taSBldmVudA0KPiA+DQo+ID4g
Rml4ZXM6IDdlZGFlYjY4NDFkZiAoImtlcm5lbC93YXRjaGRvZzogUHJldmVudCBmYWxzZSBwb3Np
dGl2ZXMgd2l0aA0KPiA+IHR1cmJvDQo+ID4gbW9kZXMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IExp
IFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFu
ZyBZdSA8emhhbmd5dTMxQGJhaWR1LmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IHYxLS0+djI6IG1h
a2UgaXQgYmUgYWJsZSB0byBiZSBjb21waWxlZCBvbiBubw0KPiA+IHYxLS0+Q09ORklHX0hBUkRM
T0NLVVBfQ0hFQ0tfVElNRVNUQU1QIHBsYXRmb3JtDQo+ID4NCj4gPiBrZXJuZWwvd2F0Y2hkb2df
aGxkLmMgfCAxOCArKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwv
d2F0Y2hkb2dfaGxkLmMgYi9rZXJuZWwvd2F0Y2hkb2dfaGxkLmMgaW5kZXgNCj4gPiAyNDdiZjBi
MTU4MmMuLmYxNGQxODI4MDM4NyAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvd2F0Y2hkb2dfaGxk
LmMNCj4gPiArKysgYi9rZXJuZWwvd2F0Y2hkb2dfaGxkLmMNCj4gPiBAQCAtOTEsMTEgKzkxLDI0
IEBAIHN0YXRpYyBib29sIHdhdGNoZG9nX2NoZWNrX3RpbWVzdGFtcCh2b2lkKQ0KPiA+ICAJX190
aGlzX2NwdV93cml0ZShsYXN0X3RpbWVzdGFtcCwgbm93KTsNCj4gPiAgCXJldHVybiB0cnVlOw0K
PiA+ICB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB3YXRjaGRvZ190b3VjaF90aW1lc3RhbXAo
aW50IGNwdSkgew0KPiA+ICsNCj4gPiArCWt0aW1lX3Qgbm93ID0ga3RpbWVfZ2V0X21vbm9fZmFz
dF9ucygpOw0KPiA+ICsNCj4gPiArCXBlcl9jcHUobGFzdF90aW1lc3RhbXAsIGNwdSkgPSBub3c7
DQo+ID4gK30NCj4gPiAgI2Vsc2UNCj4gPiAgc3RhdGljIGlubGluZSBib29sIHdhdGNoZG9nX2No
ZWNrX3RpbWVzdGFtcCh2b2lkKSAgew0KPiA+ICAJcmV0dXJuIHRydWU7DQo+ID4gIH0NCj4gPiAr
DQo+ID4gK3N0YXRpYyB2b2lkIHdhdGNoZG9nX3RvdWNoX3RpbWVzdGFtcChpbnQgY3B1KSB7DQo+
ID4gKw0KPiA+ICt9DQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgcGVyZl9l
dmVudF9hdHRyIHdkX2h3X2F0dHIgPSB7IEBAIC0xOTYsNiArMjA5LDcgQEAgdm9pZA0KPiA+IGhh
cmRsb2NrdXBfZGV0ZWN0b3JfcGVyZl9lbmFibGUodm9pZCkNCj4gPiAgCWlmICghYXRvbWljX2Zl
dGNoX2luYygmd2F0Y2hkb2dfY3B1cykpDQo+ID4gIAkJcHJfaW5mbygiRW5hYmxlZC4gUGVybWFu
ZW50bHkgY29uc3VtZXMgb25lIGh3LVBNVSBjb3VudGVyLlxuIik7DQo+ID4NCj4gPiArCXdhdGNo
ZG9nX3RvdWNoX3RpbWVzdGFtcChzbXBfcHJvY2Vzc29yX2lkKCkpOw0KPiA+ICAJcGVyZl9ldmVu
dF9lbmFibGUodGhpc19jcHVfcmVhZCh3YXRjaGRvZ19ldikpOw0KPiA+ICB9DQo+ID4NCj4gPiBA
QCAtMjc0LDggKzI4OCwxMCBAQCB2b2lkIF9faW5pdCBoYXJkbG9ja3VwX2RldGVjdG9yX3BlcmZf
cmVzdGFydCh2b2lkKQ0KPiA+ICAJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpIHsNCj4gPiAgCQlz
dHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQgPSBwZXJfY3B1KHdhdGNoZG9nX2V2LCBjcHUpOw0KPiA+
DQo+ID4gLQkJaWYgKGV2ZW50KQ0KPiA+ICsJCWlmIChldmVudCkgew0KPiA+ICsJCQl3YXRjaGRv
Z190b3VjaF90aW1lc3RhbXAoY3B1KTsNCj4gPiAgCQkJcGVyZl9ldmVudF9lbmFibGUoZXZlbnQp
Ow0KPiA+ICsJCX0NCj4gPiAgCX0NCj4gPiAgfQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjE2LjINCg0K
