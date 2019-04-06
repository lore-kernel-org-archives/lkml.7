Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030EDC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 05:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2312186A
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 05:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDFFrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 01:47:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfDFFrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 01:47:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0FC014E880943E57F9AB;
        Sat,  6 Apr 2019 13:47:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Sat, 6 Apr 2019
 13:47:15 +0800
Subject: Re: [PATCH] sysctl: redefine zero as a unsigned long
CC:     <mcgrof@kernel.org>, <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>
References: <20190405065217.125140-1-houtao1@huawei.com>
 <20190405162709.GQ22763@bombadil.infradead.org>
From:   Hou Tao <houtao1@huawei.com>
To:     <mcroce@redhat.com>, <akpm@linux-foundation.org>
Message-ID: <f5dcc987-3630-d51c-f1ea-c78dea7fb11b@huawei.com>
Date:   Sat, 6 Apr 2019 13:47:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190405162709.GQ22763@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cc Andrew for patch inclusion

On 2019/4/6 0:27, Matthew Wilcox wrote:
> On Fri, Apr 05, 2019 at 02:52:17PM +0800, Hou Tao wrote:
>> We have got KASAN splat when tried to set /proc/sys/fs/file-max:
> 
> Matteo Croce already has a patch in-flight for this.
> 
> 
Yes, I find it now: https://lkml.org/lkml/2019/3/28/320. And the fix posted
by Matteo has also been acked by Kees and has the Fixes tag.

So Andrew, could you please take Matteo's patch in your tree ?

Regards,
Tao

