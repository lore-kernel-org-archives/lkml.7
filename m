Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0D82070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ThlmGBMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfCZPUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:20:06 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16592 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbfCZPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:20:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9a43270001>; Tue, 26 Mar 2019 08:20:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 08:20:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 08:20:04 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 15:19:59 +0000
Subject: Re: [PATCH 4.19 00/45] 4.19.32-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190326042702.565683325@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <879360b6-5584-493f-4386-6f67ceb2ad16@nvidia.com>
Date:   Tue, 26 Mar 2019 15:19:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553613607; bh=QTBPdlnCXSoy0l+dGbTiqPwTkiUrr6iJxptc7mX9o1M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ThlmGBMaVZD/5h/6qkegQUhox1pth6Z+6c7hmmXhtux3Lfx5sQjsHTlxnHWtRGHoc
         p/Nkj5MRl4sfgoUkB4d7J2HzmouwT3FBqEM7ppA0eQyyZr2MArBIs0TXqSRF35ZyHi
         C/VRQtNQfQfJZfFFSGYoaMX04VugMptNbZkl1sfuDvLxic70W6wySw6yOYQcH2gCIL
         R9USebt/PVb3xx31F0EhoLf+HYXz5zqZ03yeFidPcK/KsEcU4PEhh5jnApMSYgCZD5
         3DISLNil6FR0uxp5WXKM8wyCFkzUG+qDkJXALQsWJUuNfLnev6k3U2mZ3jGuor7d/N
         FvHXKWer7DDHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/03/2019 06:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.32 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:26:41 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.32-rc1.gz
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

Linux version:	4.19.32-rc1-g91ed293
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
