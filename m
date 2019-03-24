Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0735C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA799222D1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Rn0VZ77l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfCXL6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 07:58:34 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10858 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXL6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 07:58:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9770e70000>; Sun, 24 Mar 2019 04:58:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 Mar 2019 04:58:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 Mar 2019 04:58:33 -0700
Received: from [10.26.11.193] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 11:58:29 +0000
Subject: Re: [PATCH 4.19 000/280] 4.19.31-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190322111306.356185024@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9f15978e-9284-0a46-ac61-f6bbe3191e61@nvidia.com>
Date:   Sun, 24 Mar 2019 11:58:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553428711; bh=S6mx2qnUAh2S9P7CuDHsO4+0ZPtfw6NJDTZQYkVPrGI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Rn0VZ77lnyBm84xDMxC4gnWGhlcq0iB+ZQixbopv2B0HN9hOg51jdfqJlz2wzS01E
         0QUFbaGoqnuE8eZVyP9gCFlYOgi3tVMt0Uj5LC3y1jmV+wlTdvv/K50GLy+bZDfbEF
         9qqw7jzq7k6/Pe4Ciy/YikMCoQsRDHAAVjeua3LSJJlDEuMcHvW700b6PxGfSL92I2
         UJE9dVDGDb+0eEkj4lRK7h3MP0NEg+2aRd2EaSDQw5TJVTtZf7V0YgwVB/kNRSesRl
         2XW+zY0gRUiaR/B1lrwLjUwvL9PSG5BRckIuFAJ0maxi5NQyVwmG/IYxL9ib2ALlUt
         GHPkfzbzs6l/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/03/2019 11:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.31 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:11:09 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.31-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests are passing for Tegra ...

Test results for stable-v4.19:
    11 builds:	11 pass, 0 fail
    22 boots:	22 pass, 0 fail
    28 tests:	28 pass, 0 fail

Linux version:	4.19.31-rc1-gf4bc3de
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
