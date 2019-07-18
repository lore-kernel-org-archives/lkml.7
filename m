Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F542C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C772173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ketQidtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfGRJUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:20:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6165 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfGRJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:20:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3039de0000>; Thu, 18 Jul 2019 02:20:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Jul 2019 02:20:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Jul 2019 02:20:32 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jul
 2019 09:20:30 +0000
Subject: Re: [PATCH 4.14 00/80] 4.14.134-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190718030058.615992480@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c2ceaf25-44a8-b997-fad4-4d43c54a04fe@nvidia.com>
Date:   Thu, 18 Jul 2019 10:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563441630; bh=87LPakVvWcJUoEOjnqScUN2A2G5j+YmObn+WDsm/+oo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ketQidtgmUxBrG6mEoy+yY81px319u4CVRpmBtcM/pvVrgWBEMJ+1vOaKhnrMontZ
         uXg9jbfNXJwPVwE1x8ISj1kQdQMoSJ99mO7EllFUsv4mNt8hCw3XaE9a7DlODmV2th
         pkjIskmey3JXBLkuUY2Ujy/NWrncXOjSgL4IhCiSVpWOqzbGThsKj2BtzYxXB0ebxi
         aDBxdgEOAFWAFi+DJxqPT81Dq8d++MJ3qmM6d7eo1pFHoaFcQxTCwrjsxFeuC+b/Pj
         kLh6IiWz5wp+HJsxfewfPNP8uVzhJSdxecDW+f4PKtIAR80huKbf2bZmdD8U0FgKEr
         vvaPM7p8zlZ0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/07/2019 04:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.134 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 20 Jul 2019 02:59:27 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    24 tests:	24 pass, 0 fail

Linux version:	4.14.134-rc1-g2c7e97d1f95d
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
