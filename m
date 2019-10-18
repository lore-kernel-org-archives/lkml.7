Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C8CCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD19222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634337AbfJRPdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:33:33 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:44671 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410630AbfJRPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:33:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 760951B268D1B;
        Fri, 18 Oct 2019 15:33:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rest37_758ca69fedf36
X-Filterd-Recvd-Size: 2388
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Oct 2019 15:33:27 +0000 (UTC)
Message-ID: <5348febc85ad3460f4e06ff11bf58ec70f6b3a48.camel@perches.com>
Subject: Re: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Vadim Bendebury <vbendeb@chromium.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 08:33:26 -0700
In-Reply-To: <CANiq72m0V5CBxp97Q4h70Gup1DCoZj4ZFa6VWQLk0jyurxeztQ@mail.gmail.com>
References: <20191016082430.5955-1-poeschel@lemonage.de>
         <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
         <20191017080741.GA17556@lem-wkst-02.lemonage>
         <CANiq72m0V5CBxp97Q4h70Gup1DCoZj4ZFa6VWQLk0jyurxeztQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-18 at 17:08 +0200, Miguel Ojeda wrote:
> On Thu, Oct 17, 2019 at 10:07 AM Lars Poeschel <poeschel@lemonage.de> wrote:
[]
> > Oh by the way: Do you know what I can do to make checkpatch happy with
> > its describing of the config symbol ? I tried writing a help paragraph
> > for the config symbols in Kconfig, but that did not help.
> 
> CC'ing Joe.

add
	--ignore=CONFIG_DESCRIPTION
or
	--min-conf-desc-length=1 (default is 4)

to the checkpatch command line, or just ignore it.

AK: I guess there's still some debate as to the proper
minimum length of a Kconfig help section paragraph.

commit 3354957a4f8b9bb4b43625232acdf0626851c82f
Author: Andi Kleen <ak@linux.intel.com>
Date:   Mon May 24 14:33:29 2010 -0700

    checkpatch: add check for too short Kconfig descriptions
    
    I've seen various new Kconfigs with rather unhelpful one liner
    descriptions.  Add a Kconfig warning for a minimum length of the Kconfig
    help section.
    
    Right now I arbitarily chose 4. The exact value can be debated.
 

