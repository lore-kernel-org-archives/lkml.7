Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD46BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8606E206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611499;
	bh=qB/Vh3kd5u9xuDMWkg6bSqTMWbGkr/mNbtBDoaojIiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xFAYRej6fZTRpkLtjkAJekWVpsy/L8Z3NrcZSIUwp2pYHWrs9GCxCzJjZGv38IZHl
	 1B+G1+3P2VYm7Dl8zC8FnC2NqdDpokqvw4u42+OtaHBrEmHbS4u66e3yX97grJTEcu
	 vmGfizSI7Hn7piGFVsC58R0ok8Gdjiurt6Sn0YNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404165AbfDRSKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:44 -0400
Received: from casper.infradead.org ([85.118.1.10]:52346 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391603AbfDRSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q97wY6btVCHy/kFofHI09uzvbtwu21iq5Uz5kIDdyws=; b=urJdq4JxwV4eFQA2l8/RVg4szk
        /MBfg0DCCjnUbMwm3panxmAoIN7YgOQgTN8RO8Bv5+//absL/8MJBesC7NeU5eJ1Vr/L1Yt/w8ZD2
        Fsb6qhmrYMqmN8cJL/gEMzOHcxKQWEBD+hp57z/RQ8sx/Si44CzGGaNng7DGufNBXVYW7QHO7OsmG
        H0u2IzZeSGqWLI1k1T+mQtgT1Oqm1iwTGi/CxyVSpQoENW6HLSnt7KK6o0J2fiNcA4voLFShnaAod
        +lyxyCitOLNndxBhrPTs0xsKa1KOztFaWmiQfJ8ctlg1/J11PCDy00pi1byCZ7L/N8KBi4rsxl4bd
        Gv8RcjHw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHBUX-0005MG-Iw; Thu, 18 Apr 2019 18:10:34 +0000
Date:   Thu, 18 Apr 2019 15:10:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: hwmon: convert three docs to ReST format
Message-ID: <20190418151028.341723f7@coco.lan>
In-Reply-To: <87k1frgysq.fsf@intel.com>
References: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555580417.git.mchehab+samsung@kernel.org>
        <87k1frgysq.fsf@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 18 Apr 2019 17:42:29 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Thu, 18 Apr 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > Those three new drivers were missed on the initial conversion
> > to ReST format. So:
> >
> > - Rename them to .rst;
> > - Add them to the hwmon index.rst index;
> > - add some blank lines at the "Supported systems:" part, in
> >   order to allow Sphinx to properly identify new lines,
> >   suppressing warnings and avoid it to output some random
> >   lines in bold;
> > - When multiple authors are involved, change the authors
> >   part to a list, in order to avoid adding blank lines.
> > - adjust the table cells (one of the tables seemed to be
> >   assuming that tab is 4 positions instead of 8) and add
> >   the table markup.
> > - be sure that the section markups have the same number of
> >   characters as the section title.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/hwmon/index.rst                 |  3 +++
> >  Documentation/hwmon/{ir38064 => ir38064.rst}  | 21 ++++++++++++-------
> >  .../hwmon/{isl68137 => isl68137.rst}          | 16 ++++++++++----
> >  .../hwmon/{lochnagar => lochnagar.rst}        |  7 +++++--
> >  4 files changed, 33 insertions(+), 14 deletions(-)
> >  rename Documentation/hwmon/{ir38064 => ir38064.rst} (76%)
> >  rename Documentation/hwmon/{isl68137 => isl68137.rst} (85%)
> >  rename Documentation/hwmon/{lochnagar => lochnagar.rst} (93%)
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 893804414510..3fa14fe7b49c 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -65,6 +65,8 @@ Hardware Monitoring Kernel Drivers
> >     ina2xx.rst
> >     ina3221.rst
> >     ir35221.rst
> > +   ir38064.rst
> > +   isl68137.rst  
> 
> Didn't notice it on the first patch adding index.rst, but I don't think
> it's customary to add .rst suffix to the toctree.

Provided that all documents are at the same time, I guess it
doesn't matter having a .rst there or not.

Btw, newer versions of Sphinx build can work with other formats
like markdown. I suspect that, if we end mixing markdown documents,
it would be worth having the extension there.

FYI, someone recently added a markdown file at the tree:

commit e453fa60e086786fe89ba15ee8fef80bc2e6ecc3
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Fri Sep 7 14:36:46 2018 +0200

    Documentation: ubifs: Add authentication whitepaper

	Documentation/filesystems/ubifs-authentication.md

IMO, the best would be to just run pandoc into it and convert
to .rst, than to mix different markup languages.

Thanks,
Mauro
