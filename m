Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABDFC31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B0B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560865378;
	bh=ZqjlDj4X5Ju1cr6XWllS7q+ibwcuY8P1srXtUfOSGNc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bYEpyh/opC093Ennk4lW6EfippSu/NTNxxI/mka/AMaCaHmGwJ7srBqB67g5yeVhH
	 wEpD15T7lUDiXvtfJbsJwoC7SMoekxi7Za/yVSXapx262vQz3t5pellYSd7qrbn0Bz
	 5DimYOpD6MIfuyJjqwCmrwAgOB+BDnLn1v7YGNVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfFRNm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfFRNm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:42:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 174912084B;
        Tue, 18 Jun 2019 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560865376;
        bh=ZqjlDj4X5Ju1cr6XWllS7q+ibwcuY8P1srXtUfOSGNc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bp7nt1VfhmccKPOimrc1VpnbOk8733l1vnKG5PA5fLuG0ZZ3dmC9pBtuiAKu2IjMH
         TXq+FCFo3CNTuPlgJLGlgKHD5tokM5+droHKne8cu8O6ugHww7rWzJwHr3+S5oWoSO
         21XlWYWQuzgTAsOxTzYP21JAgi2343w10vpXEEH0=
Subject: Re: [PATCH 4.19 00/75] 4.19.53-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190617210752.799453599@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6dd09a90-377e-fe8b-4ba2-bea3f7954541@kernel.org>
Date:   Tue, 18 Jun 2019 07:42:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 3:09 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.53 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 19 Jun 2019 09:06:21 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.53-rc1.gz
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
