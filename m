Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95EDC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9C72089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfJKOtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:49:32 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:36664 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbfJKOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:49:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B2613182CED34;
        Fri, 11 Oct 2019 14:49:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fire56_35c25ae377705
X-Filterd-Recvd-Size: 2749
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 14:49:29 +0000 (UTC)
Message-ID: <15ecc8a684334ee97b38d81a3af88e189d72ff21.camel@perches.com>
Subject: Re: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Oct 2019 07:49:28 -0700
In-Reply-To: <20191011120824.y52pbji6qx6rstjr@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
         <20191010202418.25098-6-rrichter@marvell.com>
         <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
         <20191011071920.3fb8c45c@coco.lan>
         <414f6658c088b9ac96ec4dad1ef751610dd83ce3.camel@perches.com>
         <20191011120824.y52pbji6qx6rstjr@rric.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 12:08 +0000, Robert Richter wrote:
> On 11.10.19 03:50:23, Joe Perches wrote:
> > On Fri, 2019-10-11 at 07:20 -0300, Mauro Carvalho Chehab wrote:
> > > Em Thu, 10 Oct 2019 15:10:53 -0700 Joe Perches <joe@perches.com> escreveu:
> > > > On Thu, 2019-10-10 at 20:25 +0000, Robert Richter wrote:
> > > > > Reduce the indentation level in edac_mc_handle_error() a bit by using
> > > > > continue. No functional changes.  
> > > > 
> > > > Seems fine, but trivially below:
> > > > 
> > > > > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c  
> > > > []
> > > > > @@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,  
> > > > []
> > > > > +		strcpy(p, dimm->label);
> > > > > +		p += strlen(p);
> > > > > +		*p = '\0';  
> > > > 
> > > > This *p = '\0' is unnecessary as the strcpy already did that.
> > > 
> > > True, but better to put it on a separate patch, as it makes
> > > easier to review if you don't mix code de-indent with changes.
> > > 
> > > Also, maybe there are other occurrences of this pattern.
> > 
> > Maybe 80 or so uses of paired
> > 
> > 	strcpy(foo, bar);
> > 	strlen(foo)
> > 
> > where another function like stpcpy, which doesn't exist
> > in the kernel, could have been used.
> 
> Under drivers/edac/ I found this one place only.
> 
> So I could create a separate patch as a oneliner with that (trivial)
> change?

Of course yes.

