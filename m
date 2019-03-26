Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633BC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAADE2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553642287;
	bh=at/mUhwW55h9QcPbeLGlRsN/bhmzRSAmI5j4ylxQELo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=d2AiCI3aK9RSfm49NTPChqKiUwxuoQiBxGIdW4cPA9O/lu/NyOMWgZ9mxq+pYUp3f
	 sgsmQlI5uPu5rgT6RmOMlO1oAouHLqut6UQdr++8yCu9/MrAkiNrMGPNpIIdpddNiU
	 2TKNliU9m1uplhwjFRsljhHugT4AlYeq0BFROUgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfCZXSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbfCZXSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:18:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E512087C;
        Tue, 26 Mar 2019 23:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553642285;
        bh=at/mUhwW55h9QcPbeLGlRsN/bhmzRSAmI5j4ylxQELo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2e/ZK07PqMzZRU6Shz9NChkP0R9GIzvZdu0RdaNozIvMeUFFp62YOdqvcwd5084/g
         X8aPt2cUoMdwOvi+ovA0ZDyT5CnEob97oTTKXpu3ZTwxliw4yuavHhXweoOG53Maty
         GpZWhLJmwnJd2g64nDySgX5xtPMRaB/+puS7MhA4=
Subject: Re: [PATCH 5.0 00/52] 5.0.5-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190326042700.963224437@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <846b9bed-9db0-2e9b-1f26-71ee418492b1@kernel.org>
Date:   Tue, 26 Mar 2019 17:18:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 12:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.5 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:26:38 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

