Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B1E21019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfCYB2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:28:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729105AbfCYB2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:28:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5DF6D5923D1EF27965C;
        Mon, 25 Mar 2019 09:28:00 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 25 Mar
 2019 09:27:51 +0800
Subject: Re: [PATCH 1/3] staging: erofs: fix error handling when failed to
 read compresssed data
To:     Sasha Levin <sashal@kernel.org>, Chao Yu <yuchao0@huawei.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>
References: <20190319135501.28712-1-gaoxiang25@huawei.com>
 <20190325003840.2176F2133F@mail.kernel.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <cf08567f-6a18-9d32-a9e4-c77f8c4fcd1f@huawei.com>
Date:   Mon, 25 Mar 2019 09:27:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190325003840.2176F2133F@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/3/25 8:38, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 3883a79abd02 staging: erofs: introduce VLE decompression support.
> 
> The bot has tested the following trees: v5.0.3, v4.19.30.
> 
> v5.0.3: Build OK!
> v4.19.30: Failed to apply! Possible dependencies:
>     390c642e1264 ("staging: erofs: fix integer overflow on 32-bit platform")
>     42d40b4ad840 ("staging: erofs: unzip_vle.c: Replace comparison to NULL.")
>     6e78901a9f23 ("staging: erofs: separate erofs_get_meta_page")
>     7dd68b147d60 ("staging: erofs: use explicit unsigned int type")
>     8be31270362b ("staging: erofs: introduce erofs_grab_bio")
>     9248fce714d5 ("staging: erofs: revisit the page submission flow")
>     a07eeddf5b63 ("staging: erofs: clean up z_erofs_map_blocks_iter")
>     ab47dd2b0819 ("staging: erofs: cleanup z_erofs_vle_work_{lookup, register}")
>     b27661cf99c2 ("staging: erofs: fold in `__update_workgrp_llen'")
>     c1448fa88025 ("staging: erofs: introduce MNGD_MAPPING helper")
> 
> 
> How should we proceed with this patch?

I will do the 4.19 backport patch after get a "Reviewed-by: " tag,
thanks for the reminder.

Thanks,
Gao Xiang

> 
> --
> Thanks,
> Sasha
> 
