Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4268C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDBF2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565921348;
	bh=BCLuIeoxbVoc+Q2IQDL+1MUUNnK0uKgkj7Hb0EpKc5Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Fja8YDAWIIJL/+fZCBa99Rs/u3RUGrnfcWY9GqtXDHo7jpUVUqy7Np2ljfchqyG6+
	 OZXuhJkOWzs3/yc9ffu49T4T4JrrGMhv++ApwS/8RohB8Z3WJT2JoAEwaQQswniNZU
	 ZmYxm/0aPLZCesfiz6nE1drK0TUWDWcRJLwYcUHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHPCJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHPCJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:09:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075352086C;
        Fri, 16 Aug 2019 02:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565921346;
        bh=BCLuIeoxbVoc+Q2IQDL+1MUUNnK0uKgkj7Hb0EpKc5Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P9kUwVgO2QaOhkW85YI+LYmN7WyfqOXB215T45IXSvBKHUrW1ReTPXwhQcsLPzvzY
         jbyLvojfSZ+8iU6B+NP9jv1jFmIeA7Q8N0zbPew36NoSdLVPXBceYdiTt8QfN+wfH0
         LtGt3jZs5n81Ufkxr14B+fQQ84vV1x7pGGhKm3+Y=
Subject: Re: [PATCH 4.19 00/91] 4.19.67-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190814165748.991235624@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6fba5974-4194-539d-ce09-01783b20cac6@kernel.org>
Date:   Thu, 15 Aug 2019 20:09:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/19 11:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.67 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 16 Aug 2019 04:55:34 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.67-rc1.gz
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
