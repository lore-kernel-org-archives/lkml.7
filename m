Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05CCC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AFA20823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560865194;
	bh=70c0tfx2NKpPi9Gpr2q7gCR4QPX5rIxB+dP6jDanaxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y4/fZLj6809poCtZLtSMFFRRX2ZO197sN1N+px/ncutL8fYOUtp1Mrh4+BMjPFO7a
	 fvGJjv/CL0Qh1kElHhTSywgi5SOK4JhAzjMNJl078Sj+yIV7O7ZU+kpAYNXB4I51XK
	 k8yE5phfomwip8AVfqqxcTUMRgcpBJXUJpVMvbg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfFRNjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFRNjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:39:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB40520823;
        Tue, 18 Jun 2019 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560865191;
        bh=70c0tfx2NKpPi9Gpr2q7gCR4QPX5rIxB+dP6jDanaxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jz1v+Fs9V1Xn8xJhqc+0MBMnEX0Tauy2tNQtP4QpgHbatyu2r3lUTxIXU3VlBa9Ay
         PW4bMxlasbWVFCOeYJYmJfb3FG2Q67RhuuiSHeVrDv+TdKjwV4kK13Rc65ZCI+orMh
         VQLAVkCAQGU0LwjFV56bsvPkuIJq8Rw6LCNc8H1M=
Date:   Tue, 18 Jun 2019 15:39:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: platform: convert
 x86-laptop-drivers.txt to reST
Message-ID: <20190618133948.GB5416@kroah.com>
References: <20190618053227.31678-1-puranjay12@gmail.com>
 <20190618054158.GA3713@kroah.com>
 <20190618071717.2132a1b7@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618071717.2132a1b7@lwn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:17:17AM -0600, Jonathan Corbet wrote:
> On Tue, 18 Jun 2019 07:41:58 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jun 18, 2019 at 11:02:27AM +0530, Puranjay Mohan wrote:
> > > This converts the plain text documentation to reStructuredText format.
> > > No essential content change.
> > > 
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > ---
> > >  Documentation/platform/x86-laptop-drivers.rst | 23 +++++++++++++++++++
> > >  Documentation/platform/x86-laptop-drivers.txt | 18 ---------------
> > >  2 files changed, 23 insertions(+), 18 deletions(-)
> > >  create mode 100644 Documentation/platform/x86-laptop-drivers.rst
> > >  delete mode 100644 Documentation/platform/x86-laptop-drivers.txt  
> > 
> > Don't you also need to hook it up to the documentation build process
> > when doing this?
> 
> Hooking it into the TOC tree is a good thing, but I think it's also good
> to think about the exercise in general.  This is a document dropped into
> place five years ago and never touched again.  It's a short list of
> seemingly ancient laptops with no explanation of what it means.  So the
> real question, IMO, is whether this document is useful to anybody and, if
> not, whether it should just be deleted instead.

I bet it should be deleted, but we should ask the platform driver
maintainers first before we do that :)

thanks,

greg k-h
