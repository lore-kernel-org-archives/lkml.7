Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33EDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9185621841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558677201;
	bh=kn1S16Ld07hbuety+OJkH2qGFXGPsK+lf/8fod4Sik0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JQQVn6RTKIy1PL/q+cy14sw9KbFygeBtGSayJkiUlTbciedIESrK/54siHBJ3A9ps
	 gbr6NrjL44QV0MZI4pmPZnL3L+s17VzADVh6tZl5CVcLcCFv+c6FZwjTsG40rc1T8A
	 PngLfyIA6ZU/599weBzq5GdsquHyeTJSVy9WXvSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbfEXFxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388814AbfEXFxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:53:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C172081C;
        Fri, 24 May 2019 05:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558677198;
        bh=kn1S16Ld07hbuety+OJkH2qGFXGPsK+lf/8fod4Sik0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/QnzEHjhiKiG5k3cC6a3yuajtiOeTnlBpmd/LE4Na0IZgBAXBzTJst6mstjAtmHF
         LpxGDF+znyZero3Vm+hho2oazJM9gbAvo/O2PIvdvUqSt07QUUs/ZA+c7pQTIp2u2k
         hdL+I/gNNQ2R/Cm3xSp3qXDkG/D/HBMzm4Xq7KUw=
Date:   Fri, 24 May 2019 07:53:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>, linux@roeck-us.net,
        shuah@kernel.org, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 4.14 00/77] 4.14.122-stable review
Message-ID: <20190524055316.GD31664@kroah.com>
References: <20190523181719.982121681@linuxfoundation.org>
 <CABMQnVK9pg8ZsZWYtc48TzVDnvYU7XSPj6FPOBGipayKfnmHSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABMQnVK9pg8ZsZWYtc48TzVDnvYU7XSPj6FPOBGipayKfnmHSA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:28:05AM +0900, Nobuhiro Iwamatsu wrote:
> Hi.
> 
> 2019年5月24日(金) 4:11 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> >
> > This is the start of the stable review cycle for the 4.14.122 release.
> > There are 77 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat 25 May 2019 06:15:09 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.122-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> > -------------
> > Pseudo-Shortlog of commits:
> >
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >     Linux 4.14.122-rc1
> >
> 
> <snip>
> 
> >
> > Yifeng Li <tomli@tomli.me>
> >     fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting
> >
> 
> There is a problem in this commit, which is fixed in the following commit:
>     9dc20113988b9a75ea6b3abd68dc45e2d73ccdab
> 
> commit 9dc20113988b9a75ea6b3abd68dc45e2d73ccdab
> Author: Yifeng Li <tomli@tomli.me>
> Date:   Tue Apr 2 17:14:10 2019 +0200
> 
>     fbdev: sm712fb: fix memory frequency by avoiding a switch/case fallthrough
> 
>     A fallthrough in switch/case was introduced in f627caf55b8e ("fbdev:
>     sm712fb: fix crashes and garbled display during DPMS modesetting"),
>     due to my copy-paste error, which would cause the memory clock frequency
>     for SM720 to be programmed to SM712.
> 
>     Since it only reprograms the clock to a different frequency, it's only
>     a benign issue without visible side-effect, so it also evaded Sudip
>     Mukherjee's code review and regression tests. scripts/checkpatch.pl
>     also failed to discover the issue, possibly due to nested switch
>     statements.
> 
>     This issue was found by Stephen Rothwell by building linux-next with
>     -Wimplicit-fallthrough.
> 
>     Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>     Fixes: f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled
> display during DPMS modesetting")
>     Signed-off-by: Yifeng Li <tomli@tomli.me>
>     Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>     Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>     Cc: Kees Cook <keescook@chromium.org>
>     Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> And this is also necessary for other stable-rc tree.
> Please apply this commit to 4.9.y, 4.14.y, 4.19.y, 5.0.y and 5.1.y.

Now queued up everywhere, thanks!

greg k-h
