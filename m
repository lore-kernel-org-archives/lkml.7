Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A0FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB7420868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V8pigoep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfCHQFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:05:06 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12666 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfCHQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:05:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8292b20000>; Fri, 08 Mar 2019 08:05:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Mar 2019 08:05:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 Mar 2019 08:05:05 -0800
Received: from [10.26.11.61] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Mar
 2019 16:05:01 +0000
Subject: Re: [PATCH 4.20 00/76] 4.20.15-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190308124914.789210760@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8d05cdcd-58e6-0b4f-32ad-ccfb1955baf8@nvidia.com>
Date:   Fri, 8 Mar 2019 16:04:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552061106; bh=8umKsC+k7qsIzb67DnGMU2su/PHPjSQcG+WqjMFKf0M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=V8pigoepHZ/NRBSAptsMkxY9anwHZLOKLwKbj7XRpiZ/VypQnAP/c+hS3zNLww8lR
         4hhgX21b5ZQpog+hIOrXQrjlEaQ4YeBLzlnNiJPm9vSU5CgdREL1dxgqzqsAwnJaBH
         DrxWcc4l9+j4wJz1tytSSbOhVOQ0y0OVCl2cpQmabQVaakCy3FGjZCWLNywdoZWOAF
         6HhjghmagMiEpyH+hDNp9nPnKr1aCyKoXvYfmAEhTn2lsWMc0g8SU02LuijST+WhIj
         PvI1Mlayh0TY1KvE/VKVGjBcXq5CwlP1agkSsluNHhUq+PCHIT2zcK6OjzM9L7PHEK
         sFlu8o2rJbWCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/03/2019 12:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.15 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 10 12:48:49 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
All tests passing for Tegra ...

Test results for stable-v4.20:
    11 builds:	11 pass, 0 fail
    22 boots:	22 pass, 0 fail
    28 tests:	28 pass, 0 fail

Linux version:	4.20.15-rc1-gb80b02d1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
