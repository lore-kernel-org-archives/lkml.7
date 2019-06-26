Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D895C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135E621726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561586236;
	bh=II0G/W6vxo9yAloiqSOi9oT+Dh8/RKBOKfUtz/1+LuI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ac5c2pldC71fYwJsybpbWMdNGgzc/xSgRWvHyohwS1aI/drJo9qPhLJQFjCYGvJZ4
	 jagDHQsL5DwV9yq7AcJMBfkTbF+wxCW1VO2E9UVyhPA0IMRrdEreyrKrrQpWIJnM/i
	 QX5y14PJ4MkqIel9y/mq2/R4N96iE4jtv1XVWv0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFZV5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZV5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:57:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8AD214DA;
        Wed, 26 Jun 2019 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561586233;
        bh=II0G/W6vxo9yAloiqSOi9oT+Dh8/RKBOKfUtz/1+LuI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MWG7aisaaGnMaOTKcrJVou8HSoSUC358znWQN9S8abUnE3yTGAoi/JFmKnYs5JZSr
         rZ+7yO0AqA7PkkQ6b+JjoaAkqaRJqwwclcGCKOLCx3AZCkSZLJfwYQLtzdBOQP0/Gd
         e+Rt6y0LuYQz2LabmaX80r2bx/udqSIdWyFZFvkQ=
Subject: Re: [PATCH 4.9 0/1] 4.9.184-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190626083606.302057200@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <1a5e01d1-656d-3043-7ee9-048dd1c3fd38@kernel.org>
Date:   Wed, 26 Jun 2019 15:57:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626083606.302057200@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 2:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.184 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.184-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Linux 4.9.184-rc1
> 
> Eric Dumazet <edumazet@google.com>
>      tcp: refine memory limit test in tcp_fragment()
> 
> 
> -------------
> 
> Diffstat:
> 
>   Makefile              | 4 ++--
>   net/ipv4/tcp_output.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
