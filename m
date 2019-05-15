Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E6FC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CD02084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEOGww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:52:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2954 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfEOGwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:52:51 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id C88F7FC871D590D4C14A;
        Wed, 15 May 2019 14:52:49 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 May 2019 14:52:49 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 15 May 2019 14:52:48 +0800
Subject: Re: [PATCH] staging: erofs: drop unneeded -Wall addition
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        <linux-erofs@lists.ozlabs.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20190515043123.9106-1-yamada.masahiro@socionext.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8e8baf6c-b604-5546-7530-53d0fa8dcea1@huawei.com>
Date:   Wed, 15 May 2019 14:52:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190515043123.9106-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/15 12:31, Masahiro Yamada wrote:
> The top level Makefile adds -Wall globally:
> 
>   KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
> 
> I see two "-Wall" added for compiling objects in drivers/staging/erofs/.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
