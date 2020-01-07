Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5174CC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E34B20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgAGBgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:36:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbgAGBgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:36:09 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 1F2D2DE7084E300C9B17;
        Tue,  7 Jan 2020 09:36:07 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Tue, 7 Jan 2020 09:35:56 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Topic: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Thread-Index: AQHVwRzFqRRtqHdXdESmtZr5m5x/BafdeacAgAD0jOA=
Date:   Tue, 7 Jan 2020 01:35:55 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340B5552@dggemm526-mbx.china.huawei.com>
References: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
 <14a39167-5704-f406-614d-4d25b8fe8c68@arm.com>
In-Reply-To: <14a39167-5704-f406-614d-4d25b8fe8c68@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEaWV0bWFyIEVnZ2VtYW5uIFtt
YWlsdG86ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDA3LCAyMDIwIDI6NDIgQU0NCj4gVG86IFplbmd0YW8gKEIpOyBzdWRlZXAuaG9sbGFAYXJtLmNv
bQ0KPiBDYzogTGludXhhcm07IEdyZWcgS3JvYWgtSGFydG1hbjsgUmFmYWVsIEouIFd5c29ja2k7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
Y3B1LXRvcG9sb2d5OiBTa2lwIHRoZSBleGlzdCBidXQgbm90IHBvc3NpYmxlIGNwdQ0KPiBub2Rl
cw0KPiANCj4gT24gMDIvMDEvMjAyMCAwNDoyNCwgWmVuZyBUYW8gd3JvdGU6DQo+ID4gV2hlbiBD
T05GSUdfTlJfQ1BVUyBpcyBzbWFsbGVyIHRoYW4gdGhlIGNwdSBub2RlcyBkZWZpbmVkIGluIHRo
ZQ0KPiBkZXZpY2UNCj4gPiB0cmVlLCB0aGUgY3B1IG5vZGUgcGFyc2luZyB3aWxsIGZhaWwuIEFu
ZCB0aGlzIGlzIG5vdCByZWFzb25hYmxlIGZvciBhDQo+ID4gbGVnYWwgZGV2aWNlIHRyZWUgY29u
Zmlncy4NCj4gPiBJbiB0aGlzIHBhdGNoLCBza2lwIHN1Y2ggY3B1IG5vZGVzIHJhdGhlciB0aGFu
IHJldHVybiBhbiBlcnJvci4NCj4gDQo+IElzIHRoaXMgZXh0cmEgY29kZSByZWFsbHkgbmVjZXNz
YXJ5Pw0KPiANCj4gQ3VycmVudGx5IHlvdSBnZXQgd2FybmluZ3MgaW5kaWNhdGluZyB0aGF0IENP
TkZJR19OUl9DUFVTIGlzIHRvbyBzbWFsbA0KPiBzbyB5b3UgY291bGQgY29ycmVjdCB0aGUgc2V0
dXAgaXNzdWUgZWFzaWx5Lg0KPg0KDQpOb3Qgb25seSBhYm91dCB3YXJuaW5nIG1lc3NhZ2VzLCB0
aGUgcHJvYmxlbSBpcyA6DQpXaGF0IHdlIGFyZSBleHBlY3RlZCB0byBkbyBpZiB0aGUgQ09ORklH
X05SX0NQVVMgaXMgdG9vIHNtYWxsPyBJIHRoaW5rIHRoZXJlDQphcmUgdHdvIGNob2ljZXM6DQox
LiBLZWVwIHRoZSBkdHMgcGFyc2luZyByZXN1bHQsIGJ1dCBza2lwIHRoZSB0aGUgQ1BVIG5vZGVz
IHdob3NlIGlkIGV4Y2VlZHMgdGhlIA0KdGhlIENPTkZJR19OUl9DUFVTLCBhbmQgdGhpcyBpcyB3
aGF0IHRoaXMgcGF0Y2ggZG8uDQoyLiBKdXN0IGFib3J0IGFsbCB0aGUgQ1BVIG5vZGVzIHBhcnNp
bmcsIGFuZCB1c2luZyBNUElEUiB0byBndWVzcyB0aGUgdG9wb2xvZ3ksIA0KYW5kIHRoaXMgaXMg
d2hhdCB0aGUgY3VycmVudCBjb2RlIGRvLg0KQW5kIGkgdGhpbmsgY2hvaWNlIDEgaXMgYmV0dGVy
IGJlY2F1c2U6DQoxLiBJdCdzIGEgbGVnYWwgZHRzLCB3ZSBzaG91bGQga2VlcCB0aGUgc2FtZSBy
ZXN1bHQgd2hldGhlciBDT05GSUdfTlJfQ1BVUyBpcw0KdG9vIHNtYWxsIG9yIG5vdC4NCjIuIElu
IHRoZSBmdW5jdGlvbiBvZl9wYXJzZV9hbmRfaW5pdF9jcHVzLCB3ZSBqdXN0IGRvIHRoZSBzYW1l
IHdheSBhcyBjaG9pY2UgMS4NCg0KQnV0IGkgYW0gb3BlbiBmb3IgdGhlIGlzc3VlLCBhbnkgc3Vn
Z2VzdGlvbnMgYXJlIHdlbGNvbWVkLg0KDQpUaGFua3MNClplbmd0YW8gDQogDQo+IEV4YW1wbGU6
IEFybTY0IEp1bm8gYm9hcmQNCj4gDQo+ICQgZ3JlcCAiY3B1QCIgLi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2FybS9qdW5vLmR0cw0KPiAJCUE1N18wOiBjcHVAMCB7DQo+IAkJQTU3XzE6IGNwdUAxIHsN
Cj4gCQlBNTNfMDogY3B1QDEwMCB7DQo+IAkJQTUzXzE6IGNwdUAxMDEgew0KPiAJCUE1M18yOiBj
cHVAMTAyIHsNCj4gCQlBNTNfMzogY3B1QDEwMyB7DQo+IA0KPiByb290QGp1bm86fiMgdW5hbWUg
LXINCj4gNS41LjAtcmM1DQo+IA0KPiByb290QGp1bm86fiMgemNhdCAvcHJvYy9jb25maWcuZ3og
fCBncmVwIENPTkZJR19OUl9DUFVTDQo+IENPTkZJR19OUl9DUFVTPTQNCj4gDQo+IHJvb3RAanVu
bzp+IyBjYXQgL3Byb2MvY3B1aW5mbyB8IGdyZXAgXnByb2MNCj4gcHJvY2Vzc29yICAgICAgIDog
MA0KPiBwcm9jZXNzb3IgICAgICAgOiAxDQo+IHByb2Nlc3NvciAgICAgICA6IDINCj4gcHJvY2Vz
c29yICAgICAgIDogMw0KPiANCj4gcm9vdEBqdW5vOn4jIGRtZXNnIHwgZ3JlcCAiVW5hYmxlXHxD
YW4ndCINCj4gWyAgICAwLjA4NTA4OV0gVW5hYmxlIHRvIGZpbmQgQ1BVIG5vZGUgZm9yIC9jcHVz
L2NwdUAxMDINCj4gWyAgICAwLjA5MDE3OV0gL2NwdXMvY3B1LW1hcC9jbHVzdGVyMS9jb3JlMjog
Q2FuJ3QgZ2V0IENQVSBmb3IgbGVhZiBjb3JlDQo+IA0KPiBbLi4uXQ0K
