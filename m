Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9FCC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CD5214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gb9J721U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfKEXqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:46:11 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10495 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbfKEXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:46:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc209c40000>; Tue, 05 Nov 2019 15:46:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Nov 2019 15:46:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Nov 2019 15:46:10 -0800
Received: from [10.26.11.93] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Nov
 2019 23:46:07 +0000
Subject: Re: [PATCH 4.19 000/149] 4.19.82-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20191104212126.090054740@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6e8b6e19-0d66-beb0-8e16-7975aa1d462a@nvidia.com>
Date:   Tue, 5 Nov 2019 23:46:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572997572; bh=y5momF3FRqvQu3YdtXVfqb2uV8PVwzSANyREhnaeY6Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gb9J721UcvRwiRbQzUuigqTtLITubocaWUK3OgRaVXLjeGirmZV7tvoI361ASUWwY
         Jkx4pMNnwTX0kOsfv13npNT7P3XpQ4bpoNTOozFpvNbQCEO59kOc7hhG9Q+6yhs2KZ
         05VV9+wARKvpNCrwKWj52sSrhhy2xI2C0LXJVFgx6NdqgvUkjwFX5eWmJ3R4veS4bL
         EqeBqXxykS1KiguhoVUnm9WEDaFWmjP6ibqMAwLXbhEiyrfrKzA7zHzDrd8xnDltyE
         7o7ZL2u8CrbF1CxFXL5/pemOxnkWXDRpd4O3HfCEk2t7SUcWF6DnFETFtMslrA5MpL
         ddYPPtepXcR+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2019 21:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.82 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.82-rc1.gz
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

> Jose Abreu <jose.abreu@synopsys.com>
>     net: stmmac: Fix NAPI poll in TX path when in multi-queue

The above commit is causing a boot regression on Tegra186. Bisect points
to this commit and reverting fixes the issue.

Regards,
Jon

-- 
nvpublic
