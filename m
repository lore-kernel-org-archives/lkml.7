Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957222173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfGQGgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:36:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:47962 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQGgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:36:18 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 7D03515792F57B4A9A3D;
        Wed, 17 Jul 2019 14:36:14 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 17 Jul 2019 14:36:13 +0800
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.227]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Wed, 17 Jul 2019 14:36:09 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     "kishon@ti.com" <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
        "Paul Kocialkowski" <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Thread-Topic: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Thread-Index: AQHVN9Ajzwa2MbZo40exGsBlwJEt36bEv5mAgAln51A=
Date:   Wed, 17 Jul 2019 06:36:09 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED2FF5B22D@DGGEMM506-MBX.china.huawei.com>
References: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
 <20190711112039.leuvelpm7opeoaxq@flea>
In-Reply-To: <20190711112039.leuvelpm7opeoaxq@flea>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF4aW1lOg0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQoNCj4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPkZyb206IE1heGltZSBSaXBhcmQgW21haWx0bzptYXhpbWUucmlwYXJkQGJv
b3RsaW4uY29tXQ0KPlNlbnQ6IFRodXJzZGF5LCBKdWx5IDExLCAyMDE5IDc6MjEgUE0NCj5Ubzog
WmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT4NCj5DYzoga2lzaG9uQHRpLmNv
bTsgQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPjsgUGF1bCBLb2NpYWxrb3dza2kNCj48cGF1
bC5rb2NpYWxrb3dza2lAYm9vdGxpbi5jb20+OyBTYWthcmkgQWlsdXMgPHNha2FyaS5haWx1c0Bs
aW51eC5pbnRlbC5jb20+Ow0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBoeTog
Q2hhbmdlIHRoZSBjb25maWd1cmF0aW9uIGludGVyZmFjZSBwYXJhbSB0byB2b2lkKg0KPnRvIG1h
a2UgaXQgbW9yZSBnZW5lcmFsDQo+DQo+KiBQR1AgU2lnbmVkIGJ5IGFuIHVua25vd24ga2V5DQo+
DQo+T24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgMDI6MDQ6MDhBTSArMDgwMCwgWmVuZyBUYW8gd3Jv
dGU6DQo+PiBUaGUgcGh5IGZyYW1ld29yayBub3cgYWxsb3dzIHJ1bnRpbWUgY29uZmlndXJhdGlv
bnMsIGJ1dCBvbmx5IGxpbWl0ZWQNCj4+IHRvIG1pcGkgbm93LCBhbmQgaXQncyBub3QgcmVhc29u
YWJsZSB0byBpbnRyb2R1Y2UgdXNlciBzcGVjaWZpZWQNCj4+IGNvbmZpZ3VyYXRpb25zIGludG8g
dGhlIHVuaW9uIHBoeV9jb25maWd1cmVfb3B0cyBzdHJ1Y3R1cmUuIEFuIHNpbXBsZQ0KPj4gd2F5
IGlzIHRvIHJlcGxhY2Ugd2l0aCBhIHZvaWQgKi4NCj4NCj5JJ20gbm90IHN1cmUgd2h5IGl0J3Mg
dW5yZWFzb25hYmxlPw0KPg0KVGhlIHBoeS5oIHdpbGwgbmVlZCB0byBpbmNsdWRlIHZlbmRvciBz
cGVjaWZpYyBwaHkgaGVhZGVycywgYW5kIHRoZSB1bmlvbiBwaHlfY29uZmlndXJlX29wdHMNCndp
bGwgYmVjb21lIG1vcmUgY29tcGxleC4gSSBkb24ndCB0aGluayB0aGlzIGlzIGEgZ29vZCBzb2x1
dGlvbiB0byBpbmNsdWRlIGFsbCB2ZW5kb3Igc3BlY2lmaWMgcGh5DQpjb25maWdzIGludG8gYSBz
aW5nbGUgdW5pb24gc3RydWN0dXJlLiANCg0KPj4gV2UgaGF2ZSBhbHJlYWR5IGdvdCBzb21lIHBo
eSBkcml2ZXJzIHdoaWNoIGludHJvZHVjZSBwcml2YXRlIHBoeSBBUEkNCj4+IGZvciBydW50aW1l
IGNvbmZpZ3VyYXRpb25zLCBhbmQgd2l0aCB0aGlzIHBhdGNoLCB0aGV5IGNhbiBzd2l0Y2ggdG8N
Cj4+IHRoZSBwaHlfY29uZmlndXJlIGFzIGEgcmVwbGFjZS4NCj4NCj5JZiB5b3UgaGF2ZSBhIGN1
c3RvbSBtb2RlIG9mIG9wZXJhdGlvbiwgdGhlbiB5b3UnbGwgbmVlZCBhIGN1c3RvbQ0KPnBoeV9t
b2RlIGFzIHdlbGwsIGFuZCBzdXJlbHkgeW91IGNhbiBoYXZlIGEgY3VzdG9tIHNldCBvZiBwYXJh
bWV0ZXJzLg0KPg0KPlNpbmNlIHRob3NlIGZ1bmN0aW9ucyBhcmUgbWVhbnQgdG8gcHJvdmlkZSBh
IHR3by13YXkgbmVnb3RpYXRpb24gb2YgdGhlDQo+dmFyaW91cyBwYXJhbWV0ZXJzLCB5b3UnbGwg
aGF2ZSB0byBoYXZlIHRoYXQgc3RydWN0dXJlIHNoYXJlZCBiZXR3ZWVuIHRoZQ0KPnR3byBlaXRo
ZXIgd2F5LCBzbyB0aGUgb25seSB0aGluZyByZXF1aXJlZCBpbiBhZGRpdGlvbiB0byB3aGF0IHlv
dSB3b3VsZCBoYXZlDQo+cGFzc2luZyBhIHZvaWQgaXMgb25lIGxpbmUgdG8gYWRkIHRoYXQgc3Ry
dWN0dXJlIGluIHRoZSB1bmlvbi4NCj4NCj5UaGF0J3MgYmFyZWx5IHVucmVhc29uYWJsZS4NCj4N
Cj5NYXhpbWUNCj4NCj4tLQ0KPk1heGltZSBSaXBhcmQsIEJvb3RsaW4NCj5FbWJlZGRlZCBMaW51
eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+aHR0cHM6Ly9ib290bGluLmNvbQ0KPg0KPiogVW5r
bm93biBLZXkNCj4qIDB4NjcxODUxQzUNCg==
