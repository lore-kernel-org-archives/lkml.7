Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5623EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235D12184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566932965;
	bh=j35b3QQ1PDlfFEvYEGqMq1GykGZQS5sT5QGOHy/w+kM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=07iUWj3Dd0t/Iuh24ZljIq8G2zTaqpNN43BTEb+uMQCVeSIL1QggJoGGeyfBtbV8i
	 JpNnNmyqE4I7KUlY3CjTdCIzyMbTIAzT0sI4BiAG2ahzKGVH5dQYPEI6yOFkuzl2P5
	 zQ13W61bfebrTcriFRLZseDz6LELcPnNiXECUkX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfH0TJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbfH0TJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:09:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB663214DA;
        Tue, 27 Aug 2019 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566932963;
        bh=j35b3QQ1PDlfFEvYEGqMq1GykGZQS5sT5QGOHy/w+kM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IAZKefRmWmh+u6QI7ylZYzizG7jW2/plT9xkMo9X1RFdBr1KitVOZRKEZnYmTLfN9
         vacuFkrD29NZcTcdGVAEl2DOUPUTH/svBYMVCqGueOOSbr/WSleslmTOZ/O6yv8fxx
         ybeZop38Acehz7hcgC6I9Shoqh6zynbJtMrvdsXA=
Subject: Re: [PATCH 5.2 000/162] 5.2.11-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190827072738.093683223@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <af4552f9-6321-dd61-2264-3f3e793aaf61@kernel.org>
Date:   Tue, 27 Aug 2019 13:09:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 1:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.11 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu 29 Aug 2019 07:25:02 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

