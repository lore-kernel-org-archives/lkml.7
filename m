Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348FC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88A220848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfEQHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:44:17 -0400
Received: from mail.monom.org ([188.138.9.77]:52138 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbfEQHoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:44:16 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 4B8F75006D0;
        Fri, 17 May 2019 09:44:14 +0200 (CEST)
Received: from [127.0.0.1] (mail.monom.org [188.138.9.77])
        by mail.monom.org (Postfix) with ESMTPSA id 61CD55003F5;
        Fri, 17 May 2019 09:44:13 +0200 (CEST)
Subject: Re: [PATCH 4.4 000/266] 4.4.180-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, linux-tegra <linux-tegra@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20190515090722.696531131@linuxfoundation.org>
 <f32de22f-c928-2eaa-ee3f-d2b26c184dd4@nvidia.com>
 <75c1f549-9098-933e-ab8b-4d0eeab87ddd@monom.org>
 <20190516164918.GA12641@kroah.com>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <1f9c1d93-0c00-2eea-96ef-10eb078317a4@monom.org>
Date:   Fri, 17 May 2019 09:44:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516164918.GA12641@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 16.05.19 18:49, Greg Kroah-Hartman wrote:
> Jon, thanks for the testing, I'll go drop this patch now from the final
> version.

That's fine, I wanted to suggest this too. I have some time to look at
this next week. So there is no hurry with this patch.

> Daniel, if you can come up with a working series, I'll be glad to take
> it.  Or, I'd recommend you just move to a newer kernel :)

Sure, I will see what is missing.

@Jon if I get have something to test, would you have time to give it a
try first?

There is someone constantly updating the v4.4.y tree, which makes me
update the -rt patches all the time. Don't fear, I am not running 4.4.y,
this is only for important infrastructure :)

Thanks,
Daniel
