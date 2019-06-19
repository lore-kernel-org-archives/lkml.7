Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8422C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F5421670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560953734;
	bh=9//fCv7R84M7FMNljtswEpVZYQad844yoyk1YittZlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WOWudfUC0vjd8hZO+LDXFNHOpuoQhhz/DqZmz2iQyE/Ucr1Rl3gVLcIXY9HXbz0qB
	 N2GJ2zgDnYyeClxFzRHck6L82BMHXMSdSnSwnowikk7nZ3aZFk05MUz/VrlvtkeFvo
	 s8Aaysk6EwsrawSJQP41Ec/z6rFWb/TuCLqxpxdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfFSOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:15:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NBYZM4x4vonQf9U9PegTdJ8Gr3lWbvulPmcaW6blw1o=; b=dPqOh1g1u6+Gx0sBalb5rkX2u
        wIbBMtAEdIsAee3Ub7W9KYWOgt2mtCWo8S4Q3A8BuyYcZpFXJIBFKLK93DcM0OgM4m/inlhuMxd4i
        xv4bXL13yE2S6AOwvmz7dbVWGoNRlTOpVocD4rVyrbv1GF1YVK56MDdeJUJ2TJdyUU/i7LDzPPxwk
        q5bBzKUGnZGKBhiO1stiWprfqZmaUIaVdpkulYzUlK2rGWSYmI7ne0f+vptRKQfKdDsKioHcQ3HVY
        ZLJmnIxZLL9Wg8XwEkfcleJ+3FQYhKRtXa8W53asUfOJcitK/KfLJc7dkOM7cGkK88AajNUpeKd7M
        OSliQfZFw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdbN5-0002AD-M9; Wed, 19 Jun 2019 14:15:32 +0000
Date:   Wed, 19 Jun 2019 11:15:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Message-ID: <20190619111528.3e2665e3@coco.lan>
In-Reply-To: <11422.1560951550@warthog.procyon.org.uk>
References: <20190619072218.4437f891@coco.lan>
        <cover.1560890771.git.mchehab+samsung@kernel.org>
        <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
        <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
        <11422.1560951550@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Em Wed, 19 Jun 2019 14:39:10 +0100
David Howells <dhowells@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > > > -Documentation/nommu-mmap.rst
> > > > +Documentation/driver-api/nommu-mmap.rst    
> 
> Why is this moving to Documentation/driver-api?  

Good point. I tried to do my best with those document renames, but
I'm pretty sure some of them ended by going to the wrong place - or
at least there are arguments in favor of moving it to different
places :-)

The driver-api ended to be where most of the stuff has been moved,
as this is the main kAPI dir (there is also a core-api dir for kAPI too).

I tend to place there stuff that has a mix of kAPI and uAPI at
driver-api, as usually such documents are written assuming that
the one that would be reading it is a Kernel developer.

> It's less to do with drivers
> than with the userspace mapping interface.  Documentation/vm/ would seem a
> better home.
> 
> Or should we institute a Documentation/uapi/?  Though that might be seen to
> overlap with man2.  Actually, should this be in man7?

Actually, there is an userspace-api dir too. While the logs show that
this was created back on 2017, I only noticed it very recently.

Re-checking the file, I see your point: there are lots of
userspace-relevant contents there. Yet, it also mentions kAPI internals,
like a reference for file and vm ops (at "Providing shareable character
device support" session):

	file->f_op->get_unmapped_area()
	file->f_op->mmap()
	vm_ops->close()

It is up to MM people and Jon to decide where to place it.

In any case, the best (long term) seems to split it on separate files, 
one with kAPI and another one with uAPI (just like may other subsystem
specific docs).

Thanks,
Mauro
