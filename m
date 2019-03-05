Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A98C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3666E20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551802756;
	bh=2gwSN13VOVp60wB67N9SX+CBggLw4dSFqnu60oLcbUU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zBoTwgYyrvcemWDV5tBq3Ki+6OaA1t1oVF/NpSZpK5NuV5eK+4+6l4jFU/fn+NBDW
	 qrdzeWVy0Qm94dBZF8dy7up4dpkmnQTGzCBjsrOY0vH/BLPmH54NnJY1KjKulzcM9t
	 ZIjqy+CwZ2s2k4CNSfDnomrNbGaHdcPJu72kmBTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCEQTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfCEQTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:19:14 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CD320652;
        Tue,  5 Mar 2019 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551802753;
        bh=2gwSN13VOVp60wB67N9SX+CBggLw4dSFqnu60oLcbUU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zvc2SRDjESnmcCGr+5qJwLgG2lnULSJU7hmxN2hdStVxRC19iQToHcwMmZZJQZzNy
         N3KSkojlWEy8WRJ+kDjqBskmDSxZbIIrALdZrIwnsag0wUh4i2CqvHMdhHsGl9vSjw
         bTCeaN6ZSolvnMbJURqnvnzJCO+bsMwoFY6T4OP4=
Subject: Re: [PATCH 4.19 00/78] 4.19.27-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190304081625.508788074@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <476f4d2d-d865-04b0-2dfd-46dff7c8d4e6@kernel.org>
Date:   Tue, 5 Mar 2019 09:19:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 1:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.27 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  6 08:16:00 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.27-rc1.gz
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

