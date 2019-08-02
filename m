Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A799C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3606D20880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564787988;
	bh=YU++tyFGcf6FgkDOi6izWRA7uaMXKRdOOC3CjOX9euM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rbT7soF3Cti0GQamNRc59F82Kkvvi5+WwQCtilRHWk40syl6PAa9XsAxsU/WdwaKa
	 AvhaxMQXZnN2j5OME7b3SVnM6QzqiFub0GJqVPDFGstPSu8GMq9f5pYbgUvDjfqVHy
	 UiS9XfOJBIr3CWS7HHH/829ZFjVlVKD8pmp8ut8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437438AbfHBXTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbfHBXTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:19:46 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404272087E;
        Fri,  2 Aug 2019 23:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564787985;
        bh=YU++tyFGcf6FgkDOi6izWRA7uaMXKRdOOC3CjOX9euM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NdIaKsCiF+u0y6wygd8WBq6MQW7yjmnvfVv5BeASL9ZOHC/B66AgZXY+dsDKqmcAz
         KBM+O23q0edTYgcQQFZGpE8dYVWgHpUQ7W7Ox8VF093NbL240T+YvMoezET5/odM+E
         FaAV6DLt9RoJVqoIpVp6xhWn7w4K9qX+kRx0eqgw=
Subject: Re: [PATCH 4.9 000/223] 4.9.187-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190802092238.692035242@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e2d79657-db37-a315-fb16-3baf3825028f@kernel.org>
Date:   Fri, 2 Aug 2019 17:19:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 3:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.187 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.187-rc1.gz
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
