Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED534C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66FC218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564125919;
	bh=jguRN9FveAlbh3y+DjcuvAJZrHedq7zXAiSbkPQLjN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lmPLmNYjPBjpNJO/Ftk5V13Y20PK2yXQwEubHhES83+cxVd6iphSPzmy7Or/vNdSh
	 N5gq6MEJiw9mh/rdbzKNYRBd+UUWwpxGO3/4zefUpcf8k+yrtJdAT/Kqscaw6/OIKe
	 oaHQhLf9vYjVF9QE/k/uoq6x7GcEsJi8Cn6uaov8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfGZHZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfGZHZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:25:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F8A21873;
        Fri, 26 Jul 2019 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564125917;
        bh=jguRN9FveAlbh3y+DjcuvAJZrHedq7zXAiSbkPQLjN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6iXmbiaXcs6MxKtWhEInmXMGwe3aN2huuqspK34+aTJyYOuiyrp9Bb+YtODGqNXt
         zI5qvYY0Gj1T+Nr1TOuMciVju3wDxMLwUP4wnb33F1bCd8PooUlCEaO+O7WNjaTuSR
         PFlmUkdV1Om+fpSZN49OKImM16/fPsg0orIJyuEA=
Date:   Fri, 26 Jul 2019 09:25:15 +0200
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
Subject: Re: [PATCH 4.19 000/271] 4.19.61-stable review
Message-ID: <20190726072515.GC19756@kroah.com>
References: <20190724191655.268628197@linuxfoundation.org>
 <CA+G9fYtOry75ux=E3g1G_SQxnqw8rFMDc4tvuUH6=hMb_hijKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtOry75ux=E3g1G_SQxnqw8rFMDc4tvuUH6=hMb_hijKQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:14:01AM +0530, Naresh Kamboju wrote:
> On Thu, 25 Jul 2019 at 01:35, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.19.61 release.
> > There are 271 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri 26 Jul 2019 07:13:35 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.61-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.19.61-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.19.y
> git commit: 872cde3ebfc93ca6ac127f51bbb54eafe1d8eda5
> git describe: v4.19.60-272-g872cde3ebfc9
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.60-272-g872cde3ebfc9
> 
> No regressions (compared to build v4.19.60)
> 
> No fixes (compared to build v4.19.60)
> 
> Ran 23544 total tests in the following environments and test suites.

Thanks for testing all of tehse and letting me know.

greg k-h
