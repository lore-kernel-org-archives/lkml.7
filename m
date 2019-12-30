Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81B3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B811207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577672453;
	bh=3oEdvGdKSqy8HK1FxYR5Z7orOSvv0gZ6ZtbLwZVR1/E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=kg/1La8tP9s52UcRQXS2FQopv1tc1EyvYGwuSHM5g+qFTsTTg2QlTZkfVuq0RN9uG
	 dhbUGiVmmux9PkMe7T8FqKvy+0Znqw5JnN6HHL4/izIZ+rqUGXLNqJbAjF920u9eTB
	 bYfGKXGccBmy6qNTglbY/A0ay/U2/95AiuPSjw5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfL3CUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfL3CUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:20:41 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660F0206DB;
        Mon, 30 Dec 2019 02:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577672440;
        bh=3oEdvGdKSqy8HK1FxYR5Z7orOSvv0gZ6ZtbLwZVR1/E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vvkhM3/Ir2RrRJNJ90z12j2LlBBsajdRCK9LLvyIthZB6U3w2w3WW31tBVEONWual
         B9LihLPAuElpPt6pJLbXa8fff8OsjprFN5GobfOVzUzP10LR1By2qnVSIGuo9dCI5G
         gjg/2VCGK0qyqqaxBI4DXuFOtALY1YYCR1T2kpxs=
Subject: Re: [PATCH 4.19 000/219] 4.19.92-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191229162508.458551679@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e29b5933-9c7a-9a6a-4964-1dd9ea3d95df@kernel.org>
Date:   Sun, 29 Dec 2019 19:20:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/19 10:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.92 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 31 Dec 2019 16:17:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.92-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
