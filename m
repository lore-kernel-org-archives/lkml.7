Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDB7C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486A520833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tghixlPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfFJHOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:14:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40804 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbfFJHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:14:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so4525200pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FskRycTTyw9VRob7qpJa6qG+/LxbamrBi5S18mFOQHg=;
        b=tghixlPkQyso0KUDuc1jCi34GALkRrwpmUJCfEdsgePr9fCl8KIOf0HrwH000EF5Uu
         BlrHQ17p+/fSj1TVH4L5J10yWB4diMPseHlK6WcGIG4cklfdigVsMSgWX2rLjf4Ct3lI
         EAV3k7XTbF6S6O1ONRnBDM0jCmRryMcFfGObQJg5XQWzivOZ1qm4+oKPI6JOz4CaaiHB
         Igb2hwMHvj2wrahAu8GmF4ZpneQV5WfVlREC1s1r3EAostvEQ1Ceom+YGTOjUb207QAw
         wUgQ1dlMNKh75jk0XFuzVnEhb79tNV9XBBRbjFjEy5NFdrv9toWOVXMNgK+b2kBSRSXX
         vLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FskRycTTyw9VRob7qpJa6qG+/LxbamrBi5S18mFOQHg=;
        b=C0uPAdCP0NEsHKTVsLiqLpNQWzEVRX3qwP1YtSKMOBfcqPdvzQwsu/jDyq+chNG1Wv
         GjXifD6oJFgX6JhBcshOS9GuIsPEn288IlessPW3OLXs2UALKce/NqjGk6HGfh5N68Bm
         K0IzAnifVXXDDwLzEFqYu68y1P/DWkip2AYKpF8l+nTvWA1Q8k8F+0NcmEnxs2233V6V
         GNT3nelo5bCd7j68tUd0fmzhswZpxP8TG7xXL2vqa+QqCEvMuekTY9vtrhu8rpEyyksy
         vqjXr/JN7/kZ8PzfX9kuwKgneYE6ecjMezeFj4GSwUe80TwJFo0ndkizbxUPj0eMI9q8
         rFiw==
X-Gm-Message-State: APjAAAUxl+tnKWwaeGewm8Q7Bfp/2NBNPmSNgjZx9XcovNS35cxx3YOq
        RmYu+6MKuX/eeSwtSJ516CWQWYP1
X-Google-Smtp-Source: APXvYqwPS2FKtnEXjVaAkSwbEk/iqraTtbkreDdnS2XmmJkV024GJpWEejPAC4UPdtJ+95cB1AHp9A==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr20064499pjj.44.1560150849546;
        Mon, 10 Jun 2019 00:14:09 -0700 (PDT)
Received: from [10.0.2.15] ([171.79.92.225])
        by smtp.gmail.com with ESMTPSA id m5sm2010017pjl.24.2019.06.10.00.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 00:14:09 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove unused
 variables
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, hardiksingh.k@gmail.com,
        linux-kernel@vger.kernel.org, benniciemanuel78@gmail.com
References: <20190607071123.28193-1-nishkadg.linux@gmail.com>
 <20190609110206.GD30671@kroah.com>
 <74fd5a83-0f60-baae-a65f-bbc0cd9f4ad0@gmail.com>
 <20190610054927.GA13124@kroah.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <7554e171-360f-f0a8-5742-9a60e4a1cc2d@gmail.com>
Date:   Mon, 10 Jun 2019 12:44:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610054927.GA13124@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/19 11:19 AM, Greg KH wrote:
> On Mon, Jun 10, 2019 at 10:08:21AM +0530, Nishka Dasgupta wrote:
>> On 09/06/19 4:32 PM, Greg KH wrote:
>>> On Fri, Jun 07, 2019 at 12:41:23PM +0530, Nishka Dasgupta wrote:
>>>> Remove variables that are declared and assigned values but not otherwise
>>>> used.
>>>> Issue found with Coccinelle.
>>>>
>>>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>>>> ---
>>>>    drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 ---------
>>>>    1 file changed, 9 deletions(-)
>>>
>>> You sent me 8 patches for this driver, yet only 2 were ordered in a
>>> series.  I have no idea what order to apply these in :(
>>>
>>> Please resend them _all_ in a numbered patch series so I have a chance
>>> to get this correct.
>>
>> Yes, I can do that. Who do I send the patch series to in that case? The
>> maintainers list is slightly different for each file, and most of the
>> patches in this driver are for different and unrelated files (except, I
>> think, the two that I did send as a patch series). Do I combine the
>> maintainers lists and send the entire patch series to everyone listed as a
>> maintainer for any one of the patches in it?
> 
> The maintainer and mailing list is the same for all of the files in a
> single driver.  If not, then something is wrong.

I'm using get_maintainers.pl with no arguments, and for rtl8723bs, I am 
getting a lot of different mailing lists.
E.g
For core/rtw_ieee80211.c, I'm getting the following list:
Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Michael Straube <straube.linux@gmail.com>
Andy Shevchenko <andy.shevchenko@gmail.com>
Hardik Singh Rathore <hardiksingh.k@gmail.com>
Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>
Nishka Dasgupta <nishkadg.linux@gmail.com>
devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Which is not the same as for core/rtw_mlme_ext.c (the current patch).

> And yes, you can combine the list of people if you wish but be sure you
> are not just randomly including people who happened to touch the driver
> "last".

Okay, I'll combine then. But is there any metric I should be using to 
filter the output of get_maintainer.pl? Currently I'm running it with no 
arguments and just adding everyone.

Thanking you,
Nishka

> greg k-h
> 

