Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC3C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B68260CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559244625;
	bh=cpPRpQnqHPQJA+OKQDgfyL3wny4sebjH4yw7QtNyFTY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=m23pLtC+2a90rZw2s9YEMRMXhI/euAYPi+ALHAfA1xZCtxnAz/pGlQ/9hVYFfBmvJ
	 cotNSCTqF/rdhQhiQLrxpHB6PvYIK/9YYkQ6/mzQN9aMZ26iYUtQXePzyiPOMxiI0e
	 K5MMz65NGe6/R55tH+77rWevwxks9YrVnTzMF6JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfE3TaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfE3TaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:30:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E210260C7;
        Thu, 30 May 2019 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559244623;
        bh=cpPRpQnqHPQJA+OKQDgfyL3wny4sebjH4yw7QtNyFTY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K/0zxK/c8mRKYVAnTxejooF55sG3pHUWWfHsisZcmSTG7BodhLXsfYrQgsdaQYGio
         Xz5MBB1anI/FEzVAa7SEZUOn+aB3bqxRQb1wVV4Y5khnewrQNYSIQ9S+XxQyzxgcT0
         n0ZIHZRUD41W4tTpkUN3qnMWC0s4+VCP33Osi6dc=
Subject: Re: [PATCH 5.1 000/405] 5.1.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190530030540.291644921@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <936fbe39-87c2-5922-5cac-245718b9fcef@kernel.org>
Date:   Thu, 30 May 2019 13:30:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 8:59 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.6 release.
> There are 405 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 01 Jun 2019 03:01:59 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

