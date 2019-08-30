Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE39C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FC720578
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfH3D3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:29:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727578AbfH3D3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:29:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C580825E6CF6E6376F14;
        Fri, 30 Aug 2019 11:29:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 11:29:38 +0800
Subject: Re: [PATCH v2 3/7] erofs: use a better form for complicated on-disk
 fields
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Joe Perches" <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
 <20190830030040.10599-3-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <018574c9-e0b8-1fa8-fd6f-9197b9c7d281@huawei.com>
Date:   Fri, 30 Aug 2019 11:29:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190830030040.10599-3-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/30 11:00, Gao Xiang wrote:
> As Joe Perches [1] suggested, let's use a better
> form to describe complicated on-disk fields.
> 
> p.s. it has different tab alignment looking between
>      the real file and patch file.
> p.p.s. due to changing a different form, some lines
>        have to exceed 80 characters.
> [1] https://lore.kernel.org/r/67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com/
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
