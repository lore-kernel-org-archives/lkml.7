Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE10C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DFB206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557261268;
	bh=WD1wTSMJl3NIOTOkLwawpFYQSDoWLuDzJ0ttPmCchQw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Sl/9zjWDv2Sdfcnx4xi/cZVR0xhpt8MXOSiilZv07WAm2U6jOAcIR7MAPNwj/B5JM
	 /Xthu3zMa/O0AGahhNRnBL3QhFb0KjxhZdciX8dUJBqK4dRwZ9V0gmvdHT4Inmw8a3
	 AgEdSGz58WQ7/k0wl0+ezy+C7Lt5Z1h5pZj11inA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEGUe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGUe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:34:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90CA720656;
        Tue,  7 May 2019 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557261266;
        bh=WD1wTSMJl3NIOTOkLwawpFYQSDoWLuDzJ0ttPmCchQw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MbpMOcp320z5w6MwejcpWeT8+7n074vUnm5X6MIdkwry1oA8eMDThkneDEN5uEMrq
         0Xhuw/EQ73NklZdPvUQSZQa3iDWTGvXsFyQoMsduApYxBl9MR3vUHasv/jwTNkpWeq
         ARCgCqytKllG1Sx6K2uiKicr+NflcN8lmi3ZFwBI=
Subject: Re: [PATCH 4.9 00/62] 4.9.174-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190506143051.102535767@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <15d95f26-41be-53ef-cd56-c945d47b45cd@kernel.org>
Date:   Tue, 7 May 2019 14:34:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506143051.102535767@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 8:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.174 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 08 May 2019 02:29:15 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.174-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

