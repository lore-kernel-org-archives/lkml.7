Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB9C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A5520862
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389331AbfEXPGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:06:53 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:51211 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388995AbfEXPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:06:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 94BB718224D9C;
        Fri, 24 May 2019 15:06:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feet66_3bc40e256854e
X-Filterd-Recvd-Size: 2638
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 May 2019 15:06:50 +0000 (UTC)
Message-ID: <ee5c9928d7193436735bf766fb3c1fce81241bf5.camel@perches.com>
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
From:   Joe Perches <joe@perches.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Date:   Fri, 24 May 2019 08:06:49 -0700
In-Reply-To: <20190524125402.GA616@chatter.i7.local>
References: <20190522193011.GB21412@chatter.i7.local>
         <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
         <20190522195804.GC21412@chatter.i7.local> <20190524045708.GH2532@mit.edu>
         <20190524125402.GA616@chatter.i7.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 08:54 -0400, Konstantin Ryabitsev wrote:
> On Fri, May 24, 2019 at 12:57:08AM -0400, Theodore Ts'o wrote:
> > > I'm perfectly fine with Link:, however Reported-By: usually has the 
> > > person's
> > > name and email address (i.e. PII data per GDPR definition). If that pehrson
> > > submitted the bug report via bugzilla.kernel.org or a similar resource,
> > > their expectation is that they can delete their account should they choose
> > > to to do so. However, if the patch containing Reported-By is committed to
> > > git, their PII becomes permanently and immutably recorded for any reasonable
> > > meaning of the word "forever."
> > 
> > Many (most?) bugzilla.kernel.org components result in e-mail getting
> > sent to vger.kernel.org mailing lists.  So even if they delete the
> > bugzilla account, there e-mail will be immortalized in lore.kernel.org
> > and their associated git repositories.
> 
> I wouldn't say that most -- to my knowledge, it's only about 5-6 
> components of the 50+. It's hard to tell how much that is by volume, 
> though, because certainly not all components see much activity.
> 
> We *can* excise things on lore.kernel.org. It's a massive pain, since 
> message archive is a git repository itself, so will need to be rebased, 
> reindexed and remirrored -- but it *is* possible.

It's likely not a worthwhile pain to self-inflict because
lore.kernel.org is not the only public vger mailing list archive.

https://lkml.org/
https://www.spinics.net/lists/kernel/
http://lkml.iu.edu/hypermail/linux/kernel/
https://marc.info/?l=linux-kernel

etc...


