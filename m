Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE2ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E82B21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570789674;
	bh=NQlnfIHW0EyL5zquV/IDum9zTq17av5hd0+OwZ2iZ3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c9a2auUUEV71cKZgzC5y5WVAH6qdXJWvzZeyLJcRzWcvx6aSGJKqVhcMANmoce9cN
	 sklMqdHu7vqTVpQoCd4rqAXrAkzWN01LbIHoQDjOGLa5d5hITOFAeeoKqIkUA681x8
	 TLa88Lmfckyltn6f6dALTDABAxax7Te1Y2uPUlb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfJKK1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfJKK1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:27:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417E6206A1;
        Fri, 11 Oct 2019 10:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570789672;
        bh=NQlnfIHW0EyL5zquV/IDum9zTq17av5hd0+OwZ2iZ3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3ay+jtbVCRXmgIEMybB6E5txuRy3CnRaUOe0Vo51V06zC2zzDwIz9EGM4i+qVdZR
         mSKxOv597APEHVo9GByDJaYZZwLvXPZ5kBVvqHDZock28bMWjQGMtph23aBanY0xkz
         VT5Ov8XezzwDotIsBuP6VqpkkBeEoI4p0IvmPfSY=
Date:   Fri, 11 Oct 2019 11:27:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     John Garry <john.garry@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
Message-ID: <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
 <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
 <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:25:29PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 3, 2019 at 1:15 PM John Garry <john.garry@huawei.com> wrote:
> > On 03/10/2019 08:40, Anders Roxell wrote:
> > > On Tue, 1 Oct 2019 at 16:04, John Garry <john.garry@huawei.com> wrote:
> > >> On 26/09/2019 20:30, Anders Roxell wrote:
> > >>> it doesn't get enabled when building allmodconfig kernels. When doing a
> > >>> 'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be dropped.
> > >>
> > >> So without having to pass KCONFIG_ALLCONFIG or do anything else, what
> > >> about a config for CONFIG_CPU_LITTLE_ENDIAN instead? I'm not sure if
> > >> that was omitted for a specific reason.
> > >
> > > Oh, I tried to elaborate on the idea in the cover letter, that using
> > > the defconfig
> > > as base and then configure the rest as modules is to get a bootable kernel
> > > that have as many features turned on as possible. That will make it possible
> > > to run as wide a range of testsuites as possible on a single kernel.
> > >
> > > Does that make it clearer ?
> >
> > Hi Anders,
> >
> > Yeah, I got the idea.
> >
> > So when you say "'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be
> > dropped", I don't know what the rules are in terms of resyncing the
> > common defconfig (I was under the impression that it's done per release
> > cycle by the arm soc maintainers, but can't find evidence as such), but
> > your change may be easily lost in this way.
> 
> We don't do it every release, but occasionally someone sends a patch
> with a refresh, and this might easily get missed.
> 
> We could force the allmodconfig kernel to be little-endian by default,
> using a choice statement to pick endianess like arch/mips and arch/sh
> do, the effect would be that an allmodconfig kernel gains a few more
> options that depend on !BIG_ENDIAN, but we would no longer catch
> a class of endianess bugs in drivers that we otherwise get warnings
> for. No idea what is better here.

Does anybody use BIG_ENDIAN? If we're not even building it then maybe we
should get rid of it altogether on arm64. I don't know of any supported
userspace that supports it or any CPUs that are unable to run little-endian
binaries.

Will
