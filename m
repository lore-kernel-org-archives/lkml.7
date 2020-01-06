Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB96AC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9662072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgAFBw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:52:28 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:56876 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbgAFBw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:52:27 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 344BCE20430513D69D12;
        Mon,  6 Jan 2020 09:52:25 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Mon, 6 Jan 2020 09:52:19 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Morten Rasmussen" <morten.rasmussen@arm.com>
Subject: RE: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Topic: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6CAAAyngIAAlqWw//+IwoCAAXt3QP//7niAgAAVeoCABI6+sA==
Date:   Mon, 6 Jan 2020 01:52:18 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340B3211@dggemm526-mbx.china.huawei.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <7b375d79-2d3c-422b-27a6-68972fbcbeaf@arm.com>
 <66943c82-2cfd-351b-7f36-5aefdb196a03@arm.com>
In-Reply-To: <66943c82-2cfd-351b-7f36-5aefdb196a03@arm.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWYWxlbnRpbiBTY2huZWlkZXIg
W21haWx0bzp2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbV0NCj4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDAzLCAyMDIwIDg6MTUgUE0NCj4gVG86IFplbmd0YW8gKEIpOyBTdWRlZXAgSG9sbGENCj4g
Q2M6IExpbnV4YXJtOyBHcmVnIEtyb2FoLUhhcnRtYW47IFJhZmFlbCBKLiBXeXNvY2tpOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNb3J0ZW4gUmFzbXVzc2VuDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGNwdS10b3BvbG9neTogd2FybiBpZiBOVU1BIGNvbmZpZ3VyYXRpb25zIGNv
bmZsaWN0cw0KPiB3aXRoIGxvd2VyIGxheWVyDQo+IA0KPiBPbiAwMy8wMS8yMDIwIDEwOjU3LCBW
YWxlbnRpbiBTY2huZWlkZXIgd3JvdGU6DQo+ID4gSSdtIGp1Z2dsaW5nIHdpdGggb3RoZXIgdGhp
bmdzIGF0bSwgYnV0IGxldCBtZSBoYXZlIGEgdGhpbmsgYW5kIHNlZSBpZiB3ZQ0KPiA+IGNvdWxk
bid0IGRldGVjdCB0aGF0IGluIHRoZSBzY2hlZHVsZXIgaXRzZWxmLg0KPiA+DQo+IA0KPiBTb21l
dGhpbmcgbGlrZSB0aGlzIG91Z2h0IHRvIGNhdGNoIHlvdXIgY2FzZTsgbWlnaHQgbmVlZCB0byBj
b21wYXJlIGdyb3VwDQo+IHNwYW5zIHJhdGhlciB0aGFuIHB1cmUgZ3JvdXAgcG9pbnRlcnMuDQo+
IA0KDQpHb29kIHN1Z2dlc3Rpb24sIEkgd2lsbCBuZWVkIHRvIGhhdmUgYSB0aGluayBhbmQgdHJ5
DQpUaGFua3MuIA0KDQo+IC0tLQ0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3RvcG9sb2d5
LmMgYi9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYw0KPiBpbmRleCA2ZWMxZTU5NWIxZDQuLmM0MTUx
ZTExYWZjZCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVkL3RvcG9sb2d5LmMNCj4gKysrIGIv
a2VybmVsL3NjaGVkL3RvcG9sb2d5LmMNCj4gQEAgLTExMjAsNiArMTEyMCwxMyBAQCBidWlsZF9z
Y2hlZF9ncm91cHMoc3RydWN0IHNjaGVkX2RvbWFpbiAqc2QsDQo+IGludCBjcHUpDQo+IA0KPiAg
CQlzZyA9IGdldF9ncm91cChpLCBzZGQpOw0KPiANCj4gKwkJLyogc2cncyBhcmUgaW5pdGVkIGFz
IHNlbGYtbG9vcGluZy4gSWYgJ2xhc3QnIGlzIG5vdCBzZWxmDQo+ICsJCSAqIGxvb3BpbmcsIHdl
IHNldCBpdCBpbiBhIHByZXZpb3VzIHZpc2l0LiBObyBmdXJ0aGVyIHZpc2l0DQo+ICsJCSAqIHNo
b3VsZCBjaGFuZ2UgdGhlIGxpbmsgb3JkZXIsIGlmIHdlIGRvIHRoZW4gdGhlIHRvcG9sb2d5DQo+
ICsJCSAqIGRlc2NyaXB0aW9uIGlzIHRlcm1pbmFsbHkgYnJva2VuLg0KPiArCQkgKi8NCj4gKwkJ
QlVHX09OKGxhc3QgJiYgbGFzdC0+bmV4dCAhPSBsYXN0ICYmIGxhc3QtPm5leHQgIT0gc2cpOw0K
PiArDQo+ICAJCWNwdW1hc2tfb3IoY292ZXJlZCwgY292ZXJlZCwgc2NoZWRfZ3JvdXBfc3Bhbihz
ZykpOw0KPiANCj4gIAkJaWYgKCFmaXJzdCkNCg==
