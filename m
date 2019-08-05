Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27309C19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCAF20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHEBOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 21:14:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbfHEBOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 21:14:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3A090BDDD9243CAA8F73;
        Mon,  5 Aug 2019 09:14:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 09:14:01 +0800
Subject: Re: [PATCH net-next] net: can: Fix compiling warning
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <socketcan@hartkopp.net>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>
References: <20190802033643.84243-1-maowenan@huawei.com>
 <133b3357-e0a4-64c8-40b7-02d386e12cef@cogentembedded.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <1d9e329a-eafc-6c32-ee2a-df3b15231a2a@huawei.com>
Date:   Mon, 5 Aug 2019 09:13:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <133b3357-e0a4-64c8-40b7-02d386e12cef@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/2 16:59, Sergei Shtylyov wrote:
> Hello!
> 
> On 02.08.2019 6:36, Mao Wenan wrote:
> 
>> There are two warings in net/can, fix them by setting bcm_sock_no_ioctlcmd
> 
>    Warnings. :-)

Thanks, I will send v2.

> 
>> and raw_sock_no_ioctlcmd as static.
>>
>> net/can/bcm.c:1683:5: warning: symbol 'bcm_sock_no_ioctlcmd' was not declared. Should it be static?
>> net/can/raw.c:840:5: warning: symbol 'raw_sock_no_ioctlcmd' was not declared. Should it be static?
>>
>> Fixes: 473d924d7d46 ("can: fix ioctl function removal")
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> [...]
> 
> MBR, Sergei
> 
> 

