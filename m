Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6A9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B009420878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221422;
	bh=YzEBQMIXdQu3DmEeibuqftlk9xUGTtYM+2sCQw5SGbI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PRyHHvKyJw4OxTpe8JfK1Isj5GuKjJakk669Waq9whhTGzpxSzN+r2pexmwS7BhFi
	 Q1wOA5/9KGicnR302l4u/4Zc8eyDohjmQHzj86Lea8t2YsBlOuRzDDhTAPvHHD/TXW
	 Axec9JnUtGLGUZDPenDBcH3dNoLNTZ18E9gXAu9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfDYTnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:43:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039D0205ED;
        Thu, 25 Apr 2019 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221420;
        bh=YzEBQMIXdQu3DmEeibuqftlk9xUGTtYM+2sCQw5SGbI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PhbMhyQETta+z0lnUb7wfM0HykaostdPWl2qt2kBfqAkAPu6E4tN0FWth7D+nCCEb
         0k1O44ObHcvZXMf7QOeGH8vPo+RiE8Ezv+cbDZp/P+FBEG0HWsES+j4Tf7EEbU4hEr
         LzbgAMFhV5P6NFmFFNSvFCWzghFoKE822Wmyy8qE=
Subject: Re: [PATCH] selftests : netfilter: Wrote a error and exit code for a
 command which needed veth kernel module.
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        pablo@netfilter.org
Cc:     Florian Westphal <fw@strlen.de>, linu-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in>
 <20190405164746.pfc6wxj4nrynjma4@breakpoint.cc>
 <CAG=yYwnN37OoL1DSN8qPeKWhzVJOcUFtR-7Q9fVT5AULk5S54w@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c4660969-1287-0697-13c0-e598327551fb@kernel.org>
Date:   Thu, 25 Apr 2019 13:43:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG=yYwnN37OoL1DSN8qPeKWhzVJOcUFtR-7Q9fVT5AULk5S54w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/19 6:39 AM, Jeffrin Thalakkottoor wrote:
> Hello Shuah,
> 
> did you get the mail related stuff below ?
> 

Yes I saw this patch.

> On Fri, Apr 5, 2019 at 10:17 PM Florian Westphal <fw@strlen.de> wrote:
>>
>> Jeffrin Jose T <jeffrin@rajagiritech.edu.in> wrote:
>>> A test for  the basic NAT functionality uses ip command which
>>> needs veth device.There is a condition where the kernel support
>>> for veth is not compiled into the kernel and the test script
>>> breaks.This patch contains code for reasonable error display
>>> and correct code exit.
>>
>> Looks good to me, thanks for following up on this.
>>
>> Acked-by: Florian Westphal <fw@strlen.de>
> 
> 
> 

Pablo,

Would you like me to take this patch through ksleftest tree?
If you want to take this through netfilter tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

