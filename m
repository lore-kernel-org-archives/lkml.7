Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E8222CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566585667;
	bh=VM+OYc/SUZhk1E669gVwpgQdtu7CqZ2mSkTDahzPDIs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ex2NP13N4e9F/iszYid7G68NsRItwRRBKJZugffXQGJTWxq/rXfZy43TFDnMU8vVC
	 WkcS47n5zTVD6tzemWtnfKxuSXvyFIZmiiYyfklK7MFniYC15yDJKOje2rxjejC1CA
	 Ftil2bYypJjvg1gh1TVc0BxYYqyGBd4HfRmrR8j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390709AbfHWSlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390289AbfHWSlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:41:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9773C21874;
        Fri, 23 Aug 2019 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566585665;
        bh=VM+OYc/SUZhk1E669gVwpgQdtu7CqZ2mSkTDahzPDIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qDnT51Nl/3OwNQxMEg/6TTVghnSir4vH9HLM3x+CWYce9vWNCsWhxUXkJl50hFW+N
         BhAnvKKex0dKsXRFtr5eSWPtEixhytVxKnQJOkgBTOhOcOwePOUF65dSkVjJ8zfH0i
         ej1NXzg8PSkfP9mXbhiuOI3g93S7tZv+6tBJgUv0=
Subject: Re: [PATCH 5.2 000/135] 5.2.10-stable review
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        shuah <shuah@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <00216731-a088-7d47-eafb-70409f876bda@kernel.org>
Date:   Fri, 23 Aug 2019 12:41:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/19 11:05 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.2.10 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:07:10 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.2.10-rc1.gz

I am seeing "Sorry I can't find your kernels". Is this posted?

> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> and the diffstat can be found below.
>

thanks,
-- Shuah

