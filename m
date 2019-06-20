Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5664C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16E52084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560997448;
	bh=HSXg+eYTEQW+nahRHajhYLv+Ds5NfZDqRb8SuuOANnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pqdztdsNcp1NuEOnvJm6sfF/K2xwncX5ea/2P0Inoko/quzPMQhcwMoLYVz0I4yn8
	 z+7C8QZYvNNaiZuuOLnin1CpheaKVADXJ92MmmShDJpIYNP9rMod2rO2jMqB55MCG6
	 CUrOOlnFzgdPy+7KWzmW7HIXH2O+2HgGOE33op6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfFTCYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:24:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=db6JPvpCz3hoflV8W037Dtn2xhi+L6YV1HcCa4+XjBQ=; b=qtscGbxxnS1WBhq+OUuuJ2LOZ
        4Qam1Qp8bSyIqMh7MF2RTJ9QcJfagUtjCQHlXYpaRIrkH/UjW2ENTOHgio8ydFetcRNpKSnPL9lB5
        Zu3VGbIe0tlkbgj7NkF5NMGmxSqYtzFwr0Toej8TG2DfN6ooBNNxNwOiBnMHyL6aQra4UbVx9KAkR
        QZrkmpZedHBzDjrBSEc3gDdiw2rbWQWHLCXk+xKsOoBZJBPTDbVCLyb7/V7ti1Tt9Xb51aUhtiWuX
        5tSD944M17TrUs1dxdV4Rlx8+8aNnPOoU+ebzu8L8t8ic1EYm2PAKx5epCNkHrsy+COEhrsWSS34p
        9QkwSKZdQ==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdmkA-0001Ik-0I; Thu, 20 Jun 2019 02:24:06 +0000
Date:   Wed, 19 Jun 2019 23:24:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619232402.20970470@coco.lan>
In-Reply-To: <20190619212753.GQ3419@hirez.programming.kicks-ass.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <20190619114356.GP3419@hirez.programming.kicks-ass.net>
        <20190619101922.04340605@coco.lan>
        <20190619212753.GQ3419@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 19 Jun 2019 23:27:53 +0200
Peter Zijlstra <peterz@infradead.org> escreveu:

> On Wed, Jun 19, 2019 at 10:19:22AM -0300, Mauro Carvalho Chehab wrote:
> > (c/c list cleaned)
> > 
> > Em Wed, 19 Jun 2019 13:43:56 +0200
> > Peter Zijlstra <peterz@infradead.org> escreveu:
> >   
> > > On Tue, Jun 18, 2019 at 05:53:17PM -0300, Mauro Carvalho Chehab wrote:
> > >   
> > > >  .../{ => driver-api}/atomic_bitops.rst        |  2 -    
> > > 
> > > That's a .txt file, big fat NAK for making it an rst.  
> > 
> > Rst is a text file. This one is parsed properly by Sphinx without
> > any changes.  
> 
> In my tree it is a .txt file, I've not seen patches changing it. And I
> disagree, rst is just as much 'a text file' as .c is.

ReStructured text is just text with a stricter style + some commands,
if the text author wants to enhance it.

Btw, I'm glad you mentioned c. 

This is c:

	int
	func( int a, int
			 b ) {
	 return a + b;
	}

This is also c:

	func(int a,int b) { goto foo;
	foo:
	   return(a+b) }

K&R style is also c, and this is also c:

	#define f(a,b) (a+b)

Despite none of the above matches my taste - and some have issues - they
all build with gcc.

Yet, none of the above follows the Kernel coding style.

The way we use ReST (with absolute minimal changes), it becomes just
a text style.

Btw, I agree with you: there are some odd things at its style - and we 
should work to try to reduce this to its minimal extent.

> 
> > > >  .../{ => driver-api}/futex-requeue-pi.rst     |  2 -    
> > >   
> > > >  .../{ => driver-api}/gcc-plugins.rst          |  2 -    
> > >   
> > > >  Documentation/{ => driver-api}/kprobes.rst    |  2 -
> > > >  .../{ => driver-api}/percpu-rw-semaphore.rst  |  2 -    
> > > 
> > > More NAK for rst conversion  
> > 
> > Again, those don't need any conversion. Those files already parse 
> > as-is by Sphinx, with no need for any change.  
> 
> And yet, they're a .txt file in my tree. And I've not seen a rename,
> just this move.

Rename is on patch 1/22.

No matter the extension, all the above files pass at the Sphinx style
validation without warnings or errors. Patch 1/22 doesn't make any
conversion.

Btw, the .rst extension is just a convenient way to help identifying what
was not validated. If I'm not mistaken, when the discussions about a
replacement for DocBook started at at linux-doc, someone proposed to
keep the .txt extension (changing it to accept .rst, .txt or both is
a single line change at conf.py).

> 
> > The only change here is that, on patch 1/22, the files that
> > aren't listed on an index file got a :orphan: added in order
> > to make this explicit. This patch removes it.  
> 
> I've no idea what :orphan: is. Text file don't have markup.
> 
> > > >  Documentation/{ => driver-api}/pi-futex.rst   |  2 -
> > > >  .../{ => driver-api}/preempt-locking.rst      |  2 -    
> > >   
> > > >  Documentation/{ => driver-api}/rbtree.rst     |  2 -    
> > >   
> > > >  .../{ => driver-api}/robust-futex-ABI.rst     |  2 -
> > > >  .../{ => driver-api}/robust-futexes.rst       |  2 -    
> > >   
> > > >  .../{ => driver-api}/speculation.rst          |  8 +--
> > > >  .../{ => driver-api}/static-keys.rst          |  2 -    
> > >   
> > > >  .../{ => driver-api}/this_cpu_ops.rst         |  2 -    
> > >   
> > > >  Documentation/locking/rt-mutex.rst            |  2 +-    
> > > 
> > > NAK. None of the above have anything to do with driver-api.  
> > 
> > Ok. Where do you think they should sit instead? core-api?  
> 
> Pretty much all of then are core-api I tihnk, with exception of the one
> that are ABI, which have nothing to do with API. 

OK.

> And i've no idea where
> GCC plugins go, but it's definitely nothing to do with drivers.

I suspect that Documentation/security would be a better place
for GCC plugins (as it has been discussed at kernel-hardening ML),
but I'm waiting a feedback from Kees.

> 
> Many of the futex ones are about the sys_futex user API, which
> apparently we have Documentation/userspace-api/ for.

Yeah, it makes sense to place sys_futex there.

Despite being an old dir, it is not too popular: there are
very few document there. I only discovered this one a few
days ago.

> 
> Why are you doing this if you've no clue what they're on about?

I don't pretend to know precisely where each document will fit.
If you read carefully the content of each orphaned document, you'll see
that many of them have uAPI, kAPI and admin-guide info inside.

To be frank, I actually tried to get rid of this document shift
part, but a Jon's feedback when I submitted a much simpler RFC
patchset challenged me to try to place each document on some place. The 
renaming part is by far a lot more complex than the conversion, 
because depending on how you interpret the file contents -
and the description of each documentation chapter - it may fit on a
different subdir.

-

My main goal is to have an organized body with the documentation. 

Try to read our docs as if it is a book, and you'll see what I'm talking
about: there are important missing parts, the document order isn't in
an order that would make easier for the headers, several documents are
placed on random places, etc.

Just like we have Makefiles, the index.rst files, plus the subdirectories
help to classify and organize the documentation on a coherent way.

- 

The main problem I want to address with this particular patch is that 
there are so many random documents from all sorts of subject at
Documentation/*.txt that it makes really hard to see the document
structure or to organize them.

Also, keeping txt files there at the root doc dir is a bad idea, as 
people keep flooding Documentation/ root with new unclassified documents
on almost every Kernel version.

After 5.1, there are two new documents added inside Documentation/*.txt
(I guess both added at linux-next for 5.3).

I proposed a few months ago to create a Documentation/staging, and do:

	mv Documentation/*.txt Documentation/*.rst Documentation/staging 

Jani proposed today something similar to it (Documentation/attic)

The name is not important. Having a place were we can temporarily
place documents while we organize the directory structure and the
documentation indexes seem to be the best way to reorganize the
docs on a coherent way.

Thanks,
Mauro
