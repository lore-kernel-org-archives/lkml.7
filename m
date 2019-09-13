Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E419BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BCE206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfIMV6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:58:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47240 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMV6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:58:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8tZv-0006gx-Mv; Fri, 13 Sep 2019 21:58:08 +0000
Date:   Fri, 13 Sep 2019 22:58:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the configfs tree with the vfs-fixes
 tree
Message-ID: <20190913215807.GP1131@ZenIV.linux.org.uk>
References: <20190912234412.38998b12@canb.auug.org.au>
 <20190912134716.GA19681@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912134716.GA19681@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 03:47:16PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 12, 2019 at 11:44:12PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the configfs tree got a conflict in:
> > 
> >   fs/configfs/symlink.c
> > 
> > between commit:
> > 
> >   e272d4fb74d6 ("configfs: fix a deadlock in configfs_symlink()")
> > 
> > from the vfs-fixes tree and commit:
> 
> The configfs one has been rebased.  I also have another refactoring
> after this one before the rest of Als patches, so you'll run into
> more issues.
> 
> Al, can you drop the branch from your tree?

Done.
