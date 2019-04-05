Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBF2C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016092186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554477971;
	bh=Yd19cceZas1RrOQnW0hnUhxqls1bSIc881Q/zgx6iqw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=D8eHoaWtbSxwjvfDyIU1qa5ag474a2DEZfF+relLBfHN9WG2WHCZmjO7zOQ28w03j
	 Lb5myygG3ALUnyJcmDKYj9+qBr82pr8cvQBrIaT4JGhIfUv1WpoaNjLQHUkIs4xAWB
	 7/V95oHxUruT6iAdSajLnReglv/cWips/YAxSASA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfDEP0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDEP0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:26:09 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CAC321852;
        Fri,  5 Apr 2019 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554477968;
        bh=Yd19cceZas1RrOQnW0hnUhxqls1bSIc881Q/zgx6iqw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cRGPGIbMPn61+ZoJIjAxLxrI7DI0rTxyuHors2owhp3bWqqY6dqzMtJvg6SRwwkX6
         6QFT6nlxxkgxstULOZZCAdfVIeTr0Tj3Us/32ZEKpKjmoCwRNccNH8yEQBUuH5PKfv
         wtlEpbhdktuQMTxkXbs5FuClE4hv1Yt8VcRTgnBk=
Subject: Re: [PATCH 4.9 00/91] 4.9.168-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190404084535.450029272@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <bb9a5118-73ad-dfa7-919d-8f03d8428b78@kernel.org>
Date:   Fri, 5 Apr 2019 09:26:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 2:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.168 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr  6 08:44:27 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
