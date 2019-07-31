Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A662C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6762089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfGaJHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:07:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfGaJHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:07:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3146AAB0E869606A36E4;
        Wed, 31 Jul 2019 17:07:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 17:07:28 +0800
Subject: Re: [PATCH 16/22] staging: erofs: tidy up decompression frontend
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-17-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b0d5c746-2450-7ad6-5714-de7ec1f20ea0@huawei.com>
Date:   Wed, 31 Jul 2019 17:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729065159.62378-17-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/29 14:51, Gao Xiang wrote:
> Although this patch has an amount of changes, it is hard to
> separate into smaller patches.
> 
> Most changes are due to structure renaming for better understand
> and straightforward,
>  z_erofs_vle_workgroup to z_erofs_pcluster
>              since it represents a physical cluster;
>  z_erofs_vle_work to z_erofs_collection
>              since it represents a collection of logical pages;
>  z_erofs_vle_work_builder to z_erofs_collector
>              since it's used to fill z_erofs_{pcluster,collection}.
> 
> struct z_erofs_vle_work_finder has no extra use compared with
> struct z_erofs_collector, delete it.
> 
> FULL_LENGTH bit is integrated into .length of pcluster so that it
> can be updated with the corresponding length change in atomic.
> 
> Minor, add comments for better description.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

I hope I don't miss anything, since this is so huge cleanup...

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
