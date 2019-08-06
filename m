Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0ABC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6017214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565053592;
	bh=9WldU+70OTg4/XnU8IihgnOgQkq9Lj1lvWH/3Weo2zg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AvkfIwuVpeT4wJyKhIaUHZUFSraesqBgIujsX1XRRhrMfltiRTrmn+XK0Ajcx5djD
	 WUR1ksRiPtLFaiz7Y2yAY1v3i86De+/PL7IE5jXEjWAfilHSVxLEzk+PjqaWHufkw8
	 T0yTfXfaI/eIeKU3izpYQDBbYmjtWtJmDi+jmsX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfHFBGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 21:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbfHFBGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:06:31 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272902075B;
        Tue,  6 Aug 2019 01:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565053590;
        bh=9WldU+70OTg4/XnU8IihgnOgQkq9Lj1lvWH/3Weo2zg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zw8DwvvX7a6SkYNjLA1gGZUHCQsbdvh+fck64F5TZMPos1dqBPiSgZ250egyEU2gn
         cD2vMQwNNoBQBjyhNME1U0GK7yuEvFnBzi0sV/w8u03iYA7YEFA7Hn8/A5WPFs2A3r
         fpm0GksAQ3HXWkuUczBToamvf6mTjN4VMm+fEeN0=
Subject: Re: [PATCH 4.14 00/53] 4.14.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190805124927.973499541@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9e6208f9-7a78-885e-1e95-8a121862165e@kernel.org>
Date:   Mon, 5 Aug 2019 19:06:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805124927.973499541@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 7:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.137 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 07 Aug 2019 12:47:58 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.137-rc1.gz
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

