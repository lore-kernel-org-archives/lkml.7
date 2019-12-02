Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4480C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9170D20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLBNcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:32:47 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfLBNcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:32:46 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 9839ACB0AB60083E64B9;
        Mon,  2 Dec 2019 21:32:40 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Dec 2019 21:32:40 +0800
Received: from DGGEMM527-MBX.china.huawei.com ([169.254.6.63]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0439.000;
 Mon, 2 Dec 2019 21:32:37 +0800
From:   huangdaode <huangdaode@hisilicon.com>
To:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Marc Zyngier <maz@kernel.org>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGlycWNoaXAvc3RtMzI6IEZpeCAiV0FSTklORzog?=
 =?utf-8?Q?invalid_free_of_devm=5F_allocated?=
Thread-Topic: [PATCH] irqchip/stm32: Fix "WARNING: invalid free of devm_
 allocated
Thread-Index: AQHVqRONo4g3fXJ0f0u7bwgldAUS36em11xw
Date:   Mon, 2 Dec 2019 13:32:36 +0000
Message-ID: <E20AE017F0DBA04DA661272787510F9813DF2864@DGGEMM527-MBX.china.huawei.com>
References: <1574931880-168682-1-git-send-email-huangdaode@hisilicon.com>
 <8acaa494701c91b8a8acd60a2390d810@www.loen.fr>
 <028744c349410eb1f74b7e2b18590c75@www.loen.fr>
 <d7a90e49-b847-7fad-d11c-5969050e8d12@st.com>
In-Reply-To: <d7a90e49-b847-7fad-d11c-5969050e8d12@st.com>
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

WWVzLCBJIHdlbnQgdGhyb3VnaCB0aGUgY29kZSwgZm91bmQgaXQncyBhIHdyb25nIHBhdGNoLCBz
b3JyeSBmb3IgbWFraW5nIHRoZSBjb25mdXNpb24uIA0KDQpUaGFua3MuDQoNCi0tLS0t6YKu5Lu2
5Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogRmFiaWVuIERFU1NFTk5FIFttYWlsdG86ZmFiaWVuLmRl
c3Nlbm5lQHN0LmNvbV0gDQrlj5HpgIHml7bpl7Q6IDIwMTnlubQxMuaciDLml6UgMjE6MjINCuaU
tuS7tuS6ujogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IGh1YW5nZGFvZGUgPGh1YW5n
ZGFvZGVAaGlzaWxpY29uLmNvbT4NCuaKhOmAgTogamFzb25AbGFrZWRhZW1vbi5uZXQ7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb207IHRnbHhA
bGludXRyb25peC5kZTsgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBBbGV4YW5kcmUgVE9SR1VFIDxh
bGV4YW5kcmUudG9yZ3VlQHN0LmNvbT4NCuS4u+mimDogUmU6IFtQQVRDSF0gaXJxY2hpcC9zdG0z
MjogRml4ICJXQVJOSU5HOiBpbnZhbGlkIGZyZWUgb2YgZGV2bV8gYWxsb2NhdGVkDQoNCkhpIERh
b2RlLA0KDQoNCkkgY29uZmlybSB0aGF0IHRoaXMgcGF0Y2ggaXMgbm90IGEgZ29vZCBpZGVhLCBo
ZXJlIGFyZSBzb21lIGV4cGxhbmF0aW9ucy4NCg0KaXJxLXN0bTMyLWV4dGkuYyBkZWFscyB3aXRo
IHR3byBkaWZmZXJlbnQgcHVycG9zZXM6DQoNCi0gZWl0aGVyIGl0IGlzIHVzZWQgdG8gcHJvYmUg
dGhlICJzdCxzdG0zMm1wMS1leHRpIiBjb21wYXRpYmxlIGRldmljZS4gDQpJbiB0aGF0IGNhc2Ug
LnByb2JlKCkgaXMgaW52b2tlZCBhbmQgdXNlcyBkZXZtX2t6YWxsb2MoKSB0byBnZXQgbWVtb3J5
LiANCk5vIG5lZWQgdG8gZnJlZSBtZW1vcnkuDQoNCi1laXRoZXIgaXMgaXQgdXNlZCBmb3Igb3Ro
ZXIgc3RtMzIgZGV2aWNlcy4gSW4gdGhhdCBjYXNlLCB0aGVyZSBpcyBubyBwcm9iZSBmdW5jdGlv
biwgdGhlIGRyaXZlciBpcyAnanVzdCcgaW5pdCdlZC4gSW4gdGhhdCBjYXNlLA0KZGV2bV9remFs
bG9jKCkgaXMgbm90IHVzZWQgYW5kIGV4cGxpY2l0IGZyZWUgbWVtb3J5IGlzIHJlcXVpcmVkLg0K
DQpBcyBzYWlkIGJ5IE1hcmssIHlvdSBoYXZlIGp1c3QgbWl4ZWQgdGhlIHR3byBwYXRocy4NCg0K
RmFiaWVuDQoNCg0KDQpPbiAwMi8xMi8yMDE5IDE6NDAgUE0sIE1hcmMgWnluZ2llciB3cm90ZToN
Cj4gT24gMjAxOS0xMi0wMiAxMjoyOSwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPj4gT24gMjAxOS0x
MS0yOCAwOTowNCwgRGFvZGUgSHVhbmcgd3JvdGU6DQo+Pj4gU2luY2UgZGV2bV8gYWxsb2NhdGVk
IGRhdGEgY2FuIGJlIGF1dG9tYWl0Y2FsbHkgcmVsZWFzZWQsIGl0J3Mgbm8gDQo+Pj4gbmVlZCB0
byBmcmVlIGl0IGFwcGFyZW50bHksIGp1c3QgcmVtb3ZlIGl0Lg0KPj4+DQo+Pj4gRml4ZXM6IGNm
YmY5ZTQ5NzA5NCAoImlycWNoaXAvc3RtMzI6IFVzZSBhIHBsYXRmb3JtIGRyaXZlciBmb3IgDQo+
Pj4gc3RtMzJtcDEtZXh0aSBkZXZpY2UiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IERhb2RlIEh1YW5n
IDxodWFuZ2Rhb2RlQGhpc2lsaWNvbi5jb20+DQo+Pj4gLS0tDQo+Pj4gwqBkcml2ZXJzL2lycWNo
aXAvaXJxLXN0bTMyLWV4dGkuYyB8IDIgLS0NCj4+PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0
aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzIt
ZXh0aS5jDQo+Pj4gYi9kcml2ZXJzL2lycWNoaXAvaXJxLXN0bTMyLWV4dGkuYw0KPj4+IGluZGV4
IGUwMGYyZmEuLjQ2ZWMwYWYgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1z
dG0zMi1leHRpLmMNCj4+PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLXN0bTMyLWV4dGkuYw0K
Pj4+IEBAIC03NzksOCArNzc5LDYgQEAgc3RhdGljIGludCBfX2luaXQgc3RtMzJfZXh0aV9pbml0
KGNvbnN0IHN0cnVjdCANCj4+PiBzdG0zMl9leHRpX2Rydl9kYXRhICpkcnZfZGF0YSwNCj4+PiDC
oMKgwqDCoCBpcnFfZG9tYWluX3JlbW92ZShkb21haW4pOw0KPj4+IMKgb3V0X3VubWFwOg0KPj4+
IMKgwqDCoMKgIGlvdW5tYXAoaG9zdF9kYXRhLT5iYXNlKTsNCj4+PiAtwqDCoMKgIGtmcmVlKGhv
c3RfZGF0YS0+Y2hpcHNfZGF0YSk7DQo+Pj4gLcKgwqDCoCBrZnJlZShob3N0X2RhdGEpOw0KPj4+
IMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4gwqB9DQo+Pg0KPj4gQXBwbGllZCwgdGhhbmtzLg0K
Pg0KPiBTY3JhdGNoIHRoYXQuIFRoaXMgcGF0Y2ggaXMganVzdCB3cm9uZywgYW5kIGp1c3QgcmVh
ZGluZyB0aGUgY29kZSANCj4gbWFrZXMgaXQgb2J2aW91cy4gc3RtMzJfZXh0aV9pbml0KCkgaXMg
b25seSBjYWxsZWQgb24gcGF0aHMgdGhhdCANCj4gYWxsb2NhdGUgdGhlIG1lbW9yeSB3aXRoIGtt
YWxsb2MuDQo+DQo+IENsZWFybHkgeW91IGhhdmVuJ3QgdHJpZWQgdG8gdW5kZXJzdGFuZCB3aGF0
IGlzIGdvaW5nIG9uLg0KPg0KPiDCoMKgwqDCoMKgwqDCoCBNLg0K
