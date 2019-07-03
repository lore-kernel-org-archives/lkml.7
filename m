Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0303AC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0819206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfGCBZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:25:41 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:53870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGCBZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:25:41 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 3C9D01080821BB1EDA5F;
        Wed,  3 Jul 2019 09:25:39 +0800 (CST)
Received: from DGGEMI524-MBX.china.huawei.com ([169.254.7.145]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0399.000;
 Wed, 3 Jul 2019 09:25:29 +0800
From:   chengzhihao <chengzhihao1@huawei.com>
To:     "david.oberhollenzer@sigma-star.at" 
        <david.oberhollenzer@sigma-star.at>,
        "richard@nod.at" <richard@nod.at>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "boris.brezillon@free-electrons.com" 
        <boris.brezillon@free-electrons.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFJGQyB2Ml0gbXRkOiB1Ymk6IEFkZCBmYXN0bWFwIHN5?=
 =?gb2312?Q?sfs_attribute?=
Thread-Topic: [PATCH RFC v2] mtd: ubi: Add fastmap sysfs attribute
Thread-Index: AQHVLakkEpLEJIeKg0yEh5ZV5Mu1B6a4IOEQ
Date:   Wed, 3 Jul 2019 01:25:28 +0000
Message-ID: <0B80F9D4116B2F4484E7279D5A66984F793E33@dggemi524-mbx.china.huawei.com>
References: <1561723581-70340-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1561723581-70340-1-git-send-email-chengzhihao1@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.224.82]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cGluZyB+DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBjaGVuZ3poaWhhbyANCreiy83K
sbzkOiAyMDE5xOo21MIyOMjVIDIwOjA2DQrK1bz+yMs6IGRhdmlkLm9iZXJob2xsZW56ZXJAc2ln
bWEtc3Rhci5hdDsgcmljaGFyZEBub2QuYXQ7IGRhdmlkQHNpZ21hLXN0YXIuYXQ7IGJvcmlzLmJy
ZXppbGxvbkBmcmVlLWVsZWN0cm9ucy5jb207IHpoYW5neWkgKEYpIDx5aS56aGFuZ0BodWF3ZWku
Y29tPg0Ks63LzTogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGNoZW5nemhpaGFvIDxjaGVuZ3poaWhhbzFAaHVhd2VpLmNvbT4NCtb3
zOI6IFtQQVRDSCBSRkMgdjJdIG10ZDogdWJpOiBBZGQgZmFzdG1hcCBzeXNmcyBhdHRyaWJ1dGUN
Cg0KVGhlIFVCSSBkZXZpY2UgY2FuIGJlIGF0dGFjaGVkIHRvIGEgTVREIGRldmljZSB2aWEgZmFz
dG1hcCBieSBzZXR0aW5nIENPTkZJR19NVERfVUJJX0ZBU1RNQVAgdG8gJ3knIChJZiB0aGVyZSBh
bHJlYWR5IGV4aXN0cyBhIGZhc3RtYXAgb24gdGhlIFVCSSBkZXZpY2UpLiBUbyBzdXBwb3J0IHNv
bWUgZGVidWdnaW5nIHNjZW5hcmlvcywgYXR0YWNoaW5nIHByb2Nlc3MgYnkgZmFzdG1hcCBjYW4g
YmUgY29uZmlybWVkIGluIGRtZXNnLiBJZiB0aGUgVUJJIGRldmljZSBpcyBhdHRhY2hlZCBieSBm
YXN0bWFwLCBsb2dzIGxpa2UgZm9sbG93aW5nIHdpbGwgYXBwZWFyIGluIGRtZXNnOg0KDQogIHVi
aTA6IGF0dGFjaGVkIGJ5IGZhc3RtYXANCg0KSWYgbXVsdGlwbGUgVUJJIGRldmljZXMgYXJlIGF0
dGFjaGVkIHRvIG11bHRpcGxlIE1URCBkZXZpY2VzIGF0IHRoZSBzYW1lIHRpbWUsIGhvdyB0byBk
aXN0aW5ndWlzaCB3aGljaCBVQkkgZGV2aWNlcyBhcmUgc3VjY2Vzc2Z1bGx5IGF0dGFjaGVkIGJ5
IGZhc3RtYXA/IEV4dHJhY3RpbmcgYXR0YWNoaW5nIGluZm9ybWF0aW9uIGZvciBlYWNoIFVCSSBk
ZXZpY2Ugb25lIGJ5IG9uZSBmcm9tIGRtZXNnIGlzIGEgd2F5LiBBIGJldHRlciBtZXRob2QgaXMg
dG8gcmVjb3JkIGZhc3RtYXAgZXhpc3RlbmNlIGluIHN5c2ZzLCBzbyBpdCBjYW4gYmUgb2J0YWlu
ZWQgYnkgdXNlcnNwYWNlIHRvb2xzLg0KDQpUaGlzIHBhdGNoIGV4cG9zZXMgZmFzdG1hcCBvbiBz
eXNmcy4gU3VwcG9zZSB5b3UgYXR0YWNoIGFuIFVCSSBkZXZpY2UgdG8gYSBNVEQgZGV2aWNlIGJ5
IGZhc3RtYXA6IGlmIGZhc3RtYXAgZXF1YWxzIHRvICcxJywgdGhhdCBpcywgdGhlIGZhc3RtYXAg
Z2VuZXJhdGVkIGJlZm9yZSBsYXN0IGRldGFjaGluZyBvcGVyYXRpb24gaXMgY29uZmlybWVkIHZh
bGlkLiBFbHNlLCB0aGVyZSBtYXkgYmUgc29tZSBwcm9ibGVtcyB3aXRoIG9sZCBmYXN0bWFwLiBC
ZXNpZGVzLCB1c2Vyc3BhY2UgdG9vbCBjYW4gYWxzbyBjaGVjayB3aGV0aGVyIHRoZSBmYXN0bWFw
IHVwZGF0aW5nIHRyaWdnZXJlZCBieSBvdGhlciBvcGVyYXRpb25zIChzdWNoIGFzIHJlc2l6ZSB2
b2x1bWUpIGlzIHN1Y2Nlc3NmdWwgYnkgcmVhZGluZyB0aGlzIHN5c2ZzIGF0dHJpYnV0ZS4NCg0K
U2lnbmVkLW9mZi1ieTogWmhpaGFvIENoZW5nIDxjaGVuZ3poaWhhbzFAaHVhd2VpLmNvbT4NCi0t
LQ0KIERvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1jbGFzcy11YmkgfCAxNSArKysrKysr
KysrKysrKysNCiBkcml2ZXJzL210ZC91YmkvYnVpbGQuYyAgICAgICAgICAgICAgICAgIHwgIDkg
KysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtY2xhc3Mt
dWJpIGIvRG9jdW1lbnRhdGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWNsYXNzLXViaQ0KaW5kZXggYTZi
MzI0MC4uMWQ5NmNmMCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNm
cy1jbGFzcy11YmkNCisrKyBiL0RvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1jbGFzcy11
YmkNCkBAIC0xMTYsNiArMTE2LDIxIEBAIERlc2NyaXB0aW9uOg0KIAkJZGV2aWNlLCBhbmQgIjBc
biIgaWYgaXQgaXMgY2xlYXJlZC4gVUJJIGRldmljZXMgbWFyayB0aGVtc2VsdmVzDQogCQlhcyBy
ZWFkLW9ubHkgd2hlbiB0aGV5IGRldGVjdCBhbiB1bnJlY292ZXJhYmxlIGVycm9yLg0KIA0KK1do
YXQ6CQkvc3lzL2NsYXNzL3ViaS91YmlYL2Zhc3RtYXANCitEYXRlOgkJSnVuZSAyMDE5DQorS2Vy
bmVsVmVyc2lvbjoJNS4yDQorQ29udGFjdDoJbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmcN
CitEZXNjcmlwdGlvbjoNCisJCUNvbnRhaW5zIEFTQ0lJICIxXG4iIGlmIHRoZXJlIGV4aXN0cyBh
IGZhc3RtYXAgb24gVUJJIGRldmljZSwNCisJCWFuZCAiMFxuIiBpZiB0aGVyZSBub3QgZXhpc3Rz
IGEgZmFzdG1hcCBvbiBVQkkgZGV2aWNlLiBBZnRlcg0KKwkJYXR0YWNoaW5nIHRoZSBVQkkgZGV2
aWNlIHRvIGEgTVREIGRldmljZSB2aWEgZmFzdG1hcCwgdXNlcnNwYWNlDQorCQl0b29sIGNhbiBz
ZW5zZSB0aGF0IHRoZXJlIGlzIGEgZmFzdG1hcCBvbiBVQkkgZGV2aWNlICBieQ0KKwkJY2hlY2tp
bmcgc3lzZnMgYXR0cmlidXRlICdmYXN0bWFwJywgdGhhdCBpcywgdGhlIGZhc3RtYXANCisJCWdl
bmVyYXRlZCBiZWZvcmUgbGFzdCBkZXRhY2hpbmcgb3BlcmF0aW9uIGlzIHZhbGlkLiBJbiBhZGRp
dGlvbiwNCisJCXVzZXJzcGFjZSB0b29sIGNhbiBhbHNvIGNoZWNrIHdoZXRoZXIgdGhlIGZhc3Rt
YXAgdXBkYXRpbmcNCisJCXRyaWdnZXJlZCBieSB2b2x1bWUgb3BlcmF0aW9uIGlzIHN1Y2Nlc3Nm
dWwgYnkgcmVhZGluZyB0aGlzDQorCQlzeXNmcyBhdHRyaWJ1dGUuDQorDQogV2hhdDoJCS9zeXMv
Y2xhc3MvdWJpL3ViaVgvdG90YWxfZXJhc2VibG9ja3MNCiBEYXRlOgkJSnVseSAyMDA2DQogS2Vy
bmVsVmVyc2lvbjoJMi42LjIyDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvdWJpL2J1aWxkLmMg
Yi9kcml2ZXJzL210ZC91YmkvYnVpbGQuYyBpbmRleCBkNjM2YmJlLi4wY2Q2YjhlIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9tdGQvdWJpL2J1aWxkLmMNCisrKyBiL2RyaXZlcnMvbXRkL3ViaS9idWls
ZC5jDQpAQCAtMTQwLDYgKzE0MCw4IEBAIHN0YXRpYyBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBk
ZXZfbXRkX251bSA9DQogCV9fQVRUUihtdGRfbnVtLCBTX0lSVUdPLCBkZXZfYXR0cmlidXRlX3No
b3csIE5VTEwpOyAgc3RhdGljIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlIGRldl9yb19tb2RlID0N
CiAJX19BVFRSKHJvX21vZGUsIFNfSVJVR08sIGRldl9hdHRyaWJ1dGVfc2hvdywgTlVMTCk7DQor
c3RhdGljIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlIGRldl9mYXN0bWFwID0NCisJX19BVFRSKGZh
c3RtYXAsIFNfSVJVR08sIGRldl9hdHRyaWJ1dGVfc2hvdywgTlVMTCk7DQogDQogLyoqDQogICog
dWJpX3ZvbHVtZV9ub3RpZnkgLSBzZW5kIGEgdm9sdW1lIGNoYW5nZSBub3RpZmljYXRpb24uDQpA
QCAtMzc4LDcgKzM4MCwxMSBAQCBzdGF0aWMgc3NpemVfdCBkZXZfYXR0cmlidXRlX3Nob3coc3Ry
dWN0IGRldmljZSAqZGV2LA0KIAkJcmV0ID0gc3ByaW50ZihidWYsICIlZFxuIiwgdWJpLT5tdGQt
PmluZGV4KTsNCiAJZWxzZSBpZiAoYXR0ciA9PSAmZGV2X3JvX21vZGUpDQogCQlyZXQgPSBzcHJp
bnRmKGJ1ZiwgIiVkXG4iLCB1YmktPnJvX21vZGUpOw0KLQllbHNlDQorCWVsc2UgaWYgKGF0dHIg
PT0gJmRldl9mYXN0bWFwKSB7DQorCQlkb3duX3dyaXRlKCZ1YmktPmZtX3Byb3RlY3QpOw0KKwkJ
cmV0ID0gc3ByaW50ZihidWYsICIlZFxuIiwgdWJpLT5mbSA/IDEgOiAwKTsNCisJCXVwX3dyaXRl
KCZ1YmktPmZtX3Byb3RlY3QpOw0KKwl9IGVsc2UNCiAJCXJldCA9IC1FSU5WQUw7DQogDQogCXVi
aV9wdXRfZGV2aWNlKHViaSk7DQpAQCAtMzk4LDYgKzQwNCw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICp1YmlfZGV2X2F0dHJzW10gPSB7DQogCSZkZXZfYmd0X2VuYWJsZWQuYXR0ciwNCiAJ
JmRldl9tdGRfbnVtLmF0dHIsDQogCSZkZXZfcm9fbW9kZS5hdHRyLA0KKwkmZGV2X2Zhc3RtYXAu
YXR0ciwNCiAJTlVMTA0KIH07DQogQVRUUklCVVRFX0dST1VQUyh1YmlfZGV2KTsNCi0tDQoyLjcu
NA0KDQo=
