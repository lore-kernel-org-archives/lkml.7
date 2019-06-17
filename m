Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97793C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6C120848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560763029;
	bh=e42yAVayU+39uOaJ5Jd3MI+KH6w9ijGTN+jGkDvUfzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=h4Dhy/92t2aP8kF2rgtS24ha3aKcsb4FWAhACSZDrbmAm4HgGn2syURvsqHydfHGY
	 DTzzrpnrGOFWEOZScRHG7FT3tT1IMVxZEvfSGRG4LFPJkPrJlyWp4atE1y7DI+F+3L
	 RcAO4LJZ5mJ0VIiU8M71U+kKHpNgVIazL+KN5jq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfFQJRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:17:08 -0400
Received: from casper.infradead.org ([85.118.1.10]:54562 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4UvzZyS/aNQ/MsOVrJfipLFSDYLsgIWS72uO2fF+tF8=; b=HS/CCJGZiIDLX7SkLozd/7MuYA
        2t7Ma2qN+j7tNX0giTN/vzpfBAEsXSVzV5SVXyj3keXbOfpphcBLRCCq5K+FykW+IGLQ04czlkpdD
        mzVe5GSNsWCGnQQ8SCYN5XGIjq51GafrObm1Tra3imKne3LxFwJ1Ggh4LkM2kptBQSx2ltvbebm6c
        DxwlMbXy5S+8IGas47ofH3Oc7cVTl65AarNjSWJTwl/GwFX0zIbrOUutxLse14oHDuKYiqcy1TrnN
        fGEJL6oKcPj8QvheF0P+5bjS6+zn7fv/suvs1Xg2q3tUoSHu18Bi17Se+K7M0bOtpbqNFNHMZcmUA
        TdgNGObw==;
Received: from 179.186.105.91.dynamic.adsl.gvt.net.br ([179.186.105.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcnlA-0007OR-OD; Mon, 17 Jun 2019 09:17:05 +0000
Date:   Mon, 17 Jun 2019 06:16:59 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 14/14] docs: sphinx/kernel_abi.py: fix UTF-8 support
Message-ID: <20190617061659.22596fc3@coco.lan>
In-Reply-To: <28aca947-4e88-7186-7f07-9a3ccb379649@darmarit.de>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <62c8ffe86df40c90299e80619a1cb5d50971c2c6.1560477540.git.mchehab+samsung@kernel.org>
        <20190614161837.GA25206@kroah.com>
        <20190614132530.7a013757@coco.lan>
        <28aca947-4e88-7186-7f07-9a3ccb379649@darmarit.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 16 Jun 2019 17:43:50 +0200
Markus Heiser <markus.heiser@darmarit.de> escreveu:

> Am 14.06.19 um 18:25 schrieb Mauro Carvalho Chehab:
> > Em Fri, 14 Jun 2019 18:18:37 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> >   
> >> On Thu, Jun 13, 2019 at 11:04:20PM -0300, Mauro Carvalho Chehab wrote:  
> >>> The parser breaks with UTF-8 characters with Sphinx 1.4.
> >>>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> >>> ---
> >>>   Documentation/sphinx/kernel_abi.py | 10 ++++++----
> >>>   1 file changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> >>> index 7fa7806532dc..460cee48a245 100644
> >>> --- a/Documentation/sphinx/kernel_abi.py
> >>> +++ b/Documentation/sphinx/kernel_abi.py
> >>> @@ -1,4 +1,5 @@
> >>> -# -*- coding: utf-8; mode: python -*-
> >>> +# coding=utf-8
> >>> +#  
> >>
> >> Is this an emacs vs. vim fight?  
> > 
> > No. This is a python-specific thing:
> > 
> > 	https://www.python.org/dev/peps/pep-0263/  
> 
> No need to change, the emacs notation is also OK, see your link
> 
>    """or (using formats recognized by popular editors):"""
> 
>    https://www.python.org/dev/peps/pep-0263/#defining-the-encoding
> 
> I prefer emacs notation, this is also evaluated by many other editors / tools.

The usage of emacs notation is something that we don't like at the
Linux Kernel. With ~4K developers per release, if we add tags to
every single editor people use, it would be really messy, as one
developer would be adding a tag and the next one replacing it by its
some other favorite editor's tag.

There's even an item at Documentation/process/coding-style.rst
due to that (item 9).

Thanks,
Mauro
