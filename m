Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E19CC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1438D20880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SGUUyP40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK1K4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:56:52 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11117 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfK1K4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:56:51 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddfa7f50000>; Thu, 28 Nov 2019 02:56:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Nov 2019 02:56:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Nov 2019 02:56:51 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Nov
 2019 10:56:48 +0000
Subject: Re: [PATCH 4.19 000/306] 4.19.87-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20191127203114.766709977@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2b46e463-4fcc-adcd-401d-f8a50a72599a@nvidia.com>
Date:   Thu, 28 Nov 2019 10:56:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574938613; bh=f6Lk/5XFWWy2m43ly07q96BwWiybHAxAgyn/d4wDaH4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SGUUyP40j8OfWxHdEISx8Us3dqwGOgfCkHPrmXCTWjc/e/G5cDSsR6zyE9ild9/SL
         dXRzTJdgEYJRJOSxLoNl1KE0STSBRyaeKeLMXdY0Qq8uEiwTReqEcYs6vuUC1ojiGu
         RctRb/h0FajDCkFZ6Y3ojhk7xaMpXEKp5iiJsBoUPiGXzUuhPDAavbjogFfg9aVXz6
         g+NG4HPhtGD/GwmTNfAhcVrplkLZJ036BnvbuTZhSFVk89yms82YrNQ4BqrtgGp8yU
         0w/jeaZjiJJkJ7Njsc2M/fL8stAV4Xe14H36P+I3lBjqwOgwX2tBBIPxU2qsT9NhZ9
         snAu4Kj6qglQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/11/2019 20:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.87 release.
> There are 306 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 29 Nov 2019 20:18:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------

All tests are passing for Tegra ...

Test results for stable-v4.19:
    13 builds:	13 pass, 0 fail
    22 boots:	22 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.19.87-rc1-g57c5d287ed48
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
