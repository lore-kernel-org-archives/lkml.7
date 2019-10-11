Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A99ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6169121929
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570763117;
	bh=a754thDulMisDOIbI3nhRGyZYcuRQPWXTVChK4boAO0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Et6x1svW/G8AGy6UDjQqSu+Cgan4SJOsIfZkwgo6qptpJHZgPtOjIziakl97ouAEm
	 2MU3VO2Uavp3D16wXxVIAobNcQ4phGmLluwL9hfd36W2pMa8Oho+BclPl0MuVydWBO
	 dcbZw92G3PoL8ICcH/oZxJm3bibi7+c8r/yrlBMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJKDFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJKDFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:05:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49A720650;
        Fri, 11 Oct 2019 03:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570763115;
        bh=a754thDulMisDOIbI3nhRGyZYcuRQPWXTVChK4boAO0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hhL2mmZneqTkpACNc8X1IsKbe0hvujRofVMGNmr0ZtsI3EmOZPqQ8lIsXWKoP8fu0
         tbasEp0pc/+On8+jO5rM/yg+RVXn14jr3CUlGUxj8xuihm5slIVB4hk6xEZp52R92/
         oqhWzDs/SZg9qWcwqaHFmz0kymITwcwQ344W13+M=
Subject: Re: [PATCH 4.19 000/114] 4.19.79-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191010083544.711104709@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <2f362727-4f0b-7ebc-a449-bdc40aedf143@kernel.org>
Date:   Thu, 10 Oct 2019 21:05:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 2:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.79 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 12 Oct 2019 08:29:51 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.79-rc1.gz
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

