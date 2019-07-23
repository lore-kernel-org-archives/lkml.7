Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B30C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FED22543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfGWNdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:33:54 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:37552 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732181AbfGWNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:33:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D6461180273E0;
        Tue, 23 Jul 2019 13:33:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boys93_78379f489d811
X-Filterd-Recvd-Size: 2231
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 13:33:45 +0000 (UTC)
Message-ID: <269b4b895d64deef4a6d0033dcbed48da11fbce0.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Duda, Sebastian" <sebastian.duda@fau.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Date:   Tue, 23 Jul 2019 06:33:44 -0700
In-Reply-To: <CAKXUXMym7Sd28gVxVXj60XS+aoqM4DAtEp2aA7BUUu06YQYufg@mail.gmail.com>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
         <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
         <2835dfa18922905ffabafb11fca7e1d2@fau.de>
         <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
         <8016ee9b5ee38fae0c782420ca449f863270cca9.camel@perches.com>
         <CAKXUXMym7Sd28gVxVXj60XS+aoqM4DAtEp2aA7BUUu06YQYufg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 15:25 +0200, Lukas Bulwahn wrote:
> Hi Joe,

Hi again.

> On Tue, Jul 23, 2019 at 1:18 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-07-23 at 10:42 +0200, Lukas Bulwahn wrote:
> [...]
> > > Joe, would you support and would you accept if we extend
> > > get_maintainer.pl to provide output of the status in such a way that
> > > the status output can be clearly mapped to the subsystem?
> > 
> > Not really, no.  I don't see much value in your
> > request to others.  It seems you are doing some
> > academic work rather than actually using it for
> > sending patches.
> > 
> 
> Thank you for that indication. It is good to know that our use case is
> too special to be covered in the existing tool and serves no one else
> besides our research work.

Seems a bit harsh a description, and yes, I've
not ever seen a single request similar to yours
to use get_maintainer in such a manner.


