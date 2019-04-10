Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB34C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D4520820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554889791;
	bh=giGxJnADM0eR18iTIDswkhkYpsX4T1IgD9vCIWgC8Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WhUdhD7+HYrqvG/rT8XJQEtr40QpG4646c9MrxnsK7lZkgtCEb7XeAq5FPIyIS0j3
	 idRb8kgW4nvpr5F8FvzcfWbOizdNVU2EGxLoCyLLt8Jw3nd/a/xxoJOJTC+4I5L8iP
	 TkdZLRmQj4oBtlDl+DdcYrxV2AF6FrJEdKuUQwT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfDJJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:49:49 -0400
Received: from casper.infradead.org ([85.118.1.10]:40994 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfDJJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZUo/oAO6LRUwF5qvt4zAp9NpnWAe/eMac0EcWXGOy/A=; b=YS8QBN4MTC0v3dgmjyZs8csZLa
        iESS4/29QV3kSEn3oi9puVYjRf1W3TSj1HOFdqNxAR4g8DHedvOEbFUXdcI87L+38OBjLYE+aJB8s
        s66LE/QB8AG2DPk1C9VR5mje11sdIKTIemSnO1MeZ0h8a+8W5On40NMrhYPaFyI9P4fjDucE///KY
        A+RarrRuMKwicmrOxmfD8+rEvLOu/RWXU7LGDRvP89HTIIIeXFgMXkWwNc6bGifEdJZHFlZcYvkSo
        T3Dy0lS9n720xXbSyh4ozlUhL9HnzOm3sQO6FZsq3yq4BjkZMfnsfj2FIV2g2P/L+9J6ecXLVAtYD
        tllC1JKg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9rU-0000Ry-NX; Wed, 10 Apr 2019 09:49:45 +0000
Date:   Wed, 10 Apr 2019 06:49:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Add all documentation files to an html/pdf
 produced book
Message-ID: <20190410064939.2a9dca9a@coco.lan>
In-Reply-To: <20190408161820.6a12657f@lwn.net>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
        <20190408161820.6a12657f@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 8 Apr 2019 16:18:20 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Mon,  8 Apr 2019 13:58:16 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > Despite having converted almost all files to ReST at the main Documentation/
> > directory, they're still not included to any book. Also, after all those years
> > after migrated to ReST as the official documentation format, there are still
> > a lot of files using plain TXT files, with random internal formatting.
> > 
> > As it will likely require a lot more years to get everything converted,
> > let's add index.rst files to Documentation/* subdirs, with a text_files.rst
> > including all plain txt files as literal includes.
> > 
> > That ensures that the html output will contain the entire Linux Kernel
> > documentation.  
> 
> Hmm...
> 
> >  251 files changed, 5262 insertions(+), 47 deletions(-)  
> 
> Somebody clearly thinks I haven't been involved in enough merge conflicts
> recently :)

:-)

If you take a look at the patches themselves, the first 6 patches are
puntual fixes to a single doc file, in order to fix them:

  [PATCH 01/10] docs: DMA-API-HOWTO: add a missing "="
  [PATCH 02/10] docs: atomic_bitops.txt: add a title for this document
  [PATCH 03/10] docs: clearing-warn-once.txt: add a title for this document
  [PATCH 04/10] docs: ntb.txt: use Sphinx notation for the two ascii figures
  [PATCH 05/10] docs: unaligned-memory-access.txt: use a lowercase title
  [PATCH 06/10] docs: video-output.txt: convert it to ReST format

I remember we patched all Documentation/*.txt files in the past to make
them ReST compliant. New changes (or new files) broke it. Those could
be easily reviewed by their maintainers.

In order to avoid new regressions, and ensure that those ReST files
will be part of the build, the 7th patch rename those files from
*.txt to *.rst and move to an "other/" directory, creating an
"unclassified" book:

  [PATCH 07/10] docs: Add all txt files to documentation

The next two patches are additional ReST improvements and warning
fixes:

  [PATCH 08/10] docs: ntb.rst: add blank lines to clean up some Sphinx warnings
  [PATCH 09/10] docs: speculation.rst: mark example blocks as such

And the final patch adds one index.rst to each sub-directory at
Documentation/ that doesn't have yet any ReST file:

  [PATCH 10/10] docs: add plain text files to ReST output from  subdirs

Inside each Documentation/ subdir, it also adds a text_files.rst with
includes all plain text files.

You're right: patch 07/10 rename would cause trivial merge conflicts. So, if
we are willing to take this, it probably makes sense to apply it late at
a merge cycle.

Patch 10/10 should not cause many conflicts (except if one remove a dir or
a file), as it only adds new files. Still, worth applying it also late
at the merge cycle.

That's said, I was naive to not reorder the patch series, keeping just
the two polemic patches at the end. I'll rebase my series, in order to
send the fixes patches.

So, let's focus the discussions on those two patches:

  [PATCH 07/10] docs: Add all txt files to documentation
  [PATCH 10/10] docs: add plain text files to ReST output from  subdirs

> I understand the goal, but I have to wonder.  This feels a lot like giving
> up on the problem and just sweeping the remaining junk into a pile
> somewhere.

The junk is already there. If we don't take any action to
separate the wheat from the chaff, it will keep tormenting us
for decades to come.

Looking on our main index.rst file, it defines those major groups:

	Licensing documentation
	User-oriented documentation
	Application-developer documentation
	Introduction to kernel development
	Kernel API documentation
	Architecture-specific documentation
	Filesystem Documentation
	Translations

The problem with the legacy stuff is that the same document frequently
has user-oriented, application-oriented and kernel-API stuff at the
same file (or group of files), as they're usually arranged per
subsystem or per C fileset. So, it is not possible to move them as-is
to any of the above without risking adding mess to the higher quality
documments.

Splitting those stuff into the main groups is no joy, and would be
an intensive hard work to solve it. We either need someone to sponsor
a group of people just for rewriting documentation or this will never
happen. In any case, IMHO, the best would be to add a new
crap^h^h^h^hstaging group were we could place all legacy random stuff.
Then, gradually fix those, splitting stuff and promoting them to the
main books, in a similar way to what we do with staging.

> I feel like it would, if anything, reduce the incentive to
> deal with these leftover documents properly.  

IMHO, it is just the opposite. Let's face it: ReST build was added around
May, 2016, for Kernel 4.7. People had quite some time and kernel versions
to do conversions. If nothing is done, I doubt we would have any boom on
patches addressing the issues.

On the other hand, if someone wants to add a ReST file to a random 
Documentation/* subdir that doesn't contain yet an index.rst file, it would
need first to add an index, and may be ashamed of adding something there
without converting the existing files. By having one index.rst file there,
newer files could be added directly there, without the need of touching
the legacy stuff. IMHO, this reduces the barrier to get new documentation
using the ReST format. It should equally be easy for someone to convert
single document files from text to ReST, as it would only need to remove
the file from the text_files.rst, adding it at index.rst.

> If this is *really* something we want to do, I would much rather proceed
> in smaller steps and preferably with the cooperation of the maintainers
> involved.  Imposing all of this at once just seems like a way to make it
> highly dangerous for me to show my face a conferences...

I understand your PoV, but not sure how to proceed.

IMO, we should aim to achieve two goals:

1) avoid, as much as possible, to add new plain text non-ReST compatible
files to the documentation, as, if we keep adding them, we'll never
have a consistent documentation set;

2) ensure that the already converted files will be on some book, as this
will help to identify regressions.

That's what patches 07/10 and 10/10 are trying to achieve.

It should be easy to break patch 10/10 on a per-subdir base, making
it easier to be merge it by subsystem maintainers.

If I split it on per-subdir, that would fit for you?

-

In the case of patch 07/10, I might have done it on a different way:
instead of moving them to a "staging-like" book (Documentation/other),
it could have used other strategies:

1) rename the files to *.rst but leaving them at the Documentation/
diretory, and adding a new "other.rst" or "staging.rst" where those
stuff would be added. IMHO, this is a crap way of doing it, as
we'll use the main Documentation/ dir as a trash can;

2) do a better job with moves, adding those files on some existing
sub-directories. This doesn't sound an easy task, as it is not
trivial to associate every single file there with an existing book.
Also, some stuff there don't have new content added for ages.
Maybe the stuff doesn't apply anymore (or it is for some part of
the Kernel that are just stable enough).

Ok, perhaps if we add patch 10/10 before 07/10, it could make
easier to move the files, as we'll have a lot more places to
add the rst files, as all sub-dirs will now contain rst files.

If you're ok with such strategy, I could try such approach and
see what happens.

Thanks,
Mauro
