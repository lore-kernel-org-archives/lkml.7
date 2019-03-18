Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5047EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258EA20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfCRPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:41:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfCRPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:41:20 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B77F3E18EDE1E875B9F;
        Mon, 18 Mar 2019 23:41:18 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 18 Mar
 2019 23:41:11 +0800
Subject: Re: [PATCH v3] staging: erofs: Add whitespace after declaration
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bharath Vedartham <linux.bhar@gmail.com>
CC:     <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20190318153224.GA3596@bharath12345-Inspiron-5559>
 <20190318153816.GA15943@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <863a7266-0068-a751-bbe6-cea78caf9355@huawei.com>
Date:   Mon, 18 Mar 2019 23:40:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190318153816.GA15943@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/18 23:38, Greg KH wrote:
> On Mon, Mar 18, 2019 at 09:02:24PM +0530, Bharath Vedartham wrote:
>> Add whitespace after declaration. Fixed the checkpatch.pl warning.
>>
>> ---
> 
> No signed-off-by?
> 
>> changes since v2
>> 	- mutt gave me a lot of problems. Hence 3 patches for a really
>> 	  small problem.
>> 	- Fixed the extra missing line.
>>
>> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> 
> It needs to be above the --- line, otherwise it will be stripped off
> when applied.
> 
> v4 please?

Actually a duplicate commit, see:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=8af36478f9516d51fcfedf9b9ed8905a1c00d278

several people submit patches on this line in erofs_iget()....

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
