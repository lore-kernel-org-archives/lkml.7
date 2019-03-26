Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70029C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3425F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553642246;
	bh=R2JZdUJrz/w3Uvy1ak+2NsSAGvnIjtFtvJJnjPHAUiw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vWjxl6nNa6l3Yu9zwWimA+Ons92d/5venRckX2+0ptp5rjt8R2gjFPQEHWi4h7xaM
	 sIjm/z1ljPiv54ndx7E7AocOd0MSKCTPgaeAKU4f2xqRRWr47RYwZERKkUDtvWjAhA
	 DFRHkm51LDPe0MsZC9hcER7pX+/ID5bSYmtGwxG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfCZXRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbfCZXRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:17:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21842087C;
        Tue, 26 Mar 2019 23:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553642244;
        bh=R2JZdUJrz/w3Uvy1ak+2NsSAGvnIjtFtvJJnjPHAUiw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d8Ud/410sMXb+JAZ2mjoUd9n2WuXOl7C7YrpWl/N+suG3AtnwgAB3b+VWOz6yaV9v
         JqO49Usdu1mjAnzP3y8fn4I+wS6tbN4RQnhL9Q85xD+pcnpFzDsG5vU519okGWwnp7
         8U1lj2EZmMu+xZ0cBbpz3/PTv+5iVQzKiHhozP/c=
Subject: Re: [PATCH 4.19 00/45] 4.19.32-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190326042702.565683325@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <bd80905c-e8cf-3605-10f9-862c5e5781a7@kernel.org>
Date:   Tue, 26 Mar 2019 17:17:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 12:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.32 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:26:41 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.32-rc1.gz
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

