Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E53C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11202075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555450864;
	bh=yNBM+Jlo3SakDTnr+5uwxTDfcm5FSouh6WUQdDVPzWQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rYXrkSbuJZeEAb0vugkF3uN35nbuTQVYRR+JMHIxWMHovnx2hwS6odWexqLAtMczD
	 qN98NIP3tkMMZd2Ph5c5GY2gIy815P4ogz2lBDrrfQIraqXRh6zAjLuOtk0H620/yE
	 cjU021+w5nRXl+4UPshFzXvx4KMHB77Bey6/JlgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfDPVlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfDPVlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:41:03 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9283F20684;
        Tue, 16 Apr 2019 21:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555450863;
        bh=yNBM+Jlo3SakDTnr+5uwxTDfcm5FSouh6WUQdDVPzWQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QVArgqQ6XJLy831ZzCtflFR2eqT8PadYHAgvHVTbrr3dWVkCQDUg4YYRbG1UcEBwj
         UBQGgSSmezhnT4sTRZnRoZH5CukFEisEA389o8XAY2ngfNV3WRRb4HlSMOLACLe+aU
         t2FuJzVqJ+N53VfYxec/KQk8pl9gm+Lc1pxQ7RGQ=
Subject: Re: [PATCH 5.0 000/117] 5.0.8-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190415183744.887851196@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d01fd527-fc6d-e86b-6683-cf9767e685ee@kernel.org>
Date:   Tue, 16 Apr 2019 15:41:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 12:59 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.8 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:42 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.8-rc1.gz
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

