Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84201C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F1221736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BUN0SnKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfDSTaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:30:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11950 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfDSTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:30:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb99e230000>; Fri, 19 Apr 2019 03:08:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 19 Apr 2019 03:08:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 19 Apr 2019 03:08:57 -0700
Received: from [10.26.11.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Apr
 2019 10:08:53 +0000
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190418160436.781762249@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <34d2263a-8c63-7859-e73a-52cd11d926b5@nvidia.com>
Date:   Fri, 19 Apr 2019 11:08:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555668515; bh=o+YkyI5isCkoBn5+pbH8Fl3um6hIxUW6THA32BmOc2s=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BUN0SnKwyeQEl4E1BUK+YtvYx6okWZxarTcKHIRrXFlNm8TWUZdojMoeJe5Dx5SPC
         BkqHqUdDN3EhZ35N6gU1iHuwb4tHaIJDELwV0E2Yt5zDaMXarXGupSvr5sOhn+lW6D
         gpnvMs9WsCKO2F2tIRxrib+DCOq7KCz/vOfhs4otqycfn3le2n+Ce5cZ3H1tu+Q+Ee
         u6QIit4zjwoUXRdHYR0oPdgguuTFPXP0ZKEDd6yzvcPrFa4jbNL12/I5hcJag8g3lG
         AFBXgzAYYJ2MLHzCpJFodPRnHnOeNzAFl1+aWwXNK25tt+SNISForD/xEOiMEXYtAG
         noBUoDGeRvhGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/04/2019 18:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.9 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v5.0:
    11 builds:  11 pass, 0 fail
    22 boots:   22 pass, 0 fail
    32 tests:   32 pass, 0 fail

Linux version:  5.0.9-rc1-g68497c6
Boards tested:  tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
