Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5087BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E37E217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565342291;
	bh=IEpqj6xkaOVgv1+xNDozKfujFRajkj+vMmI3IFXddpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FGW00Nqrx6tgdt1O70v3Bh0eATQdSmjdD8B95jrPdPcTq8jWoSZiKOqn8lBa4n2xI
	 Xz40Z7R3tWfHfIu7L/pzTu8Rky100rI/CwWlLXbbMU1HTINit2atlcA1MQiqYg/5gW
	 eg6uBtoHYLvlecY8m3ZfZ2dvTenFXbDiZTU68ypU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406147AbfHIJSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406007AbfHIJSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:18:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FA52184E;
        Fri,  9 Aug 2019 09:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565342288;
        bh=IEpqj6xkaOVgv1+xNDozKfujFRajkj+vMmI3IFXddpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKQqEcEL2wg1EKmiHYqkH8EVLnXEeUi1aoKY6BLfWyFD8cvyCv2KUmCMkwZBs4tWc
         HJyiNFaApwuUyPkRuOnuRYKLZlCB7NCdkZLI2pF35KNoRNM3ELh6mSwdRVLovly/VE
         ZC3CCK++s8Hbrsws8Ryzo8+jQyhz35wYpoL9DHtE=
Date:   Fri, 9 Aug 2019 10:42:04 +0200
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
Subject: Re: [PATCH 5.2 00/56] 5.2.8-stable review
Message-ID: <20190809084204.GA4014@kroah.com>
References: <20190808190452.867062037@linuxfoundation.org>
 <CA+G9fYuAYB11dZefGa7bY27Dz3GrKZWQurLaCwOehx1mLDWTOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuAYB11dZefGa7bY27Dz3GrKZWQurLaCwOehx1mLDWTOA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:15:26PM +0530, Naresh Kamboju wrote:
> On Fri, 9 Aug 2019 at 00:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.2.8 release.
> > There are 56 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat 10 Aug 2019 07:03:19 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.8-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.2.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
