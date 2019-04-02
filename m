Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB93C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DF02133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554216617;
	bh=M0ukXduT/AXA4JSHtZtnbSxH9QnlPIm7dirzlKV12l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UDcXL7wkB30o8ZVT4uoFtwVivtiS4yHVrlxJ+doT2Kf7eq3jWYmvmVOs7tE/M1tA6
	 YG/k54rFec5uUcHOXig/x+j03CO/HpRdkvpgGQ/NTdWGpm378HwYVUCb5Dvz49JeN9
	 B68+hge0kB4GkHGuFpkl793+9NrPHJwmFyqzO7AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfDBOuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbfDBOuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:50:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39EC520883;
        Tue,  2 Apr 2019 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554216614;
        bh=M0ukXduT/AXA4JSHtZtnbSxH9QnlPIm7dirzlKV12l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItIn/C0RQ6gqz6ARBgzvP4a6bf0ob6hzcbNvN1jGtDp6gWPYkRXPlQOXJvY2QlBDa
         cGRQDAIWevtzI68XwUMrj7JFMD452kEkgtz9lUSv4TpF1HsYsvrolpESTGVbbXtlC0
         yaKTwbK0szxQZx6rjyRFXnq43EMC3eBiv8PWn72Q=
Date:   Tue, 2 Apr 2019 16:50:11 +0200
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
Subject: Re: [PATCH 5.0 000/146] 5.0.6-stable review
Message-ID: <20190402145011.GA21873@kroah.com>
References: <20190401170048.449559024@linuxfoundation.org>
 <CA+G9fYvC80nexMB0EHhvyNWs1=3LUUkqEtS12rVF=cAQLHcfUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvC80nexMB0EHhvyNWs1=3LUUkqEtS12rVF=cAQLHcfUw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 04:35:11PM +0530, Naresh Kamboju wrote:
> On Mon, 1 Apr 2019 at 22:34, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.0.6 release.
> > There are 146 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing most of these and letting me know.

greg k-h
