Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5162FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC45208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aH8oaMCS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CxdkT4Ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDATzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:55:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDATzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:55:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B2AD608CC; Mon,  1 Apr 2019 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554148505;
        bh=lg/WjPP7fSXj1sQ85Vza08p52bmkE+SZGn+BlcDkwJs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aH8oaMCSbcZzy07RgKla9d8G7J3AbEJ2pekw7wljfOvmWkP82KNlvR/Jl6RGPKwCC
         pMntGIKtuCX6os+v9/xT1Tn+/SWdGrIXpeQU/wLcsAYhhmic9RWjRWTPhcKRuK97+z
         kTTkzrzBzA0RHIaiJCPCdjxLTj7yFvoV7P9Y3kAM=
Received: from [10.79.170.163] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0976D60736;
        Mon,  1 Apr 2019 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554148504;
        bh=lg/WjPP7fSXj1sQ85Vza08p52bmkE+SZGn+BlcDkwJs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CxdkT4YeF7+he2AavZRwwNWysZWxrOr/wfWfurJFdZIfwKYXfQqDi4CApoaRf9pr5
         Xss1m2YfD2bAMsDX9vb8SvKo2dk902ehKkQnSHmoxtyWpqdalNK/9Ul6GdkX9wlhI7
         ZVrYO6yvD7AdNCHzoAcaIAhwC3T6LMlAOLuSr/O4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0976D60736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/4] staging: iio: ad9832: add SPDX identifier
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
References: <20190401143724.mcn73jhdtq3zp3nk@smtp.gmail.com>
 <ac167cc8-4236-2e15-d5f2-fa222d95da49@codeaurora.org>
 <20190401171355.GA19716@kroah.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0e1a0be4-e2f3-fb09-3d2b-e8a52b87f7e5@codeaurora.org>
Date:   Tue, 2 Apr 2019 01:24:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401171355.GA19716@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:43 PM, Greg KH wrote:
> On Mon, Apr 01, 2019 at 08:36:50PM +0530, Mukesh Ojha wrote:
>> On 4/1/2019 8:07 PM, Marcelo Schmitt wrote:
>>> Add SPDX identifier of GPL-2.0 for the ad9832 driver.
>>>
>>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>>> ---
>>>    drivers/staging/iio/frequency/ad9832.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
>>> index 50a583020072..d8d4a7936275 100644
>>> --- a/drivers/staging/iio/frequency/ad9832.c
>>> +++ b/drivers/staging/iio/frequency/ad9832.c
>>> @@ -1,9 +1,8 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>> FYI
>>
>> Use C notations here as per https://lkml.org/lkml/2019/2/13/570.
>>
>> <https://lkml.org/lkml/2019/2/13/570>
>>
>> Once you fix it then you can take mine
>> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Did you read the documentation about how to put a proper SPDX line in
> the kernel documentation?  For .c files, you have to use "//", not "/* */"
>
> Please read:
> 	Documentation/process/license-rules.rst
> and see the section "Style" for all of the details.
Thanks for the detail Greg.

Missed the fact.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>
> thanks,
>
> greg k-h
