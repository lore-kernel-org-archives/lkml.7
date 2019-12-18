Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B09C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F88521582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576702785;
	bh=mu/TWkkf62L851xbIq3fn5FU0D5qq/HNYswGVUpjqDo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=b24IOJ8PZFwCXVylsaXu6QintyqQ5ffAR9m2c/9OSPGl15eoFAH3aH2D3Myu5waSe
	 SXQcbc7HztWncOEBBAseb01hWQfPyjlMFIzuBoRx6aZKF8YNYpu59car3Zvl6beDse
	 W+AAtRz9sY2gKiPLjxowIi4pBMK+iTKvZ5lVI++Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLRU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfLRU7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:59:43 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A95218AC;
        Wed, 18 Dec 2019 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576702783;
        bh=mu/TWkkf62L851xbIq3fn5FU0D5qq/HNYswGVUpjqDo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P0zABtZXJqnv2cOd1H8YLTcBBhCpdCxBpKK9zvdZYhnw2nXbHMLZnuclxl7bKnaaq
         xgp4iPs0qOBqVIRRkFG4I+Rh4DelWzXh0UoIjxO6KvUa3fcz6VTLRmQw1j0ijUmcKm
         GG4yKrawGPpm7QAUmQ0Gz2M6F2X6X5KFCxkQ4j8Q=
Subject: Re: [PATCH 5.4 00/37] 5.4.5-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191217200721.741054904@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6cec4c6c-ff54-0cf9-3cbc-1581c24d7d97@kernel.org>
Date:   Wed, 18 Dec 2019 13:59:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 1:09 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.5 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2019 20:06:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

