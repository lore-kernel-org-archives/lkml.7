Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B6C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB8621783
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564866472;
	bh=GyUseNIq/TOH+J0pqQVl0ttWouIq5laojh4Jgs4Gnps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LacFN2rUgrn9Fl3SNwvGErbw5hG1oADeN0FpckZmNoTcheAlJ9efDS1XVd/Ho1ATG
	 JyEwRmLjqPxD4yKVaVKfmy9ant613fbPUoWVTCEjwkQUohaONJMhGQi7eOXxjUQ941
	 wshjsEqxLZdnPgvA/YF1yOUPRFTWYX9XQlLjO+ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfHCVHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 17:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfHCVHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 17:07:48 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608F621726;
        Sat,  3 Aug 2019 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564866467;
        bh=GyUseNIq/TOH+J0pqQVl0ttWouIq5laojh4Jgs4Gnps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0ufmtJyVDpkkKuh/ZNpBn7FwsB2gRYd1keOXDOk2jXPyaFu8aIKi6IemELXoxpDP
         MIhY1qrZCErDo3LBKy844+Xc3Zu1EzX177X+FqQ8u/WO3GFQcA/nEOQmHnf/U3ppf5
         5v9JUPZ9mQBq7UGgLIsgMANGo5+1CVEKrVmUzTko=
Date:   Sat, 3 Aug 2019 14:07:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: cleanups for 5.3-rc3
Message-ID: <20190803210746.GM7138@magnolia>
References: <20190803163312.GK7138@magnolia>
 <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgg8Y=KxZaHy66BdOKKtDzQ_XN4sR6YWa00+v+06azt4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 10:46:38AM -0700, Linus Torvalds wrote:
> On Sat, Aug 3, 2019 at 9:33 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Here are a couple more bug fixes that trickled in since -rc1.  It's
> > survived the usual xfstests runs and merges cleanly with this morning's
> > master.  Please let me know if anything strange happens.
> 
> Hmm. This was tagged, but not signed like your usual tags are.
> 
> I've pulled it (I don't _require_ signed tags from kernel.org), but
> would generally be much happier if I saw the signing too...

D'oh.  Sorry, I forgot to git tag -a. :(

/me rummages around to see if there's a way to configure git to sign
always...

--D

> Thanks,
> 
>                  Linus
