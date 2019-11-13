Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D709FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB27F222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573623204;
	bh=cmVkkx8IxTndhMOx7kQdQT7/VHpxz5FOgRZiosp5KpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pso+BV5fZVQ2tIaafx0ZKeBzTjU072EnmoLBfE952V1SrLork7OIYHQ7plBKvMVr1
	 6+tMYJCkhjuoEGUTo6sVMxXXFZOyIVN1xz/fkGO1Qxpcs+azGgjOrjLAaQVxId8rMr
	 iEZ7PGABuFjjbB5F6UvtLEYcdsW+xXfan1zLUPFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfKMFdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfKMFdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 00:33:23 -0500
Received: from localhost (unknown [8.46.76.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22471222D0;
        Wed, 13 Nov 2019 05:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573623202;
        bh=cmVkkx8IxTndhMOx7kQdQT7/VHpxz5FOgRZiosp5KpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x2fJUqoO6VCixekEkHmJiIDqmihNDm8EoYrKvk2KUevLEJ+GYIbx4rscedW6dW5qP
         8lfUs16NrIa1E8BGUief6py52rQmkjXwYwL0tV2E2cHqoQ7HEZT9XuECd2L4eYrv4Q
         MKrvNYM4kDXILdrhtNUsunpdBnwTk1KEgR7eoz2k=
Date:   Wed, 13 Nov 2019 06:33:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vboxsf: move out of staging to fs/
Message-ID: <20191113053311.GB2036664@kroah.com>
References: <20191110154303.GA2867499@kroah.com>
 <20191112063440.GA15951@infradead.org>
 <20191112065629.GA1242198@kroah.com>
 <20191112225427.GA1873491@kroah.com>
 <CAHk-=wiLZpyGyOcymND-Pk7_a_MXHZHJtsT9TryHmZBE7Babiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiLZpyGyOcymND-Pk7_a_MXHZHJtsT9TryHmZBE7Babiw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:12:53PM -0800, Linus Torvalds wrote:
> On Tue, Nov 12, 2019 at 2:54 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Christoph, this is what you mean, right?  If so, I'll send this to Linus
> > later this week, or he can grab it right from this patch :)
> 
> No.
> 
> I was unhappy about a staging driver being added in rc7, but I went
> "whatever, it's Greg's garbage"
> 
> There is no way in hell I will take a new filesystem in rc8.
> 
> Would you take that into stable? No, you wouldn't. Then why is this
> being upstreamed now.
> 
> Honestly, I think I'll just delete the whole thing, since it shouldn't
> have gone in in the first place. This is not how we add new
> filesystems.

Fair enough, sorry for the noise.

greg k-h
