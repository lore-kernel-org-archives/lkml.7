Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0ABC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 08:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B1B20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573891393;
	bh=mZ+hytdzCGkJw7I5H/sEbKT1SIz3VTZLSucUoyHDZj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y5Tu1muOw9UgL+G6+7gcDWN9/pdxKyD1L6pEGYNtHmHtmVphH258HzzkJNKNnAoBT
	 CBXgVfC4UpBMlDlG4kcKuQNxesokHgyyM76B3KR0ZCuGEEKTUrc2Ptf8o3OJormf93
	 w2s7BpRt+5OdPux10q4tdtchqs50fQhPHUuMX48Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfKPICy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 03:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfKPICy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 03:02:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7ED720723;
        Sat, 16 Nov 2019 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573891372;
        bh=mZ+hytdzCGkJw7I5H/sEbKT1SIz3VTZLSucUoyHDZj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uje3YqkFj+vLcOVATrNAW2A3QoaDK93eycJiwUR3ROhvKkEwnEGaThikyfeL2QIsa
         NaHKd0bd2KsZJSH9itue2xTREvDzoiQXTdtKHetcpQD3FY3f2Q7YvMPrN7ACHYcNYL
         4BbuxNPJvMr3gMmZ17I0nX+2YJzs3Pu0h2UN1/hs=
Date:   Sat, 16 Nov 2019 16:02:49 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 00/31] 4.9.202-stable review
Message-ID: <20191116080249.GA382536@kroah.com>
References: <20191115062009.813108457@linuxfoundation.org>
 <CA+G9fYt-y23nfB1gU_e8JoTU+n973QgJCtMcqGrugRQ7sVHUMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYt-y23nfB1gU_e8JoTU+n973QgJCtMcqGrugRQ7sVHUMg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:22:05PM +0530, Naresh Kamboju wrote:
> On Fri, 15 Nov 2019 at 11:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.9.202 release.
> > There are 31 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 17 Nov 2019 06:18:35 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.202-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

THanks for testing both of these and letting me know.

greg k-h
