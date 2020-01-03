Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE799C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3F2222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578088320;
	bh=lkVZIrOcBIm2xz+5QypPOZ7AEtMcbg9KTsvtVzBMejI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dOc9+eTjyD1dNszhRGWPy9TQcA9txvEpWVqkZV7Ic+f+HsitaWBPPQ2RPYv0hOVgR
	 jqUSxsa0rqaGrc+C5VStTiIIAOs+lgllKV0Z3K/XUOyOQ4oAkTszAg5aeR35Hx2c50
	 vaQOnf9nwPjvXsO0V6K4kGaJHOVET7OkF/w4YiZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgACVv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 16:51:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbgACVv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 16:51:58 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DAE206DB;
        Fri,  3 Jan 2020 21:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578088317;
        bh=lkVZIrOcBIm2xz+5QypPOZ7AEtMcbg9KTsvtVzBMejI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tdf45k3TI8PoEoopB2puxXk9u7GKq2tQ0Jw4XC8E4n2+pBUxNnOukHpylD68/1Rho
         zWQsgoxZukTlzwh0dCn3bU2u3DUK1lYcRGDO4fFymurcexwmF/M9LAzs12fNsAsT5J
         pZcE2fjbIx5D5ujHSERa+z3TQBFM1yznw7kEHjFw=
Subject: Re: [PATCH 4.9 000/171] 4.9.208-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200102220546.960200039@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <81d2b642-589c-00e8-903f-f37f62df5413@kernel.org>
Date:   Fri, 3 Jan 2020 14:51:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/20 3:05 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.208 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jan 2020 22:02:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.208-rc1.gz
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
