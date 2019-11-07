Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B11C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6272087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfKGLKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:10:10 -0500
Received: from mx21.baidu.com ([220.181.3.85]:56558 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727707AbfKGLKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:10:09 -0500
Received: from BC-Mail-Ex31.internal.baidu.com (unknown [172.31.51.25])
        by Forcepoint Email with ESMTPS id EFF444C6A6F82;
        Thu,  7 Nov 2019 18:53:48 +0800 (CST)
Received: from BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) by
 BC-Mail-Ex31.internal.baidu.com (172.31.51.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 7 Nov 2019 18:53:50 +0800
Received: from BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) by
 BJHW-Mail-Ex13.internal.baidu.com ([100.100.100.36]) with mapi id
 15.01.1713.004; Thu, 7 Nov 2019 18:53:50 +0800
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
Thread-Index: AQHVhIbsJWHFXEYJak262w7TdcNcAad/qiDw
Date:   Thu, 7 Nov 2019 10:53:50 +0000
Message-ID: <2142496f954e4f688056c8cc347369a8@baidu.com>
References: <1571121247-19392-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1571121247-19392-1-git-send-email-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.4]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZyANCg0KVGhhbmtzDQoNCi1MaQ0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6
IGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcNCj4gW21haWx0bzpsaW51eC1rZXJu
ZWwtb3duZXJAdmdlci5rZXJuZWwub3JnXSC0+rHtIExpIFJvbmdRaW5nDQo+ILeiy83KsbzkOiAy
MDE5xOoxMNTCMTXI1SAxNDozNA0KPiDK1bz+yMs6IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7
IHNlcmdleS5zZW5vemhhdHNreS53b3JrQGdtYWlsLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOyBLYW4ubGlhbmdAaW50ZWwuY29tDQo+INb3
zOI6IFtQQVRDSF1bdjJdIHdhdGNoZG9nL2hhcmRsb2NrdXA6IHJlYXNzaWduIGxhc3RfdGltZXN0
YW1wIHdoZW4NCj4gZW5hYmxlIG5taSBldmVudA0KPiANCj4gbGFzdF90aW1lc3RhbXAgaXMgbm90
IGluaXRpYWxpemVkIGFuZCBpcyB6ZXJvIGFmdGVyIGJvb3QsIG9yIHN0b3AgdG8gZm9yd2FyZCB3
aGVuDQo+IG5taSB3YXRjaGRvZyBpcyBkaXNhYmxlZDsgYW5kIGZhbHNlIHBvc2l0aXZlcyBzdGls
bCBpcyBwb3NzaWJsZSB3aGVuIHJlc3RhcnQgTk1JDQo+IHRpbWVyIGFmdGVyIHN0b3BwaW5nIDEy
MCBzZWNvbmRzDQo+IA0KPiBzbyByZWFzc2lnbiBsYXN0X3RpbWVzdGFtcCBhbHdheXMgd2hlbiBl
bmFibGUgbm1pIGV2ZW50DQo+IA0KPiBGaXhlczogN2VkYWViNjg0MWRmICgia2VybmVsL3dhdGNo
ZG9nOiBQcmV2ZW50IGZhbHNlIHBvc2l0aXZlcyB3aXRoIHR1cmJvDQo+IG1vZGVzIikNCj4gU2ln
bmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBaaGFuZyBZdSA8emhhbmd5dTMxQGJhaWR1LmNvbT4NCj4gLS0tDQo+IA0KPiB2MS0t
PnYyOiBtYWtlIGl0IGJlIGFibGUgdG8gYmUgY29tcGlsZWQgb24gbm8NCj4gdjEtLT5DT05GSUdf
SEFSRExPQ0tVUF9DSEVDS19USU1FU1RBTVAgcGxhdGZvcm0NCj4gDQo+IGtlcm5lbC93YXRjaGRv
Z19obGQuYyB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvd2F0
Y2hkb2dfaGxkLmMgYi9rZXJuZWwvd2F0Y2hkb2dfaGxkLmMgaW5kZXgNCj4gMjQ3YmYwYjE1ODJj
Li5mMTRkMTgyODAzODcgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC93YXRjaGRvZ19obGQuYw0KPiAr
KysgYi9rZXJuZWwvd2F0Y2hkb2dfaGxkLmMNCj4gQEAgLTkxLDExICs5MSwyNCBAQCBzdGF0aWMg
Ym9vbCB3YXRjaGRvZ19jaGVja190aW1lc3RhbXAodm9pZCkNCj4gIAlfX3RoaXNfY3B1X3dyaXRl
KGxhc3RfdGltZXN0YW1wLCBub3cpOw0KPiAgCXJldHVybiB0cnVlOw0KPiAgfQ0KPiArDQo+ICtz
dGF0aWMgdm9pZCB3YXRjaGRvZ190b3VjaF90aW1lc3RhbXAoaW50IGNwdSkgew0KPiArDQo+ICsJ
a3RpbWVfdCBub3cgPSBrdGltZV9nZXRfbW9ub19mYXN0X25zKCk7DQo+ICsNCj4gKwlwZXJfY3B1
KGxhc3RfdGltZXN0YW1wLCBjcHUpID0gbm93Ow0KPiArfQ0KPiAgI2Vsc2UNCj4gIHN0YXRpYyBp
bmxpbmUgYm9vbCB3YXRjaGRvZ19jaGVja190aW1lc3RhbXAodm9pZCkgIHsNCj4gIAlyZXR1cm4g
dHJ1ZTsNCj4gIH0NCj4gKw0KPiArc3RhdGljIHZvaWQgd2F0Y2hkb2dfdG91Y2hfdGltZXN0YW1w
KGludCBjcHUpIHsNCj4gKw0KPiArfQ0KPiAgI2VuZGlmDQo+IA0KPiAgc3RhdGljIHN0cnVjdCBw
ZXJmX2V2ZW50X2F0dHIgd2RfaHdfYXR0ciA9IHsgQEAgLTE5Niw2ICsyMDksNyBAQCB2b2lkDQo+
IGhhcmRsb2NrdXBfZGV0ZWN0b3JfcGVyZl9lbmFibGUodm9pZCkNCj4gIAlpZiAoIWF0b21pY19m
ZXRjaF9pbmMoJndhdGNoZG9nX2NwdXMpKQ0KPiAgCQlwcl9pbmZvKCJFbmFibGVkLiBQZXJtYW5l
bnRseSBjb25zdW1lcyBvbmUgaHctUE1VIGNvdW50ZXIuXG4iKTsNCj4gDQo+ICsJd2F0Y2hkb2df
dG91Y2hfdGltZXN0YW1wKHNtcF9wcm9jZXNzb3JfaWQoKSk7DQo+ICAJcGVyZl9ldmVudF9lbmFi
bGUodGhpc19jcHVfcmVhZCh3YXRjaGRvZ19ldikpOw0KPiAgfQ0KPiANCj4gQEAgLTI3NCw4ICsy
ODgsMTAgQEAgdm9pZCBfX2luaXQgaGFyZGxvY2t1cF9kZXRlY3Rvcl9wZXJmX3Jlc3RhcnQodm9p
ZCkNCj4gIAlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KPiAgCQlzdHJ1Y3QgcGVyZl9ldmVu
dCAqZXZlbnQgPSBwZXJfY3B1KHdhdGNoZG9nX2V2LCBjcHUpOw0KPiANCj4gLQkJaWYgKGV2ZW50
KQ0KPiArCQlpZiAoZXZlbnQpIHsNCj4gKwkJCXdhdGNoZG9nX3RvdWNoX3RpbWVzdGFtcChjcHUp
Ow0KPiAgCQkJcGVyZl9ldmVudF9lbmFibGUoZXZlbnQpOw0KPiArCQl9DQo+ICAJfQ0KPiAgfQ0K
PiANCj4gLS0NCj4gMi4xNi4yDQoNCg==
