Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE77EC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9361F20848
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578451484;
	bh=tKX/g50PeSf0rckrF3k9pMA9uhtkP8emnoQv2uXvG3E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mp4CsmNxt2zF0yM3/nRw2xj3hxL8IZcxZlMYkTSmsFDiL55nN1V33mwwaH9hVwbEQ
	 Gcw6G6Kt3XNQJaY+aZhtKwzkjyOcsCToDPywiHfiOl2ZhSFUhhOUcTcMFhZhyI/1fA
	 iDFDfrQ767FSRrgQJdZPYn8FVyq06bkktruTiANE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgAHCon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHCon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:44:43 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E212080A;
        Wed,  8 Jan 2020 02:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578451483;
        bh=tKX/g50PeSf0rckrF3k9pMA9uhtkP8emnoQv2uXvG3E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uGE99XwlIlAefJ2pZM/SiGhwB9LgADNjEjEuWjF+TSsVq55Fthi0c4RG1+ApmwbVD
         khvUQl2LtH+rnavUCz7OXyVTvX/jaDeKddBXjE0dcuPrBGg5w1Z3OCn7lHUyLUQ9eH
         1f8A09MCMh9GepXZZXBiyAK7fmZ2m4JNnsMZJ40M=
Subject: Re: [PATCH 4.14 00/74] 4.14.163-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200107205135.369001641@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <afb20973-fd39-9752-80f5-75723625776b@kernel.org>
Date:   Tue, 7 Jan 2020 19:44:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 1:54 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.163 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jan 2020 20:44:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.163-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
