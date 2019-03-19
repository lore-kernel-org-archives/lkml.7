Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDCCC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D4D2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552998025;
	bh=w4wsvCaxVYQHOlIAQ2U5lVNN4I8QRU6sRH6aLkt5SO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZKz6sNYMPR4qfcZdG1UqHobIOxRVe0me7nIosYa510h0m24ayBRUZKE2Xw27OlIP
	 NmXhsWrRDOUi04nsSOrLk9YYk1zL9Pyo1xtV/KE+AoWiI9pGgz+8Wf5zVMpdW3RN4a
	 5Yt9P/tcU7/bcVGTREuVcIwbf1UKfrnwBig2JTGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfCSMUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbfCSMUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:20:24 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D9A213F2;
        Tue, 19 Mar 2019 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552998023;
        bh=w4wsvCaxVYQHOlIAQ2U5lVNN4I8QRU6sRH6aLkt5SO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKWP6/BmyO5NWRUNoBze7WTSYEi83C8gDGxWOMgt13sqwnzJ8gg3dcRMeI9+DQwLs
         iEGqIxRZUXZjJKiXPRXU69NnuGmuwuiSX9Q9mT+/6Y1r9z073sG6TAbSjr0pAHaS5O
         9YgHd0iDCscP27iBLQfLSAOsKI2G4y1ctdftbWCo=
Date:   Tue, 19 Mar 2019 13:20:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.0 00/43] 5.0.3-stable review
Message-ID: <20190319122020.GC29633@kroah.com>
References: <20190318083715.877441740@linuxfoundation.org>
 <CA+G9fYtHRmRKYdNXWQNsjzmTf4_G1BMmTyXbGiJ0B70twBWKsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtHRmRKYdNXWQNsjzmTf4_G1BMmTyXbGiJ0B70twBWKsg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 08:24:25AM +0530, Naresh Kamboju wrote:
> On Mon, 18 Mar 2019 at 14:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.3 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Mar 20 08:36:53 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great!  Thanks for testing all of these and letting me know.

greg k-h
