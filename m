Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F260DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2A221773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564788046;
	bh=qi5ay9/kdJhy1ODdxA6n7mf2MOolGcG0+fzIwVabdMU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Nz82GSWrEQLqcUVZ1O0rd6Wnru4Xb51gyDGgiFi7CGmNmDI3mXLXcVx3pDaeSMFPL
	 VtFIkRmw7Pbr1G4m1JUBlImwgBSIcz90YCtHdjNKKYWe5m9C8YNRggHie5OSSreDIs
	 dx5Io4NaX764Sgwl5KUAthduJlsO0pSUSLLdQTqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392614AbfHBXUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388056AbfHBXUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:43 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB5F20B7C;
        Fri,  2 Aug 2019 23:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788042;
        bh=qi5ay9/kdJhy1ODdxA6n7mf2MOolGcG0+fzIwVabdMU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HsibIOlnCBlDDdyzMZrXgaW958H7qPEqCAwLdF+tGpWHDbxZRLRCaFawCczueg96y
         /cp9dheEo83rYZSiNe27PxoiXjq4qWdgkm/j5jrMCqnQwUau6off6/iVDMGzOnfkaf
         Bbn1UQlE63MQwYbEDkTqec2lMO/RChYXKZZUbHqQ=
Subject: Re: [PATCH 4.14 00/25] 4.14.136-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190802092058.428079740@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cb52ee66-6034-6fbb-d19c-96b2c7242d65@kernel.org>
Date:   Fri, 2 Aug 2019 17:20:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802092058.428079740@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 3:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.136 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.136-rc1.gz
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

