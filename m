Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40735C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1311220848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D3HZ6/tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfEQITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:19:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18532 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfEQITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:19:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cde6e780002>; Fri, 17 May 2019 01:19:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 01:19:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 01:19:08 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 08:19:06 +0000
Subject: Re: [PATCH 4.4 000/266] 4.4.180-stable review
To:     Daniel Wagner <wagi@monom.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20190515090722.696531131@linuxfoundation.org>
 <f32de22f-c928-2eaa-ee3f-d2b26c184dd4@nvidia.com>
 <75c1f549-9098-933e-ab8b-4d0eeab87ddd@monom.org>
 <20190516164918.GA12641@kroah.com>
 <1f9c1d93-0c00-2eea-96ef-10eb078317a4@monom.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <da3b7cf4-6ea0-ebe8-c680-2a93fbabde0d@nvidia.com>
Date:   Fri, 17 May 2019 09:19:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1f9c1d93-0c00-2eea-96ef-10eb078317a4@monom.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558081144; bh=S06TagP6Qxrl3rJljPJPCB7yMxGspWctuLjuU00DheY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=D3HZ6/tn6VLL6LOq2MNrB//u8oQhSZ9r8t/2EMiAxq2ZGrOwSbGFY39Oc7MuuYCbk
         +mb7T+Hhs288JY7ED0LtFv5UnswUIo9IihDa620pLKkxGBc7uesoZ00RONEQiELNmP
         g0Pj7lrd+OFtI+yHQveVaSAFjrDhfVcp60+JPb7yF+XK1wDRxCoCs7HW231CcHKjLc
         j6FdRtyYlWxe8BCULYi1xn7bpqIX+g15f382Ryalsy/LQEZ5C0PMBX/3TTs/kANLSE
         T9k3jC2jNeH3NfRoq3kyFGyd28eH5s0/hoeDU45Ees2AZV46nA6gBo+VQvQNuhyank
         9ZkmoiPTYjgww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/05/2019 08:44, Daniel Wagner wrote:
> Hi Greg,
> 
> On 16.05.19 18:49, Greg Kroah-Hartman wrote:
>> Jon, thanks for the testing, I'll go drop this patch now from the final
>> version.
> 
> That's fine, I wanted to suggest this too. I have some time to look at
> this next week. So there is no hurry with this patch.
> 
>> Daniel, if you can come up with a working series, I'll be glad to take
>> it.  Or, I'd recommend you just move to a newer kernel :)
> 
> Sure, I will see what is missing.
> 
> @Jon if I get have something to test, would you have time to give it a
> try first?

Yes no problem.

Cheers
Jon

-- 
nvpublic
