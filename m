Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD02C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D44B20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552078798;
	bh=LH9FhbsnfmggjdnGlt2h/qYxyY2qO+SJVvxWOi9hqa8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZiwsskIYe6l/aAzWDsB/aYZL6Ix/d6DPB/bcFg7YI8ZwYV9bDxAsU3uj9MLeEuGL3
	 svhZyEmRh9L+dpI/h7dxsyGL5LVMJdWMlQw74/pULZDT9Cuwelh/I2JeB0mfKi/qN0
	 UzTfUsPKYBTjRWFiT2RcisX1lIrZ71h6+o2aj1MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCHU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:59:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfCHU74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:59:56 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0C420851;
        Fri,  8 Mar 2019 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552078795;
        bh=LH9FhbsnfmggjdnGlt2h/qYxyY2qO+SJVvxWOi9hqa8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Io/VEQ+b9613/ON3ktAnkKZUUmqsuiSXFLJAsee1ziN42MUdSqokNJKImf7yetZFh
         JXXtIM0z0VjXOG49iLnxuY4IFT8TnRF+9LHjYmYiD7E22x342sDa7o2nlAZmDjp6t5
         X1RkhdYdAsfQIV/5+4pV5kwQqQKvdT4lxA25vRso=
Subject: Re: [PATCH 4.19 00/68] 4.19.28-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190308124910.696595153@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <83845a72-0a1b-3e96-bd90-56da8ba6e223@kernel.org>
Date:   Fri, 8 Mar 2019 13:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 5:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.28 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 10 12:48:45 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.28-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
