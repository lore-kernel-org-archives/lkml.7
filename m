Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75738C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDB52075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555450829;
	bh=DFv3k+z39/s8uFkzSqXns9VnEOhNuDQX1EW2ftwkpbY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Zd5NsVF+q9XvRulPGaNHx5lB5HZPwivpIwe/ulywmlIcrCW6JTph3GzhEETaAGfZr
	 UEber4Rdv2Y43Q81bDrXSk2JfxrbH+w++z8kE5uUtrlC1Dc0jng0y2qujKZf4bsZml
	 qYdoOqkEfyi0iGLgqtoaBt6U6zH7QtLmM+yStYAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfDPVk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfDPVk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:40:27 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D59A120684;
        Tue, 16 Apr 2019 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555450827;
        bh=DFv3k+z39/s8uFkzSqXns9VnEOhNuDQX1EW2ftwkpbY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fAnE0E2VrVoi1xReUA+o5Imx7Cn09LOFueia3HLuACx/4hygYVvjnJQCBz69j3mqV
         VmXplKc5IXEjiranVAIkcnROyVPCS9S2GHmW307s1KanAqPI4DIz5sL+GwRURVOFhX
         7hp2iu2qp+WwvZBTijrLV4Aa7FMTEiZj4FF1MviA=
Subject: Re: [PATCH 4.14 00/69] 4.14.112-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190415183726.036654568@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6448b66c-cebf-d652-8ba6-db9747a2484f@kernel.org>
Date:   Tue, 16 Apr 2019 15:40:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 12:58 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.112 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:38 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.112-rc1.gz
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

