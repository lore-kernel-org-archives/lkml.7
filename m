Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD69C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4140F26E66
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ekYMgx6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfFCSeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:34:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4380 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFCSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf568240001>; Mon, 03 Jun 2019 11:34:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Jun 2019 11:34:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Jun 2019 11:34:13 -0700
Received: from [10.26.11.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Jun
 2019 18:34:11 +0000
Subject: Re: [PATCH 5.1 00/40] 5.1.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190603090522.617635820@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <75303365-74d0-de3c-2f54-5cff3469d8a0@nvidia.com>
Date:   Mon, 3 Jun 2019 19:34:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559586852; bh=yT2aKoUSjC1S496mvwRzbK4hBYRD0SeSWYW01CRMMn0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ekYMgx6mGLFm7AY85sJOnEg8rkEFkTjF0zSjRh0/I74CMliENYS9kSyqDWVePeEMT
         Z+m/pJjgMA1F+Y8WsYCWcItO4BgfppNFk4yjQ0HK6cGE4wA1KT13FGZ+ZLQY1T0Ryu
         5InpQ74kl0H7mt3/uN3K7SYQ3dpTZ630HPcjkj6YAZRjozY4mR5kgdu9hT8toINNE0
         Oi0bShbUWl5zeqd+9ow2IqjjuUAcYUh7/Kez6nixY7g0In0XwX+SnfvptdxjXAgfoj
         nbgoRlqr+jecbEjZ6mOl46o9rq/vyx5+peonsbroAV0ILXktibBpDPENd5Mfd0MsSM
         h9L8SiiAor/VQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/06/2019 10:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.7 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 05 Jun 2019 09:04:46 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v5.1:
    12 builds:	12 pass, 0 fail
    22 boots:	22 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	5.1.7-rc1-ge674455
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
