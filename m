Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94ADC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8731321A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfIZBEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:04:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfIZBEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:04:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9C7AF081E2BB4CD68B6;
        Thu, 26 Sep 2019 09:04:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 26 Sep
 2019 09:04:12 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix comment of f2fs_evict_inode
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190925093050.118921-1-yuchao0@huawei.com>
 <20190925134706.GA157912@architecture4>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4f1a7400-04d3-ff1e-3ea0-cf5b95af972c@huawei.com>
Date:   Thu, 26 Sep 2019 09:04:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190925134706.GA157912@architecture4>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/25 21:47, Gao Xiang wrote:
> Hi Chao,
> 
> On Wed, Sep 25, 2019 at 05:30:50PM +0800, Chao Yu wrote:
>> evict() should be called once i_count is zero, rather than i_nlinke
>> is zero.
>>
>> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/inode.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index db4fec30c30d..8262f4a483d3 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>>  }
>>  
>>  /*
>> - * Called at the last iput() if i_nlink is zero
>> + * Called at the last iput() if i_count is zero
> 
> Yeah, I'd suggest taking some time to look at other
> inconsistent comments, it makes other folks confused
> and ask me with such-"strong" reason...

Xiang, I'm looking into it, will fix those inconsistent comments in another
patch, please wait a while. ;)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>   */
>>  void f2fs_evict_inode(struct inode *inode)
>>  {
>> -- 
>> 2.18.0.rc1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
