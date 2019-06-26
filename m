Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC63FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14732085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFZHOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:14:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfFZHOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:14:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7383ED8A4FDEEF3C92B8;
        Wed, 26 Jun 2019 15:14:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun
 2019 15:13:54 +0800
Subject: Re: [PATCH RESEND] staging: erofs: return the error value if
 fill_inline_data() fails
To:     Yue Hu <zbestahu@gmail.com>, <gaoxiang25@huawei.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <huyue2@yulong.com>
References: <20190626033038.9456-1-zbestahu@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <96f12ad4-e9dc-a688-2c26-2dd285b7b795@huawei.com>
Date:   Wed, 26 Jun 2019 15:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190626033038.9456-1-zbestahu@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/26 11:30, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We should consider the error returned by fill_inline_data() when filling
> last page in fill_inode(). If not getting inode will be successful even
> though last page is bad. That is illogical. Also change -EAGAIN to 0 in
> fill_inline_data() to stand for successful filling.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
