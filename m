Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525F0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3626921882
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfIBPaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:30:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43218 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfIBPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:30:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i4oHM-0000An-6r; Mon, 02 Sep 2019 15:30:04 +0000
Date:   Mon, 2 Sep 2019 16:30:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: linux-next: manual merge of the vfs tree with the fuse tree
Message-ID: <20190902153004.GD1131@ZenIV.linux.org.uk>
References: <20190830130119.446e7389@canb.auug.org.au>
 <CAJfpeguxmJvCV+PXr=wz5HXONKv4RDmZ1LpYNEqAtvw_smP5Ag@mail.gmail.com>
 <CAJfpegsijOi6TdRcObGSAJ+tS0JiZky=v6Wqh5u8RZTzi6tkjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsijOi6TdRcObGSAJ+tS0JiZky=v6Wqh5u8RZTzi6tkjA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 05:10:27PM +0200, Miklos Szeredi wrote:
> On Mon, Sep 2, 2019 at 11:00 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, Aug 30, 2019 at 5:01 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Today's linux-next merge of the vfs tree got a conflict in:
> > >
> > >   fs/fuse/inode.c
> > >
> > > between commit:
> > >
> > >   1458e5e9f99a ("fuse: extract fuse_fill_super_common()")
> > >
> > > from the fuse tree and commit:
> > >
> > >   2ad9ab0f7429 ("vfs: Convert fuse to use the new mount API")
> > >   48ceb15f98c8 ("vfs: Move the subtype parameter into fuse")
> >
> > And the latter is b0rked anyway.
> 
> Both, actually.
> 
> Pushed fixed ones to fuse.git#for-next.

... originals cheerfully dropped; will be gone in today's push to
vfs.git#for-next.
