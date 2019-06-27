Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C768C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A932063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0HXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:23:13 -0400
Received: from verein.lst.de ([213.95.11.211]:50142 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfF0HXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:23:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DCFEF68B20; Thu, 27 Jun 2019 09:22:40 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:22:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] powerpc/powernv: remove unused NPU DMA code
Message-ID: <20190627072240.GA9916@lst.de>
References: <20190625145239.2759-1-hch@lst.de> <20190625145239.2759-4-hch@lst.de> <7bde96e0-7bc5-d5fe-f151-52c29660633c@ozlabs.ru> <20190626074935.GA25452@lst.de> <027a5095-a22c-2799-8ff6-42d0bc4d2bc9@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027a5095-a22c-2799-8ff6-42d0bc4d2bc9@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:21:55AM +1000, Alexey Kardashevskiy wrote:
> > Which comment?  Last time I asked you complaint "it is still used in
> > exactly the same way as before" which you later clarified that you
> > have a hidden out of tree user somewhere, and you only objected to
> 
> It is not hidden, anyone can download and inspect that GPL driver.

For one no one has ever posted a link.  And second as mentioned
countless times it doesn't matter, it only matters if it is in mainline,
or as a special exception actively trying to go mainline.

> > the word "dead".  That has been fixed and there were no further
> > comments.
> 
> You still have it in the cover letter so at very least 3/4 is not a part
> of this patchset then.
> 
> And I still want to see a formal statement about out-of-tree drivers
> support/tolerance. If you manage to remove this code, I'll have to post
> a revert (again and again) but I would rather know the exact list of
> what we do and what we do not do about such drivers and if the list 1)
> exists 2) is reasonable then I could try to come up with a better
> solution or point others to the policy and push them to do the right
> thing. Right now it is just you pretending that the nVidia driver does
> not exist, this is not helping. Thanks,

We had that discussion at kernel summit and it was reported.  Anyway,
adding Greg, who usually has some pretty good prewritten letters for
this kind of thing.
