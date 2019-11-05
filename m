Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B6CC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A563C21929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572972794;
	bh=0wnkzIIg/mZzTrcvW+HvvSJ4Vani8pF/49eaf3+jabY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=DhFO8ICoRKJhFJ364lOFgnjYeFJhewFFU+myt4lQ455+oFizMTZBgX0RQuvWqcfNZ
	 CbH09wDdDAH5VGwWl5Qh6cXOp0FNROyUVcvm4/GT9Vl94bkM6TJAfevjjRPfG5K/F3
	 m+YQTAoZLMptYIuIeZysID29FgEeYsU21Tzwd7wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbfKEQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390060AbfKEQxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:53:13 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8596221928;
        Tue,  5 Nov 2019 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572972793;
        bh=0wnkzIIg/mZzTrcvW+HvvSJ4Vani8pF/49eaf3+jabY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h9JwSZnqD44r9NGSR+qVhzJP0N4mELXaRETaBLhRh+jwExTf9ftGK5ggSvIDllljv
         yJD4upCQKj1QpMV/qGk5xwa3sBL9z7lrHrXV/Ih/wdBK5ZnuL7Q3DRacSHb7xM641J
         mKSxCjhX7dYMAxYmwpZ65USEHMLksFAKK5Uph4V4=
Subject: Re: [PATCH 4.14 00/95] 4.14.152-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191104212038.056365853@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f5e0bb62-81ba-bd21-1e64-001aa5f22689@kernel.org>
Date:   Tue, 5 Nov 2019 09:53:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/19 2:43 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.152 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.152-rc1.gz
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
