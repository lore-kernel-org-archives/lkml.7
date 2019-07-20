Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B255C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4A20880
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbfGTDJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 23:09:23 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:52322 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729238AbfGTDJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 23:09:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 44B2818225E03;
        Sat, 20 Jul 2019 03:09:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lamp01_1756563093547
X-Filterd-Recvd-Size: 1773
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Jul 2019 03:09:20 +0000 (UTC)
Message-ID: <a91f850658e6d2ba206639e214ee47a0dcd90f38.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Improve SPDX license checking
From:   Joe Perches <joe@perches.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Jul 2019 20:09:19 -0700
In-Reply-To: <20190720122203.7baf841a@canb.auug.org.au>
References: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
         <f08eb62458407a145cfedf959d1091af151cd665.1563575364.git.joe@perches.com>
         <20190720122203.7baf841a@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-07-20 at 12:22 +1000, Stephen Rothwell wrote:
> Hi Joe,
> 
> On Fri, 19 Jul 2019 15:31:33 -0700 Joe Perches <joe@perches.com> wrote:
> > Use perl's m@<match>@ match and not /<match>/ comparisons to avoid
> > an error using c90's // comment style.
> > 
> > Miscellanea:
> > 
> > o Use normal tab indentation and alignment
> > 
> > Link: http://lkml.kernel.org/r/5e4a8fa7901148fbcd77ab391e6dd0e6bf95777f.camel@perches.com
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Again, don't include other's (non author's) SOB lines.

Nope.
You _already_ signed-off this patch.
I'm simply reproducing it.


