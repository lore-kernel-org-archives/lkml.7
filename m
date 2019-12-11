Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF3DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056082173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576106344;
	bh=fAYdKWBy0REBRBwfpT2O9WgHpDZhTb5srn3VxP/4GQg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lv0HOV0sQvBrS7ZTQyXUQ0p27ulKGezX8kjiosUKMW6LnwH49AF8vx8614qHD+9GN
	 Xv7uGS41bHBhz1M4vuZMw22y43NUvu4TCzOQgw+x0VrDg2iH0T/KjHIx4jYhsVImby
	 0P3+azt0QPb/XSz5RYi6OGNH0ps3LFIThGg9vj50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLKXTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:19:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLKXTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:19:02 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6701320836;
        Wed, 11 Dec 2019 23:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576106341;
        bh=fAYdKWBy0REBRBwfpT2O9WgHpDZhTb5srn3VxP/4GQg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AvYgzyofqcb0g2Z+LWdZvUh5KXKi0gHQixD5s7N9u1QcSDAVm6ZiBSUNN3VbQ/SgJ
         HmBtjH8yXJe1D60Q9LWHFnkHZbcBE4Sdu/a0pe8qYpizmYqrpqxQsTt0SMhdCZ+WuJ
         k1y09B68pnLNcoMWEtIEZ209EumBtbHDkwH+cYOU=
Subject: Re: [PATCH 4.4 00/92] 4.4.206-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191204174327.215426506@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <2959daae-72f2-8f85-df04-d6a0fe33516d@kernel.org>
Date:   Wed, 11 Dec 2019 16:19:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 10:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.206 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Dec 2019 17:42:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.206-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

I know this is way late. I managed to boot 4.4.206 finally on my test
system running Ubuntu 19.10.

It turns out, Ubuntu 19.10 defaults to LZ4 compression.

/etc/initramfs-tools/initramfs.conf
COMPRESS=lz4

Enabling the following worked for me.

CONFIG_RD_LZ4=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_DECOMPRESS_LZ4=y

Stable release older than 4.19 will require the above change.

thanks,
-- Shuah
