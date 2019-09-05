Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E43C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5522173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfIEFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:48:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfIEFsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:48:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D9BB35487A5F82F717B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 13:48:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 13:48:07 +0800
Message-ID: <5D70A196.3020106@huawei.com>
Date:   Thu, 5 Sep 2019 13:48:06 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: drm/amdgpu: remove the redundant null check
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com> <62b33279-9ca9-5970-5336-a8511ce54197@web.de>
In-Reply-To: <62b33279-9ca9-5970-5336-a8511ce54197@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/5 1:50, Markus Elfring wrote:
>> debugfs_remove and kfree has taken the null check in account.
>> hence it is unnecessary to check it. Just remove the condition.
> How do you think about a wording like the following?
>
>   The functions “debugfs_remove” and “kfree” tolerate the passing
>   of null pointers. Hence it is unnecessary to check such arguments
>   around the calls. Thus remove the extra condition check at two places.
>
It's better, Thanks
>> No functional change.
> I find this information questionable while it is partly reasonable
> according to the shown software refactoring.
>
> Can a subject like “[PATCH] drm/amdgpu: Remove two redundant
> null pointer checks” be nicer here?
>
It's more clearer, thanks,  Will repost using above description in v2.
> Were any source code analysis tools involved for finding
> these update candidates?
With the help of Coccinelle. You can find out some example in scripts/coccinelle/.

Sincerely,
zhong jiang
> Regards,
> Markus
>
> .
>


