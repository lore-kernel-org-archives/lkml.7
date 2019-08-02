Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA7C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36420880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564787949;
	bh=td07OACSiRS3uanVWwmw0+8JEPqkbw8ZYWDwKbkdThU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=S7w9z1+8X6pFUq1Qv5Q5eBthqHk1LWXEWAZjUFju3zwxXGFZrJWGbY2tvmmXfukrJ
	 0/9Vaiep45N5xnsE7g0LrUFmkZsKajTQY/881nyXyaYV7U8OCNO9n+UdbDrRnN3g/c
	 Yn2CNhURmnEuw2aNhrWxWYZNGl+SSKLYXJjExeOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437415AbfHBXTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437403AbfHBXTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:19:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AB92087E;
        Fri,  2 Aug 2019 23:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564787946;
        bh=td07OACSiRS3uanVWwmw0+8JEPqkbw8ZYWDwKbkdThU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WgeIXrAESPbhAm61RAJesz0OBAhf7wnjRHHE/FRsm7cxMYy2MoJjcBCcrkxMUFQGw
         zUzF36a3ZG7DMLUGK3dhxHwKfAK7WMrEnKaHtL1oUUbngfNmq9virhnIiEqKOi8KdN
         Suqppwjg0HCDhDjsfomxYuCI3q1EvkUU6fSJkuwY=
Subject: Re: [PATCH 4.4 000/158] 4.4.187-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190802092203.671944552@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <126c3901-1367-49e1-305b-d247bddc6fa9@kernel.org>
Date:   Fri, 2 Aug 2019 17:19:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 3:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.187 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.187-rc1.gz
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

