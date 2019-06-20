Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D69C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2144206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561040877;
	bh=g4RymDhzZ9lSZdyQBzT23kPXNf1VfZcJ141L7MKR5F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZfWCqjnMB8pib9fJjIHBHvS+PRVnXm9sA9uVGJUw8zZedMXVXC+LRzQ26nM2s4Sut
	 lUIf1pGWKX4XjUw0kMMfaa0/bQd/+5n8h2qHsvpIfKmvJ4goqDNPFv2qKMpI76OADr
	 vg8O810m+HUWy7oo8Mk/Ac3bBFkHFD4sTV/smviM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfFTO1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:27:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFTO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Eo3Cd2w1lr7uJ/86SmwydClQeF3F6HBZIAwj6cLHd40=; b=jGWqHMkmvYmrVIQRhcZAN40hO
        xgbf0ngkD5QwFEVYssM34zelu81VnvYc/Tt+bg59ZHJu/Hnh7LTS/u5wdk+uaxCDYm+uwOwlNR+Cb
        5K9hXGx7mEKwOqxrubBXXKxrdMeYYz4icb3gcA8taS+QP8MOLUvaZP4O1e8Dfp8XRBbx4PfZJjzbs
        W6Td4ufX3+llqKTaTH8nsO5HbQajwoVwo0bQbrFE1KweJCt1USjFj5PnF2kSVZbzZB3FdHGFGqKL0
        LjRUbyBTWWDE8TkrQg1LhwZ3HMTdVRpOAaq43bcPT0hNQIDSrOtjaC3NBThRTkDlxCmEOVe4OFcYw
        02pMZjxxw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdy2b-0004qm-IE; Thu, 20 Jun 2019 14:27:53 +0000
Date:   Thu, 20 Jun 2019 11:27:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH 04/14] ABI: better identificate tables
Message-ID: <20190620112749.5e3fb4e9@coco.lan>
In-Reply-To: <20190619131408.26b45c3b@coco.lan>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <6bc45c0d5d464d25d4d16eceac48a2f407166944.1560477540.git.mchehab+samsung@kernel.org>
        <20190619125135.GG25248@localhost>
        <20190619105633.7f7315a5@coco.lan>
        <20190619150207.GA19346@kroah.com>
        <20190619131408.26b45c3b@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 19 Jun 2019 13:14:08 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Em Wed, 19 Jun 2019 17:02:07 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Wed, Jun 19, 2019 at 10:56:33AM -0300, Mauro Carvalho Chehab wrote:  
> > > Hi Johan,
> > > 
> > > Em Wed, 19 Jun 2019 14:51:35 +0200
> > > Johan Hovold <johan@kernel.org> escreveu:
> > >     
> > > > On Thu, Jun 13, 2019 at 11:04:10PM -0300, Mauro Carvalho Chehab wrote:    
> > > > > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > > > > 
> > > > > When parsing via script, it is important to know if the script
> > > > > should consider a description as a literal block that should
> > > > > be displayed as-is, or if the description can be considered
> > > > > as a normal text.
> > > > > 
> > > > > Change descriptions to ensure that the preceding line of a table
> > > > > ends with a colon. That makes easy to identify the need of a
> > > > > literal block.      
> > > > 
> > > > In the cover letter you say that the first four patches of this series,
> > > > including this one, "fix some ABI descriptions that are violating the
> > > > syntax described at Documentation/ABI/README". This seems a bit harsh,
> > > > given that it's you that is now *introducing* a new syntax requirement
> > > > to assist your script.    
> > > 
> > > Yeah, what's there at the cover letter doesn't apply to this specific
> > > patch. The thing is that I wrote this series a lot of time ago (2016/17).
> > > 
> > > I revived those per a request at KS ML, as we still need to expose the
> > > ABI content on some book that will be used by userspace people.
> > > 
> > > So, I just rebased it on the top of curent Kernel, add a cover letter
> > > with the things I remembered and re-sent.
> > > 
> > > In the specific case of this patch, the ":" there actually makes sense
> > > for someone that it is reading it as a text file, and it is an easy
> > > hack to make it parse better.
> > >     
> > > > Specifically, this new requirement isn't documented anywhere AFAICT, so
> > > > how will anyone adding new ABI descriptions learn about it?    
> > > 
> > > Yeah, either that or provide an alternative to "Description" tag, to be
> > > used with more complex ABI descriptions.
> > > 
> > > One of the things that occurred to me, back on 2017, is that we should
> > > have a way to to specify that an specific ABI description would have
> > > a rich format. Something like:
> > > 
> > > What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/pyra/roccatpyra<minor>/actual_cpi
> > > Date:		August 2010
> > > Contact:	Stefan Achatz <erazor_de@users.sourceforge.net>
> > > RST-Description:
> > > 		It is possible to switch the cpi setting of the mouse with the
> > > 		press of a button.
> > > 		When read, this file returns the raw number of the actual cpi
> > > 		setting reported by the mouse. This number has to be further
> > > 		processed to receive the real dpi value:
> > > 
> > > 		===== =====
> > > 		VALUE DPI
> > > 		===== =====
> > > 		1     400
> > > 		2     800
> > > 		4     1600
> > > 		===== =====
> > > 
> > > With that, the script will know that the description contents will be using
> > > the ReST markup, and parse it accordingly. Right now, what it does, instead,
> > > is to place the description on a code-block, e. g. it will produce this
> > > output for the description:
> > > 
> > > ::
> > > 
> > > 		It is possible to switch the cpi setting of the mouse with the
> > > 		press of a button.
> > > 		When read, this file returns the raw number of the actual cpi
> > > 		setting reported by the mouse. This number has to be further
> > > 		processed to receive the real dpi value:
> > > 
> > > 		VALUE DPI
> > > 		1     400
> > > 		2     800
> > > 		4     1600
> > > 
> > > 
> > > Greg, 
> > > 
> > > what do you think?    
> > 
> > I don't know when "Description" and "RST-Description" would be used.
> > Why not just parse "Description" like rst text and if things are "messy"
> > we fix them up as found, like you did with the ":" here?  It doesn't
> > have to be complex, we can always fix them up after-the-fact if new
> > stuff gets added that doesn't quite parse properly.
> > 
> > Just like we do for most kernel-doc formatting :)  
> 
> Works for me. Yet, I guess I tried that, back on 2017. 
> 
> If I'm not mistaken, the initial patchset to solve the broken things 
> won't be small, and will be require a lot of attention in order to
> identify what's broken and where.
> 
> Btw, one thing is to pass at ReST validation. Another thing is to
> produce something that people can read. 
> 
> Right now, the pertinent logic at the script I wrote (scripts/get_abi.pl)
> is here:
> 
>                 if (!($desc =~ /^\s*$/)) {
>                         if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
>                                 # put everything inside a code block
>                                 $desc =~ s/\n/\n /g;
> 
>                                 print "::\n\n";
>                                 print " $desc\n\n";
>                         } else {
>                                 # Escape any special chars from description
>                                 $desc =~s/([\x00-\x08\x0b-\x1f\x21-\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
> 
>                                 print "$desc\n\n";
>                         }
>                 }
> 
> If it discovers something weird enough, it just places everything
> into a comment block. Otherwise, it assumes that it is a plain
> text and that any special characters should be escaped.
> 
> If the above block is replaced by a simple:
> 
> 		print "$desc\n\n";
> 
> The description content will be handled as a ReST file.
> 
> I don't have any time right now to do this change and to handle the
> warnings that will start to popup.
> 
> Btw, a single replace there is enough to show the amount of problems that
> it will rise, as it will basically break Sphinx build with:
> 
> 	reading sources... [  1%] admin-guide/abi-testing
> 	reST markup error:
> 	get_abi.pl rest --dir $srctree/Documentation/ABI/testing:45261: (SEVERE/4) Missing matching underline for section title overline.
> 	
> 	==========================
> 	PCIe Device AER statistics
> 	These attributes show up under all the devices that are AER capable. These

To be clear here: the problem with the above is that ReST has zero
tolerance and actually behaves like a crash, if it receives something like:

   ==========================
   PCIe Device AER statistics
   ==========================

For it to work, it has to have zero spaces before ===..=== line, e. g.:

==========================
PCIe Device AER statistics
==========================

Ok, maybe we could try to teach the parser a way to identify the initial
spacing of the first description line and remove that amount of 
spaces/tabs for the following lines, but it may require some heuristics.

Thanks,
Mauro
