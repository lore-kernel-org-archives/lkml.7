Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B9CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA320851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558608355;
	bh=BXS6EfcWtTzyBlJtA6lHiVTlEPt1j5lmojILahvc79c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hrPpqJ+BGikdh/0AuptLdLnITHlXABHb6B+fXBvQy0ijt1kKtmVkJKZdj2X6vdAUy
	 j/pRGSeqriy+4b/9zTD2oYSxQb0QRGdHI/KYPk/R2IONIXXvu8QNn0T9d7g9dbWlHX
	 QtqAk8fu4Us2XSXhgn2ssKlp5dEwJ9EfRfwOiHjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfEWKpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:45:54 -0400
Received: from casper.infradead.org ([85.118.1.10]:44008 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fjMPrd2+xzbd1Cr2J5ISSgp6rqzlaCnr5IwuSuxJoic=; b=fF1VRCpk2egpSuxYOGeGtHi5dJ
        bLBlrF1R0dr9Bfi8daRRXn3xjd0rebJi33VBoTt/qEV1b8d/EcZqvO4p+DuXqqXCCVUP1zvRaHzS6
        PU+jrvmSNcbzmnfByVsT6hEMg8ToT2v0NCGB2PS9jlbhG74wzHolzZxYI7pI1byzryoY1yZ19aJ2d
        UUWgdQ6gU9lH4IHX7yi0t30oI6fUuFIBLIJrsmz29NxLOpHgZ1pOEK1VVRN35832yo01I+sNA6wPU
        xRA1U3ZsZH6JixL/SUHw9g/PGNjTkuA2/uANSr8l/VxbvoxHy5yOUj+ZZm40/tWst9IlD9ENn4i7O
        PWNCQf/g==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTlEM-00020w-IN; Thu, 23 May 2019 10:45:51 +0000
Date:   Thu, 23 May 2019 07:45:45 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: Re: [PATCH 0/8] docs: Fixes for recent versions of Sphinx
Message-ID: <20190523074545.65642eac@coco.lan>
In-Reply-To: <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
References: <20190522205034.25724-1-corbet@lwn.net>
        <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 23 May 2019 11:39:44 +0200
Oleksandr Natalenko <oleksandr@redhat.com> escreveu:

> Hi.
> 
> On Wed, May 22, 2019 at 02:50:26PM -0600, Jonathan Corbet wrote:
> > The Sphinx folks deprecated some interfaces in the 2.0 release; one
> > immediate result of that is a bunch of warnings that show up when building
> > with 1.8.  These two patches make those warnings go away, but at a cost:
> > 
> >  - It introduces a couple of Sphinx version checks, which are always
> >    ugly, but the alternative would be to stop supporting versions
> >    before 1.7.  For now, I think we can carry that cruft.
> > 
> >  - The second patch causes the build to fail horribly on newer
> >    Sphinx installations.  The change to switch_source_input() seems
> >    to make the parser much more finicky, increasing warnings and
> >    eventually failing the build altogether.  In particular, it will
> >    scream about problems in .rst files that are not included in the
> >    TOC tree at all.
> > 
> > This version of the patch set fixes up the worst problems (the i915 error
> > in particular, which breaks the build hard).  I've tested it with versions
> > 1.4, 1.8, and 2.0.
> > 
> > Given that these problems are already breaking builds on some systems, I
> > think I may try to sell these changes to Linus for 5.2 still.
> > 
> > Changes since v1:
> >   - Fix up a couple of logging changes I somehow missed
> >   - Don't save state when using switch_source_input()
> >   - Fix a few build errors
> >   - Add Mauro's sphinx-pre-install improvements
> > 
> > Jonathan Corbet (7):
> >   doc: Cope with Sphinx logging deprecations
> >   doc: Cope with the deprecation of AutoReporter
> >   docs: fix numaperf.rst and add it to the doc tree
> >   lib/list_sort: fix kerneldoc build error
> >   docs: fix multiple doc build warnings in enumeration.rst
> >   docs/gpu: fix a documentation build break in i915.rst
> >   docs: Fix conf.py for Sphinx 2.0
> > 
> > Mauro Carvalho Chehab (1):
> >   scripts/sphinx-pre-install: make it handle Sphinx versions
> > 
> >  Documentation/admin-guide/mm/index.rst        |  1 +
> >  Documentation/admin-guide/mm/numaperf.rst     |  2 +-
> >  Documentation/conf.py                         |  2 +-
> >  .../firmware-guide/acpi/enumeration.rst       |  2 +-
> >  Documentation/gpu/i915.rst                    |  4 +-
> >  Documentation/sphinx/kerneldoc.py             | 44 +++++++---
> >  Documentation/sphinx/kernellog.py             | 28 +++++++
> >  Documentation/sphinx/kfigure.py               | 40 +++++----
> >  lib/list_sort.c                               |  3 +-
> >  scripts/sphinx-pre-install                    | 81 +++++++++++++++++--
> >  10 files changed, 166 insertions(+), 41 deletions(-)
> >  create mode 100644 Documentation/sphinx/kernellog.py
> > 
> > -- 
> > 2.21.0
> >   
> 
> Thanks for the efforts. I've run this on top of Linus' tree, and the
> only sphinx-related deprecation warning I've spotted is this one:
> 
> /home/onatalen/work/src/linux/Documentation/sphinx/cdomain.py:51: RemovedInSphinx30Warning: app.override_domain() is deprecated. Use app.add_domain() with override option instead.
>   app.override_domain(CDomain)
> 
> Otherwise, it builds.
> 

Just sent a fix. Could you please test?


https://lore.kernel.org/lkml/b38a9fdfdcda49b2c6118072afac564e96406800.1558608217.git.mchehab+samsung@kernel.org/T/#u

Thanks,
Mauro
