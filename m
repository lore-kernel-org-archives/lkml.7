Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB0C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA452067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKRLbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:31:13 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfKRLbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:31:12 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 260692A3A9C03E1DC8A3;
        Mon, 18 Nov 2019 19:31:10 +0800 (CST)
Received: from dggeme715-chm.china.huawei.com (10.1.199.111) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 19:31:09 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme715-chm.china.huawei.com (10.1.199.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 18 Nov 2019 19:31:09 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Mon, 18 Nov 2019 19:31:09 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jannh@google.com" <jannh@google.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "walken@google.com" <walken@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Topic: [PATCH v3] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Index: AdWeAfZA6El8rFaYR4a14N6qgMMNMg==
Date:   Mon, 18 Nov 2019 11:31:09 +0000
Message-ID: <649a404995f34fe3ab36ae2c4d58f077@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IE9uIDE4LjExLjE5IDA3OjM5LCBsaW5taWFvaGUg
d3JvdGU6DQo+PiBGcm9tOiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4+IA0K
Pj4gVGhlIGp1bXAgbGFiZWxzIHRyeV9wcmV2IGFuZCBub25lIGFyZSBub3QgcmVhbGx5IG5lZWRl
ZCBpbiANCj4+IGZpbmRfbWVyZ2VhYmxlX2Fub25fdm1hKCksIGVsaW1pbmF0ZSB0aGVtIHRvIGlt
cHJvdmUgcmVhZGFiaWxpdHkuDQo+DQo+SSB0aGluayB5b3UgY2FuIGdldCByaWQgb2YgbmVhciBj
b21wbGV0ZWx5IGFzIHdlbGwNCj4NCj4JaWYgKHZtYS0+dm1fbmV4dCkgew0KPgkJYW5vbl92bWEg
PSByZXVzYWJsZV9hbm9uX3ZtYShuZWFyLCB2bWEsIHZtYS0+dm1fbmV4dCk7DQo+CQlpZiAoYW5v
bl92bWEpDQo+CQkJcmV0dXJuIGFub25fdm1hOw0KPgl9DQo+DQo+Li4uDQo+DQo+QXBhcnQgZnJv
bSAgdGhhdCBsb29rcyBnb29kIHRvIG1lLg0KPg0KPj4gICANCj4+IC0JYW5vbl92bWEgPSByZXVz
YWJsZV9hbm9uX3ZtYShuZWFyLCB2bWEsIG5lYXIpOw0KPj4gLQlpZiAoYW5vbl92bWEpDQo+PiAt
CQlyZXR1cm4gYW5vbl92bWE7DQo+PiAtdHJ5X3ByZXY6DQo+PiArCS8qIFRyeSBwcmV2IG5leHQu
ICovDQo+PiAgIAluZWFyID0gdm1hLT52bV9wcmV2Ow0KPj4gLQlpZiAoIW5lYXIpDQoNClRoYW5r
cyBmb3IgeW91ciBhZHZpY2UgYWdhaW4uIEkgd2lsbCBnZXQgcmlkIG9mIG5lYXIgY29tcGxldGVs
eSBpbiB2NC4gVGhhbmtzIGEgbG90Lg0K
