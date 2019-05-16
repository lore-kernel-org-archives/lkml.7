Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0458C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7457020848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558016636;
	bh=YMK7jzWCRdBG+ypS7H3A+bYEvzbVdl+vPZnhd674Vw4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OjKIOlFjmouwPb9lQ3aixpY0syK/N42NhcO43Blf6zSl96LzHW5DIAhMOjITb0PS+
	 kQ3EdsQJPEmJIDwBKQ3AbzH4OS0te8ZlY9/DNhNWgJQKqUyplZ4gnQZJhLbdIQoIpv
	 8cxF6sC7NlePc7yvHrWD0ZqcS9UrhWSUjERG2XK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfEPOXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPOXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:23:53 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5198820833;
        Thu, 16 May 2019 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558016632;
        bh=YMK7jzWCRdBG+ypS7H3A+bYEvzbVdl+vPZnhd674Vw4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cPdywYMiMXONkpeWBOsKo+nrvIjYE1rMUN+mrRiPcCkqefvRs0c1Q7n0/vZXfu0cz
         +IbH1eJErtF5V6NoweOn2SO7dk7jV7/puTQb6r+3mDaQdafX3tr13xAtExa1I+81+E
         q/oJajsLLe7u1DeWmFQKURqvdT6jUnnYzNrcZ1H8=
Subject: Re: [PATCH 4.4 000/266] 4.4.180-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190515090722.696531131@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <64e43cbc-2160-9961-e231-a72f2ee61b2e@kernel.org>
Date:   Thu, 16 May 2019 08:23:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 4:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.180 release.
> There are 266 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 17 May 2019 09:04:49 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.180-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

