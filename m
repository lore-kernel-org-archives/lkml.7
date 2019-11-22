Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB1FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377DB20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKVDpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:45:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfKVDpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:45:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C054EA336454F4F117DE;
        Fri, 22 Nov 2019 11:45:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 22 Nov 2019
 11:45:17 +0800
Subject: Re: [RESEND PATCH v4 00/10] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
To:     Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Elena Reshetova" <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20191121115902.2551-1-will@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2d008348-e000-0627-132f-7fc8990de3a4@huawei.com>
Date:   Fri, 22 Nov 2019 11:44:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191121115902.2551-1-will@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/21 19:58, Will Deacon wrote:
> Hi everybody,
> 
> This is a resend of version four of the patches I posted here:
> 
>   v4: https://lore.kernel.org/lkml/20191030143035.19440-1-will@kernel.org
> 
> Previous versions can be found at:
> 
>   v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
>   v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
>   v3: https://lkml.kernel.org/r/20191007154703.5574-1-will@kernel.org
> 
> I didn't receive any feedback last time around, other than some positive
> noises from Kees, so please consider this for inclusion in mainline.

This time I tested this patch set on both ARM64 and x86 server, against
5.4-rc8.

On ARM64, similar test case and the similar performance improvement.

On X86, I tested on a 24 cores Xeon(R) CPU E5-2620, with kernel compile
(make -j) for test case, and no issue was found.

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

