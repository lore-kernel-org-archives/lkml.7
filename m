Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4742CC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095D8204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698563;
	bh=MmZrG7AeLkJrBajeK5MMaz+A5Ag1JEZxMOQhAfM55dg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=XqQif5TGJgBDmEqzQ+Sb+1KDlt0EvmlbMwpxidHCV7PAKCLclo8so5xLqkLYMDMyi
	 x98rIbcM4Hx5wBDA0Rs+6tD6CnBQLqyoM5YCPTfTKXDuLKjj3nfTJP4ZVY63bOrDVF
	 uRyKmNn/RNjUl6MHGJCpC1U4JB1bTRTVtvpEO2RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfDSS3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FAA5222D0;
        Fri, 19 Apr 2019 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555683878;
        bh=MmZrG7AeLkJrBajeK5MMaz+A5Ag1JEZxMOQhAfM55dg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b/SomUX29GzFkGhS7hncvBupsO7SkWpT+YR4y0Hax5iLj7/6OdsPhCbw45icF+3Yi
         WX1hJMthAxwACq+jqLbmPbliyiuxd4ojq7su/vgHV7j081TrM6Zuq+C8Rl6GVRDr0V
         udVFM9ThaVLf5dcshq+fA18niHvkOtSjZrAtbq10=
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190418160422.455656724@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <2ce78639-5bb8-8ba2-9e34-1ed2c03c709f@kernel.org>
Date:   Fri, 19 Apr 2019 08:24:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 11:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.170 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.170-rc1.gz
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

