Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEF6C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E0F216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561585568;
	bh=DRHwIYagcxSefxtxUmGepQRlcDBzbp7VVh0IXC49n8Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dzsX3QWB1qhALVLOrci0/VnC8nwMIcpEWNjiyiCKqSwCUJE22i52EwL/17K/uxSsL
	 eRt8CNN62vr1u0MvbLW10R36tx16WQaipEoEeCvDhMNtRE7uw8Tl5UwqHre1bl6CJg
	 M+rEYamzSch8emDhCsIECmloWamD3VWBdkT99Yq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFZVqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZVqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:46:03 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0750C20665;
        Wed, 26 Jun 2019 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561585562;
        bh=DRHwIYagcxSefxtxUmGepQRlcDBzbp7VVh0IXC49n8Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2UE+8Fn0BnnwdB5XkYfFOQT8enkZJtVG1YenOJ3+ZigNVe+qhyTdKpsJXa8nYNdEn
         l/7U9IAwZG2JFXhpN3iHoieAPJkqsdQv8ZCkl7v+aTUZ+K0qF2r6AtYYVK3tGz4zfF
         JufcidEUfCDSdO0ns3YoNaBIegjYlslQsRWiLY5U=
Subject: Re: [PATCH 4.4 0/1] 4.4.184-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190626083604.894288021@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7507a259-5b00-39bd-a76d-6b8b40ba1f82@kernel.org>
Date:   Wed, 26 Jun 2019 15:46:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626083604.894288021@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 2:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.184 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.184-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 4.4.184-rc1
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: refine memory limit test in tcp_fragment()
> 
> 
> -------------
> 
> Diffstat:
> 
>   Makefile              | 4 ++--
>   net/ipv4/tcp_output.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
