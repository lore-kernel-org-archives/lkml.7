Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9DEC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20873208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfFZPgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:36:37 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:55605 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbfFZPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:36:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CBB8E18225DEA;
        Wed, 26 Jun 2019 15:36:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pest84_397bcb5d8fa2a
X-Filterd-Recvd-Size: 2614
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Jun 2019 15:36:34 +0000 (UTC)
Message-ID: <b007126ee329ba5094d84f0af91c0c8eafecbed4.camel@perches.com>
Subject: Re: [PATCH v2] get_maintainer: Add --prefix option
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Jun 2019 08:36:33 -0700
In-Reply-To: <20190626093635.GK3419@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
         <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
         <20190625163701.xcb2ue7phpskvfnz@linutronix.de>
         <8d416a7b0dad3933ceb8d12c9efaad541f7cf269.camel@perches.com>
         <20190626093635.GK3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 11:36 +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2019 at 10:23:34AM -0700, Joe Perches wrote:
[]
> > I want to proposed patches to moderated lists
> > and believe everyone really should too.
> > 
> > I don't care if moderated lists send a
> > "waiting for moderation" message as long as the
> > list gets the proposed patch eventually.
> > 
> > I think only Peter cares about those, to him,
> > superfluous "being moderated" messages.
> 
> I'm really not alone in that. Not only do you get those annoying
> messages, the people reading that list might get the discussion in
> fragments, because some people that reply are subscribed and do not
> require moderation while others do get caught in the moderation thing
> and then delayed.

<shrug> email moderation time is up to any moderator.

> It also puts a burden on the moderator, do they allow the whole
> discussion or only part. What if they deem the thing off-topic and want
> to kill it, but then some of their whitelisted people do reply.

Please remember any moderated list entries originate here
by using get_maintainers.pl for a proposed patch or discuss
a particular subsystem.

If a moderator of a list decides an email chain about a
patch is somehow off-topic and does not forward the email,
likely that moderated list should be removed from MAINTAINERS.

Under what use case would you want to use get_maintainer and
_not_ cc a particular mailing list?


