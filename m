Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB43AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8BF222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578088917;
	bh=9+eJqxZTWrHj1YKwG+bK9Q1jlHHSSYrl5YzXYFmRmq4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dujjP09yvxtl6zkhMcLtHXGuKUW/TSdOg2pKjdFfPy+Q1W5L35AbD7FZBFGIJ7kPU
	 RnKrYK6Txb0y3F3wL7PlCSYtHhA11xRmwzIb2Xbf6fH/GdBjJO36rVR4trOzaObQCH
	 9bMZDJFZn4gG3yOyL3iwjpXFwb9y4/1AjV7s0e94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgACWB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgACWB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:01:56 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38144206DB;
        Fri,  3 Jan 2020 22:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578088915;
        bh=9+eJqxZTWrHj1YKwG+bK9Q1jlHHSSYrl5YzXYFmRmq4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kplFe31bkeWISEZVPbwzxZk3RGoIWxhrGWuu1DLXh+bEbwAY5Utl2mkKt6cjpAZVt
         8LjnT0Oe6nvpzLeXuL/+ZxZjAD8/VOSaVoGYFpIPVOcS0PmyoAK4XKP5wWeGQrkbKc
         s8J/vJvAN7l8W8hETSkwswUa3Su6m1zs0RhjbU9c=
Subject: Re: [PATCH 4.14 00/91] 4.14.162-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200102220356.856162165@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <20b4f395-56e1-dba6-7a2f-5bf91f18b149@kernel.org>
Date:   Fri, 3 Jan 2020 15:01:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/20 3:06 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.162 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jan 2020 22:01:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.162-rc1.gz
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
