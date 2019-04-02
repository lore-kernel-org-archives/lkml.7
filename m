Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F87C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C008620882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554248746;
	bh=dTsdlU9GhcRmHNyquevYfMhA4P2OO8g6VWKsUIiQqeI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vblNs1XV7mJ6oZvYjAsKjoNt0RwyYAJPEeRw7SnJwNp3J2ZZWIvIbXCuhvoiaRrOG
	 /Oo0PlUBTKR5VxrcgRV4M3292sr3DCfwxWaKBOgUfCRRBFDVOmd8dJhVPm8aCpFsHb
	 mOyCUorKYiKxg5WXI9jnpILViyZS/rXLNkMI0drs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDBXpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfDBXpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:45:44 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C595A207E0;
        Tue,  2 Apr 2019 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554248744;
        bh=dTsdlU9GhcRmHNyquevYfMhA4P2OO8g6VWKsUIiQqeI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BagSjFfG+ymgadHHiZgCRVZqGQ+InGJZmYcGTBIlhR5p8P8q8iIzEEryP7kv2C9J+
         b9036C7SI7RzR45q0w6jvBs81bvFBXk8KrpFZJwLKF1T/ZXdQHOF0goLYG+mmpVlnH
         fTdmEuPr2L6Lhym9vYQGQvY91NRsh/v5QYTpex78=
Subject: Re: [PATCH 4.14 000/107] 4.14.110-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190401170045.246405031@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <440ff90a-c9a9-97ad-be7e-b2f3339c7267@kernel.org>
Date:   Tue, 2 Apr 2019 17:45:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 11:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.110 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:25 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
