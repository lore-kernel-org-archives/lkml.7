Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB93C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3E121D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSBfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:35:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfLSBfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:35:37 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26576785A90840925E18;
        Thu, 19 Dec 2019 09:35:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 09:35:26 +0800
Subject: Re: [PATCH v6 0/4] support reserving crashkernel above 4G on arm64
 kdump
To:     Will Deacon <will@kernel.org>
References: <20190830071200.56169-1-chenzhou10@huawei.com>
 <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
 <20191218090932.GA14061@willie-the-truck>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>,
        <dyoung@redhat.com>, <bhsharma@redhat.com>, <horms@verge.net.au>,
        <guohanjun@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <60f9bf3c-62d1-41cc-ad8e-0e06e6495d52@huawei.com>
Date:   Thu, 19 Dec 2019 09:35:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191218090932.GA14061@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will

On 2019/12/18 17:09, Will Deacon wrote:
> On Wed, Dec 18, 2019 at 10:07:59AM +0800, Chen Zhou wrote:
>> Friendly ping...
> 
> You broke the build:
> 
> https://lore.kernel.org/lkml/201909010744.CDe940pv%lkp@intel.com
> https://lore.kernel.org/lkml/201909010704.4m9y2sg7%lkp@intel.com
> 
> So I doubt anybody will seriously look at this.

I was also waiting for other suggestions.
I will fix this in next version.

> 
> Will
> 
> .

Thanks,
Chen Zhou

