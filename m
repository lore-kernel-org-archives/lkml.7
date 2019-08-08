Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67245C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430B121874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfHHGqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:46:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfHHGqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:46:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F10AA387A0EDCAB66BF8;
        Thu,  8 Aug 2019 14:46:48 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 14:46:42 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix build error while CONFIG_NLS=m
To:     Chao Yu <yuchao0@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
References: <20190808020253.27276-1-yuehaibing@huawei.com>
 <4e1c457e-621f-e9bd-e625-3a9f27da2277@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <c93cdedd-2144-79d9-92ac-a3e02f58a5ef@huawei.com>
Date:   Thu, 8 Aug 2019 14:46:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4e1c457e-621f-e9bd-e625-3a9f27da2277@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/8 14:18, Chao Yu wrote:
> Hi Haibing,
> 
> Thanks for the patch!
> 
> Out of curiosity, does Hulk Robot check linux-next git repo as well? This will
> be more valuable if the bug can be found during development of related patch?

Yes, Hulk Robot now do this on linux-next.git and linux.git every day.

> 
> On 2019/8/8 10:02, YueHaibing wrote:
>> If CONFIG_F2FS_FS=y but CONFIG_NLS=m, building fails:
>>
>> fs/f2fs/file.o: In function `f2fs_ioctl':
>> file.c:(.text+0xb86f): undefined reference to `utf16s_to_utf8s'
>> file.c:(.text+0xe651): undefined reference to `utf8s_to_utf16s'
>>
>> Select CONFIG_NLS to fix this.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> .
> 

