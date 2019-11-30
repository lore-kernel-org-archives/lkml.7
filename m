Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501DC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80E520732
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfK3Iio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 03:38:44 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:36210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfK3Iio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 03:38:44 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 2271585DF4F9251C3CCD;
        Sat, 30 Nov 2019 16:38:42 +0800 (CST)
Received: from dggeme714-chm.china.huawei.com (10.1.199.110) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 30 Nov 2019 16:38:41 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme714-chm.china.huawei.com (10.1.199.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 30 Nov 2019 16:38:41 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Sat, 30 Nov 2019 16:38:41 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Topic: [PATCH v4] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Index: AdWnWSC4DFo9P44HRnWneBHBmfqvHA==
Date:   Sat, 30 Nov 2019 08:38:41 +0000
Message-ID: <c6be1499b0144cd8b5a8f9275c846e6e@huawei.com>
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

Pg0KPj4gQW0gMzAuMTEuMjAxOSB1bSAwODoyMyBzY2hyaWViIGxpbm1pYW9oZSA8bGlubWlhb2hl
QGh1YXdlaS5jb20+Og0KPj4gDQo+PiDvu78NCj4+PiANCj4+Pj4gRnJvbTogTWlhb2hlIExpbiA8
bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+Pj4+IA0KPj4+PiBUaGUganVtcCBsYWJlbHMgdHJ5X3By
ZXYgYW5kIG5vbmUgYXJlIG5vdCByZWFsbHkgbmVlZGVkIGluIA0KPj4gZnJpZW5kbHkgcGluZyAu
Li4NCj4+IA0KPg0KPldl4oCYcmUgY3VycmVudGx5IGluIHRoZSBtZXJnZSBwaGFzZSwgYW5kIFUu
Uy5BLiBqdXN0IGhhZCBUaGFua3NnaXZpbmcgLSBzbyBpdCBtaWdodCB0YWtlIHNvbWUgdGltZSB0
byBnZXQgcGlja2VkIHVwLiBDaGVlcnMhDQoNCkhpLA0KVGhhbmtzIGZvciB5b3VyIHJlbWluZC4g
VGhpcyBwYXRjaCBoYXZlIGJlZW4gc2lsZW50IGZvciBhbG1vc3QgaGFsZiBhIG1vbnRoLCBzbw0K
SSBzZW5kIHRoaXMgcGluZy4gVGhhbmtzIGFnYWluLg0KDQo=
