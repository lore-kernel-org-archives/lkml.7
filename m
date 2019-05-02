Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A7C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC220873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556796538;
	bh=fqx8UlBQV0EdoNBTnAuO4hpKhnRVHJvkc8nSmJ/L22k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kj5iOcfBfZ4CD7Bh10/NsykSiW0j8CnO9TaxaQa7EbfRceqslrcPEK0yx/AUBE81B
	 QKzCqTGMOOywCWqoW3X5Xg0x9Szc9YsSqc7iV8FKzMos2Xks7vlGKLS+gOUIE6ZJr+
	 zMtKl4m5K9Z5OMYJdulf8gAmigW4BqivaS3qhi04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEBL25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 07:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfEBL25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:28:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DD32075E;
        Thu,  2 May 2019 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556796536;
        bh=fqx8UlBQV0EdoNBTnAuO4hpKhnRVHJvkc8nSmJ/L22k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zQxwkyY5pPrdl15G8NdigAQvxmLoabfGm6HRZYTvKDfxlWn5LW/amKuqfOoE2wlZW
         jwSupKI0HJxWuGwCHNNUD5Ju8iUKUwUBym6qdRWci01TA2vYWoj0IwJJj/Hd15NUXW
         jOXUJi1JMnYZajhuMHiZPzPY9xnGv+tuojviGjb0=
Date:   Thu, 2 May 2019 13:28:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH] clk: actions: Use the correct style for SPDX License
 Identifier
Message-ID: <20190502112853.GB7358@kroah.com>
References: <20190501070707.GA5619@nishad>
 <057d9b37-7475-1902-bce7-6d519c2e0fdf@suse.de>
 <20190502070746.GA16247@kroah.com>
 <315de620-b638-aea4-d8d2-e00f5a493625@suse.de>
 <20190502103848.GA17256@kroah.com>
 <f52484fc-b35b-f92a-9c7b-ce53fd731ab5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f52484fc-b35b-f92a-9c7b-ce53fd731ab5@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 12:45:05PM +0200, Andreas Färber wrote:
> Am 02.05.19 um 12:38 schrieb Greg Kroah-Hartman:
> > On Thu, May 02, 2019 at 12:25:36PM +0200, Andreas Färber wrote:
> >> Am 02.05.19 um 09:07 schrieb Greg Kroah-Hartman:
> >>> On Wed, May 01, 2019 at 10:20:44PM +0200, Andreas Färber wrote:
> >>>> + linux-actions
> >>>>
> >>>> Am 01.05.19 um 09:07 schrieb Nishad Kamdar:
> >>>>> This patch corrects the SPDX License Identifier style
> >>>>> in header files related to Clock Drivers for Actions Semi Socs.
> >>>>> For C header files Documentation/process/license-rules.rst
> >>>>> mandates C-like comments (opposed to C source files where
> >>>>> C++ style should be used)
> >>>> [...]
> >>>>>  drivers/clk/actions/owl-common.h       | 2 +-
> >>>>>  drivers/clk/actions/owl-composite.h    | 2 +-
> >>>>>  drivers/clk/actions/owl-divider.h      | 2 +-
> >>>>>  drivers/clk/actions/owl-factor.h       | 2 +-
> >>>>>  drivers/clk/actions/owl-fixed-factor.h | 2 +-
> >>>>>  drivers/clk/actions/owl-gate.h         | 2 +-
> >>>>>  drivers/clk/actions/owl-mux.h          | 2 +-
> >>>>>  drivers/clk/actions/owl-pll.h          | 2 +-
> >>>>>  drivers/clk/actions/owl-reset.h        | 2 +-
> >>>>>  9 files changed, 9 insertions(+), 9 deletions(-)
> >>>>
> >>>> Where's the practical benefit of this patch? These are all private
> >>>> headers used from C files, so they can handle C++ comments just fine,
> >>>> otherwise we would've seen build failures.
> >>>
> >>> Please read Documentation/process/license-rules.rst, the section
> >>> entitled "Style", for what the documented formats are for SPDX lines,
> >>> depending on the file type.
> >>
> >> That does in no way answer my question! You conveniently dropped my
> >> paragraph indicating that I understand why we would do that for public
> >> headers in include/, but none of these private headers here are included
> >> in .lds files. So there really seems to be no benefit of switching from
> >> one style to another for in-tree code.
> > 
> > It should answer the question, it was "decreed" that all header files
> > use /* */, and all C files use // for their SPDX lines, so we documented
> > it that way.
> > 
> > Yes, maybe it doesn't make "sense" in that this really is only needed
> > for headers that get included into asm files, which is why we had to do
> > it this way, but it's better to be consistant than to have random
> > breakages at times.
> > 
> > It's not an issue of public headers at all, sorry.
> > 
> > Consistency is good, as we can have automatic tools check these types of
> > things, which is the only way to reliably handle the format of something
> > that needs to be in every file in a project with 63,100+ different
> > files.
> 
> Okay, if it's about consistency then there will be more cases to fix.

Agreed, hopefully checkpatch is up to date enough to catch these.

> What about this one:
> 
> My interpretation of the documentation has been that I should end the
> comment after the identifiers:
> 
> /* SPDX-... */
> /* ...
>  */

Correct.

> Some people deviate by doing
> 
> /* SPDX-...
>  * foo
>  */

Not correct.

> So the documentation may need to be extended to clarify that for full
> consistency, as well as clarify the previous scenario:
>   "If a specific tool cannot handle the standard comment style, then the
>    appropriate comment mechanism which the tool accepts shall be used."
> To me that reads very different from what you just said above.

Documentation can always be updated, a patch to make it clearer is
always appreciated.  But look at what we have today in the document, I
think it should be pretty obvious that:
	/* SPDX... */
is the thing to use for C header files.

If you disagree, that's fine, please send a patch to make it clearer and
we can all review it.

thanks,

greg k-h
