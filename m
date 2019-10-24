Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B534CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D9421A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571950447;
	bh=7sZmrGWXepRQ8u4bq2vU4EgT9SDSluaWSj44q42TNxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uZcpf+/BXK2+VAhQ5+D0CyQUKgwt1vDii89venxFGrmO/4eVYb2/Cd1atP1A9vkX8
	 zRUF+xYT6iJi+LOHsHe/Lr+Z/BeQPBdDe2xkkiyedg9MK8yeCYUYAhjY6bnrbqbHe1
	 QBX2HQSxNfObpyQ5j66/orqDT/vJsTv4aY4ES2wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfJXUyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36107 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbfJXUyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:54:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id v19so52062pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 13:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EwhH6xiECs7L8rpX+VJC4HQgocepfGRCibixehUAMYs=;
        b=k8HZvPQmcgwBv/eg+6SMyMmaFbTSQl2y6L+IBMYiVuspMXgnnNLaNJ9WSeXSVjuhDv
         k9WUisSjESWzU9Nm5YphaAuzX12GvDtpk/JzIjIxDAdEdVK0+BKoqgtKYtq6z83BiRSt
         u6hc/6reO76d8Ky5sdOZaxi5VttdditA9zmB3nzy1rSyo2VQHv3kDHEzONItvwAorKw6
         d1irXymoTqGwPzlbBMj/8WY6WnWrfDknR8S+Tqj7nERbZe+PpXXgdmFcLLgCgCzL/DBi
         7bt6bK9DmhFJxHDC8K7as1yEsLqeObAfca+Y2LJZcpbfo2FyVrg4SN0XtqNqvVmcKaIo
         QRWw==
X-Gm-Message-State: APjAAAV4Fveo+xL7cfnAx05yShcAOI9ijYWX65GBg3cVo2+P+g/YTUPt
        snWOSNz+zPfzyvbCrd8BHyw=
X-Google-Smtp-Source: APXvYqwHHY2mkw0on4g2lRGyuyXbw8E1AuYrV9432gK07ON8OZGpu2i/3WkZQTgJEz/sNLPSpRMoUA==
X-Received: by 2002:a17:90a:94c3:: with SMTP id j3mr5986656pjw.41.1571950444995;
        Thu, 24 Oct 2019 13:54:04 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id 69sm26909836pgh.47.2019.10.24.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:54:03 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:54:20 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2 1/5] staging: octeon: remove
 typedef declaration for cvmx_wqe
Message-ID: <20191024205420.u7z3bhcjgetsyh3w@lantea.localdomain>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
 <fa82104ea8d7ff54dc66bfbfedb6cca541701991.1570821661.git.wambui.karugax@gmail.com>
 <20191024050011.2ziewy6dkxkcxzvo@lantea.localdomain>
 <alpine.DEB.2.21.1910240722070.2771@hadrien>
 <20191024100020.GA13343@wambui>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191024100020.GA13343@wambui>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wambui, Julia,

Side-note: Wambui, your mail client seems to have added this header:

  Reply-To: alpine.DEB.2.21.1910240722070.2771@hadrien

This is the ID of the message you replied to (ie. this is the same value
that the In-Reply-To: header has). You should probably figure out how
that happened, or you're going to miss responses when people reply
without noticing the bogus email address.

On Thu, Oct 24, 2019 at 01:00:20PM +0300, Wambui Karuga wrote:
> On Thu, Oct 24, 2019 at 07:26:59AM +0200, Julia Lawall wrote:
> > > If you're making significant changes to this driver, please test them
> > > using the MIPS cavium_octeon_defconfig which is where this driver is
> > > actually used.
> > >
> > > This driver has broken builds a few times recently which makes me very
> > > tempted to ask that we stop allowing it to be built with COMPILE_TEST.
> > > The whole octeon-stubs.h thing is a horrible hack anyway...
> > 
> > Wambui,
> > 
> > Please figure out what went wrong here.  Are there two sets of typedefs
> > that should have been updated?
> >
> I managed to reproduce these build errors and finally noticed that the
> "octeon-stubs.h" header is only included when CONFIG_CAVIUM_OCTEON_SOC
> is not defined, therefore compiling properly for COMPILE_TEST but will
> actually fail when compiled with CONFIG_CAVIUM_OCTEON_SOC is set since
> the functions will try to use the definitions in
> arch/mips/include/asm/octeon/ that don't have the changes.
> 
> Paul, please tell me if this is correct?

Yes, that's correct. The driver was written to use the headers in
arch/mips/include/asm/octeon, and then recently the octeon-stubs.h
header was added which duplicates lots of the MIPS & Octeon-specific
header content in one huge monstrous file.

I'm all for improving compile test coverage, but I think octeon-stubs.h
in its short life has already proven itself to be a bad way to achieve
that goal[1][2][3].

> > Others,
> > 
> > Would it be reasonable to put the information about how the driver should
> > be compied in the TODO file?  git grep cavium_octeon_defconfig in the
> > octeon directory turns up nothing.

It wouldn't hurt. I'd argue that Kconfig already provides enough
information to figure this out easily though - OCTEON_ETHERNET depends
on CAVIUM_OCTEON_SOC || COMPILE_TEST, which ought to tell people that
its real use is when CAVIUM_OCTEON_SOC=y. That doesn't necessarily point
you to cavium_octeon_defconfig (though grepping for CAVIUM_OCTEON_SOC=y
would), but that's not strictly needed anyway - any old config with
CAVIUM_OCTEON_SOC=y would do.

Thanks,
    Paul

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0228ecf6128c92b47eadd2ac270c5574d9150c09
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/staging/octeon?id=17a29fea086ba18b000d28439bd5cb4f2b0a527b
[3] https://storage.kernelci.org/next/master/next-20191024/mips/cavium_octeon_defconfig/gcc-8/build.log
