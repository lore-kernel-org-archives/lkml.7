Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB748C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DC1218AF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555115171;
	bh=x7FSTyGfJlPdiXW5VI0btM70k1QO7NtP0ZRkWpiTWsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Z76W0tQ8eogLigTkKQTRfDsOg4SKW05UeeIP3Cc6nLZ1qESh5mQlIrYrsT5g1bEs+
	 P90xiwfNG8vPB7PrI/g1Oe1Pmodb30TPOhky9K5rD6+AB6/Bcaer/AprnrNVt0fe4p
	 1MxGA7/hLVN8fE7jXUUO5cJPfKDQwwsiSHJB/XCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDMA0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:26:09 -0400
Received: from casper.infradead.org ([85.118.1.10]:50956 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDMA0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4mQ9cEOwWsjtS00QxTayhbQ57nO91ztak7S0dPl4OCA=; b=qRkeB63T/VDW/K1SrqBJjuulkZ
        F2Qe/Gv89KZaClsUhOo3tq+ciBVgxFl7goed5PTgh7/VxqooIG6QUsNkhY9cLanR7iQaq4QfrTiHp
        5Be7GLO/HidpS4mrLedilzPdUMO7TIj9M7xXVjM4CDQ4p9KuauMCL1NA4dMwQ7lse2cFYvUhXIoaL
        TVa1Lm9NSPY6akwTxXYU6xnoAvW/ooQSkTpsWXdqVpTffYN0MkPBOwKzPGBF+KOF+ORMYiEs4Nqkx
        pfDGXPdLIzuiJqkC1M9J8OagYHAoRlu+2Un1za6vV9JJ835F9YWj+yrBrwKO8RFJYD+PtHARV8jl9
        EiF3RxtA==;
Received: from 201.86.162.146.dynamic.adsl.gvt.net.br ([201.86.162.146] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF6US-0002NC-62; Sat, 13 Apr 2019 00:25:52 +0000
Date:   Fri, 12 Apr 2019 21:25:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
Message-ID: <20190412212541.0cde9452@coco.lan>
In-Reply-To: <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
        <20190411124324.3ed62fad@lwn.net>
        <20190411174357.251904f5@coco.lan>
        <20190411210731.GA29378@roeck-us.net>
        <20190412100451.6fe49de7@lwn.net>
        <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 12 Apr 2019 09:12:52 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On 4/12/19 9:04 AM, Jonathan Corbet wrote:
> > On Thu, 11 Apr 2019 14:07:31 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> >>> While nobody does such split, IMHO, the best would be to keep the
> >>> information outside Documentation/admin-guide. But hey! You're
> >>> the Doc maintainer. If you prefer to move, I'm perfectly fine
> >>> with that.
> >>>      
> >>
> >> Same here, but please don't move the files which are kernel facing only.  
> > 
> > Well, let's step back and think about this.  Who is the audience for
> > these documents?  That will tell us a lot about where they should really
> > be.
> >   
> 
> Most of them are for users, some of them are for driver developers. A few
> are for both, though that is generally not the intention (and one may argue
> that driver internal documentation should be moved into the respective
> driver source).

The big issue is really those files that contain both kernel internals
and userspace stuff.

This is a common pattern. I just finishing converting a lot more
documents to ReST and I found the same thing on almost all document
directories I touched.

> > What I would prefer to avoid is the status quo where *everything* is in
> > the top-level directory, and where documents are organized for the
> > convenience of their maintainers rather than of their readers.  But
> > sometimes I feel like I'm alone in that desire...:)
> >   
> I am fine with separating user pointing from kernel API/driver developer
> guides, and I agree that it would make a lot of sense. As I said, please
> just make sure that kernel facing files don't end up in the wrong directory.

I like the idea of splitting user faced documents from the rest, but
this is not an easy task. On several cases, there are just a couple
of paragraphs with things like sysfs entries in the middle of a big
file with Kernel internals.

Thanks,
Mauro
