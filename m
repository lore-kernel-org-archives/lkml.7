Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2269C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D452080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553558656;
	bh=oAf2+dYR0feGej2eMzzvA/IR3p+qHjuUXRD8A92zkIc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xzjuARGGBnF5qsUkEb1/jU3DVbh7ruhpEF+YhTXeI/DKGhe2V1BzAw4SvZEf8bviX
	 t4zosoHdenoqApOc3jyjoRut1VJz2TkhBsWAzvMSVHr+QpKfYU298sYjJbPqKL9R2D
	 mKxgXm/87EW0UC/EExQoxALQOC8BV4CEn3mdl4S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfCZAEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfCZAEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:04:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A11482080F;
        Tue, 26 Mar 2019 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553558654;
        bh=oAf2+dYR0feGej2eMzzvA/IR3p+qHjuUXRD8A92zkIc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dUe1XSuOZoUCT5ecb+hWErMNV/jHHIRQInc/LtzC+ZHc7EqSm0cMflzrMLtWglzBB
         qTL5udwlgjvcFDuGGzWuSbtABKT2VphFxPG1wvCQqFJSVaP7BtMy62Rjl6l1afh4CP
         OVYl+ZAXrKPOBygLzqDURBq0TktqcRsveumMnoEk=
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel
 versions
To:     Brian Norris <briannorris@chromium.org>
Cc:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>
References: <20190306214730.6545-1-valleau@chromium.org>
 <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org>
 <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org>
 <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <759fcefa-974b-7430-e7cf-64eabd219d61@kernel.org>
Date:   Mon, 25 Mar 2019 18:04:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 5:02 PM, Brian Norris wrote:
> On Mon, Mar 25, 2019 at 3:07 PM shuah <shuah@kernel.org> wrote:
>> On 3/25/19 11:56 AM, Brian Norris wrote:
>>> On Mon, Mar 25, 2019 at 8:51 AM shuah <shuah@kernel.org> wrote:
>>>> In general the ABI is stable.
>>>
>>> No, it really isn't. This commit was a breaking change:
> ...
>>> But this one is definitely a break:
>>>
>>> commit 1c9de5bf428612458427943b724bea51abde520a
>>> Author: Yuyang Du <yuyang.du@intel.com>
>>> Date: Thu Jun 8 13:04:10 2017 +0800
>>>
>>>     usbip: vhci-hcd: Add USB3 SuperSpeed support
>>>
>>> You can't just arbitrarily add columns to the beginning of a file like
>>> that and claim that you're not breaking ABI. And I shouldn't need to
>>> remind you that Thou Shalt Not Break User Space.
>>
>> USB 3.0 driver and tool support went in, I would say it was oversight to
>> not make sure the tool continues to work on older kernels.
> 
> While that's true, you're still not grokking my main point when asking
> about ABI stability:
> 
>    *old* tools should still work on *new* kernels
> 
> The above commit broke that.
> 

Agreed. Let's move forward with the assumption that this won't happen
in the future.

On a side note, in this specific tool case, the newer version is more
secure than the older version.

thanks,
-- Shuah
