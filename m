Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9923CC04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6096E2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557503388;
	bh=WTqqb1sAmxKg12IIETATV/IXRRJXKSpDYho4YpoJ5zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ouRyMipsRbXcL7KVzKY8textxnJzhoo/fFA5HtMAA8zOVGuoLmdm0CLiJLpSoH5ye
	 ZdESyOPEFTK/NgiOf5M37qxnLP52xqLoYGVfPtLm5zYWDyO1Zw2QmX+P/EU4cuV0gi
	 HKmTOeoO0TFf+hXWJNHCDpb4XeF8xHQzdrs6X9Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfEJPtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfEJPtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:49:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8165520881;
        Fri, 10 May 2019 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557503386;
        bh=WTqqb1sAmxKg12IIETATV/IXRRJXKSpDYho4YpoJ5zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlqGXGl+jrNyoBSufpz4J30gW22rRCe5tvgzSlR52mKP4mBUIG4DoLNvdFHrTr78b
         MDjLWIC0rOHG6FEAhd8iRLd8jo2krsqhBk5hCdtjp1PaQDjE58GpCx0y8YSNx8vMwn
         D2V/J3jSmL1C81CZRsBeUEsq7JB/eln53iyJgVcY=
Date:   Fri, 10 May 2019 17:49:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vandana BN <bnvandana@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/95] 5.0.15-stable review
Message-ID: <20190510154943.GA2209@kroah.com>
References: <20190509181309.180685671@linuxfoundation.org>
 <411e19b0-7f02-a1e3-e1b6-1ff9ca4e1145@roeck-us.net>
 <58ff150d-31b6-a393-c3e4-77a8e72462b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58ff150d-31b6-a393-c3e4-77a8e72462b1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 07:13:43PM +0530, Vandana BN wrote:
> 
> On 10/05/19 7:06 PM, Guenter Roeck wrote:
> > On 5/9/19 11:41 AM, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 5.0.15 release.
> >> There are 95 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Sat 11 May 2019 06:11:22 PM UTC.
> >> Anything received after that time might be too late.
> >>
> >
> > Build results:
> >     total: 159 pass: 159 fail: 0
> > Qemu test results:
> >     total: 349 pass: 349 fail: 0
> >
> > Guenter
> 
> compiled booted and no regressions on my system.

Did you mean to send this twice for the 5.0 release?

Anyway, thanks for testing :)

greg k-h
