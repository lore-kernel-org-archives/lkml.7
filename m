Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E397C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E272070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfFRNRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:17:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:50292 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFRNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:17:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D6F1E380;
        Tue, 18 Jun 2019 13:17:18 +0000 (UTC)
Date:   Tue, 18 Jun 2019 07:17:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: platform: convert
 x86-laptop-drivers.txt to reST
Message-ID: <20190618071717.2132a1b7@lwn.net>
In-Reply-To: <20190618054158.GA3713@kroah.com>
References: <20190618053227.31678-1-puranjay12@gmail.com>
        <20190618054158.GA3713@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 07:41:58 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jun 18, 2019 at 11:02:27AM +0530, Puranjay Mohan wrote:
> > This converts the plain text documentation to reStructuredText format.
> > No essential content change.
> > 
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  Documentation/platform/x86-laptop-drivers.rst | 23 +++++++++++++++++++
> >  Documentation/platform/x86-laptop-drivers.txt | 18 ---------------
> >  2 files changed, 23 insertions(+), 18 deletions(-)
> >  create mode 100644 Documentation/platform/x86-laptop-drivers.rst
> >  delete mode 100644 Documentation/platform/x86-laptop-drivers.txt  
> 
> Don't you also need to hook it up to the documentation build process
> when doing this?

Hooking it into the TOC tree is a good thing, but I think it's also good
to think about the exercise in general.  This is a document dropped into
place five years ago and never touched again.  It's a short list of
seemingly ancient laptops with no explanation of what it means.  So the
real question, IMO, is whether this document is useful to anybody and, if
not, whether it should just be deleted instead.

Puranjay, thanks for working to improve the kernel docs!  Please don't be
discouraged by this response - it's just a sign that kernel documentation
has problems far beyond just formatting...

Thanks,

jon
