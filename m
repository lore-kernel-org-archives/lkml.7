Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC738C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC6623407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfH3SBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:01:33 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:57059 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727246AbfH3SBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:01:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EA4F8180238A6;
        Fri, 30 Aug 2019 18:01:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mint24_d3d3ba433a38
X-Filterd-Recvd-Size: 2856
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 18:01:30 +0000 (UTC)
Message-ID: <a8afdbf13db47e7650473c7f71384f177f3dff59.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove obsolete period from "ambiguous
 SHA1" query
From:   Joe Perches <joe@perches.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 11:01:29 -0700
In-Reply-To: <20190830171731.GB15405@linux.intel.com>
References: <20190830163103.15914-1-sean.j.christopherson@intel.com>
         <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
         <20190830171731.GB15405@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 10:17 -0700, Sean Christopherson wrote:
> On Fri, Aug 30, 2019 at 09:37:51AM -0700, Joe Perches wrote:
> > On Fri, 2019-08-30 at 09:31 -0700, Sean Christopherson wrote:
> > > Git dropped the period from its "ambiguous SHA1" error message in commit
> > > 0c99171ad2 ("get_short_sha1: mark ambiguity error for translation"),
> > > circa 2016.  Drop the period from checkpatch's associated query so as to
> > > match both the old and new error messages.
> > > 
> > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > ---
> > >  scripts/checkpatch.pl | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 93a7edfe0f05..ef3642c53100 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -962,7 +962,7 @@ sub git_commit_info {
> > >  
> > >  	return ($id, $desc) if ($#lines < 0);
> > >  
> > > -	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
> > > +	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous/) {
> > >  # Maybe one day convert this block of bash into something that returns
> > >  # all matching commit ids, but it's very slow...
> > >  #
> > 
> > Thanks.
> > 
> > Did git ever change to actually support human readable
> > messages in multiple languages?
> 
> Yep, e.g.:
> 
>   error: Kurzer SHA-1 745f ist mehrdeutig.
> 
> > If so, this won't work for non-english output.
> 
> Yep again.  The next check for 'fatal: ambiguous argument' obviously fails
> as well and checkpatch ends up using git's error message as the id and
> description.
> 
>   ERROR: Please use git ... - ie: 'commit error: Kurze ("")'

Does git exit with unique failure codes?
If so, maybe the waitid/siginfo_t error could be used instead.


