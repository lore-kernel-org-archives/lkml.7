Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74924C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEF8218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfCUO0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:26:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:30664 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUO0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:26:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 07:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="128931688"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2019 07:26:23 -0700
Date:   Thu, 21 Mar 2019 07:26:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] docs: Explicitly state ordering requirements for
 Co-developed-by
Message-ID: <20190321142622.GA6519@linux.intel.com>
References: <20190320151140.32432-1-sean.j.christopherson@intel.com>
 <87lg18e4nx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg18e4nx.fsf@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:30:10PM +0200, Jani Nikula wrote:
> On Wed, 20 Mar 2019, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > Per Thomas' yet-to-be-merged "tip tree handbook"[1], Co-developed-by and
> > Signed-off-by must be paired together, i.e. the co-authors' SOB mustn't
> > be scattered willy-nilly, and the author's SOB must be the first SOB
> > *after* the last Co-developed-by/Signed-off-by pair.  Provide an example
> > to eliminate any ambiguity.
> >
> > [1] http://lkml.kernel.org/r/20181107171149.165693799@linutronix.de
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Niklas Cassel <niklas.cassel@linaro.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  Documentation/process/submitting-patches.rst | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index be7d1829c3af..f4b5c4850601 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -547,8 +547,13 @@ have been included in the discussion.
> >  
> >  A Co-developed-by: states that the patch was also created by another developer
> >  along with the original author.  This is useful at times when multiple people
> > -work on a single patch.  Note, this person also needs to have a Signed-off-by:
> > -line in the patch as well.
> > +work on a single patch.  Note, Co-developed-by: must be accompanied by a
> > +Signed-off-by: of the co-author(s).  All Co-developed-by:/Signed-off-by: pairs
> > +must precede the Signed-off-by: of the original author.
> > +
> > +	Co-developed-by: Random Co-Author <random@coauthor.example.org>
> > +	Signed-off-by: Random Co-Author <random@coauthor.example.org>
> > +	Signed-off-by: Original Author <original@author.example.org>
> 
> Seems to me this suggests Original Author is involved in the patch from
> start to finish, and then gives Random Co-Author credit as well.
> 
> IME it's more common for the Original Author to write a patch, and
> Random Co-Author to take over, finishing the job. Chronologically in
> this case I'd put the sign-offs the other way round.

Hmm, and my experience is exclusively limited to contributing code to
someone else's patches.  Rather than dictate exact ordering, what about
deferring to standard sign-off procedure?

E.g.:

  A Co-developed-by: states that the patch was also created by another developer
  along with the original author.  This is useful at times when multiple people
  work on a single patch.  Co-developed-by: must be immediately followed by a
  Signed-off-by: of the co-author(s).  As per standard sign-off procedure, the
  ordering of Co-developed-by:/Signed-off-by: pairs should reflect the patch's
  handling insofar as possible.  Notably, the last Signed-off-by: must always be
  that of the developer submitting the patch, regardless of whether they are the
  original author or a co-author.
