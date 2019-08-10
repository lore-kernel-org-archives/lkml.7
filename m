Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8CC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC472166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHJHqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:46:08 -0400
Received: from verein.lst.de ([213.95.11.211]:32862 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfHJHqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:46:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E91468B02; Sat, 10 Aug 2019 09:46:02 +0200 (CEST)
Date:   Sat, 10 Aug 2019 09:46:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     mpe@ellerman.id.au
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v4 0/6] Remove x86-specific code from generic headers
Message-ID: <20190810074601.GA23926@lst.de>
References: <20190806044919.10622-1-bauerman@linux.ibm.com> <87sgqasdr6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgqasdr6.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:51:41PM +1000, mpe@ellerman.id.au wrote:
> I need to take this series via the powerpc tree because there is another
> fairly large powerpc specific series dependent on it.
> 
> I think this series already has pretty much all the acks it needs, which
> almost never happens, amazing work!
> 
> I'll put the series in a topic branch, just in case there's any bad
> conflicts and other folks want to merge it later on. I'll then merge the
> topic branch into my next, and so this series will be tested in
> linux-next that way.

Sounds good to me, I don't expect conflicts from the dma-mapping tree.
