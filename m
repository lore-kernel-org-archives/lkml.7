Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF5DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8F20449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698861;
	bh=2aIbcoJNb9wROv1MECCc9c+36J1M8zNDTG6NPz801hI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YJbztshEhZ4dhnZw2kSsz5WaR2n3v7ceansq+QF6pVa5yuGZIILVkne4Q6j39v5U1
	 yr0GabUuZhBRNkSp8IS3lEwV9XET6BnjhOi7GCQn353tYJFl2idG1sP4+qySqcAS6j
	 kBla9DFAFLVIAzKaA6knHsy1eKH0fSjVgH3cyYSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfDSSeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D34222CF;
        Fri, 19 Apr 2019 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555683844;
        bh=2aIbcoJNb9wROv1MECCc9c+36J1M8zNDTG6NPz801hI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qfulrIfP/pEN4uaOHG/Xhn8WO1vVwSnETPgCL76Y05IO71doZVYX1TCctYoJ+fNrK
         /F0Cl8LXEM+ZRbyUynJEJNSbFdyNlp+ca22JzTx1mk3gHgoZ+8Ww5MEwnv0BjHVdUa
         9nwxRJOUg0good8lq5nhTmR6tn10/00ekFnw/78Q=
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190418160436.781762249@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <b9d55173-72d0-ad9f-5b28-7fa6c81b961f@kernel.org>
Date:   Fri, 19 Apr 2019 08:24:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 11:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.9 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.9-rc1.gz
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
