Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D09FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5320675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfCFGcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:32:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfCFGcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:32:47 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A39BDAF0C7F041F4D1FD;
        Wed,  6 Mar 2019 14:32:45 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Mar 2019
 14:32:40 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to check inline_xattr_size
 boundary correctly
From:   Chao Yu <yuchao0@huawei.com>
To:     Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190214160825.4973-1-chao@kernel.org>
 <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
Message-ID: <6849d9c1-f329-7dff-b866-7ecf78d64399@huawei.com>
Date:   Wed, 6 Mar 2019 14:32:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

On 2019/3/4 14:39, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2019/2/15 0:08, Chao Yu wrote:
>> ---
>> v2:
>> - fix lower bound check, inline xattr size should be larger than
>> xattr_header's size at least.
> 
> ...
> 
>> +		if (F2FS_OPTION(sbi).inline_xattr_size <
>> +			sizeof(struct f2fs_xattr_header) / sizeof(__le32)
> 
> No sure we should set this low bound as above... now I guess original
> non-zero check is enough.
> 
> How do you think of setting inline_xattr_size range as
> (0, MAX_INLINE_XATTR_SIZE]?
> 
> Thanks,
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 

