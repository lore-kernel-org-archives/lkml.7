Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A883C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA57922CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566669554;
	bh=Eanb8b7474+DllUDkXF7rOJehr0GMgl7M/7UVZ6WANI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dgL+RGjKGkbKecVQ68corrhPXpMtT2xgedlPKorVG4y4Lo848ctS1cvJVMcmzML6X
	 ri5BfGFk5IaEoF9V58H1rXPujijVpik0zxOjNhlW12ygEJJFyj/VX2ej4pZJq7EXXb
	 NZEijZfARtqyyV1bLLycDdLYlR+0XNkmSJjf194c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfHXR7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 13:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfHXR7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 13:59:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C537021897;
        Sat, 24 Aug 2019 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566669552;
        bh=Eanb8b7474+DllUDkXF7rOJehr0GMgl7M/7UVZ6WANI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XHyPiGywxZpi6Vu1c0SdcodpQ4umZYFuqKngMt8Uq/maasNPBk5ECXu4DKIFt38LL
         UzKO/OyGW93CMvcm+lSLoZpF/tkUChb7pug10u7bHzQLGUpDaTTmdC7zuDDAZcdq1f
         wga6S3ht+d2IMdhMcTdGpwaU1OM8JmY3n52BvQms=
Subject: Re: [PATCH 4.9 000/103] 4.9.190-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190822171728.445189830@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <61e6e5bb-708c-0a28-e997-06c7ba2a3636@kernel.org>
Date:   Sat, 24 Aug 2019 11:59:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/19 11:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.190 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:15:44 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.190-rc1.gz
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

