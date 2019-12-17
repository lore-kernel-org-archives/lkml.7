Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E19C21739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qNn7T4TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfLQL1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:27:33 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13537 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfLQL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:27:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df8bb820000>; Tue, 17 Dec 2019 03:26:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 03:27:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 03:27:26 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 11:27:24 +0000
Subject: Re: [PATCH 4.14 000/267] 4.14.159-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20191216174848.701533383@linuxfoundation.org>
 <20191217090548.GA2801817@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c067e2f2-e9ec-6006-21b9-a1fd4d508d21@nvidia.com>
Date:   Tue, 17 Dec 2019 11:27:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217090548.GA2801817@kroah.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576582019; bh=nGwtza/SVQILMLhlaQJsnoDs3TgqHWopxWMuKFWmHu8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qNn7T4TP2fUattxxxVJsCqpNCIPOz+laoIVH3wIz6vT6ZnsAHtwczT4nPnqHJiEji
         XADV243e1rXnuInmkBJZ3VfUWfUU5wdnKAuziZgd5nqiYbaUgu1GXhF98mxY7R79e9
         IxJWjEyyGSZs/94SECce5CFmmSI9ZxL8Sy1925agyDi3XRXOMQmp8cKI//ONGjXC/u
         swqF56V2hPO9v2xLgQF6i2ATL6/08n0cPdcjsTbDyb4frk3BGzR+FwQ/bbtJWioWCP
         m9cR1YxOZyoZa5jeSYgd3R1HVAQG7xKpsy6AaXvWP9yOEwv24TwjERqnqfP6BOlue+
         U0X7PfiTOJE7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/12/2019 09:05, Greg Kroah-Hartman wrote:
> On Mon, Dec 16, 2019 at 06:45:26PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.14.159 release.
>> There are 267 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.159-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
>> and the diffstat can be found below.
> 
> There is a -rc2 out now to resolve some reported issues:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.159-rc2.gz


All tests are passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    24 tests:	24 pass, 0 fail

Linux version:	4.14.159-rc2-g66745e000c83
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
