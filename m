Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0B2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EBB222CB
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407456AbfJYIbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:31:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389290AbfJYIbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:31:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4A36215660F7E19A1B36;
        Fri, 25 Oct 2019 16:31:01 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 25 Oct
 2019 16:30:56 +0800
Subject: Re: [PATCH 2/2] f2fs: Add f2fs stats to sysfs
To:     Hridya Valsaraju <hridya@google.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20191023214821.107615-1-hridya@google.com>
 <20191023214821.107615-2-hridya@google.com>
 <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
 <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <96f89e7c-d91e-e263-99f7-16998cc443a7@huawei.com>
Date:   Fri, 25 Oct 2019 16:30:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/25 11:51, Hridya Valsaraju wrote:
> On Thu, Oct 24, 2019 at 2:26 AM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> On 2019/10/24 5:48, Hridya Valsaraju wrote:
>>> Currently f2fs stats are only available from /d/f2fs/status. This patch
>>> adds some of the f2fs stats to sysfs so that they are accessible even
>>> when debugfs is not mounted.
>>
>> Why don't we mount debugfs first?
> 
> Thank you for taking a look at the patch Chao. We will not be mounting
> debugfs for security reasons.

Hi, Hridya,

May I ask is there any use case for those new entries?

So many sysfs entries exist, if there is real use case, how about backuping
entire /d/f2fs/status entry into /proc/fs/f2fs/<dev>/ directory rather than
adding some of stats as a single entry in sysfs directory?

Thanks,

> 
> Regards,
> Hridya
> 
>>
>> Thanks,
> .
> 
