Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFDCC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BF4233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i54Q6wU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbfHWCGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:06:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9979 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbfHWCGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:06:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5f4a2a0000>; Thu, 22 Aug 2019 19:06:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 22 Aug 2019 19:06:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 22 Aug 2019 19:06:34 -0700
Received: from [10.2.172.208] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 02:06:32 +0000
Subject: Re: [PATCH 4.9 000/103] 4.9.190-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190822171728.445189830@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9399e972-c7ae-a9bd-1dbf-27420e2063ca@nvidia.com>
Date:   Fri, 23 Aug 2019 03:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566525994; bh=YnQaYd3/v0pI66ibNhZPBwXkGm9D09KMCGHodh0boZA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=i54Q6wU10QCVBUkc8BCpRUXxivuM7FBhI2U7CF+qMkLuSdfqz1eVum3x9eyge94xb
         7xHvhsI4OsZn5PgKXyQKYXzAdvReh7lFJ9nocCoTPP3ut4KfV3o3YdSdYPeilUngRP
         ZidqP9ee9W8P82AaV7QhXI9MRSU9fbADZnEmqHxa/p/1lW9kSi4ChcOxOXXck37hnI
         BjUnsRNTR5zDEWGJTTczTwes/c+iuAZ+am1HATmF8EzZPbkpdH1jO7OslQf/Fc0Uaz
         YC931Ew7yPUUouuemEY1jx7PFZBZ+Fk5XGsBtoKdQGZmUABFW0aWasinxKK3RzvYHk
         cHuKflbrakS8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/08/2019 18:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.190 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:15:44 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.190-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests for Tegra are passing ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    24 tests:	24 pass, 0 fail

Linux version:	4.9.190-rc1-g7a35fdc061cd
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
