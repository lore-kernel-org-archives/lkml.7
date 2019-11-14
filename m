Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C612071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKNNNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:13:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfKNNNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:13:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 18CACFB1E458C6647982;
        Thu, 14 Nov 2019 21:13:16 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 21:13:13 +0800
Subject: Re: [PATCH -next] ubi: remove unused variable 'err'
To:     Miquel Raynal <miquel.raynal@bootlin.com>
References: <20191114072236.15104-1-yuehaibing@huawei.com>
 <20191114110053.4fbeb918@xps13>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <f9a8e5f3-cea9-a251-9627-63dfb34149c7@huawei.com>
Date:   Thu, 14 Nov 2019 21:13:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191114110053.4fbeb918@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/14 18:00, Miquel Raynal wrote:
> Hi Yue,
> 
> YueHaibing <yuehaibing@huawei.com> wrote on Thu, 14 Nov 2019 15:22:36
> +0800:
> 
>> drivers/mtd/ubi/debug.c:512:6: warning: unused variable 'err' [-Wunused-variable]
>>
>> commit 3427dd213259 ("mtd: no need to check return value
>> of debugfs_create functions") leave this variable not used.
> 
> Thanks for the fix but I already fixed this trivial issue, I just
> did not had time yesterday night to push it, now it is done. It will
> be part of tomorrow's linux-next release.

Ok, thanks for the info.

> 
> Cheers,
> Miquèl
> 
> .
> 

