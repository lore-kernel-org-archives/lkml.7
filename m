Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F83EC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B882077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yx0L+75p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfLDJph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:45:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11929 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfLDJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:45:36 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de7803b0000>; Wed, 04 Dec 2019 01:45:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 04 Dec 2019 01:45:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 04 Dec 2019 01:45:35 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Dec
 2019 09:45:33 +0000
Subject: Re: [PATCH 4.19 000/321] 4.19.88-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20191203223427.103571230@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <79c636e7-145b-3062-04a3-f03c78d51318@nvidia.com>
Date:   Wed, 4 Dec 2019 09:45:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575452732; bh=26kyV1gW8PkF4sKzVfX5NP+tngMmMEqR9KtT7T85FsI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Yx0L+75pxw8ZP0uaEQ5SM3bjGZqwgInjobvUKwV8P5F3PIgHm4bpjZju6W+VE2wwS
         4dev6EXK3woPZ/KGEXl+KqXYzdvI3Fq+1ldHOE1kXL2toeJJg91vggQKUSdG5UGR0w
         3EjqY/NesEP0jZCFFTzKodk2DOGKkBrhDXPJbvj9/J/AD4MhZE7yiDFKBM0Hxy8SRw
         11ZvC59DJnib1BVC4+Z1d+RRJDu9wYk8OZ8qykIXMdD4JzeGaeg6rF6mQ3g95g+UZd
         WZyM0BRSB6B8Z2t3BXHiMPFizyTxRPiIGx7Mw+Il2h+s4OOvKkmoVRkG/U7F1LMsDj
         UW6vimPZAmNUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/12/2019 22:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.88 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2019 22:30:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:

...

> Ding Tao <miyatsu@qq.com>
>     arm64: dts: marvell: armada-37xx: Enable emmc on espressobin

The above commit is causing the following build failure for ARM64 ...

  DTC     arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtb
arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtb: ERROR
(phandle_references): /soc/internal-regs@d0000000/sdhci@d0000: Reference
to non-existent node or label "sdio_pins"

arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtb: ERROR
(phandle_references): /soc/internal-regs@d0000000/sdhci@d8000: Reference
to non-existent node or label "mmc_pins"

Cheers
Jon

-- 
nvpublic
