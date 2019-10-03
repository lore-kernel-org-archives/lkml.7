Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C07C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 23:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB17222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570146623;
	bh=0ERmU6cL8kSh7G8kvzaR4oK/hHtDKC79GGdnWsa72V8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=v7grxgmmLnM5KXMoVuD2x/0yVXzcTjZPXpz5+scb8kfb+Je9XsnKWsXJZ1h65Oox5
	 7klNuHRuSWm5QDv/6Ysx+W1tI8dVhr3wwhpzWC0E4mIim63IYWEMxZWUxa0JmXA8Hs
	 a180DX1ev70lYMGyasqYZxvwzPXPYBvtu/XRrd54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfJCXuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 19:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfJCXuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 19:50:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0654620842;
        Thu,  3 Oct 2019 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570146620;
        bh=0ERmU6cL8kSh7G8kvzaR4oK/hHtDKC79GGdnWsa72V8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dNMKht0wRimtx4Zwcu3tbSkbfn5Ab6cecQyS2xwjEod+Y5cudakM2FrrUY4gEdGpL
         /wkaIW3CVkmuF7eWl7j3OZZmmbt2748MSD9AmdLP9zXbQ1taJDOQFzSSKefoZRqN+q
         zlzk8QhWlf/tp+EYhCf8l5dliFf6RHPM8XcBbOXU=
Subject: Re: [PATCH 5.2 000/313] 5.2.19-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191003154533.590915454@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3126f24d-530e-fa74-89be-58f5bf236a77@kernel.org>
Date:   Thu, 3 Oct 2019 17:50:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/19 9:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.19 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 05 Oct 2019 03:37:47 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
