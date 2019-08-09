Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDB9C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEC121743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565311263;
	bh=WGQG5Pfhg6CrPeE3yWQ62soOdtDALodm0wFNhFzQ5sQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1KIYVsCnReWRyPZVaYVdTRuaE/F2Q1kL/ra7GcuyOmxmpLXz/THTV2bTjshQ1i/Zv
	 GMtD49FYhLB7nXZcjw3a0BZnxwEDrM6FtwiBwERMOn4Qq//FuBIctS6ygHRZXxQlcM
	 jvDn8ZcACXBKTj87eoOTpc4Mm4CaiKS0oYpbbtCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405023AbfHIAlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 20:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfHIAlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:41:02 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E3B9208C4;
        Fri,  9 Aug 2019 00:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565311261;
        bh=WGQG5Pfhg6CrPeE3yWQ62soOdtDALodm0wFNhFzQ5sQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BNdFUlat7aT4TOx3F0d69r8Bcrrx6TSvEEOpSbJekXUBK3JOm41g+rfZLDYpu7kyp
         OOr3LOY8sag1ft/xNdJsU0tCtDPnlM+kglU8KgNUMrse8WyqGz0YPeywi0cDBasa6I
         nVijl0ifSp0MWhoUXdpXVrInlIVV4KTyfHfrdyVY=
Subject: Re: [PATCH 4.14 00/33] 4.14.138-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190808190453.582417307@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <39ecdf5b-9875-3efe-9137-347b8f990b5c@kernel.org>
Date:   Thu, 8 Aug 2019 18:41:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808190453.582417307@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 1:05 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.138 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 10 Aug 2019 07:03:19 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.138-rc1.gz
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
