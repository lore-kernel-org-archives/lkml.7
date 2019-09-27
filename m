Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5CD208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfI0BBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:01:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfI0BBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 21:01:36 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 509E8ABA564421E84065;
        Fri, 27 Sep 2019 09:01:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 09:01:33 +0800
Subject: Re: [PATCH] async: Using current_work() to implement
 current_is_async()
To:     Bart Van Assche <bvanassche@acm.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <dsterba@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        <sakari.ailus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <395617ec-ef92-c20f-d5c1-550b47a07f6d@huawei.com>
 <8336ea6a-bc98-bd45-b317-3fc8d5f1d9f8@acm.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <d4554101-b68c-e761-6d1e-d6f1069a0631@huawei.com>
Date:   Fri, 27 Sep 2019 09:01:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8336ea6a-bc98-bd45-b317-3fc8d5f1d9f8@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/26 23:27, Bart Van Assche wrote:
> On 9/26/19 1:40 AM, Yunfeng Ye wrote:
>> current_is_async() can be implemented using current_work(), it's better
>> not to be aware of the workqueue's internal information.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
I will update the patch with Reviewed-by, thanks.
> .
> 

