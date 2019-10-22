Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C39CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA19621872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbfJVLbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:31:05 -0400
Received: from mx21.baidu.com ([220.181.3.85]:51821 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387768AbfJVLbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:31:05 -0400
X-Greylist: delayed 1859 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2019 07:31:03 EDT
Received: from BJHW-Mail-Ex15.internal.baidu.com (unknown [10.127.64.38])
        by Forcepoint Email with ESMTPS id C2BA71A427E44;
        Tue, 22 Oct 2019 18:43:38 +0800 (CST)
Received: from BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) by
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 22 Oct 2019 18:43:40 +0800
Received: from BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) by
 BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) with mapi id
 15.01.1713.004; Tue, 22 Oct 2019 18:43:40 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Kan.liang@intel.com" <Kan.liang@intel.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVt2Ml0gd2F0Y2hkb2cvaGFyZGxvY2t1cDogcmVhc3Np?=
 =?gb2312?Q?gn_last=5Ftimestamp_when_enable_nmi_event?=
Thread-Topic: [PATCH][v2] watchdog/hardlockup: reassign last_timestamp when
 enable nmi event
Thread-Index: AQHVhIbsJWHFXEYJak262w7TdcNcAadmgfVA
Date:   Tue, 22 Oct 2019 10:43:40 +0000
Message-ID: <076b0c0a3e284e5e8821fc6db161f857@baidu.com>
References: <1571121247-19392-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1571121247-19392-1-git-send-email-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.33]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQpUaGFua3MNCg0KLUxpDQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7Iyzog
bGludXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LWtlcm5l
bC1vd25lckB2Z2VyLmtlcm5lbC5vcmddILT6se0gTGkgUm9uZ1FpbmcNCj4gt6LLzcqxvOQ6IDIw
MTnE6jEw1MIxNcjVIDE0OjM0DQo+IMrVvP7IyzogYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsg
c2VyZ2V5LnNlbm96aGF0c2t5LndvcmtAZ21haWwuY29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7IEthbi5saWFuZ0BpbnRlbC5jb20NCj4g1vfM
4jogW1BBVENIXVt2Ml0gd2F0Y2hkb2cvaGFyZGxvY2t1cDogcmVhc3NpZ24gbGFzdF90aW1lc3Rh
bXAgd2hlbg0KPiBlbmFibGUgbm1pIGV2ZW50DQo+IA0KPiBsYXN0X3RpbWVzdGFtcCBpcyBub3Qg
aW5pdGlhbGl6ZWQgYW5kIGlzIHplcm8gYWZ0ZXIgYm9vdCwgb3Igc3RvcCB0byBmb3J3YXJkIHdo
ZW4NCj4gbm1pIHdhdGNoZG9nIGlzIGRpc2FibGVkOyBhbmQgZmFsc2UgcG9zaXRpdmVzIHN0aWxs
IGlzIHBvc3NpYmxlIHdoZW4gcmVzdGFydCBOTUkNCj4gdGltZXIgYWZ0ZXIgc3RvcHBpbmcgMTIw
IHNlY29uZHMNCj4gDQo+IHNvIHJlYXNzaWduIGxhc3RfdGltZXN0YW1wIGFsd2F5cyB3aGVuIGVu
YWJsZSBubWkgZXZlbnQNCj4gDQo+IEZpeGVzOiA3ZWRhZWI2ODQxZGYgKCJrZXJuZWwvd2F0Y2hk
b2c6IFByZXZlbnQgZmFsc2UgcG9zaXRpdmVzIHdpdGggdHVyYm8NCj4gbW9kZXMiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFpoYW5nIFl1IDx6aGFuZ3l1MzFAYmFpZHUuY29tPg0KPiAtLS0NCj4gDQo+IHYxLS0+
djI6IG1ha2UgaXQgYmUgYWJsZSB0byBiZSBjb21waWxlZCBvbiBubw0KPiB2MS0tPkNPTkZJR19I
QVJETE9DS1VQX0NIRUNLX1RJTUVTVEFNUCBwbGF0Zm9ybQ0KPiANCj4ga2VybmVsL3dhdGNoZG9n
X2hsZC5jIHwgMTggKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC93YXRj
aGRvZ19obGQuYyBiL2tlcm5lbC93YXRjaGRvZ19obGQuYyBpbmRleA0KPiAyNDdiZjBiMTU4MmMu
LmYxNGQxODI4MDM4NyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3dhdGNoZG9nX2hsZC5jDQo+ICsr
KyBiL2tlcm5lbC93YXRjaGRvZ19obGQuYw0KPiBAQCAtOTEsMTEgKzkxLDI0IEBAIHN0YXRpYyBi
b29sIHdhdGNoZG9nX2NoZWNrX3RpbWVzdGFtcCh2b2lkKQ0KPiAgCV9fdGhpc19jcHVfd3JpdGUo
bGFzdF90aW1lc3RhbXAsIG5vdyk7DQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICsNCj4gK3N0
YXRpYyB2b2lkIHdhdGNoZG9nX3RvdWNoX3RpbWVzdGFtcChpbnQgY3B1KSB7DQo+ICsNCj4gKwlr
dGltZV90IG5vdyA9IGt0aW1lX2dldF9tb25vX2Zhc3RfbnMoKTsNCj4gKw0KPiArCXBlcl9jcHUo
bGFzdF90aW1lc3RhbXAsIGNwdSkgPSBub3c7DQo+ICt9DQo+ICAjZWxzZQ0KPiAgc3RhdGljIGlu
bGluZSBib29sIHdhdGNoZG9nX2NoZWNrX3RpbWVzdGFtcCh2b2lkKSAgew0KPiAgCXJldHVybiB0
cnVlOw0KPiAgfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB3YXRjaGRvZ190b3VjaF90aW1lc3RhbXAo
aW50IGNwdSkgew0KPiArDQo+ICt9DQo+ICAjZW5kaWYNCj4gDQo+ICBzdGF0aWMgc3RydWN0IHBl
cmZfZXZlbnRfYXR0ciB3ZF9od19hdHRyID0geyBAQCAtMTk2LDYgKzIwOSw3IEBAIHZvaWQNCj4g
aGFyZGxvY2t1cF9kZXRlY3Rvcl9wZXJmX2VuYWJsZSh2b2lkKQ0KPiAgCWlmICghYXRvbWljX2Zl
dGNoX2luYygmd2F0Y2hkb2dfY3B1cykpDQo+ICAJCXByX2luZm8oIkVuYWJsZWQuIFBlcm1hbmVu
dGx5IGNvbnN1bWVzIG9uZSBody1QTVUgY291bnRlci5cbiIpOw0KPiANCj4gKwl3YXRjaGRvZ190
b3VjaF90aW1lc3RhbXAoc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCj4gIAlwZXJmX2V2ZW50X2VuYWJs
ZSh0aGlzX2NwdV9yZWFkKHdhdGNoZG9nX2V2KSk7DQo+ICB9DQo+IA0KPiBAQCAtMjc0LDggKzI4
OCwxMCBAQCB2b2lkIF9faW5pdCBoYXJkbG9ja3VwX2RldGVjdG9yX3BlcmZfcmVzdGFydCh2b2lk
KQ0KPiAgCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7DQo+ICAJCXN0cnVjdCBwZXJmX2V2ZW50
ICpldmVudCA9IHBlcl9jcHUod2F0Y2hkb2dfZXYsIGNwdSk7DQo+IA0KPiAtCQlpZiAoZXZlbnQp
DQo+ICsJCWlmIChldmVudCkgew0KPiArCQkJd2F0Y2hkb2dfdG91Y2hfdGltZXN0YW1wKGNwdSk7
DQo+ICAJCQlwZXJmX2V2ZW50X2VuYWJsZShldmVudCk7DQo+ICsJCX0NCj4gIAl9DQo+ICB9DQo+
IA0KPiAtLQ0KPiAyLjE2LjINCg0K
