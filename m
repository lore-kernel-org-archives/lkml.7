Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D5DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C26B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555450749;
	bh=2Mahu5HQEdZA1joMA/Et56WMDKQSYhLB4bMyLQv181w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vU/IGukijpeTnWhUUprAiFni/RoobRw9Qi4+L31l01BbxyQVzuPKLOJY65bpyOolK
	 GzNRcig4sTeMNpQEWEOVHTYYb3IPAXLyUNBa0QIlb71/wmpM12KUl1HgwwT/4JvUqJ
	 QL7PxWwdYITH2sOYNr6S2YjyW+U/gOVUh8DjSuCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfDPVjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfDPVjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:39:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7B320684;
        Tue, 16 Apr 2019 21:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555450747;
        bh=2Mahu5HQEdZA1joMA/Et56WMDKQSYhLB4bMyLQv181w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aq26KcWCyIqBScqnvALWF5Cu1rKVt1uQl64sgK1bT/5aqRvqV20xhJhNfnPRJ3J4b
         F5J1NafmdoynqvPUmTRG+AO6VCe/TJQZKdZCCj78poI/SDFufgwxEG3hlKyRStsd87
         G9L2G3JnVUSH0/mtB5IVwQotsc1Z/WSlcUqFIn0U=
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190415183707.712011689@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <15ee3269-0b12-c5b4-a566-af8c9f831c8e@kernel.org>
Date:   Tue, 16 Apr 2019 15:39:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 12:43 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.169 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.169-rc1.gz
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

