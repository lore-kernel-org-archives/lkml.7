Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EE9C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5711222D1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="To7dSYWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfCXMCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:02:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10966 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:02:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9771cc0000>; Sun, 24 Mar 2019 05:02:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 Mar 2019 05:02:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 Mar 2019 05:02:21 -0700
Received: from [10.26.11.193] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 12:02:18 +0000
Subject: Re: [PATCH 4.4 000/230] 4.4.177-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190322111236.796964179@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <954b1f55-c267-b88a-51cd-0a409039142d@nvidia.com>
Date:   Sun, 24 Mar 2019 12:02:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553428940; bh=BMO+AKYBpGR/vjTW4l0J8xRDbq4XJpgNHJM/siWCfSk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=To7dSYWhJGnQKx4bNppjVQrGhWiqPYmbcxZ/RSJxIxOYiO/4RSZvZ0ugTu3x/WTa/
         nNNCk69HYP9xcoNQXION7WBiKRO0ylM2YcEpeTWJAbcLmHDLUYNdLdDaPDHCuBRSpH
         jt0V7kS9FlhejiKVzz4+jEHyQs214pt8ftccAg14z6OzcOUc5aQQsPCTvK+Hc+gjmM
         o0Rj6E1ahG2GUK0lqQ/vx5BIcgDLZySRTCY4kgnNETLiHl8MgjBYiFpT0E5s8m95ZG
         Wt8SB7+vkq1ZfBxu4QqgYyWitI9va4PGZhpGJtlPPtKvpPiEybcrMUpsHmLIV+ca2+
         DEIvlfuWWfs9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/03/2019 11:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.177 release.
> There are 230 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:10:58 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.177-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
Our daily builder has taken the weekend off unexpectedly and so I don't
have a test report for this branch yet (although I was able to pull some
reports for other branches) but I have given it a quick test myself and
see no issues.

Cheers
Jon

-- 
nvpublic
