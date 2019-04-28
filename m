Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43183C4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF21208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556413583;
	bh=eUI68AveqtP4MfBKAUnTJhOGaoGLejMNyQf70X98KNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yK/Vm4UpgMOcxl5YKrHBei6AtuyUfz7UdvWKQjmQ1D9OpN4eG0h7w8yoHeOB1teuJ
	 OtFESrI8+NhrE7JTm9Cj/qTdN0KXcHRzy3kWbkct/YsWR2VZFDO/ppRZfalR2zjbbC
	 HbHfi9pIeScmNlp4aJNoe/seeonsxL71KpA8FNWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfD1BGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 21:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfD1BGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 21:06:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4886B206E0;
        Sun, 28 Apr 2019 01:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556413580;
        bh=eUI68AveqtP4MfBKAUnTJhOGaoGLejMNyQf70X98KNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKeLeFpLpe2uV48NcP22R8Ee7kEztKIZZEdktlZQAYXWd0Lo8hcuv8Vm62BS+MRpk
         lRcpuZLWI7HQdJEQojZYcloiKJlCYC9w1d/6XZObT6mOjEzuW+9VNtUeJsRgAgWt/Z
         YkI5dVV6s2s7Ld3tzailoagUvfyhDkMEKNplHf7Y=
Date:   Sat, 27 Apr 2019 21:06:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.0 03/79] ASoC: ab8500: Mark expected switch
 fall-through
Message-ID: <20190428010618.GG17719@sasha-vm>
References: <20190427013838.6596-1-sashal@kernel.org>
 <20190427013838.6596-3-sashal@kernel.org>
 <20190427171410.GE14916@sirena.org.uk>
 <90e92595-1609-6c3b-b1d7-ca6a20a81f79@embeddedor.com>
 <20190427180029.GK14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190427180029.GK14916@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 03:00:29AM +0900, Mark Brown wrote:
>On Sat, Apr 27, 2019 at 12:31:22PM -0500, Gustavo A. R. Silva wrote:
>> On 4/27/19 12:14 PM, Mark Brown wrote:
>
>> > Are we *realy* going to enable -Wimplicit-fallthrough in stable kernels
>> > and both backport all the fixes and add new fixes for the issues which
>> > don't have backportable fixes?
>
>> I don't think so.
>
>> There are hundreds of these patches in mainline, and I think this is
>> the first time I see one of them being backported.
>
>Right, this looked like a super weird thing to backport.

I agree, it's part of my scripts to drop them but somehow this one snuck
through. I'll drop it. Thanks for pointing it out!

--
Thanks,
Sasha
