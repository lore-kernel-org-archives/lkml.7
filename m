Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011BBC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48C52084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLOiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:38:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbfDLOiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:38:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7EFF5BA23C32BEA7654;
        Fri, 12 Apr 2019 22:38:19 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 12 Apr
 2019 22:38:10 +0800
Subject: Re: [PATCH v2] staging: erofs: fix unexpected out-of-bound data
 access
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190412095314.224932-1-gaoxiang25@huawei.com>
 <20190412135145.GK6095@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <603ee7f3-aba4-de45-9bf3-8fe70fa2c638@huawei.com>
Date:   Fri, 12 Apr 2019 22:38:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190412135145.GK6095@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/12 21:51, Dan Carpenter wrote:
> On Fri, Apr 12, 2019 at 05:53:14PM +0800, Gao Xiang wrote:
>> Unexpected out-of-bound data will be read in erofs_read_raw_page
>> after commit 07173c3ec276 ("block: enable multipage bvecs") since
>> one iovec could have multiple pages.
>>
>> Let's fix as what Ming's pointed out in the previous email [1].
>>
>> [1] https://lore.kernel.org/lkml/20190411080953.GE421@ming.t460p/
>>
> 
> Please also use the Fixes tag.
> 
> Fixes: 07173c3ec276 ("block: enable multipage bvecs")

Thanks for reminder. Maybe Greg could add this line...

Thanks,
Gao Xiang

> 
>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> regards,
> dan carpenter
> 
