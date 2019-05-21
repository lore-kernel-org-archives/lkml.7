Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF8C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0122E217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558457175;
	bh=I/hZac6f/z2/Fyqy2qd623hagnktGp7xURyaL2uNcmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XWy6KjOI4xb3iZGyFSlK6nRl7fh4kwws8EjuvuKasqQZJo/aHu4EPIrwP+bytxPrr
	 dphuCJ8dR6EmxRJsD99qcntGsT+TX+b2XvnbHHPIcOLdTBMlfCQmmo2CV/h1dZy81z
	 R+jSOwxAeA31/ra4NBsu8i+Hwf0azL3PUj5UKv+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfEUQqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfEUQqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:46:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16EF42173E;
        Tue, 21 May 2019 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558457173;
        bh=I/hZac6f/z2/Fyqy2qd623hagnktGp7xURyaL2uNcmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hw1puu1RZHRekEVpsSndTUuiGiVE7jFBczM4KMssjdhSKqPfr94yjnky4eN7Gj5gM
         DgmigpBLAzm24yUVYz1SsJu69v/+sSOfZbHDNPnFtYoaFTOof53+MTA+f9pu8FNDbr
         nK92UMfdOYYS8CCxovn9I9kPTyDHKxhZCS+9R0wk=
Date:   Tue, 21 May 2019 18:46:11 +0200
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
Subject: Re: [PATCH 4.9 00/44] 4.9.178-stable review
Message-ID: <20190521164611.GA8787@kroah.com>
References: <20190520115230.720347034@linuxfoundation.org>
 <CA+G9fYs+Ft2v_Xr0KJ3AOdbTTJJ8YB6vgLc-ps6TiVM4nyftLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYs+Ft2v_Xr0KJ3AOdbTTJJ8YB6vgLc-ps6TiVM4nyftLw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 04:04:35PM +0530, Naresh Kamboju wrote:
> On Mon, 20 May 2019 at 17:47, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.9.178 release.
> > There are 44 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed 22 May 2019 11:50:58 AM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.178-rc1.gz
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

Thanks for testing this one, and all of the others.

greg k-h
