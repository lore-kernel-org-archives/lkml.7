Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723ECC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0CE20644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfGNSMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 14:12:43 -0400
Received: from mother.openwall.net ([195.42.179.200]:33777 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728218AbfGNSMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:12:43 -0400
Received: (qmail 28208 invoked from network); 14 Jul 2019 18:06:01 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 14 Jul 2019 18:06:01 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 5AED8AB5B3; Sun, 14 Jul 2019 20:05:55 +0200 (CEST)
Date:   Sun, 14 Jul 2019 20:05:55 +0200
From:   Solar Designer <solar@openwall.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        keescook@chromium.org, peterz@infradead.org, tyhicks@canonical.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: provide more information about linux-distros
Message-ID: <20190714180555.GA8536@openwall.com>
References: <20190711163637.30327-1-sashal@kernel.org> <20190711170732.GB7544@kroah.com> <20190711170921.ywi43n262s3ckxpi@willie-the-truck> <20190711203500.GB10104@sasha-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711203500.GB10104@sasha-vm>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 04:35:00PM -0400, Sasha Levin wrote:
> On Thu, Jul 11, 2019 at 06:09:21PM +0100, Will Deacon wrote:
> >On Thu, Jul 11, 2019 at 07:07:32PM +0200, Greg KH wrote:
> >>On Thu, Jul 11, 2019 at 12:36:37PM -0400, Sasha Levin wrote:
> >>> Provide more information about how to interact with the linux-distros
> >>> mailing list for disclosing security bugs.
> >>>
> >>> First, clarify that the reporter must read and accept the linux-distros
> >>> policies prior to sending a report.
> >>>
> >>> Second, clarify that the reported must provide a tentative public
> >>> disclosure date and time in his first contact with linux-distros.
> >>>
> >>> Suggested-by: Solar Designer <solar@openwall.com>
> >>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >>> ---
> >>>  Documentation/admin-guide/security-bugs.rst | 21 +++++++++++++--------
> >>>  1 file changed, 13 insertions(+), 8 deletions(-)

Thanks.  Sasha's proposed changes do address the two issues I pointed
out, so are an improvement.  However:

> >>Do we really need to describe all of the information on how to use the
> >>distro list here?  That's why we included the link, as it has all of
> >>this well spelled out and described.  If anything, I would say we should
> >>say less in this document about what linux-distros do, as that is
> >>independent of the Linux security team.
> >
> >Agreed, and it also means that any changes linux-distros make to their
> >policy won't be reflecting in the numerous kernel trees out there, so a
> >link is much better imo.

I also agree with this.

> I agree that the 2nd part about embargo timelines is redundant, but I
> only addressed it because the document was already addressing embargos.
> 
> I only now realized that the link we had there was just going to the
> main wiki page by mistake: the tag it was trying to point to was removed
> from the wiki page. We should probably update that too.
> 
> With regards to the explicit instruction to agree with policies, I think
> we do need it there. Right now this section reads as "for embargoes work
> with linux-distros@vs.openwall.org, and btw they have a wiki which you
> may or may not need to read".

Yes, we should update the link, but maybe we should also drop the
posting e-mail address, which will ensure someone will have to check out
the link before they're able to post.  This should allow us to drop the
summary of linux-distros policy and posting instructions, although maybe
they're beneficial to keep if we're confident we'd be maintaining this
summary to reflect possible changes on the linked page.

> We probably do need to stress here that linux-distros has different
> policies than security@kernel.org.

OK.

Alexander
