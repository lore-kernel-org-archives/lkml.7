Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B6C742DD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC12146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562969112;
	bh=BOiJTE9I+P91dU3tRa+BkyaaPjyUTwPZTfgUB8WDHk0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=BXi7oPEqfMDLjF+SJ40OzwgvcMWhRJYorfktjIFyQ/YVw6KNJZf/ujT+A0b1+b3yh
	 gNtYspZamM8Go3SfQ17mOn8FofXtfYBPyFkRM6Zi7O8r1ZwW7zJXPXwcWgNWU9iGvn
	 MkrDWXg63J0c/cET/HINQnG3XwfD99X334QNjnW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfGLWFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbfGLWFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:05:10 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BDDC20989;
        Fri, 12 Jul 2019 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562969109;
        bh=BOiJTE9I+P91dU3tRa+BkyaaPjyUTwPZTfgUB8WDHk0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QfWTqTZmbK4u9pWdOSgKd2Lyg6xvgi+Vm8cVmsokzM5eGZX4c5ya3ORXyf1m+qYUH
         rn5ioK6KuzttrgPJxsxcD81XRsEonWNGXioYfRj5ikoj/WliaWuVTlR1ptNGhyFllw
         23w6AojtRBBkoUFo5Xt+fH7p4MHi9nOm7QQcLlEw=
Subject: Re: [PATCH 5.1 000/138] 5.1.18-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190712121628.731888964@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3f27e550-34b1-f3b1-6d93-62d360b4f2a2@kernel.org>
Date:   Fri, 12 Jul 2019 16:05:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 6:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.18 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.18-rc1.gz
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
