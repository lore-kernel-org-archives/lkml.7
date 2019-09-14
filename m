Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF7BC4CEC5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 08:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C02089C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568448221;
	bh=earSS+jZ3Os1iT8HGapRoOt6ggsQnZEwmNEQKdxUrSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mOkFXt4kZV+8IF568U037KVYgBOEE7oCnAmIhzR8NAej26yWpSl7h8YBVImWoMpwC
	 Vy2TIVyMJ6wA2zGpjpjojOxM8z17B0pngVSvyQabX0L9eqyixrJ2Y+oP9VHyB9VA/p
	 TKv60jPlJMg6e7ng/i8KuQ2H47qkQjZqQEziOUgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfINIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 04:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfINIDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 04:03:40 -0400
Received: from localhost (unknown [84.241.204.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A7D2084F;
        Sat, 14 Sep 2019 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568448219;
        bh=earSS+jZ3Os1iT8HGapRoOt6ggsQnZEwmNEQKdxUrSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkTXIiA7UVNBBg4e+MDvsF5GYwLuuU1Ma5vOuK8qKC1797pHm1gkUt9V7sTNG8Cnb
         yvG3y/iAmRKsGSNNRSuWiPMf/K6IsqEYWsEcmATBn8YVuz4hDqXQ66v5WzKm1uHj68
         1VKTHqmsb3K4FrKCvuIOTGgPnVr7UHtvApdlpXms=
Date:   Sat, 14 Sep 2019 08:43:53 +0100
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
Subject: Re: [PATCH 5.2 00/37] 5.2.15-stable review
Message-ID: <20190914074353.GD519223@kroah.com>
References: <20190913130510.727515099@linuxfoundation.org>
 <CA+G9fYtx=GQDwCSNmyQcg+yQqJDPVgTyxXUjyb-4x7_pNn-Meg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtx=GQDwCSNmyQcg+yQqJDPVgTyxXUjyb-4x7_pNn-Meg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:26:40AM -0400, Naresh Kamboju wrote:
> On Fri, 13 Sep 2019 at 09:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.2.15 release.
> > There are 37 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun 15 Sep 2019 01:03:32 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.15-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
