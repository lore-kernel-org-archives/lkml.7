Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0749BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569FE2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556209399;
	bh=mdMWSmQ9A/6WipH8G3ou0Tv8+gmSGQnNBCInH63NinU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=snwu/iahoXe8gI9G/BAgM7mdxPsjIAHLzI/FZxOYvSB9GqiZi4y6c+VHWgPyGyeHj
	 yjgqbSZXCAYyNHy8m7zU0qRWrtMzv9zR//FlPpv0xBqqjqMvKIVpPmsCA4ZdX2Q2lO
	 X1IKNEQKjQms4jVhm/o5G35076PL1/U7xjvJSXuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfDYQXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfDYQXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:23:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E232077C;
        Thu, 25 Apr 2019 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556209397;
        bh=mdMWSmQ9A/6WipH8G3ou0Tv8+gmSGQnNBCInH63NinU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kWNekj3xvjsO5qPz1D8soOWD9Zatp3ERjDGG2dv5k91rC6iAUTAzlJLpybP7RYRHo
         DOOMbhRJsmGMYm49cxZ70q9AtVDa/8nW2oNgGx/jLzTCffP1wsm/DEsk3tRuTjmMkt
         8UoCFDi9A5Cgz4NLH0hi4zM4V8OneMblUOnhmGLk=
Subject: Re: [PATCH 3.18 000/104] 3.18.139-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190424170839.996641496@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3e4f0ed7-84bb-f8fb-0ed5-9dea28741925@kernel.org>
Date:   Thu, 25 Apr 2019 10:23:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 11:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.139 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:26 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.139-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
