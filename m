Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92646C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F9F217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bzqXGSff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfDST3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:29:51 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16190 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfDST3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:29:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb99e200000>; Fri, 19 Apr 2019 03:08:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Apr 2019 03:08:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Apr 2019 03:08:35 -0700
Received: from [10.26.11.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Apr
 2019 10:08:31 +0000
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190418160422.455656724@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0ab11971-bae2-0e5d-d0d7-f5a9a9da47b1@nvidia.com>
Date:   Fri, 19 Apr 2019 11:08:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555668513; bh=HTLXGJm0AaD0/VkfJ7+asY/GMBhm38yV1C3JRKgipy4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bzqXGSffjqEr8aoh1+Gb0TwItbuAPQE582wVjF9y0eKsOXN/biIKqt2Jhb4Ew1QU+
         /BeGiKykEPNFs4l3kv1vHM3nrwC5wGi2X6Q2JLhC8RZtyg3p1CFhqjEuD425w7TWy8
         sqWinE7ETebca2nZaHc4Goy8n4IUjzHt48GwSHfwvAQX+Zt9iUWgzFF9sKSFdvitQA
         IHIP2ji+hfGLnYZr2rbd9ouYuhbGal5IYfk+5yelKZkAWiUL8FL2kIZeqyYkYo2s++
         7K92H8DPs4VI+pKu4uEBYQXbx9aKkpTguGy/YGQr0a9Hx2gaCc1PjZjNA0Q/uXf2hm
         GzOexOjqpR6+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/04/2019 18:57, Greg Kroah-Hartman wrote:
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

All tests are passing for Tegra ...

Test results for stable-v4.9:
    8 builds:   8 pass, 0 fail
    16 boots:   16 pass, 0 fail
    24 tests:   24 pass, 0 fail

Linux version:  4.9.170-rc1-g0f6275b
Boards tested:  tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
