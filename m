Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1549FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A5921743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556663536;
	bh=XRVMa04kudlHTq2z7N3HsIVwyLgTj7ZVz8OS2PVDtX4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=u1DbQmZvFzmelUnCXZiRzQ0cD0UphHWrZA7+gLIE7yKTQu58uWFeQbnjzaPdwy9vl
	 YazJ6/Bf9WE4lHhK+bGndZOMgAKs0PF3h4gjVo/BcA/tsyAhmu+XDvOaZ7H4kDY4eV
	 X38zk1qaH6LG52qcJedUaQgM9kS+X0mSxW883kPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfD3WcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfD3WcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:32:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A4720854;
        Tue, 30 Apr 2019 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556663533;
        bh=XRVMa04kudlHTq2z7N3HsIVwyLgTj7ZVz8OS2PVDtX4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UCSRWUfbjl6cuajEsqZVQJHL4EtO2TdNKLBhxLvrEpQdF7NrQGDZ4/XjSoNd98Vh8
         nf5hALAw3NTPm5E5kJuXNd80ZEo/alVbYMZsJtmVIYXQM3HZsG8CdHXaua0HjGT4PJ
         OVBnorCDoFJqTFdXrsxXMUa6RKJftY++VDlriyNw=
Subject: Re: [PATCH 4.19 000/100] 4.19.38-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190430113608.616903219@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <505d050a-6d02-9e62-fbb8-fa13129744c7@kernel.org>
Date:   Tue, 30 Apr 2019 16:32:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/19 5:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.38 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 02 May 2019 11:34:55 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.38-rc1.gz
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
