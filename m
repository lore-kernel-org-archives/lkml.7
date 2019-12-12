Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD161C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B0F22B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576118830;
	bh=4pW158F0CF5QGH/4WSUmqslDKdwjBrYUjR8Di5PgTEQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AzWwHNN0vF6ZHh5gWsqxnjbqW2gLs0H+Tib4Hj4GPjKiiliLDHKQhNhyEomOFDzo4
	 giUD4RKKCLjmorIUDYDjEb80SgrcNzRkMNF4Uq/Sh4/rWy6BpfEx8FmK+Lnt6b0R6P
	 p37hl2wtCJkbp6mhi+uebWWBqx5riJex0QvVL0u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfLLCrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfLLCrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:47:09 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1ACF22527;
        Thu, 12 Dec 2019 02:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576118829;
        bh=4pW158F0CF5QGH/4WSUmqslDKdwjBrYUjR8Di5PgTEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KxwQ7PXEnw4ojJP7BHrsOTi4QgprZBKOJoxE37zkLwVcv8Yqcgga6KYr4jbQAevsP
         izcujT96dKwS0gS0aZQmA/qTlsj9+dPrn1p1lqcMdN4xbUcBnFeiIJ/4Ous+2kzWY+
         2+3hgoSSInhEfCY9A3RVPsTXffxwAo/ZsSE0C06M=
Subject: Re: [PATCH 4.19 000/243] 4.19.89-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191211150339.185439726@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <84a8181f-e8f5-af7f-9c64-effde6d2dc4c@kernel.org>
Date:   Wed, 11 Dec 2019 19:47:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 8:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.89 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.89-rc1.gz
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
