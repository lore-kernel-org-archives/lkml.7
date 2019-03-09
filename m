Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFCAC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9770620866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCIEpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:45:42 -0500
Received: from namei.org ([65.99.196.166]:56226 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfCIEpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:45:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x294jaje024550;
        Sat, 9 Mar 2019 04:45:36 GMT
Date:   Sat, 9 Mar 2019 15:45:36 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 03/27] Enforce module signatures if the kernel is locked
 down
In-Reply-To: <CACdnJuvhPd2dD7cWkxP78YMMFKU3FsigLHgkDntwhnbamNZr-w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1903091544530.24498@namei.org>
References: <20190306235913.6631-1-matthewgarrett@google.com> <20190306235913.6631-4-matthewgarrett@google.com> <alpine.LRH.2.21.1903090959210.12052@namei.org> <CACdnJuvhPd2dD7cWkxP78YMMFKU3FsigLHgkDntwhnbamNZr-w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, Matthew Garrett wrote:

> On Fri, Mar 8, 2019 at 3:00 PM James Morris <jmorris@namei.org> wrote:
> >
> > On Wed, 6 Mar 2019, Matthew Garrett wrote:
> >
> > > From: David Howells <dhowells@redhat.com>
> > >
> > > If the kernel is locked down, require that all modules have valid
> > > signatures that we can verify.
> >
> > Perhaps note that this won't cover the case where folk are using DM-Verity
> > with a signed root hash for verifying kernel modules.
> 
> Mm. I can't see a terribly good way of doing this generically -
> loadpin gives no indication to the module loading code that it comes
> from a trusted source. Would making the lockdown/module signature
> enforcement a separate config option be reasonable?

I was just suggest documenting this.

-- 
James Morris
<jmorris@namei.org>

