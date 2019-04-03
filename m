Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAACC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB622146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554249914;
	bh=s89EkJxEhR0LZf/UxyEO4KX3PKLHtqenRSHjj9vE7Uo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mLO5jB8/W1smbVXntnFiCOz+OHqgvOXQVMd4YpWo8MtmkSTwBjQPoTWiqXIw6bChm
	 FoSq422ByKpXLx5hHiL3B0HfOXNoMPj7/38ldiI+opvrOHVY+OoUUF3OfnGZ2OSEVM
	 evgxfDLyjTAxSkwXCS7vDhO0gTfj6zH2z6JiYXEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCAFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfDCAFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:05:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3048C20882;
        Wed,  3 Apr 2019 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554249912;
        bh=s89EkJxEhR0LZf/UxyEO4KX3PKLHtqenRSHjj9vE7Uo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tqf9mIkUbK8vws1uYuUNCnUn7dpSo/CFd4JD1oCnayEpNiu/07cgnVHkrjTKcwbuv
         dRHitlpbeW8UKBBKz6XNVK5sL1h5FVd8kjpUzBm8H0+Aab/sejhXP5LS6iEnTaIchR
         IKoYVC0WFHGHUHQ5RKciKT9j+f8lL+ulSUJbi1rU=
Subject: Re: [PATCH 3.18 00/50] 3.18.138-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190401170041.257273804@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d68c6b56-fa2f-70a5-67fd-055767946168@kernel.org>
Date:   Tue, 2 Apr 2019 18:05:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 11:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.138 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:36 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.138-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

