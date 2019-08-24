Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7391C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A4F22CF7
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566669305;
	bh=xe06EIuJ+bahv97u1dmiNTt1kRBb7GDApPnLA1nRkZc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=c1ia6VSpq3hjQmZ28kfuH2LwXm9BRsLqhSs0CfkpP/76zmeEnjlRHiVzArCfSB2FW
	 /T7asy+asHKVfPHIN7BMs6ZTVnCFV6Kq3O47p792kXTCZ94v42gV4L4RMBa1WVGFZO
	 goXkscIfbGSwnsWiRCGxhEdD7Pnp4co78lYGqHZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfHXRzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 13:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfHXRzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 13:55:04 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA60721897;
        Sat, 24 Aug 2019 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566669303;
        bh=xe06EIuJ+bahv97u1dmiNTt1kRBb7GDApPnLA1nRkZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hbE+fCa19DCPmPsbLfJAKt3jWHOwUMU1VlvMqKZ9u4tUm3rjO2MCsrJLjimgYRFyK
         TO1IxeySu9qz9YHV4SeNZRmAUIN2r0hWB7NvWbCYmD1RET0I9SKCCnKlCEZG9ugTCk
         x621ACLQmgUKf3TETzd5MWdmTpTVPjcDleE5Ge0I=
Subject: Re: [PATCH 4.14 00/71] 4.14.140-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190822171726.131957995@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <4d415789-c8c4-0c8a-d499-593383a01c0f@kernel.org>
Date:   Sat, 24 Aug 2019 11:55:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/19 11:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.140 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:15:46 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.140-rc1.gz
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

