Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DFAC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747E8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MWFPFG/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfDPKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:33:38 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19502 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDPKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:33:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5af6d0000>; Tue, 16 Apr 2019 03:33:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 03:33:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 03:33:37 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 10:33:34 +0000
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190415183707.712011689@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <450a5ad2-a759-b95c-b90b-7126ffb8ed06@nvidia.com>
Date:   Tue, 16 Apr 2019 11:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555410797; bh=//Y51OeWYsmuA3hEFI3FJA9aoYFp8aDeZMDp6IH2UKE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MWFPFG/Ct0sZJr3qZ2GDw0BfqHa9JSq5lIOka/PUtDWZzs4kPTVOA6QW1RIGBB6Rd
         /h4lISpy9x7egNbOFBP2SOn/jvdnUIkzqNbL2GZcJNBny887VVQ5cKZpvMFfr+ISzj
         WSQRYcKcObzpQBamlgB40Iq0FqMXN5c25WnC+kN2e0kVZ4VYp/1+UeKzUReOOahRwf
         lbHTezussoxvgUVRUGCxo5L7SHCi+Grfbk1Wme/wMo3Jn5dwvF0Qt6Ujlk1V/bLqLP
         VxWxCO3VbHrLy2xBGLA+2Xu/koIGG/wZOO6nVxu4eQFCbqizdQEHl6eQazNC91+2dB
         i5ba2CYUDrFxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/04/2019 19:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.169 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.169-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    22 tests:	22 pass, 0 fail

Linux version:	4.9.169-rc1-ga590593
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
