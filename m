Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0BEC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1252183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfDRHLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:11:02 -0400
Received: from mx.socionext.com ([202.248.49.38]:11389 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfDRHLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:11:01 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Apr 2019 16:11:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id DCEB91800F6;
        Thu, 18 Apr 2019 16:11:00 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 18 Apr 2019 16:11:00 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 507961A15B7;
        Thu, 18 Apr 2019 16:11:00 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 37C141217B3;
        Thu, 18 Apr 2019 16:11:00 +0900 (JST)
Subject: Re: [PATCH] serial: Fix using plain integer instead of Null pointer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1555568485-6421-1-git-send-email-sugaya.taichi@socionext.com>
 <20190418064045.GA12503@kroah.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <85e1a238-aa87-ad56-3703-9556f0aa3613@socionext.com>
Date:   Thu, 18 Apr 2019 16:10:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418064045.GA12503@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/04/18 15:40, Greg Kroah-Hartman wrote:
> On Thu, Apr 18, 2019 at 03:21:25PM +0900, Sugaya Taichi wrote:
>> Fix build warning that using plain integer as Null pointer.
>> This is reported by kbuild test robot.
>>
>> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   drivers/tty/serial/milbeaut_usio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Using a "Reported-by:" tag is usually a good idea.  I'll add it when I
> apply the patch, but for next time can you please add it?
> 

Yes, of course!
I will add the tag in the next chance.

Thanks a lot!
Sugaya Taichi

> thanks,
> 
> greg k-h
> 

