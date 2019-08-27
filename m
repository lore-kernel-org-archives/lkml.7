Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F0C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0592186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566933128;
	bh=jCgCFn35XLgLyC4s9GEbxLkOEIMgEav78GwF57cYTZw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=S7qi/UOV5dzjFT9maJ/Dl3eNlK84BHr4av8qSptU5Eesd/WEC4ki/If/EkQDxdO+F
	 0xXVsh0SF8Ix0jpRaasFCewI1ZsmGpobRLs8aaqMAU9rjgiHb17QcGmLC72PmAaXUE
	 U+gylktrclpl+W9BF4zXAtWkFJHVE6nzxuH2yb4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfH0TMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfH0TMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:12:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FA32184D;
        Tue, 27 Aug 2019 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566933127;
        bh=jCgCFn35XLgLyC4s9GEbxLkOEIMgEav78GwF57cYTZw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uev+irkFBiTU0Q0kD6bLDShFvzareCNsV4vHhv055EtLkE+sWlwh4Yhsm4c0cJbH/
         5WUXatcS/odjUE209a/GtH10I2ztsYjzJZTmgzg5GClQfYTwXkOCgSbsYzsILbgAbE
         dmu93Wx/qOWMyoZy3leCsknW2yCOIhSINSUqDU/w=
Subject: Re: [PATCH 4.14 00/62] 4.14.141-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190827072659.803647352@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7533a709-2969-a6b8-ada5-768c352ea8f7@kernel.org>
Date:   Tue, 27 Aug 2019 13:12:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 1:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.141 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 29 Aug 2019 07:25:02 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

