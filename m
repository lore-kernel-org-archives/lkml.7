Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692ACC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A02217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfEXE5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:57:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44973 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfEXE5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:57:14 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4O4v8jX006709
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 May 2019 00:57:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 57DED420481; Fri, 24 May 2019 00:57:08 -0400 (EDT)
Date:   Fri, 24 May 2019 00:57:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
Message-ID: <20190524045708.GH2532@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20190522193011.GB21412@chatter.i7.local>
 <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
 <20190522195804.GC21412@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522195804.GC21412@chatter.i7.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 03:58:04PM -0400, Konstantin Ryabitsev wrote:
> > If the report is public, and lists like vger are public,
> > then using a Reported-by: and/or a Link: are simply useful
> > history and tracking information.
> 
> I'm perfectly fine with Link:, however Reported-By: usually has the person's
> name and email address (i.e. PII data per GDPR definition). If that pehrson
> submitted the bug report via bugzilla.kernel.org or a similar resource,
> their expectation is that they can delete their account should they choose
> to to do so. However, if the patch containing Reported-By is committed to
> git, their PII becomes permanently and immutably recorded for any reasonable
> meaning of the word "forever."

Many (most?) bugzilla.kernel.org components result in e-mail getting
sent to vger.kernel.org mailing lists.  So even if they delete the
bugzilla account, there e-mail will be immortalized in lore.kernel.org
and their associated git repositories.

So perhaps a better approach is to put a warning alerting bug
reporters that submitting a bug means their e-mail will end up get
broadcasting in public mailing list archives and public git
repositories?

I assume distro engineers who are fixing bugs from their Distro
bugzillas which support non-public bugs already know that they
shouldn't be revealing their customers' identities.  But
realistically, while I agree it would be nice to ask people if they
don't mind being immortalized in git repositories, we should probably
warn people that when they submit a bug, or for that matter, send
e-mail to a kernel mailing list, they're going to be immortalized in a
git repository *already*.

						- Ted
