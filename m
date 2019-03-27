Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB144C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B5E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663217;
	bh=vCgAMRMG5xItlvlR3fzYFfx77dC9Bz6AZe5IrDI9usM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b+GT88e7gARZjFue2eJCErGCnKxs1hfmJqsrF8Mc+PSnDlyvhowsPG09sTfxkmHK0
	 4HvFNfRs18NloYsyPvNIKcpWi29cQD91LX8yvuc8q3myvsQLwvrAqqdTi5wPmiwr3w
	 Jg1eLUbJLf/txojbQnMCh2giRuaJ9+iCFU0CS8C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfC0FG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfC0FG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:06:56 -0400
Received: from localhost (unknown [218.148.84.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8252075E;
        Wed, 27 Mar 2019 05:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553663215;
        bh=vCgAMRMG5xItlvlR3fzYFfx77dC9Bz6AZe5IrDI9usM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfQ7BqmP4uClxCWeCHiuhq7jcZeXts1BjeeQ6Dm+DybKojTYjll8I6jylrIUd12UR
         PKmf9Xtx7Rz1Vt1pZC6T/Ha6kRgU+kjHq8RoXFVkQ6+/8leR4zSFkcHgw59XnwmtAk
         druBZp4ocJI5EFz7UIqSDsB9l5t1iCPnieKsFTvY=
Date:   Wed, 27 Mar 2019 14:06:51 +0900
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
Subject: Re: [PATCH 5.0 00/52] 5.0.5-stable review
Message-ID: <20190327050651.GA830@kroah.com>
References: <20190326042700.963224437@linuxfoundation.org>
 <CA+G9fYvQ5oHdxwBYPW-B9Bp9bdDAkhLrHJqhH0k=nuO1kZSftw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvQ5oHdxwBYPW-B9Bp9bdDAkhLrHJqhH0k=nuO1kZSftw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:36:06AM +0530, Naresh Kamboju wrote:
> On Tue, 26 Mar 2019 at 12:09, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.5 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Mar 28 04:26:38 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.5-rc1.gz
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

Thank you for testing all of these and letting me know.

greg k-h
