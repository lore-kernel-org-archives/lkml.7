Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E317C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3514A2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfEWLWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:22:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:22:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id c77so5415672wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o5spxOia4/6GDV/owf0hUE+Yl+KqSq8ES+CEbG5WZlY=;
        b=sVkSNpXH6Yf+c/Ia7y2ROPIh0YTx/cxSiOQyyzEhx/JDMDqncWlAGkZK4NtREdtAqF
         slVTHM6Qt9YOJJqw9VAZMjVxftzDPU/o4rJ1PFP1vajfvTYI1l73fcrCxdEdbEtW0Odh
         DxaJeb9L8SzGevBN9QHNfioQIgbmBu8ozMXt2U4ahT9UfEwtCwCdoFspxfbQgYHErgX7
         f5wT6KtIhGMQMe9S6wYSHUWKOgGx64GZnUebwSjTAITmDewaVQpfW2ex0zl8Fed0XdpQ
         iTVo0iqd3Z3FlQBpRBNYkeP1ax3bVaj2WQyn2y9rI73njdzGhpwXHJLrabymkfcLeFZ5
         LVUA==
X-Gm-Message-State: APjAAAXcss3rx+8ZXV/dHuYfDas9sfIk9W3qKA8BD9hgtWDXc+BurgD0
        bFh1Uj+D5tVHgVU7Id0wY6j7oA==
X-Google-Smtp-Source: APXvYqx9Gn6HemSAZ87ApeaJsnDwTZFfySah89pYCZ120z3yhNqY4R//xB9J5AhiGRciFCsdYI81dw==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr11007052wmk.122.1558610564990;
        Thu, 23 May 2019 04:22:44 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h8sm16765707wmf.5.2019.05.23.04.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 04:22:43 -0700 (PDT)
Date:   Thu, 23 May 2019 13:22:42 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: Re: [PATCH 0/8] docs: Fixes for recent versions of Sphinx
Message-ID: <20190523112240.7hv4ufwknwbaviv2@butterfly.localdomain>
References: <20190522205034.25724-1-corbet@lwn.net>
 <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
 <20190523074545.65642eac@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523074545.65642eac@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 07:45:45AM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 23 May 2019 11:39:44 +0200
> Oleksandr Natalenko <oleksandr@redhat.com> escreveu:
> 
> > Hi.
> > 
> > On Wed, May 22, 2019 at 02:50:26PM -0600, Jonathan Corbet wrote:
> > > The Sphinx folks deprecated some interfaces in the 2.0 release; one
> > > immediate result of that is a bunch of warnings that show up when building
> > > with 1.8.  These two patches make those warnings go away, but at a cost:
> > > 
> > >  - It introduces a couple of Sphinx version checks, which are always
> > >    ugly, but the alternative would be to stop supporting versions
> > >    before 1.7.  For now, I think we can carry that cruft.
> > > 
> > >  - The second patch causes the build to fail horribly on newer
> > >    Sphinx installations.  The change to switch_source_input() seems
> > >    to make the parser much more finicky, increasing warnings and
> > >    eventually failing the build altogether.  In particular, it will
> > >    scream about problems in .rst files that are not included in the
> > >    TOC tree at all.
> > > 
> > > This version of the patch set fixes up the worst problems (the i915 error
> > > in particular, which breaks the build hard).  I've tested it with versions
> > > 1.4, 1.8, and 2.0.
> > > 
> > > Given that these problems are already breaking builds on some systems, I
> > > think I may try to sell these changes to Linus for 5.2 still.
> > > 
> > > Changes since v1:
> > >   - Fix up a couple of logging changes I somehow missed
> > >   - Don't save state when using switch_source_input()
> > >   - Fix a few build errors
> > >   - Add Mauro's sphinx-pre-install improvements
> > > 
> > > Jonathan Corbet (7):
> > >   doc: Cope with Sphinx logging deprecations
> > >   doc: Cope with the deprecation of AutoReporter
> > >   docs: fix numaperf.rst and add it to the doc tree
> > >   lib/list_sort: fix kerneldoc build error
> > >   docs: fix multiple doc build warnings in enumeration.rst
> > >   docs/gpu: fix a documentation build break in i915.rst
> > >   docs: Fix conf.py for Sphinx 2.0
> > > 
> > > Mauro Carvalho Chehab (1):
> > >   scripts/sphinx-pre-install: make it handle Sphinx versions
> > > 
> > >  Documentation/admin-guide/mm/index.rst        |  1 +
> > >  Documentation/admin-guide/mm/numaperf.rst     |  2 +-
> > >  Documentation/conf.py                         |  2 +-
> > >  .../firmware-guide/acpi/enumeration.rst       |  2 +-
> > >  Documentation/gpu/i915.rst                    |  4 +-
> > >  Documentation/sphinx/kerneldoc.py             | 44 +++++++---
> > >  Documentation/sphinx/kernellog.py             | 28 +++++++
> > >  Documentation/sphinx/kfigure.py               | 40 +++++----
> > >  lib/list_sort.c                               |  3 +-
> > >  scripts/sphinx-pre-install                    | 81 +++++++++++++++++--
> > >  10 files changed, 166 insertions(+), 41 deletions(-)
> > >  create mode 100644 Documentation/sphinx/kernellog.py
> > > 
> > > -- 
> > > 2.21.0
> > >   
> > 
> > Thanks for the efforts. I've run this on top of Linus' tree, and the
> > only sphinx-related deprecation warning I've spotted is this one:
> > 
> > /home/onatalen/work/src/linux/Documentation/sphinx/cdomain.py:51: RemovedInSphinx30Warning: app.override_domain() is deprecated. Use app.add_domain() with override option instead.
> >   app.override_domain(CDomain)
> > 
> > Otherwise, it builds.
> > 
> 
> Just sent a fix. Could you please test?
> 
> 
> https://lore.kernel.org/lkml/b38a9fdfdcda49b2c6118072afac564e96406800.1558608217.git.mchehab+samsung@kernel.org/T/#u

Yes, now it's fine. Thanks.

> 
> Thanks,
> Mauro

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
