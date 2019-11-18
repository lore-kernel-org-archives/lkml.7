Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE53C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5120722
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfKRGYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:24:46 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfKRGYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:24:46 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id DD453C3666B88723D521;
        Mon, 18 Nov 2019 14:24:42 +0800 (CST)
Received: from dggeme714-chm.china.huawei.com (10.1.199.110) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 14:24:42 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme714-chm.china.huawei.com (10.1.199.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 18 Nov 2019 14:24:42 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Mon, 18 Nov 2019 14:24:42 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     John Hubbard <jhubbard@nvidia.com>,
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
        "david@redhat.com" <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Topic: [PATCH v2] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Index: AdWdwjMMuY8E1Q0PSCe9zU4kyv+3BA==
Date:   Mon, 18 Nov 2019 06:24:42 +0000
Message-ID: <ed7a8b5fb71d4ff4b7b515f402aa265a@huawei.com>
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

Sm9obiBIdWJiYXJkIHdyb3RlOg0KPiBPbiAxMS8xNy8xOSA3OjIyIFBNLCBsaW5taWFvaGUgd3Jv
dGU6DQo+ID4gRnJvbTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+ID4gDQo+
ID4gVGhlIGp1bXAgbGFiZWxzIHRyeV9wcmV2IGFuZCBub25lIGFyZSBub3QgcmVhbGx5IG5lZWRl
ZCBpbiANCj4gPiBmaW5kX21lcmdlYWJsZV9hbm9uX3ZtYSgpLCBlbGltaW5hdGUgdGhlbSB0byBp
bXByb3ZlIHJlYWRhYmlsaXR5Lg0KPiA+IC12MjoNCj4gPiAJRml4IGNvbW1pdCBkZXNjcmlwdGlv
bnMgYW5kIGZ1cnRoZXIgc2ltcGxpZnkgdGhlIGNvZGUNCj4gPiAJYXMgc3VnZ2VzdGVkIGJ5IERh
dmlkIEhpbGRlbmJyYW5kIGFuZCBKb2huIEh1YmJhcmQuDQo+DQo+IEFkbWluIHBvaW50OiB0aGUg
YWJvdmUgdGhyZWUgbGluZXMgd2lsbCBlbmQgdXAgaW4gdGhlIGNvbW1pdCBsb2csIHdoaWNoIGlz
IHByb2JhYmx5IG5vdCB3aGF0IHlvdSBpbnRlbmRlZC4gSWYsIGluc3RlYWQsIHlvdSBwdXQgdGhl
bSBiZWxvdyB0aGUgIi0tLSIgbGluZSwgdGhlbiB0aGV5IHdpbGwgYWN0IGFzIGNvbW1lbnRzIGFi
b3V0IHRoZSBwYXRjaCwgYW5kIHdvbid0IHNob3cgdXAgaW4gdGhlIGNvbW1pdCBsb2cuDQo+DQo+
DQpUaGFua3MgZm9yIHlvdXIgcmVtaW5kLiBJJ2FtIHNvcnJ5IGZvciB0aGlzIG1pc3Rha2UuIEkn
bGwgZml4IHRoaXMuIE1hbnkgdGhhbmtzLg0K
