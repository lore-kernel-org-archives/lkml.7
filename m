Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428CAC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0816120665
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfGSIm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:42:26 -0400
Received: from mother.openwall.net ([195.42.179.200]:54143 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726036AbfGSIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:42:26 -0400
Received: (qmail 23955 invoked from network); 19 Jul 2019 08:42:23 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 19 Jul 2019 08:42:23 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 6D080AB5B3; Fri, 19 Jul 2019 10:42:15 +0200 (CEST)
Date:   Fri, 19 Jul 2019 10:42:15 +0200
From:   Solar Designer <solar@openwall.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sasha Levin <sashal@kernel.org>, corbet@lwn.net, will@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/security-bugs: provide more information about linux-distros
Message-ID: <20190719084215.GA24691@openwall.com>
References: <20190717231103.13949-1-sashal@kernel.org> <201907181457.D61AC061C@keescook> <20190719003919.GC4240@sasha-vm> <201907181833.EF0D93C@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907181833.EF0D93C@keescook>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:51:07PM -0700, Kees Cook wrote:
> On Thu, Jul 18, 2019 at 08:39:19PM -0400, Sasha Levin wrote:
> > On Thu, Jul 18, 2019 at 03:00:55PM -0700, Kees Cook wrote:
> > > On Wed, Jul 17, 2019 at 07:11:03PM -0400, Sasha Levin wrote:
> > > > Provide more information about how to interact with the linux-distros
> > > > mailing list for disclosing security bugs.
> > > > 
> > > > Reference the linux-distros list policy and clarify that the reporter
> > > > must read and understand those policies as they differ from
> > > > security@kernel.org's policy.
> > > > 
> > > > Suggested-by: Solar Designer <solar@openwall.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > 
> > > Sorry, but NACK, see below...

I like Sasha's PATCH v2 better, but if Kees insists on NACK'ing it then
I suggest that we apply Sasha's first revision of the patch instead.
I think either revision is an improvement on the status quo.

> I think reinforcing information to avoid past mistakes is appropriate
> here.

Maybe, but from my perspective common past issues with Linux kernel bugs
reported to linux-distros were:

- The reporter having been directed to post from elsewhere (and I
suspect this documentation file) without being aware of list policy.

- The reporter not mentioning (and sometimes not replying even when
asked) whether they're also coordinating with security@k.o or whether
they want someone on linux-distros to help coordinate with security@k.o.
(Maybe this is something we want to write about here.)

- The Linux kernel bug having been introduced too recently to be of much
interest to distros.

> Reports have regularly missed the "[vs]" detail or suggested
> embargoes that ended on Fridays, etc.

This happens too.  Regarding missing the "[vs]" detail, technically
there are also a number of other conditions that also let the message
through, but those are changing and are deliberately not advertised.

> Sending to the distros@ list risks exposing Linux-only flaws to non-Linux
> distros.

Right.

> This has caused leaks in the past

Do you mean leaks to *BSD security teams or to the public?  I'm not
aware of past leaks to the public via the non-Linux distros present on
the distros@ list.  Are you?

Alexander
