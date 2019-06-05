Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48008C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139732086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559714530;
	bh=HepOocMGQbxV1XkzbMNksN58w/TkVlWsGTwtJsPEC3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1aoqckymao0dKc5NC2sM3QlFEIyjOIxTC7qkf1EE8u6kvnqiMAn6M7dmsQ9IGrcFa
	 hLqPNPjxjr9t2sks514XMDGv5GXbXmD6vX0bDKHupwxITq1VKNUG61ppkpFH4Gg+GF
	 RJx13oJ3km4bpnRpf3tdDJk8aH8zdHu6XeShOhXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFEGCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfFEGCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:02:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73632075B;
        Wed,  5 Jun 2019 06:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559714528;
        bh=HepOocMGQbxV1XkzbMNksN58w/TkVlWsGTwtJsPEC3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpwYst9o9FOBMseaTUmOc8FZStSK3v69CHuj3cMA26LdyDNfjZBBkYCVsfmv1Ezbc
         ryP7VakobNyJF1HaIMEEDmKrEPPrNzABbUywElOndzfLyeQljOtWqBTL2lUDKe+TeQ
         jYP8/8RN0G/7ehzDSaHPFH8DKxmiLhj/Y7w/nn7c=
Date:   Wed, 5 Jun 2019 08:02:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: do not use C++ style comments in uapi headers
Message-ID: <20190605060205.GA29484@kroah.com>
References: <20190604111334.22182-1-yamada.masahiro@socionext.com>
 <8cf48e20064eabdfe150795365e6ca6f36032e9f.camel@perches.com>
 <CAK8P3a1oDfNF_T+NCoPsXkJAY2x4_uCWSwrDXHi7dDSaMqfnfA@mail.gmail.com>
 <CAK7LNAS0Ph2Z6x0-UPSkJUC31NvPi09BmFrve+YJcXMrop-BGA@mail.gmail.com>
 <20190604134213.GA26263@kroah.com>
 <CAK7LNARyqW3q6_46e-aYjmF8c0jUNDLdyB28zNaBEXqTV+5QSA@mail.gmail.com>
 <CAK8P3a0bz8XYJOsmND2=CT_oTDmGMJGaRo9+QMroEhpekSMEaQ@mail.gmail.com>
 <CAK7LNARU+uT0aUBh5niwEafL8+Ok7=sOZYukptpDH1w7Cii3hQ@mail.gmail.com>
 <20190605051040.GA22760@kroah.com>
 <b70cf8c1f901ea09abbdb22dd28244b18fd1a39d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70cf8c1f901ea09abbdb22dd28244b18fd1a39d.camel@perches.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 10:22:05PM -0700, Joe Perches wrote:
> On Wed, 2019-06-05 at 07:10 +0200, Greg KH wrote:
> > On Wed, Jun 05, 2019 at 01:10:41PM +0900, Masahiro Yamada wrote:
> > > On Wed, Jun 5, 2019 at 3:21 AM Arnd Bergmann <arnd@arndb.de> wrote:
> []
> > > This means we cannot reliably use uint{8,16,32,64}_t in UAPI headers.
> > 
> > We should not be doing that as they are in the userspace "namespace" of
> > variables, not in the kernel namespace.  We've been over this many times
> > in the past :(
> 
> Just not very successfully...
> 
> $ git grep -w -P 'u?_?int(?:8|16|32|64)_t' include/uapi | wc -l
> 342
> 
> $ git grep -w -P --name-only 'u?_?int(?:8|16|32|64)_t' include/uapi | wc -l
> 13
> 
> Documentation helps a bit, checkpatch helps as well.
> Maintainer knowledge and vigilance probably helps the most.

Yes, it's not been a dedicated effort at all :(

But it needs to be resolved, if we want people to actually use our
kernel headers easily.

thanks,

greg k-h
