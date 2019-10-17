Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08BAFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C39521D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571323254;
	bh=VX9fM7owBzI3MerH5NcTg4JBJr4yjrXcJnJfhpSpTgY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hZs+esz+H76GxkPisHc6IxSBkniynjUpqh7fHHrxfAZSsLTgGWGfbGE60aoldTsf2
	 HQquUnNEJOpKRST6BZxbslGZLreGTGrft0pqYaUpd6vj258EuXxX5iWJhIxAy7Jp2H
	 DumA89DYEdvQxxIY2bX8di6LCt4zpyW01rAXjZGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440323AbfJQOkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437960AbfJQOkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:40:53 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE7721A4C;
        Thu, 17 Oct 2019 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571323252;
        bh=VX9fM7owBzI3MerH5NcTg4JBJr4yjrXcJnJfhpSpTgY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y16Nz+zgA5q80JcW+zeFLY43dxPSW7zyJl1X1ctxNhDxz3Atxcju5fiMqV25CIrfi
         c2gdqKcdjgrKcsldgnhpoE1HFCD58AMDGf/NyrDWRGTq3TWZjg92jnNVwAqdx39WHE
         dUQiyNZvVBd819QauCNoaIbFHh4dcZi53va2kTrA=
Subject: Re: [PATCH 4.4 00/79] 4.4.197-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191016214729.758892904@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <37c7cc8e-f531-0834-7352-c88c2a025c13@kernel.org>
Date:   Thu, 17 Oct 2019 08:40:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/19 3:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.197 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.197-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
