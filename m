Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155E620989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfEHMzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:55:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:8343 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfEHMzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:55:35 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 May 2019 21:55:34 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id D817B180B3E;
        Wed,  8 May 2019 21:55:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 8 May 2019 21:55:34 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 8964B1A04E1;
        Wed,  8 May 2019 21:55:34 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 7AB7A121BCE;
        Wed,  8 May 2019 21:55:34 +0900 (JST)
Subject: Re: serial: Add Milbeaut serial control
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <246f81ba-0ed1-d5bc-1a48-bcf0fb2cc05e@canonical.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <d19f16aa-1066-9a51-a743-4483a1b2ac46@socionext.com>
Date:   Wed, 8 May 2019 21:55:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <246f81ba-0ed1-d5bc-1a48-bcf0fb2cc05e@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for pointing out.

On 2019/05/02 20:47, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity has picked up an issue in commit:
> 
> commit ba44dc04300441b47618f9933bf36e75a280e5fe
> Author: Sugaya Taichi <sugaya.taichi@socionext.com>
> Date:   Mon Apr 15 20:31:40 2019 +0900
> 
>      serial: Add Milbeaut serial control
> 
> In function mlb_usio_rx_chars() the u8 status is being bit-wise AND'd
> with MLB_USIO_SSR_BRK (which is 1UL << 8) and hence the result is always
> false, which looks incorrect to me.  Is this intentional?
>

No. It is always false so should be dropped.
I will send a fixes patch.

Thanks,
Sugaya Taichi

> Colin
> 

