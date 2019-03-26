Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE361C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B082087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553642206;
	bh=GScaNa9EsGR3Vn4/0ueFFrlptcpPYKd7asjKu1zbZ8k=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hOZzrEH6DEgf1V3qXdvMOYoZO4sWvCC7HlqPUP5o/38dMUiGfYnWhamfl5+QT80Px
	 x9rlPto4LycsOfOYD28C1U93RP6uxphWUE82lm4DZuf3i1VUoIRsrAwSi0oVf4OXW+
	 GKhhcM1/dAx6PgFwI++3sJw7EYeyIzVENjnra0FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfCZXQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbfCZXQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:16:45 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F2962087C;
        Tue, 26 Mar 2019 23:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553642204;
        bh=GScaNa9EsGR3Vn4/0ueFFrlptcpPYKd7asjKu1zbZ8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kcjB9XwoV+n+/OjDEoPVhkCgQ4jUui4TH76sD2qz7FBJz8XO7eSf8VM9h0kNDSLbk
         iciGITpbMbmzKfyUqnj9AIJq1sGKgncugvLybrczZdbr6f4lsEVMDN1k4V8nnVKmnB
         d9dBbK/9gx1K3OXWR0PZGTpv8JJvg6q2LCAKe3qU=
Subject: Re: [PATCH 4.9 00/30] 4.9.166-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190326042607.558087893@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <b7a4db53-9483-1418-fd4e-8d11e4131a96@kernel.org>
Date:   Tue, 26 Mar 2019 17:16:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 12:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.166 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:25:51 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.166-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

