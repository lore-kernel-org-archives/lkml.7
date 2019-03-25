Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463D820863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfCYCv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 22:51:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729154AbfCYCvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 22:51:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C977FBF4C17C19322468;
        Mon, 25 Mar 2019 10:51:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Mar 2019
 10:51:15 +0800
Subject: Re: [PATCH v2] dccp: Fix memleak in __feat_register_sp
To:     David Miller <davem@davemloft.net>
References: <20190322134348.15048-1-yuehaibing@huawei.com>
 <20190324.201226.2195904854628723725.davem@davemloft.net>
CC:     <gerrit@erg.abdn.ac.uk>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <dccp@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <f86a5326-2681-1d8f-094a-4316837f7beb@huawei.com>
Date:   Mon, 25 Mar 2019 10:51:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190324.201226.2195904854628723725.davem@davemloft.net>
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/25 8:12, David Miller wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> Date: Fri, 22 Mar 2019 21:43:48 +0800
> 
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> If dccp_feat_push_change fails, we forget free the mem
>> which is alloced by kmemdup in dccp_feat_clone_sp_val.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: kfree 'val --> 'fval'
> 
> Don't submit any patches for at least 2 days, I am getting really tired of
> changes you don't even COMPILE TEST:
> 
>   CC [M]  net/dccp/feat.o
> net/dccp/feat.c: In function ¡__feat_register_sp¢:
> net/dccp/feat.c:742:13: error: invalid type argument of ¡->¢ (have ¡dccp_feat_val¢ {aka ¡union <anonymous>¢})
>    kfree(fval->sp.vec);
>       

I'm very sorry for this, will self-reflection.

       ^~
> 

