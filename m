Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B35C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811712089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfEVUAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:00:25 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:56989 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731063AbfEVUAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:00:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 23506837F24A;
        Wed, 22 May 2019 20:00:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: peace94_1fea29cb36c22
X-Filterd-Recvd-Size: 1820
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 20:00:19 +0000 (UTC)
Message-ID: <05f565be52179acd1128b51a6e0cf055882ce78b.camel@perches.com>
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
From:   Joe Perches <joe@perches.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 13:00:17 -0700
In-Reply-To: <20190522195804.GC21412@chatter.i7.local>
References: <20190522193011.GB21412@chatter.i7.local>
         <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
         <20190522195804.GC21412@chatter.i7.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 15:58 -0400, Konstantin Ryabitsev wrote:
> On Wed, May 22, 2019 at 12:45:06PM -0700, Joe Perches wrote:
> > > It is common courtesy to include this tagline when submitting 
> > > patches:
> > > 
> > > Reported-By: J. Doe <jdoe@example.com>
> > > 
> > > Please ask the reporter's permission before doing so (even if they'd
> > > submitted a public bugzilla report or sent a report to the mailing
> > > list).
> > 
> > I disagree with this.
> > 
> > If the report is public, and lists like vger are public,
> > then using a Reported-by: and/or a Link: are simply useful
> > history and tracking information.
> 
> I'm perfectly fine with Link:, however Reported-By: usually has the 
> person's name and email address (i.e. PII data per GDPR definition).

So?

Like I wrote, if that report came from a public list, that
report _also_ contained the person's name and email address.


