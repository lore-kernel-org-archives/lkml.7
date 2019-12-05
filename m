Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF44EC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B347205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfLEKTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:19:43 -0500
Received: from mx20.baidu.com ([111.202.115.85]:33047 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729222AbfLEKTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:19:42 -0500
Received: from BJHW-Mail-Ex16.internal.baidu.com (unknown [10.127.64.39])
        by Forcepoint Email with ESMTPS id E24DFD9791CE1;
        Thu,  5 Dec 2019 18:19:36 +0800 (CST)
Received: from BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) by
 BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 5 Dec 2019 18:19:37 +0800
Received: from BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) by
 BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) with mapi id
 15.01.1713.004; Thu, 5 Dec 2019 18:19:37 +0800
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
Thread-Index: AQHVhIbsJWHFXEYJak262w7TdcNcAad/qiDwgCv3FSA=
Date:   Thu, 5 Dec 2019 10:19:36 +0000
Message-ID: <f22b9fa4a2b74bdfa4fd2cb0d26a313a@baidu.com>
References: <1571121247-19392-1-git-send-email-lirongqing@baidu.com>
 <2142496f954e4f688056c8cc347369a8@baidu.com>
In-Reply-To: <2142496f954e4f688056c8cc347369a8@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.17]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex16_2019-12-05 18:19:37:652
x-baidu-bdmsfe-viruscheck: BJHW-Mail-Ex16_GRAY_Inside_WithoutAtta_2019-12-05
 18:19:37:621
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQp0aGFua3MNCg0KLUxpDQoNCg0KPj4gW1BBVENIXVt2Ml0gd2F0Y2hkb2cvaGFyZGxv
Y2t1cDogcmVhc3NpZ24gbGFzdF90aW1lc3RhbXAgd2hlbg0KPiA+IGVuYWJsZSBubWkgZXZlbnQN
Cj4gPg0KPiA+IGxhc3RfdGltZXN0YW1wIGlzIG5vdCBpbml0aWFsaXplZCBhbmQgaXMgemVybyBh
ZnRlciBib290LCBvciBzdG9wIHRvDQo+ID4gZm9yd2FyZCB3aGVuIG5taSB3YXRjaGRvZyBpcyBk
aXNhYmxlZDsgYW5kIGZhbHNlIHBvc2l0aXZlcyBzdGlsbCBpcw0KPiA+IHBvc3NpYmxlIHdoZW4g
cmVzdGFydCBOTUkgdGltZXIgYWZ0ZXIgc3RvcHBpbmcgMTIwIHNlY29uZHMNCj4gPg0KPiA+IHNv
IHJlYXNzaWduIGxhc3RfdGltZXN0YW1wIGFsd2F5cyB3aGVuIGVuYWJsZSBubWkgZXZlbnQNCj4g
Pg0KPiA+IEZpeGVzOiA3ZWRhZWI2ODQxZGYgKCJrZXJuZWwvd2F0Y2hkb2c6IFByZXZlbnQgZmFs
c2UgcG9zaXRpdmVzIHdpdGgNCj4gPiB0dXJibw0KPiA+IG1vZGVzIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogWmhhbmcgWXUgPHpoYW5neXUzMUBiYWlkdS5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiB2MS0t
PnYyOiBtYWtlIGl0IGJlIGFibGUgdG8gYmUgY29tcGlsZWQgb24gbm8NCj4gPiB2MS0tPkNPTkZJ
R19IQVJETE9DS1VQX0NIRUNLX1RJTUVTVEFNUCBwbGF0Zm9ybQ0KPiA+DQo+ID4ga2VybmVsL3dh
dGNoZG9nX2hsZC5jIHwgMTggKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
a2VybmVsL3dhdGNoZG9nX2hsZC5jIGIva2VybmVsL3dhdGNoZG9nX2hsZC5jIGluZGV4DQo+ID4g
MjQ3YmYwYjE1ODJjLi5mMTRkMTgyODAzODcgMTAwNjQ0DQo+ID4gLS0tIGEva2VybmVsL3dhdGNo
ZG9nX2hsZC5jDQo+ID4gKysrIGIva2VybmVsL3dhdGNoZG9nX2hsZC5jDQo+ID4gQEAgLTkxLDEx
ICs5MSwyNCBAQCBzdGF0aWMgYm9vbCB3YXRjaGRvZ19jaGVja190aW1lc3RhbXAodm9pZCkNCj4g
PiAgCV9fdGhpc19jcHVfd3JpdGUobGFzdF90aW1lc3RhbXAsIG5vdyk7DQo+ID4gIAlyZXR1cm4g
dHJ1ZTsNCj4gPiAgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgd2F0Y2hkb2dfdG91Y2hfdGlt
ZXN0YW1wKGludCBjcHUpIHsNCj4gPiArDQo+ID4gKwlrdGltZV90IG5vdyA9IGt0aW1lX2dldF9t
b25vX2Zhc3RfbnMoKTsNCj4gPiArDQo+ID4gKwlwZXJfY3B1KGxhc3RfdGltZXN0YW1wLCBjcHUp
ID0gbm93Ow0KPiA+ICt9DQo+ID4gICNlbHNlDQo+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbCB3YXRj
aGRvZ19jaGVja190aW1lc3RhbXAodm9pZCkgIHsNCj4gPiAgCXJldHVybiB0cnVlOw0KPiA+ICB9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB3YXRjaGRvZ190b3VjaF90aW1lc3RhbXAoaW50IGNw
dSkgew0KPiA+ICsNCj4gPiArfQ0KPiA+ICAjZW5kaWYNCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0
IHBlcmZfZXZlbnRfYXR0ciB3ZF9od19hdHRyID0geyBAQCAtMTk2LDYgKzIwOSw3IEBAIHZvaWQN
Cj4gPiBoYXJkbG9ja3VwX2RldGVjdG9yX3BlcmZfZW5hYmxlKHZvaWQpDQo+ID4gIAlpZiAoIWF0
b21pY19mZXRjaF9pbmMoJndhdGNoZG9nX2NwdXMpKQ0KPiA+ICAJCXByX2luZm8oIkVuYWJsZWQu
IFBlcm1hbmVudGx5IGNvbnN1bWVzIG9uZSBody1QTVUgY291bnRlci5cbiIpOw0KPiA+DQo+ID4g
Kwl3YXRjaGRvZ190b3VjaF90aW1lc3RhbXAoc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCj4gPiAgCXBl
cmZfZXZlbnRfZW5hYmxlKHRoaXNfY3B1X3JlYWQod2F0Y2hkb2dfZXYpKTsNCj4gPiAgfQ0KPiA+
DQo+ID4gQEAgLTI3NCw4ICsyODgsMTAgQEAgdm9pZCBfX2luaXQgaGFyZGxvY2t1cF9kZXRlY3Rv
cl9wZXJmX3Jlc3RhcnQodm9pZCkNCj4gPiAgCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7DQo+
ID4gIAkJc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50ID0gcGVyX2NwdSh3YXRjaGRvZ19ldiwgY3B1
KTsNCj4gPg0KPiA+IC0JCWlmIChldmVudCkNCj4gPiArCQlpZiAoZXZlbnQpIHsNCj4gPiArCQkJ
d2F0Y2hkb2dfdG91Y2hfdGltZXN0YW1wKGNwdSk7DQo+ID4gIAkJCXBlcmZfZXZlbnRfZW5hYmxl
KGV2ZW50KTsNCj4gPiArCQl9DQo+ID4gIAl9DQo+ID4gIH0NCj4gPg0KPiA+IC0tDQoNCj4gPiAy
LjE2LjINCg0K
