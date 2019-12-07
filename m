Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EE8C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893D22173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLGHVF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 02:21:05 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2527 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfLGHVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 02:21:05 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 8417D6B030C277E91752;
        Sat,  7 Dec 2019 15:21:03 +0800 (CST)
Received: from dggeme715-chm.china.huawei.com (10.1.199.111) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 7 Dec 2019 15:21:03 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme715-chm.china.huawei.com (10.1.199.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 7 Dec 2019 15:21:03 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Sat, 7 Dec 2019 15:21:02 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: get rid of var page in kvm_set_pfn_dirty()
Thread-Topic: [PATCH] KVM: get rid of var page in kvm_set_pfn_dirty()
Thread-Index: AdWszoDtsWxJ/gWEQkaDkTQc5F3KgQ==
Date:   Sat, 7 Dec 2019 07:21:02 +0000
Message-ID: <488cb59fccb74338aa7b8b7dcfc0c4fc@huawei.com>
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

Sean Christopherson wrote:
>On Thu, Dec 05, 2019 at 11:05:05AM +0800, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>> 
>> We can get rid of unnecessary var page in
>> kvm_set_pfn_dirty() , thus make code style similar with 
>> kvm_set_pfn_accessed().
>
>For future reference, there's no need to wrap so aggressively, preferred kernel style is to wrap at 75 columns (though for some reason I am in the habit of wrapping changelogs at 73 columns), e.g.:
>
>We can get rid of unnecessary var page in kvm_set_pfn_dirty(), thus make code style similar with kvm_set_pfn_accessed().
>
Many thanks for your remind. I would try to wrap changelogs at about 75 columns.
Thanks again.
