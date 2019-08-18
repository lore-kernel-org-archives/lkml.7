Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89748C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517B72087E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566110130;
	bh=yS7kcy4ENt8zJ6qY/RMfLntL/OB8sSWXB1lEigYzgpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LG/Ui7372m0dTeeOeAIOX1oSP/ahcRygGVswc9WjA2/Fxh6h1OCJPo1c8igqbZre0
	 ipuXU00GhuvT0yRB6j1+d6Uhj25P5vxJzJFMy25SpBoreUQetqnxGlg26mbGG/ITCR
	 TzB3rzBeWpjm/LlQSil/BEAW8prTEtSdriJgpVn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHRGb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 02:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRGb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 02:31:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F34B2087E;
        Sun, 18 Aug 2019 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566109887;
        bh=yS7kcy4ENt8zJ6qY/RMfLntL/OB8sSWXB1lEigYzgpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7OjEhxXHpJ9fzLXh+oI3B/bBqsY4tRgt/q/TsZZi1Ca5rxl3Ug74XgD197BDgaj0
         +jD4GjNURVObr3mMjd3uIUtRSzJ3bgJym6N7/9uxeE9aLPI2BG2X9tDcRLGsZvUjLW
         g/RoswdqGJwOtMdALwLzlgLdVOWUr1vhVHasDiAk=
Date:   Sun, 18 Aug 2019 08:31:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Donald Yandt <donald.yandt@gmail.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com, christian@brauner.io
Subject: Re: [PATCH] staging: android: Remove ion device tree bindings from
 the TODO
Message-ID: <20190818063124.GA31192@kroah.com>
References: <20190817213758.5868-1-donald.yandt@gmail.com>
 <20190818050317.GA8147@kroah.com>
 <CADm=fgmb-JN-t-VxFSfWw_UzvxO__P6NkNh+U3XhR6+NRtK9yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADm=fgmb-JN-t-VxFSfWw_UzvxO__P6NkNh+U3XhR6+NRtK9yw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 01:47:38AM -0400, Donald Yandt wrote:
> On Sun, Aug 18, 2019 at 1:03 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Aug 17, 2019 at 05:37:58PM -0400, Donald Yandt wrote:
> > > This patch removes the todo for the ion chunk and
> > > carveout device tree bindings.
> > >
> > > Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
> > > ---
> > >  drivers/staging/android/TODO | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
> > > index fbf015cc6..767dd98fd 100644
> > > --- a/drivers/staging/android/TODO
> > > +++ b/drivers/staging/android/TODO
> > > @@ -6,8 +6,6 @@ TODO:
> > >
> > >
> > >  ion/
> > > - - Add dt-bindings for remaining heaps (chunk and carveout heaps). This would
> > > -   involve putting appropriate bindings in a memory node for Ion to find.
> > >   - Split /dev/ion up into multiple nodes (e.g. /dev/ion/heap0)
> > >   - Better test framework (integration with VGEM was suggested)
> > >
> >
> > This is already done?  Do you have a pointer to the git commit id(s)
> > that did it?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> Both the chunk and carveout heaps were removed from ion,
> so unless I'm mistaken there's no need to implement the device tree
> bindings for them.
> 
> Commits that removed both heaps:
>   - 23a4388f2 staging: android: ion: Remove file ion_chunk_heap.c
>   - eadbf7a34 staging: android: ion: Remove file ion_carveout_heap.c

Great, can you resend this patch with that information in the changelog?
As you wrote it, it could be implied that these tasks were actually
completed :)

thanks,

greg k-h
