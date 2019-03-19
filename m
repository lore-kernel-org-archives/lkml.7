Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A246720989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lrjqN78u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCSKdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:33:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12237 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCSKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:33:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c90c5700000>; Tue, 19 Mar 2019 03:33:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 Mar 2019 03:33:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 Mar 2019 03:33:21 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Mar
 2019 10:33:19 +0000
Subject: Re: [PATCH 4.9 00/31] 4.9.164-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190318084210.397476003@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <99f06d45-dd1e-3b56-5b03-73d624c4925c@nvidia.com>
Date:   Tue, 19 Mar 2019 10:33:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552991600; bh=JJg4bcL1KEVExMRl3wJKWU4Ure6ceLCsPI1ikgPif5w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lrjqN78uB55wkaWaOAPvIFrQ9mmaFJIozZoTpX/o4S6Lk5ZmJjrbp0mOMKyGoSOYb
         GwDgUgJ6WyV8T7d91gHi1tmMkYRl4un20TjIl5HmMwFMlsGz+ti/8uB/0AARFxJFwN
         0cKivqZllXetf8A5+jbafeh9I6+Nj0Z9MzlHiy+gshNuo9JNHT4mwC1DpsS7ahxI3A
         yUIWvnOS7PY9o0qiO1KhyctKgSS9BvoSQGg272J30o0GF6J2py3A55B1tBZSwjo0FI
         lFuThelSIWF3cAEH1WFUam31FCAnAfZuC44WRjuuEL4Ua98FiVp1G9P7SkJc/Bcake
         aakQamoGJM8Lw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/03/2019 09:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.164 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 20 08:42:01 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.164-rc1.gz
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
    20 tests:	20 pass, 0 fail

Linux version:	4.9.164-rc1-g631b5fe
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
