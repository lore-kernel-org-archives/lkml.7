Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01FBC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CFF22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566320309;
	bh=sFHOWf96vi7j1GNkuu7k6bQraygG3Q7ZGW8YYWz6/84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BWLEM3sIEeSFJAOSlctZmByiYvX7hSfPWh0ID1OQw0w9ue5SETHxMZ9Ym/AWz6gLO
	 hAkCzcRZLifk1DwbcQkP3tOcX9REMHL392U/n3HUiJEBgyGV57clrz0vCQ5l+72D6g
	 7shquIKnbuWZPzbQ7bQwZ+pyLKPOUFwoR7OritHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfHTQ62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbfHTQ62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:28 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371DA2087E;
        Tue, 20 Aug 2019 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566320307;
        bh=sFHOWf96vi7j1GNkuu7k6bQraygG3Q7ZGW8YYWz6/84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2zrD9tuaRrnLHmBG37ekGWvZyqiDxfqQQlxJMjESJL5bmHg14df1GG/AXR2GYEwr
         lKdseJRZPnvj4nUYlLCqx3nIyJzzrf6ZRrQEEB5NkG5EstfhOmY6SyNiNPSFqDFR7A
         zKjo5XlIkQDuXLdxOuZg6l2zmDp5Hge3t3lTWQ/M=
Date:   Tue, 20 Aug 2019 09:58:26 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Tyler Hicks <tyhicks@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] Documentation/admin-guide: Embargoed hardware
 security issues
Message-ID: <20190820165826.GB3736@kroah.com>
References: <20190725130113.GA12932@kroah.com>
 <20190815212505.GC12041@kroah.com>
 <20190820145850.x445rw4uoqz6n4hw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820145850.x445rw4uoqz6n4hw@treble>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:58:50AM -0500, Josh Poimboeuf wrote:
> On Thu, Aug 15, 2019 at 11:25:05PM +0200, Greg Kroah-Hartman wrote:
> > +Contact
> > +-------
> > +
> > +The Linux kernel hardware security team is separate from the regular Linux
> > +kernel security team.
> > +
> > +The team only handles the coordination of embargoed hardware security
> > +issues.  Reports of pure software security bugs in the Linux kernel are not
> > +handled by this team and the reporter will be guided to contact the regular
> > +Linux kernel security team (:ref:`Documentation/admin-guide/
> > +<securitybugs>`) instead.
> > +
> > +The team can be contacted by email at <hardware-security@kernel.org>. This
> > +is a private list of security officers who will help you to coordinate an
> > +issue according to our documented process.
> > +
> > +The list is encrypted and email to the list can be sent by either PGP or
> > +S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
> > +certificate. The list's PGP key and S/MIME certificate are available from
> > +https://www.kernel.org/....
> 
> This link needs to be filled in?
> 
> > +Encrypted mailing-lists
> > +-----------------------
> > +
> > +We use encrypted mailing-lists for communication. The operating principle
> > +of these lists is that email sent to the list is encrypted either with the
> > +list's PGP key or with the list's S/MIME certificate. The mailing-list
> > +software decrypts the email and re-encrypts it individually for each
> > +subscriber with the subscriber's PGP key or S/MIME certificate. Details
> > +about the mailing-list software and the setup which is used to ensure the
> > +security of the lists and protection of the data can be found here:
> > +https://www.kernel.org/....
> 
> Ditto?

Yes, they will once the links are up and running :)

thanks,

greg k-h
