Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6C4C742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FA2208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AG1KSqHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfGLQKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:10:37 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16721 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGLQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:10:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d28b1010000>; Fri, 12 Jul 2019 09:10:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Jul 2019 09:10:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Jul 2019 09:10:35 -0700
Received: from [10.26.11.231] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jul
 2019 16:10:32 +0000
Subject: Re: [PATCH 5.2 00/61] 5.2.1-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190712121620.632595223@linuxfoundation.org>
 <a1ae16a7-e8f7-b6fc-df4e-46079bebf9b3@nvidia.com>
 <20190712153108.GD13940@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a0d871e7-a68c-5c77-1389-5b9a86f93ac9@nvidia.com>
Date:   Fri, 12 Jul 2019 17:10:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712153108.GD13940@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562947841; bh=bYr87e5kr2ZaII8bFB9CgHx1dtUYpJJfkgUrOuzXxa8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AG1KSqHlPEW4mGoNA/PwDzdmkxHDB+DqPJZsj311xHcTDmYy+fQMCfyQwUCMYDF6z
         /z17+yquZIlG2k457vQbAo1/9To19BKHEuvIL+A53SS6O6fajJ9HEaa5MIvMGgb3aD
         aSLfKVXmpETBbmuTVzfxN89Tal6JEY7Jg+gxbajLughoB45K9GDpWS/+BgFnFKya2J
         02i/uza2EACqvBA0nr0wPj3XJZtXrpIO6AMJf6+WstJcWqyOAH7FnE0T29OvxMVpUr
         WrHmd3lkL2Ygl3pt4x12iQULtAPlrGGR/wRGer6mE5+qP/wmksilP6hC8TLaAswZYd
         rWAmufaPSEexg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/07/2019 16:31, Greg Kroah-Hartman wrote:
> On Fri, Jul 12, 2019 at 02:36:29PM +0100, Jon Hunter wrote:
>>
>> On 12/07/2019 13:19, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.2.1 release.
>>> There are 61 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.1-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> All tests are passing for Tegra ...
>>
>> Test results for stable-v5.2:
>>     12 builds:	12 pass, 0 fail
>>     22 boots:	22 pass, 0 fail
>>     38 tests:	38 pass, 0 fail
>>
>> Linux version:	5.2.1-rc1-g61731e8fe278
>> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>>                 tegra194-p2972-0000, tegra20-ventana,
>>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 
> That was fast, thanks for testing all of these.

Friday afternoon for me and so I am even more motivated :-)

BTW, has anyone ever requested pushing out a deadline failing on the
weekend to the following Monday? There is a chance I could miss this if
I happen to leave early on a Friday.

Cheers!
Jon

-- 
nvpublic
