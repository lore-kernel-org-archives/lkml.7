Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC66C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8576C2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574454927;
	bh=VVsgx1slc83AT05Ps00nj/yMRWSnNTgWe4Bwsw3pFHE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=H8n8njq4yf2gtBWSXrru3h1X77b6FsSCS8wtEvmS0klqYGoH0YzjI9iplK5MU4cSO
	 66bEdhcnabZ8zikoGlrzD1bnmJKhSktOSPmv6F24cvdMqwsBjtSlwvRpGhWUf1+p9s
	 KQH5u+qpIk7UzuNUkSZyzu59SLmIAxXGCvfjY7Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKVUf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVUf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:35:26 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0EC20708;
        Fri, 22 Nov 2019 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574454925;
        bh=VVsgx1slc83AT05Ps00nj/yMRWSnNTgWe4Bwsw3pFHE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h5wb6NUKkLLxoWMTt+xdoTKcQI4AtiS8FRhI1DiaD37GLClH3Ga5KcAMouy2UUMKw
         WCjJAHNLXUYoeqJwq7Hc/lZkVcDP87MlljPgsFi/geDx2C8lYc68c/0Sahj1wqb/bE
         p5Ngs4boxEkjXmn0xQ8YgGiF+4/Fou1ND2xzl6q0=
Subject: Re: [PATCH 4.19 000/220] 4.19.86-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191122100912.732983531@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <a635e62a-a6db-9301-daf9-252eda1a1922@kernel.org>
Date:   Fri, 22 Nov 2019 13:35:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/19 3:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.86 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.86-rc1.gz
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

