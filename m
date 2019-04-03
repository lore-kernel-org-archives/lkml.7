Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EEDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04B8205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDCTrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:47:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35852 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:47:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBlqz-0007X3-3z; Wed, 03 Apr 2019 19:47:21 +0000
Date:   Wed, 3 Apr 2019 20:47:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Message-ID: <20190403194720.GY2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org>
 <20190402094934.5b242dc0@lwn.net>
 <20190402164824.GK2217@ZenIV.linux.org.uk>
 <20190402192520.GA6285@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402192520.GA6285@eros.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:25:20AM +1100, Tobin C. Harding wrote:
> On Tue, Apr 02, 2019 at 05:48:24PM +0100, Al Viro wrote:
> > On Tue, Apr 02, 2019 at 09:49:34AM -0600, Jonathan Corbet wrote:
> > > On Wed, 27 Mar 2019 16:16:53 +1100
> > > "Tobin C. Harding" <tobin@kernel.org> wrote:
> > > 
> > > > Hi Al,
> > > > 
> > > > This series converts the VFS file Documentation/filesystems/vfs.txt to
> > > > reStructuredText format.  Please consider taking this series through
> > > > your tree as apposed to Jon's tree because this set makes a fair amount
> > > > of changes to VFS files (and also the VFS tree and docs tree are out of
> > > > sync right now with the recent work by Mauro and Neil).
> > > 
> > > Al, do you have any thoughts on how you want to handle this?  I was about
> > > to apply Jeff Layton's vfs.txt update, but would rather not create
> > > conflicts unnecessarily.  Let me know if you'd like me to pick this work
> > > up.
> > 
> > Frankly, I would rather see that file be eventually replaced by something
> > saner, and I'm not talking about the format.
> 
> Are you able to extrapolate on this comment please?  Is this something
> someone new to the VFS (me) can do with a little nudge in the right
> direction or is this something that needs thorough knowledge of the VFS? 

Put it that way - IMO the best way to do it is not a list of methods with
explanations what each does, but a bunch of per-data structure documents
describing their life cycles.  The fundamental ones for VFS would be
	* inode
	* dentry
	* super_block
	* (vfs)mount
	* file
	* files_struct
Having a list of methods is nice, but those would be better off with short
description along with "see <document> for details, including the locking,
etc."; said short descriptions make little sense without the background...
