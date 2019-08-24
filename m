Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C5C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D5422CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566666082;
	bh=PsVYKPeLGylvxL45W+0jiW0BvrVx3hxT1IbOp37s3uY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ctIzB9X/BOPRd2Bqq8flSv8XZg0/hqbChRgl6AxDdHPg5PcSJGtj2HGR8AN2UjQ2+
	 NrnUwoHqIh8x8phvuUJCFGuTZIAyr8u5njFAHXDWbzllvqAs0mukOEQfMMLirYt4LN
	 FvwT5NlsXhfkSLk76kE66c37fG/uNZt92mqboEfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfHXRBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 13:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfHXRBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 13:01:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3114B2173E;
        Sat, 24 Aug 2019 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566666080;
        bh=PsVYKPeLGylvxL45W+0jiW0BvrVx3hxT1IbOp37s3uY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vnnK2pS8/apoAAIk2CKDr8RgnnrAdqSSrkzaMaTBVWHIMIiyWYhCEJPsFRhFdpG+C
         ST4RlLDYWvS61K84aKOXBzIBnWhauWZc8/7HzBOIPbx87UY6x41Az8D11CKj4gUezU
         U1PKUbubQNg1TvgRGYaK0kokrhS3e1FL9Tb1SKOg=
Subject: Re: [PATCH 5.2 000/135] 5.2.10-stable review
To:     Greg KH <greg@kroah.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, shuah <shuah@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
 <00216731-a088-7d47-eafb-70409f876bda@kernel.org>
 <20190824023829.GE9862@kroah.com>
 <e4d5ba59-8e38-a267-8a14-3c6bc03f77bd@kernel.org>
 <20190824153348.GA27505@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <93850e40-7df9-b5db-bda4-5b4354d2c3f3@kernel.org>
Date:   Sat, 24 Aug 2019 11:01:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824153348.GA27505@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/19 9:33 AM, Greg KH wrote:
> On Sat, Aug 24, 2019 at 09:21:53AM -0600, shuah wrote:
>> On 8/23/19 8:38 PM, Greg KH wrote:
>>> On Fri, Aug 23, 2019 at 12:41:03PM -0600, shuah wrote:
>>>> On 8/22/19 11:05 AM, Sasha Levin wrote:
>>>>>
>>>>> This is the start of the stable review cycle for the 5.2.10 release.
>>>>> There are 135 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Sat 24 Aug 2019 05:07:10 PM UTC.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>>            https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.2.10-rc1.gz
>>>>
>>>> I am seeing "Sorry I can't find your kernels". Is this posted?
>>>
>>> Ah, Sasha didn't generate the patch but it was still listed here, oops.
>>> He copied my format and we didn't notice this, sorry about that.
>>>
>>> As the thread shows, we didn't generate this file this time to see what
>>> would happen.  If your test process requires it, we can generate it as I
>>> don't want to break it.
>>>
>>
>> It will make it lot easier for me to have continued support for patch
>> generation. My scripts do "wget" to pull the patch and apply.
> 
> Ok, we will get this back and working, sorry about that.
> 

Great. Thanks for accommodating my workflow.

thanks,
-- Shuah
