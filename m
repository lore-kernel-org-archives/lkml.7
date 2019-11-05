Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57859C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E7021929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572972755;
	bh=nJYNKwViMyU8WZcqIbzeYXr6iFhKDQYiwtdQNOzWjIM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=F41WtfA8ESBWLJHibGXhFA4cHTsv3KWX4gvtpSkZTXEk6pt5MGhvbrNFSSd3gXbqQ
	 hvWszDG76xPyY1SBwk/LyXgZ6m87m52zDjm1+Ocy7nn8kvtrTestclC9eUfS0YZm0u
	 CJSftWDWV4erSDPFOQxQpnoinGjNDuVivNJ41Luo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfKEQwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfKEQwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:52:33 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF81221928;
        Tue,  5 Nov 2019 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572972753;
        bh=nJYNKwViMyU8WZcqIbzeYXr6iFhKDQYiwtdQNOzWjIM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=yvtTFvkICbtxcgJWDMzgv6MouO3qhvFPwAMoOqioCWMmSH8kO9/NBW1KJjj/wkzYM
         lXGZSV3gPw8aVAKghPNLS+b0MSid1cE1ruZJKR5ug1R3paOroTjjXxhKWJ2yXe/92V
         0qucvmde2dmDJClicsomAVZvMKnnj9ZCTQatfZcI=
Subject: Re: [PATCH 4.19 000/149] 4.19.82-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191104212126.090054740@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3f143292-96f6-3246-7f0b-7debe0737ab0@kernel.org>
Date:   Tue, 5 Nov 2019 09:52:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/19 2:43 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.82 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.82-rc1.gz
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

