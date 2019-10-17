Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB79ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4B320869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393468AbfJQJUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:20:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2431 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393097AbfJQJUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:20:18 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 7866E25CA36B01519D37;
        Thu, 17 Oct 2019 17:20:16 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 17 Oct 2019 17:20:16 +0800
Received: from DGGEMM527-MBX.china.huawei.com ([169.254.6.34]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 17:20:10 +0800
From:   huangdaode <huangdaode@hisilicon.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "nm@ti.com" <nm@ti.com>, "t-kristo@ti.com" <t-kristo@ti.com>,
        "ssantosh@kernel.org" <ssantosh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz?=
 =?utf-8?Q?ource()_for_irqchip_drivers?=
Thread-Topic: [PATCH] use devm_platform_ioremap_resource() for irqchip
 drivers
Thread-Index: AQHVhLrhTEOo/fABek625E0pBMISbadd+MMAgACSrxA=
Date:   Thu, 17 Oct 2019 09:20:10 +0000
Message-ID: <E20AE017F0DBA04DA661272787510F9813D297B0@DGGEMM527-MBX.china.huawei.com>
References: <1571296423-208359-1-git-send-email-huangdaode@hisilicon.com>
 <9bbcce19c777583815c92ce3c2ff2586@www.loen.fr>
In-Reply-To: <9bbcce19c777583815c92ce3c2ff2586@www.loen.fr>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.61.13.197]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYw0KSSBhbSBqdXN0IGRvaW5nIHRoZSBjb2NjaWNoZWNrIHVzaW5nIHRoZSBjb21tYW5k
ICJtYWtlIGNvY2NpY2hlY2sgTT1kcml2ZXJzL2lycWNoaXAvIiwgYW5kIGl0IHJlcG9ydCANCiQg
bWFrZSBjb2NjaWNoZWNrIE09ZHJpdmVycy9pcnFjaGlwLw0KLi4uLi4uLg0KZHJpdmVycy9pcnFj
aGlwLy9pcnEtbXZlYnUtaWN1LmM6MzYxOjEtMTA6IFdBUk5JTkc6IFVzZSBkZXZtX3BsYXRmb3Jt
X2lvcmVtYXBfcmVzb3VyY2UgZm9yIGljdSAtPiBiYXNlDQpkcml2ZXJzL2lycWNoaXAvL2lycS10
czQ4MDAuYzoxMDU6MS0xMTogV0FSTklORzogVXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNv
dXJjZSBmb3IgZGF0YSAtPiBiYXNlDQpkcml2ZXJzL2lycWNoaXAvL2lycS1tdmVidS1waWMuYzox
MzQ6MS0xMDogV0FSTklORzogVXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSBmb3Ig
cGljIC0+IGJhc2UNCmRyaXZlcnMvaXJxY2hpcC8vaXJxLXRpLXNjaS1pbnRhLmM6NTcxOjEtMTE6
IFdBUk5JTkc6IFVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UgZm9yIGludGEgLT4g
YmFzZQ0KZHJpdmVycy9pcnFjaGlwLy9pcnEtc3RtMzItZXh0aS5jOjg1MzoxLTE2OiBXQVJOSU5H
OiBVc2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlIGZvciBob3N0X2RhdGEgLT4gYmFz
ZQ0KDQpzbyBqdXN0IGZpeCB0aGUgV0FSTklORy4gDQoNCkFuZCBhZnRlciAgYXBwbHkgdGhlIHBh
dGNoLCBJIGRvIHRoZSBjb21waWxlLCBpdCdzIE9LLCBidXQgSSBsYWNrIG9mIGhhcmR3YXJlIHRv
IHRlc3QgaXQuIA0KVGhhdCdzIHRoZSBjYXNlLiANCg0KTUJSLg0KVGhhbmtzDQoNCi0tLS0t6YKu
5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogTWFyYyBaeW5naWVyIFttYWlsdG86bWF6QGtlcm5l
bC5vcmddIA0K5Y+R6YCB5pe26Ze0OiAyMDE55bm0MTDmnIgxN+aXpSAxNjoyNA0K5pS25Lu25Lq6
OiBodWFuZ2Rhb2RlIDxodWFuZ2Rhb2RlQGhpc2lsaWNvbi5jb20+DQrmioTpgIE6IGphc29uQGxh
a2VkYWVtb24ubmV0OyBhbmRyZXdAbHVubi5jaDsgZ3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29t
OyBzZWJhc3RpYW4uaGVzc2VsYmFydGhAZ21haWwuY29tOyB0Z2x4QGxpbnV0cm9uaXguZGU7IG1j
b3F1ZWxpbi5zdG0zMkBnbWFpbC5jb207IGFsZXhhbmRyZS50b3JndWVAc3QuY29tOyBubUB0aS5j
b207IHQta3Jpc3RvQHRpLmNvbTsgc3NhbnRvc2hAa2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tDQrkuLvpopg6IFJlOiBbUEFUQ0hd
IHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSBmb3IgaXJxY2hpcCBkcml2ZXJz
DQoNCk9uIDIwMTktMTAtMTcgMDg6MTMsIERhb2RlIEh1YW5nIHdyb3RlOg0KPiBGcm9tOiBEYW9k
ZSBIdWFuZyA8aHVhbmdkYW9kZUBoaXNsaWNvbi5jb20+DQo+DQo+IFVzZSB0aGUgbmV3IGhlbHBl
ciB0aGF0IHdyYXBzIHRoZSBjYWxscyB0byBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSBhbmQgDQo+
IGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIHRvZ2V0aGVyDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERh
b2RlIEh1YW5nIDxodWFuZ2Rhb2RlQGhpc2xpY29uLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2ly
cWNoaXAvaXJxLW12ZWJ1LWljdS5jICAgfCAzICstLQ0KPiAgZHJpdmVycy9pcnFjaGlwL2lycS1t
dmVidS1waWMuYyAgIHwgMyArLS0NCj4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzItZXh0aS5j
ICB8IDMgKy0tICANCj4gZHJpdmVycy9pcnFjaGlwL2lycS10aS1zY2ktaW50YS5jIHwgMyArLS0N
Cj4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtdHM0ODAwLmMgICAgICB8IDMgKy0tDQo+ICA1IGZpbGVz
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLW12ZWJ1LWljdS5jIA0KPiBiL2RyaXZlcnMvaXJxY2hp
cC9pcnEtbXZlYnUtaWN1LmMgaW5kZXggNTQ3MDQ1ZC4uZGRmOWIwZCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1pY3UuYw0KPiArKysgYi9kcml2ZXJzL2lycWNoaXAv
aXJxLW12ZWJ1LWljdS5jDQo+IEBAIC0zNTcsOCArMzU3LDcgQEAgc3RhdGljIGludCBtdmVidV9p
Y3VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4NCj4gIAlpY3UtPmRl
diA9ICZwZGV2LT5kZXY7DQo+DQo+IC0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLQlpY3UtPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3Vy
Y2UoJnBkZXYtPmRldiwgcmVzKTsNCj4gKwlpY3UtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVt
YXBfcmVzb3VyY2UocGRldiwgcmVzKTsNCg0Kdm9pZCBfX2lvbWVtICpkZXZtX3BsYXRmb3JtX2lv
cmVtYXBfcmVzb3VyY2Uoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaW5kZXgpDQoN
CldoYXQgY291bGQgcG9zc2libHkgZ28gd3Jvbmc/IEknZCBzdWdnZXN0IHlvdSBzdGFydCBjb21w
aWxpbmcgKGFuZCBwb3NzaWJseQ0KdGVzdGluZykgdGhlIGNvZGUgeW91IGNoYW5nZSBiZWZvcmUg
c2VuZGluZyBwYXRjaGVzLi4uDQoNCiAgICAgICAgIE0uDQotLQ0KSmF6eiBpcyBub3QgZGVhZC4g
SXQganVzdCBzbWVsbHMgZnVubnkuLi4NCg==
