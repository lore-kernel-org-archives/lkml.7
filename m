Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B33C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EE12070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfE2Mai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2Mai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:30:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 151F46147C;
        Wed, 29 May 2019 12:30:38 +0000 (UTC)
Received: from treble (ovpn-123-24.rdu2.redhat.com [10.10.123.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A75411001E71;
        Wed, 29 May 2019 12:30:33 +0000 (UTC)
Date:   Wed, 29 May 2019 07:30:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@redhat.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Oops caused by race between livepatch and ftrace
Message-ID: <20190529123031.vaz6ze7tjekcbebl@treble>
References: <90f78070-95ec-ce49-1641-19d061abecf4@redhat.com>
 <20190520210905.GC1646@sventech.com>
 <20190520211931.vokbqxkx5kb6k2bz@treble>
 <20190520173910.6da9ddaf@gandalf.local.home>
 <20190521141629.bmk5onsaab26qoaw@treble>
 <20190521104204.47d4e175@gandalf.local.home>
 <20190521164227.bxdff77kq7fgl5lp@treble>
 <20190521125319.04ac8b6c@gandalf.local.home>
 <nycvar.YFH.7.76.1905291315310.1962@cbobk.fhfr.pm>
 <20190529080648.0e001bfd@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529080648.0e001bfd@oasis.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 29 May 2019 12:30:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:06:48AM -0400, Steven Rostedt wrote:
> On Wed, 29 May 2019 13:17:21 +0200 (CEST)
> Jiri Kosina <jikos@kernel.org> wrote:
> 
> > > > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > Subject: [PATCH] livepatch: Fix ftrace module text permissions race  
> > > 
> > > Thanks,
> > > 
> > > I'll try to find some time to test this as well.  
> > 
> > Steve, Jessica, any final word on this?
> 
> I was under the impression that Josh was going to send an updated
> patch (and a properly sent one). Patches embedded in other emails don't
> get flagged by my internal patchwork, so they usually get ignored.

Yeah, I actually have a newer version of the patch in my queue.  I'll
try to send it out shortly.

-- 
Josh
