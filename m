Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC7C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFC5222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553429882;
	bh=AyapjFRGijLVNeIXqyHQDkP1hh0B4kdR23Qfy8Jh7us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQsoSgNIVZyeOzJHQmwdBQz+m4voJG/rdgJOKqDTaMmL1Gc3vW72ylNPQbhTlHAzM
	 JNOAAciTJ/fzpNQPtMHCnouQxC4NWyxgEOaFyBhkucbN1EbfNhGgqf9VFVbZUmXmZ4
	 d9JRs3TwGQJsg9emRKDucjjaI28pmv4+1/BH3eM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfCXMSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXMSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:18:01 -0400
Received: from localhost (unknown [88.128.80.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EEF2222CD;
        Sun, 24 Mar 2019 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553429880;
        bh=AyapjFRGijLVNeIXqyHQDkP1hh0B4kdR23Qfy8Jh7us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGyTnFYcaECK89bKH6RVnP0/euzrT/EwlRgm21cxVlSKQssp8n3CG98SbXPskjAaq
         iL6lP6qu4/ggbVQtzBzDFLhnU3kaqwZpuFxTB2XO9JaxMsbb9IoP8K8QvKXQCeJKWQ
         wscC0i/WInVJM/5MEk+b4y1VmoRJn6mEH4r2/Gvc=
Date:   Sun, 24 Mar 2019 13:17:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.0 000/238] 5.0.4-stable review
Message-ID: <20190324121757.GA6569@kroah.com>
References: <20190322111258.383569278@linuxfoundation.org>
 <5dffcc1a-fef5-21e3-4e30-fa0825fae744@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dffcc1a-fef5-21e3-4e30-fa0825fae744@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 11:58:56AM +0000, Jon Hunter wrote:
> 
> On 22/03/2019 11:13, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.4 release.
> > There are 238 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 24 11:11:13 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.4-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v5.0:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     28 tests:	28 pass, 0 fail

Thank you for testing all of these and letting me know.

greg k-h
