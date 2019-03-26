Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4214AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26672087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553642164;
	bh=0Qzk3lqDRuA3Nk/u0vaGUpmmu4zBSe5DaH372G2muVY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Q586KZYRtGqXiati0iDQQoFepbrxjtup029PpZS09sr3NyuU9G7vBaEVbXADWND6L
	 af6w7Dmj1bJwXK+ddk9u67vnTmxgTlXvA1LSUFVp+4CjQ3rnI47iUDlV+OySCOWEI7
	 obe3Vddlc48qQE1DR+VhdbVEniFSktWOO28VLwv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfCZXQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731483AbfCZXQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:16:02 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363442087C;
        Tue, 26 Mar 2019 23:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553642161;
        bh=0Qzk3lqDRuA3Nk/u0vaGUpmmu4zBSe5DaH372G2muVY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X65BuZHrS7QU8qqtJ/nOS9F2JIXh6BUAYQ5LNzBU7zepRkblU9OJNjUQHntWiTOcv
         yIJ+WT06jYZQHecVR1d7vmIbaW/DQkNIuXF+GKUfA6HMSZsCE/Jr3JliRFrDD8N0r1
         QDPnWRMBz4s7d/v70nLnry5r+aDeJ1SMRV+M6Mg8=
Subject: Re: [PATCH 4.14 00/41] 4.14.109-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190326042649.889479098@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6f7a8e83-6b0e-c6ae-7f05-1c6f98b46a04@kernel.org>
Date:   Tue, 26 Mar 2019 17:15:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 12:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.109 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:26:32 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
