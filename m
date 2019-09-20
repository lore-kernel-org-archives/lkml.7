Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B84C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D10720B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569014536;
	bh=c8bKi5gxH/slUGOKQqLHUtK90XeqzDTtSmwbWANAwRw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OU0Vq5gYoigZhsJJhLY7Lci4iNQuPPiEALJt+UU3lBnD39yIHQpGyR/bxQzd5jpKW
	 UOl0+zXKOetCdOLUhOcNvXaZOI6e8mmZrQJPmuPghmqlwGpKqY4yWPtGR0VwWShb9D
	 3TaZPjxac5DGAZZsK6haFNTQBRc47ROHyRAezCBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfITVWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfITVWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:22:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A2220820;
        Fri, 20 Sep 2019 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569014534;
        bh=c8bKi5gxH/slUGOKQqLHUtK90XeqzDTtSmwbWANAwRw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qtxRmAA1kVflFC7NmXe8AeO3HJErM2DLot+79QH/xvek+t+RtehYCzwTulonynkIZ
         P9HP6fLZjc7hm3zdM3XAWmDZt1I3I+PLKP2AjfpYGa/jWxTqRVu5TBygq28JepZsGw
         3MfwkYHm5bFINBcO2vg28BdP/VfzQRwwkYe66LuU=
Subject: Re: [PATCH 4.14 00/59] 4.14.146-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190919214755.852282682@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <390db9a4-9ecd-576a-0a67-ec7ccda79edc@kernel.org>
Date:   Fri, 20 Sep 2019 15:22:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 4:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.146 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.146-rc1.gz
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

