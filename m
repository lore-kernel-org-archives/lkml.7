Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E11C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466820868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558520363;
	bh=meak3U01GThH0IfuZtpExbh/D0Mr6GkD8ee9Z2B8tRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GdTQchA1pf/L3gWCt8RJe6xZU5jcte2qSVBTPvj4ZQZErMGEkXDfIqAbHEZefKBze
	 R8Q7b4i0KxxfxS7e+5MyQdA3oFpKnN0sSXELuO4SK5o4Xitkgrg52RIWMQ38v6/f5N
	 ye2ISDhKCzsGbBKo20Fc5heVXpyknh06Gf1PP/V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfEVKTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:19:22 -0400
Received: from casper.infradead.org ([85.118.1.10]:51686 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfEVKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MNNWQkMpAeP5cdL0iBQSICJkN4ZWR11nVvJgfc6zMgU=; b=iNFlpcrN1RcMAP1iO9D+A4S/Ag
        Zdb4xTBd5u2hyuKpRMdb1cBJ2KS3URlwrQ79ofcRaMCLyOaPEY4p1YVeTPAPSBi9QGWl1dDCnwW/O
        /fMS7VXOzwbus5RYrWpOh9Hgtsof93tLpwnoaPUrWYh29iMHbzBh43bvqRpdzD5CAumypchvCZEXK
        JYN8Mca7dBM+1GucZlfls2sald9v6iDlohzoERJWaj9pEn6hXF23fCstUVdRU1g2V3zA5cSv2oxT7
        McC4bzthb3qv4iEsiVfwdhx05Nb+62YhxmAgzDZ7F41flsimsXAMMhFVsAjLlWMrX6lbn24lFqboM
        zYHD2v9g==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTOL6-00062F-7v; Wed, 22 May 2019 10:19:16 +0000
Date:   Wed, 22 May 2019 07:19:09 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: Re: [PATCH RFC 0/2] docs: Deal with some Sphinx deprecation
 warnings
Message-ID: <20190522071909.050bb227@coco.lan>
In-Reply-To: <87d0kb7xf6.fsf@intel.com>
References: <20190521211714.1395-1-corbet@lwn.net>
        <87d0kb7xf6.fsf@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 22 May 2019 10:36:45 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Tue, 21 May 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> > The Sphinx folks are deprecating some interfaces in the upcoming 2.0
> > release; one immediate result of that is a bunch of warnings that show up
> > when building with 1.8.  These two patches make those warnings go away,
> > but at a cost:
> >
> >  - It introduces a couple of Sphinx version checks, which are always
> >    ugly, but the alternative would be to stop supporting versions
> >    before 1.7.  For now, I think we can carry that cruft.  
> 
> Frankly, I'd just require Sphinx 1.7+, available even in Debian stable
> through stretch-backports.

We can raise the bar and force a 1.7 or even 1.8 (Fedora 30 comes
with version 1.8.4), but I would prefer to keep support older versions,
at least while we don't depend on some new features introduced after
the version we're using, and while our extensions won't require a major
rework due to a new version.
> 
> >  - The second patch causes the build to fail horribly on newer
> >    Sphinx installations.  The change to switch_source_input() seems
> >    to make the parser much more finicky, increasing warnings and
> >    eventually failing the build altogether.  In particular, it will
> >    scream about problems in .rst files that are not included in the
> >    TOC tree at all.  The complaints appear to be legitimate, but it's
> >    a bunch of stuff to clean up.  

There is a flag to cleanup the warning about a file not included at
a TOC tree (:orphan:), but it will still try to parse it. There's also
a conf.py way of doing it. For example, you can exclude an entire dir:

	exclude_patterns = ['includes/*.rst']

But using exclude_patterns will likely be too messy.

> I can understand Sphinx complaining that a file is not included in a TOC
> tree, but I don't understand why it goes on to parse them anyway.

Yeah, this is, IMHO, a very bad behavior.

> 
> BR,
> Jani.
> 
> 
> >
> > I've tested these with 1.4 and 1.8, but not various versions in between.
> >
> > Jonathan Corbet (2):
> >   doc: Cope with Sphinx logging deprecations
> >   doc: Cope with the deprecation of AutoReporter
> >
> >  Documentation/sphinx/kerneldoc.py | 48 ++++++++++++++++++++++++-------
> >  Documentation/sphinx/kernellog.py | 28 ++++++++++++++++++
> >  Documentation/sphinx/kfigure.py   | 38 +++++++++++++-----------
> >  3 files changed, 87 insertions(+), 27 deletions(-)
> >  create mode 100644 Documentation/sphinx/kernellog.py  
> 



Thanks,
Mauro
