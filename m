Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9302CC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5813B20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552078719;
	bh=dHcMHCDQTSDrisOLCpHbpK9oo93vDTk9Y3m8AMyNsE0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=gAfgdFUAMARC/wsdb6/uQM/a65c9F8TMSiBkp6zHz38opg91JZSmB8jlmDU/KPAa5
	 olTcVX4G+/4k4dyMLrxs1gbmhVprTySMAh93ZLMwy7/7ybiXCO6BE7h8XAZfww9KwE
	 gKVXWSzw7TNER4gcv+PxauyqjtTvzy3K+c8vB8lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfCHU6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfCHU6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:58:37 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8302420851;
        Fri,  8 Mar 2019 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552078717;
        bh=dHcMHCDQTSDrisOLCpHbpK9oo93vDTk9Y3m8AMyNsE0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M6SEOyF6EuYPzaQDBQiKdiLupFdiJrZQoVPv8ZoSn2SUFbJaYxDYn3JQefEqIdszu
         ryVjU8+TLtfOkGi9HwOrh1/zULsMF0coasn7mucv92Yw4cMbnZIeHjEi4r+HNHaD1g
         zGjVRDIusTKAEUngGqveuf8vVcBVj67z/F0SQGCQ=
Subject: Re: [PATCH 5.0 00/46] 5.0.1-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190308124902.257040783@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6bdc650c-9f51-2467-aa32-f30c73768d10@kernel.org>
Date:   Fri, 8 Mar 2019 13:58:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 5:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.1 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 10 12:48:36 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.1-rc1.gz
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
