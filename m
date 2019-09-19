Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9C4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A421929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568856254;
	bh=WvVMaZ6o5q+pQh1jzXhkIF8dn/EdE5hc9ID95Zhlvsc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=naihuhLt4ZtPWXHjNhXiOLdkvJSTMtRtmzm4eLdxxr4fYyoNzNAJDAxZBNsPewCju
	 4TgEAcpAHZ4pTk27qRF+h/FJsZ+8oZpfS7dAkxggrZFAccfSxQ6dLvjPUMZUiXIXv6
	 QcNzhYG2wMBiQIOTPkrVc7kRb5ZhzwBMA8a+bizI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfISBYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731790AbfISBYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:24:11 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2937421925;
        Thu, 19 Sep 2019 01:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568856250;
        bh=WvVMaZ6o5q+pQh1jzXhkIF8dn/EdE5hc9ID95Zhlvsc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ji0k6mmheiV53f287tnQVhgb8Kcu3qSwGa2ImrQc985N9a6SC5zt/0Y8gq8hHZNa/
         /fEO6rtDOpxvdwHeM2CE/Q+93M/Gevl2E96wlmQIrs0MMiYdrbAsc6cJixsTKuLfI1
         pBj9nvR+ndWPWNwkwcDn2oCAM77WN53N9+YJ2u5Y=
Subject: Re: [PATCH 4.19 00/50] 4.19.74-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190918061223.116178343@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d095760f-6dfe-aa9f-ee4e-a3b47c8ef697@kernel.org>
Date:   Wed, 18 Sep 2019 19:24:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/19 12:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.74 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 20 Sep 2019 06:09:47 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.74-rc1.gz
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
