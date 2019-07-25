Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4BFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D58822BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564068913;
	bh=6myISTP5Lxh3k2FO5KcWQ2ql+slqQgy/VnRM9UbiR5c=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=SyDgh+w0aAOqeNdCvNoM7B/Xu0tSZm/S7Ow/6vcKOXCqmDvLXD2dEek3KwCmx6dkw
	 XTzIlK3Noz2P3oussk0jfBiloel+rw+pjP5HJVkUMlKYM9he8+qM/1/buGEjE3I+sV
	 n9LTp26ekl2MPpuGWJYdOk+bb52gTl4Ap3VLdN6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbfGYPfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGYPfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:35:12 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA37D229F3;
        Thu, 25 Jul 2019 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564068911;
        bh=6myISTP5Lxh3k2FO5KcWQ2ql+slqQgy/VnRM9UbiR5c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GQy/qwk+M9jpAEwwILd5JT8T8/GjYQwDIJ8CBIzq0CsC3livgG9ZsQfj6mZ6xTZhD
         r3QnVL03+KpsAyIGFP3FYZzWCL4oFnDPmwE8tUWRX1iGbz2ZM+a5J82nTOJ3Gd/po1
         ot+63chj+5JO6yEKHF/VoJeysf805pzyEGhTQBc4=
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190724191735.096702571@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f0e2b7f5-b078-2639-6011-0ac04966a347@kernel.org>
Date:   Thu, 25 Jul 2019 09:35:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/19 1:14 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.3 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Jul 2019 07:13:35 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
