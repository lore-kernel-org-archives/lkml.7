Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF6520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g1aNvZs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfCEOHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:07:42 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17740 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfCEOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:07:42 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7e82ac0000>; Tue, 05 Mar 2019 06:07:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Mar 2019 06:07:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Mar 2019 06:07:41 -0800
Received: from [10.26.11.29] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Mar
 2019 14:07:36 +0000
Subject: Re: [PATCH 4.20 00/88] 4.20.14-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190304081630.610632175@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ece0a914-4b84-b832-757a-72583516c1f6@nvidia.com>
Date:   Tue, 5 Mar 2019 14:07:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551794861; bh=AvgZHY+p01+2n/mcUn8KVps1on60XJXqFk4lpa5/soM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=g1aNvZs9sxH5XZplIyuM8bWuGbrkNBi+DSuIUd44IvNUkUwLS43NECMROIRpqeFzK
         16mafsNdc2XKumgM/7M4j1Ur3japy2bcf/kSFFwbEkCbxqFE9rTtw0gTvzXtp5HnsZ
         7M/H9qRrj7Xzrncydm1SOhTipARFbz6rIgPze1dJiBHfCKXnyKDiN/IwOfiMjvS6tq
         jjL94/my721MBlF5KH5K4G5B62jmwDnPqsrrOOUjDnCRjzeXFzm7OcZa88J/cqpnN2
         OD3DmMPrXxpfUpyumm2mIeaNCZneEqCa7Ct5JmxIrD8r3oSrMyepc8psF2HTWBHU0H
         T1Lc3JsjyOqzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/03/2019 08:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  6 08:16:03 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
All tests are passing for Tegra ...

Test results for stable-v4.20:
    11 builds:	11 pass, 0 fail
    22 boots:	22 pass, 0 fail
    28 tests:	28 pass, 0 fail

Linux version:	4.20.14-rc1-ge260750
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
