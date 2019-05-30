Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC203C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01EE260DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559244700;
	bh=HAeeeyIuKJlselAZMCf8MCqGbbGxod0OcJMX5igAlNw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=J1x/fgj/DXv0rt2dUHSl2N4bdT4giT+LCkJbIL77VXOlG7C5dWqHGORmFrs92WqHr
	 rVpZbyMi4R03AJJLdMSScQM+WaZMeuDGyMBzoNr4FlMxh7MM6uCyen4BZBuojkaTIc
	 4QdtPdyopwZSbPLsq/zClXBqvqYbOH7/OJad1QBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE3Tbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfE3Tbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:31:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDFA260D7;
        Thu, 30 May 2019 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559244698;
        bh=HAeeeyIuKJlselAZMCf8MCqGbbGxod0OcJMX5igAlNw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LY4fr2ZPdtoxTRgTPgxelQdM+zUNRr2JM0htRdkY93aE4sWgMYBIiZXkZt30tD4Vj
         j+J5t06xrh0zX3UeziO9JXD+sUgxTRyDtw4thKsy92XbUCBIvOxiIA94Uc4HQmbUGS
         hkF5lUHL/23HzKTUW4Z00Mfg7Qlkhag8o0k0fYqI=
Subject: Re: [PATCH 5.0 000/346] 5.0.20-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.orgs, shuah <shuah@kernel.org>
References: <20190530030540.363386121@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <44200647-5f26-54f2-6709-aca7fc2c3640@kernel.org>
Date:   Thu, 30 May 2019 13:31:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 9:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.20 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 01 Jun 2019 03:02:10 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.20-rc1.gz
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

