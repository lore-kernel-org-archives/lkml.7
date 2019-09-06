Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35538C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDEB207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567748336;
	bh=T3bW+kIZ2qASQ0APwTcYaCPfdfVDJZoKLoksIdyI/VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yaR/HDl2wy/HT8sJyptO2bdxJixPk4urJ91A1GgNTRzst+kwKeWubZQ9ewsUcL8nJ
	 vEo3jxeEDROspfTeWCuM7jLBjzWRliqTSzGejnrRPUrrl+uSG7GnxXtXuaSdbOMr4N
	 AboC8AxssN31wYmwkbVYaSuuH0OHHDGGtxctcAlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392397AbfIFFiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390255AbfIFFiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:38:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D57207FC;
        Fri,  6 Sep 2019 05:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567748334;
        bh=T3bW+kIZ2qASQ0APwTcYaCPfdfVDJZoKLoksIdyI/VA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6BFHFaOrn7loH77l7tKedXvfHBiiPjUPTV5fsPUg/+gK3RuL84leDYBLWLwZz7lR
         UyWSp74bOEoR/faQeQaE0AmTbUsJcNNfH2YrDZnRgDejV7Z0zOs0730cIjWzcC31ky
         RZ0BjKV7nLYCJsz94WDgWG8Je1uCURQpDShzzpn8=
Date:   Fri, 6 Sep 2019 07:38:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] habanalabs pull request for kernel 5.4
Message-ID: <20190906053851.GA23838@kroah.com>
References: <20190905121934.GA31853@ogabbay-VM>
 <20190905205017.GA25089@kroah.com>
 <CAFCwf12VtkZd-cd7A+dznWx70ydjdxX7ahi7tn5CSGPoEcjexA@mail.gmail.com>
 <CAFCwf12LurmKz0ek-fN-uCh5tXq95hHtkzRJ7_bxzvEK-mMsnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12LurmKz0ek-fN-uCh5tXq95hHtkzRJ7_bxzvEK-mMsnA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:54:41AM +0300, Oded Gabbay wrote:
> On Fri, Sep 6, 2019 at 7:38 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > On Thu, Sep 5, 2019 at 11:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Sep 05, 2019 at 03:19:34PM +0300, Oded Gabbay wrote:
> > > > Hello Greg,
> > > >
> > > > This is the pull request for habanalabs driver for kernel 5.4.
> > > >
> > > > It contains one major change, the creation of an additional char device
> > > > per PCI device. In addition, there are some small changes and
> > > > improvements.
> > > >
> > > > Please see the tag message for details on what this pull request contains.
> > > >
> > > > Thanks,
> > > > Oded
> > > >
> > > > The following changes since commit 25ec8710d9c2cd4d0446ac60a72d388000d543e6:
> > > >
> > > >   w1: add DS2501, DS2502, DS2505 EPROM device driver (2019-09-04 14:34:31 +0200)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-09-05
> > >
> > > Is that a signed tag?  It doesn't seem to me like it is, have you always
> > > sent unsigned tags?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > It is unsigned. I have never sent you a signed tag.
> >
> > Thanks,
> > Oded
> 
> Just to clarify. I have never sent a signed pull request. I'll look
> now how to do it and re-send this pull request to you.
> My only question is how do you verify my GPG key ? Do I need to
> authenticate it somewhere ?

Ok, for some reason I thought you had sent signed tags in the past, my
fault, sorry about that.

If at all possible, it would be good to get your gpg key into the
kernel.org "web of trust" by having it signed by a kernel.org developer
so that I "know" this is you in some form :)

Now pulled and pushed out.

thanks,

greg k-h
