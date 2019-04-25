Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163BEC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657D820891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556209482;
	bh=0rz7EG8YPPfJroE4ABwkWnhZQjnymPir6rZ0R7zTN4U=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=P7yMpIrZgdwvJZXsxUUNotYnLUwUVri81XrOiNc8gbEl+YJoSIAtgLTyPJFsKXtBV
	 ZUu43v36suvk9ZUwkUJ1yLOOfhA6548NwpN/C/1XI0VTR6shFaQeKimgbqEKhcIiUJ
	 /R34QD7iBpjGkqjYYksNoM3HHygBo9NzeNmccPU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfDYQYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfDYQYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:24:40 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAFA2077C;
        Thu, 25 Apr 2019 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556209480;
        bh=0rz7EG8YPPfJroE4ABwkWnhZQjnymPir6rZ0R7zTN4U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CQOvOMyVVV0N+qufWKs3H5At7mIn5N9vZBbIW6xRsTo9mgvsFzdV4/xU5s+JdLA73
         mnWEgwSXzc4R+p+zw8MIKYz958/Xevr0ppd3i85Oo2Iu2zgvTL1HhiCe9eye26+Cov
         bIheXarqil2I+pbiBNUZcSM41up2o0STsuG6Me14=
Subject: Re: [PATCH 4.19 00/96] 4.19.37-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190424170919.829037226@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3df3964d-52ae-fe7f-547f-55433e63b424@kernel.org>
Date:   Thu, 25 Apr 2019 10:24:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 11:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.37 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:35 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.37-rc1.gz
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
