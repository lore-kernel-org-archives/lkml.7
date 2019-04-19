Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD94C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C592171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555707840;
	bh=tT8a0hMsSQ0YyLXya2F2hbc7P7S1+/rh8wg7HPWKRzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g9YshBRwytN6KdPp61aX2g2zIcu7SYrdFqiVFaQhfH+oEJhCOwmelPXxXMoSwE+nT
	 PbIvYdU5sijlSwJptL+lOBbX90wIMJCWUEx4rvmFvtckiD0FYvF2j99PVJ5uf6GEGa
	 yGjWn0fhJBdbKuvuX7oedUabDYruJT33GggwrljU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfDSVD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:03:58 -0400
Received: from casper.infradead.org ([85.118.1.10]:39858 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AQ19LFwVTjtH/+6i4GAAIQgmeJLnXakChake00M6d3E=; b=u9E/KHxxrDNXuAgARNyTWdqYQZ
        PvqYcYCK489DM67JjEGQq0JY/mEmWSD1fv0JgaMubtBFzKXz+vvaMy5OgIIWPyJUx+5Jj6JS8SJoh
        su0DC3164wWvPusfOk84evgU0MnZlR4liClnCOKPvJQ2A5Y2gChGGzd97GGUwfg8S4q0jgsC0LxJt
        jhKTXnLuRU1y7SvTs/VLS1U89q9nB6h2wBYMpmCTQEeFGVotwuL/u64cZxQOeQ8PryZ7eH9l7cCSv
        A0vhL71Iuh3hK92iwfE70fBHnMsVUUz+l1kHCXsT+3qzO9MppFPAqewVGd6JbaZ/dTfd+eAfAzfF0
        CyqO/vLw==;
Received: from 177.18.24.91.dynamic.adsl.gvt.net.br ([177.18.24.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHQk9-0004qq-Lt; Fri, 19 Apr 2019 10:27:42 +0000
Date:   Fri, 19 Apr 2019 07:27:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: hwmon: convert three docs to ReST format
Message-ID: <20190419072735.46f26b87@coco.lan>
In-Reply-To: <877ebqgv79.fsf@intel.com>
References: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555580417.git.mchehab+samsung@kernel.org>
        <87k1frgysq.fsf@intel.com>
        <20190418151028.341723f7@coco.lan>
        <877ebqgv79.fsf@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 19 Apr 2019 13:12:26 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Thu, 18 Apr 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > Em Thu, 18 Apr 2019 17:42:29 +0300
> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >  
> >> On Thu, 18 Apr 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:  
> >> > Those three new drivers were missed on the initial conversion
> >> > to ReST format. So:
> >> >
> >> > - Rename them to .rst;
> >> > - Add them to the hwmon index.rst index;
> >> > - add some blank lines at the "Supported systems:" part, in
> >> >   order to allow Sphinx to properly identify new lines,
> >> >   suppressing warnings and avoid it to output some random
> >> >   lines in bold;
> >> > - When multiple authors are involved, change the authors
> >> >   part to a list, in order to avoid adding blank lines.
> >> > - adjust the table cells (one of the tables seemed to be
> >> >   assuming that tab is 4 positions instead of 8) and add
> >> >   the table markup.
> >> > - be sure that the section markups have the same number of
> >> >   characters as the section title.
> >> >
> >> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> >> > ---
> >> >  Documentation/hwmon/index.rst                 |  3 +++
> >> >  Documentation/hwmon/{ir38064 => ir38064.rst}  | 21 ++++++++++++-------
> >> >  .../hwmon/{isl68137 => isl68137.rst}          | 16 ++++++++++----
> >> >  .../hwmon/{lochnagar => lochnagar.rst}        |  7 +++++--
> >> >  4 files changed, 33 insertions(+), 14 deletions(-)
> >> >  rename Documentation/hwmon/{ir38064 => ir38064.rst} (76%)
> >> >  rename Documentation/hwmon/{isl68137 => isl68137.rst} (85%)
> >> >  rename Documentation/hwmon/{lochnagar => lochnagar.rst} (93%)
> >> >
> >> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> >> > index 893804414510..3fa14fe7b49c 100644
> >> > --- a/Documentation/hwmon/index.rst
> >> > +++ b/Documentation/hwmon/index.rst
> >> > @@ -65,6 +65,8 @@ Hardware Monitoring Kernel Drivers
> >> >     ina2xx.rst
> >> >     ina3221.rst
> >> >     ir35221.rst
> >> > +   ir38064.rst
> >> > +   isl68137.rst    
> >> 
> >> Didn't notice it on the first patch adding index.rst, but I don't think
> >> it's customary to add .rst suffix to the toctree.  
> >
> > Provided that all documents are at the same time, I guess it
> > doesn't matter having a .rst there or not.  
> 
> Parse error. No other index.rst has the suffixes.

Actually, there are a few that has, including the doc-guide

$ git grep \\.rst $(find Documentation/ -name index.rst)|cut -d: -f1|sort|uniq
Documentation/admin-guide/mm/index.rst
Documentation/doc-guide/index.rst
Documentation/filesystems/ext4/index.rst
Documentation/filesystems/index.rst
Documentation/hwmon/index.rst
Documentation/translations/it_IT/doc-guide/index.rst
Documentation/translations/it_IT/kernel-hacking/index.rst
Documentation/translations/it_IT/process/index.rst
Documentation/translations/zh_CN/process/index.rst

(I'm looking at linux-next).

Clearly, the Documentation/doc-guide/index.rst has it:

=================================
How to write kernel documentation
=================================

.. toctree::
   :maxdepth: 1

   sphinx.rst
   kernel-doc.rst
   parse-headers.rst

Anyway I'll send a patch removing the extra .rst from hwmon, to
be applied after this one, and another one for the doc-guide.

> 
> > Btw, newer versions of Sphinx build can work with other formats
> > like markdown. I suspect that, if we end mixing markdown documents,
> > it would be worth having the extension there.
> >
> > FYI, someone recently added a markdown file at the tree:
> >
> > commit e453fa60e086786fe89ba15ee8fef80bc2e6ecc3
> > Author: Sascha Hauer <s.hauer@pengutronix.de>
> > Date:   Fri Sep 7 14:36:46 2018 +0200
> >
> >     Documentation: ubifs: Add authentication whitepaper
> >
> > 	Documentation/filesystems/ubifs-authentication.md
> >
> > IMO, the best would be to just run pandoc into it and convert
> > to .rst, than to mix different markup languages.  
> 
> Agreed. I'd rather we keep it all rst.
> 
> BR,
> Jani.
> 
> 



Thanks,
Mauro
