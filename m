Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E602C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5723D21900
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554477483;
	bh=7XcE+bzPic9FIS2jz+fgLO2qesMltmC/S8q0HHh1OS0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jR7Opk7VLv3TFRAwRmoI+0f7Ur3G5Ej08otXBo+9hIQJjsGMlMbOPj88RkAw5zYdj
	 OCcPt5Vmvt3rq2n2NBWO4RniXBDwmzKb/j8q1UBEpZ57a0muj8xxCL+LNDCk18Y0ge
	 6F4onI7ihtM0Wr6i2eNdd6LqmPn90AXVZ/DzkT0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfDEPSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:18:02 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDFB218D3;
        Fri,  5 Apr 2019 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554477481;
        bh=7XcE+bzPic9FIS2jz+fgLO2qesMltmC/S8q0HHh1OS0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r6XkulzhXQt3O9ry/yjprVXWx5/epcXXg5wyTkA9uWoL06VO0CatV0kxz73g0I3A6
         CxPdR/3ONY4eI7jsBBdWwQVJ/SpypeXAR4xfJOiqSel7aC4QtLYAmXH7QQIg97k85j
         47KL5AVpNv77+VDF81dVEGiQjppCL+r/l/7AaAzo=
Subject: Re: [PATCH 4.14 000/121] 4.14.111-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190404084545.245659903@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cf7a46dc-eff2-a9eb-8b06-b6dfbd956a2f@kernel.org>
Date:   Fri, 5 Apr 2019 09:18:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 2:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.111 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr  6 08:44:23 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.111-rc1.gz
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

