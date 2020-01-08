Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F3C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B0B2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578451304;
	bh=g1QhP24GYtWHumO4wQr4TElEcAdPK+9n2phaXK0dnyw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=soQMotfhPL2AOHeBeoc8gpibr7SO1GbZv+IGqR19B9VFD0abHL2SXBRO2hJSTU1L1
	 FzX18hXuDm7MOoQUaK9pKWnYUHeERsj8Q8CeDZZlckhy9P4fKrai2yroohJDswCZRo
	 IgluSZiZ8BZxogMqC5dILfWgKDB+EQGqNehpA+BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgAHCln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHCln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:41:43 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FFF22070E;
        Wed,  8 Jan 2020 02:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578451302;
        bh=g1QhP24GYtWHumO4wQr4TElEcAdPK+9n2phaXK0dnyw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bt7a73xRq0/Rf78yaKwW95qAUNQLW+9WsGTi3acVMAVkaOiLW9ktfpB75lbFmZIKn
         mHnElvI2MEaq6yYWE0LoOVWoRmq2RG/iBT4QoL0hn8vNq4Y1uD71OpnY/YuYBp0aWh
         d8XLkq4NPbe6hUOTf7pCbXZOZGCULArjd5qbNfSQ=
Subject: Re: [PATCH 4.19 000/115] 4.19.94-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200107205240.283674026@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3e601354-667e-0f25-dc67-43594f757bd5@kernel.org>
Date:   Tue, 7 Jan 2020 19:41:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 1:53 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.94 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jan 2020 20:44:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.94-rc1.gz
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

