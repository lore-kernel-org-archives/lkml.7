Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F82C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EB923404
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rHgptXKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbfHWCHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:07:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10066 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbfHWCHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:07:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5f4a670001>; Thu, 22 Aug 2019 19:07:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 22 Aug 2019 19:07:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 22 Aug 2019 19:07:35 -0700
Received: from [10.2.172.208] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 02:07:33 +0000
Subject: Re: [PATCH 4.14 00/71] 4.14.140-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190822171726.131957995@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a183a811-35f2-ebe8-c8b6-810eb80745ae@nvidia.com>
Date:   Fri, 23 Aug 2019 03:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566526055; bh=d8aoXexj8xxgDgw61BGNl8d5Pku7mAE/HxLXLrOMH50=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rHgptXKvLVDiEYK+drIVzgkoo7MhliXhZmwvnfECUR1I8hUM1CyFrSIUFH2rp3Yaq
         IcIfj2UzTsM+qb5YBlMnyXH4lsfvaYRy1QinFzvceM+vgt6jlTPUG9rOjoGPOk+vJc
         G1puC6cPTxS/GZbiD1foB8kufKuGfFf1qu1HEIIpSkyucNh3KnSDtJ9J5LhgDMjvZt
         OBO3qLFBLVhjUoub2gq3hxRNoB7OINxjFQxMtkwOC+xwfvB2sNy4VLdz6+tGSGETcD
         bt2ZDmHnrpJlKzMgN3Mgdid5NGHD5GpZ8jv4mha7FeDVucH2orL0StZzDlWuPKupuN
         D1Tme7bCSpMGA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/08/2019 18:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.140 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:15:46 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests for Tegra are passing ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    24 tests:	24 pass, 0 fail

Linux version:	4.14.140-rc1-gc62e7b28b99c
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
