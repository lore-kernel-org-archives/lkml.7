Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6620CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37611206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558344690;
	bh=9mf5Ph72Tc0vQONuF+weC0PRNahfszSem//nmlEwEtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QqBzOaUJandYegMWkLSIlk17uOTAJ1OaM48jJWI4GLE09zJuLtWhgcBezwOtAseAb
	 wZUKj0TE56qdfq+JB9kKt5PUuh4CI/k7dblMsoGeWwLHQgUv07yqfguzaVZ/eVucRs
	 eNfxyXCzs9cpXimLEOQ0mZstcK48X+9jR0qxMLyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfETJb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbfETJb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:31:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B12A20675;
        Mon, 20 May 2019 09:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558344688;
        bh=9mf5Ph72Tc0vQONuF+weC0PRNahfszSem//nmlEwEtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jx3dlP/HD9EcQvKyirrw/LfiOp7/spHQfeXf5nXhRMTQm8EEVyIkHTEjxcy2O3MXb
         AfvPFPZf8Aa8L2i2rmSOPwOUnrUCCw8evSKYkvc3JrSj4jbAfJKDTmo6GIxQAe16Tm
         LBhT6qgI7jnq7s42MaQ6n2jEuvpeuSa0HeAOXkRg=
Date:   Mon, 20 May 2019 11:31:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Matt Sickler <Matt.Sickler@daktronics.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arch/xtensa/include/asm/uaccess.h:40:22: error: implicit
 declaration of function 'uaccess_kernel'; did you mean 'getname_kernel'?
Message-ID: <20190520093126.GA15326@kroah.com>
References: <201905201259.JxEFGvZU%lkp@intel.com>
 <CAMo8BfJnr8j+uqOAMb5FE4ParRYCURqfTdb_1kh0iaqboxpMdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJnr8j+uqOAMb5FE4ParRYCURqfTdb_1kh0iaqboxpMdg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 10:50:44PM -0700, Max Filippov wrote:
> Hello,
> 
> On Sun, May 19, 2019 at 10:39 PM kbuild test robot <lkp@intel.com> wrote:
> > Hi Matt,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   a188339ca5a396acc588e5851ed7e19f66b0ebd9
> > commit: 7df95299b94a63ec67a6389fc02dc25019a80ee8 staging: kpc2000: Add DMA driver
> > date:   4 weeks ago
> > config: xtensa-allmodconfig (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 8.1.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 7df95299b94a63ec67a6389fc02dc25019a80ee8
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=8.1.0 make.cross ARCH=xtensa
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from drivers/staging/kpc2000/kpc_dma/fileops.c:11:
> >    arch/xtensa/include/asm/uaccess.h: In function 'clear_user':
> > >> arch/xtensa/include/asm/uaccess.h:40:22: error: implicit declaration of function 'uaccess_kernel'; did you mean 'getname_kernel'? [-Werror=implicit-function-declaration]
> >     #define __kernel_ok (uaccess_kernel())
> >                          ^~~~~~~~~~~~~~
> 
> I've posted a fix for this issue here:
>   https://lkml.org/lkml/2019/5/8/956
> 
> If there are post merge window pull requests planned for the
> staging tree please consider including this fix. Alternatively
> if I could get an ack for this fix I'd submit it in a pull request
> from the xtensa tree.

It's now queued up, sorry, I had to wait for 5.2-rc1 to be released.

thanks,

greg k-h
