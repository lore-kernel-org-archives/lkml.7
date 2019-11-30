Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23892C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F337D2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3HX0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 02:23:26 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfK3HX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 02:23:26 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 15BF0B529DA55D5F0231;
        Sat, 30 Nov 2019 15:23:25 +0800 (CST)
Received: from dggeme765-chm.china.huawei.com (10.3.19.111) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 30 Nov 2019 15:23:24 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme765-chm.china.huawei.com (10.3.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 30 Nov 2019 15:23:24 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Sat, 30 Nov 2019 15:23:24 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jannh@google.com" <jannh@google.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "walken@google.com" <walken@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v4] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Topic: [PATCH v4] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
Thread-Index: AdWnTvaZDFo9P44HRnWneBHBmfqvHA==
Date:   Sat, 30 Nov 2019 07:23:24 +0000
Message-ID: <0db7574905b64d47a7c88766081fa0ad@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>From: Miaohe Lin <linmiaohe@huawei.com>
>>
>>The jump labels try_prev and none are not really needed in 
>>find_mergeable_anon_vma(), eliminate them to improve readability.
>>
>>Reviewed-by: David Hildenbrand <david@redhat.com>
>>Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>
>Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
friendly ping ...
