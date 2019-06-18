Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB2C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1752F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560865080;
	bh=ZLBtEm7zQVesFFCcAaPBIdGsaSsT8cqYWREkYWR+x7I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zd45h9dShYyqgsyKYlkXO2um9dxfsyuEwoQYw/66y8N/3FdPcYW5vrhjud26Y5lSQ
	 aK7HpF2NaZz24QTVKZomT4+hOfoSt+1WTEBGnI0PawsjR3EqyWwUdoHXWxs0lUHMOH
	 /tGt2dCjtx+naJkmWp09t+tLIN6QlSNOEcx1NZDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfFRNh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFRNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:37:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8730420823;
        Tue, 18 Jun 2019 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560865077;
        bh=ZLBtEm7zQVesFFCcAaPBIdGsaSsT8cqYWREkYWR+x7I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gb45AAwqW1HCwFIxD0ZqeN0uRDFfsmJrYNt0OCr81qvBCPGmWQiSpVJ8H9lRjxlSz
         UaZLvseOlwI5mc3YvMhrMkZpZr1tAjAp8aFDWlg6j7Ea8dkSA+XpMgP3V0z+cX3ams
         BJBDRIN9TxJlD/51jjF2rA1bG2uoeejfQYcj6O5I=
Subject: Re: [PATCH 5.1 000/115] 5.1.12-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190617210759.929316339@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <716d3e71-3ae0-709a-4705-db4c3c5ff3f9@kernel.org>
Date:   Tue, 18 Jun 2019 07:37:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 3:08 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.12 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 19 Jun 2019 09:06:21 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
