Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF67C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8C220449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698935;
	bh=bbPyEQ0vuClQSZYwDE17EAXe+dCbyTn/depgMWLGNuo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=P/VcjnPRt7eE8hZeyqWXvwQ1yRG9iVMh2pScXUgldmNvfVG7PGw2uaM7hiyRYmbH4
	 EncubGSy+Dv3Jw1pHBIbgejB85NH6ylF7a6NwBFE4dS7z4mKPP/NZSEUjPoc1Fc4sQ
	 JO9Ki+QXrDfhQnvVzmDrdbFt2AxXFoR6+DnBIjBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfDSSfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfDSS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1616222CB;
        Fri, 19 Apr 2019 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555683773;
        bh=bbPyEQ0vuClQSZYwDE17EAXe+dCbyTn/depgMWLGNuo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zuXj1VddJUX4Q728QpcJEm6nQf7VHrzj4nhphNOoYV4YKROE3GqXs36Lb7xMxyOjR
         3t7fcxspVJM9pXdmZZoQ5iseXuHGNHGSHCwnUHduVW0LO10FuRhLM23/ulWgrI3e7T
         TeUlaabV0PIUx5k05r5/aNR2q1e/sFwuHK8e15jc=
Subject: Re: [PATCH 4.19 000/110] 4.19.36-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190418160437.484158340@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f9faddc0-4186-af7a-7771-9506a8c3456c@kernel.org>
Date:   Fri, 19 Apr 2019 08:22:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 11:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.36 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:29 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.36-rc1.gz
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

