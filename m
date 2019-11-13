Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACBD222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKMNSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:18:05 -0500
Received: from verein.lst.de ([213.95.11.211]:34190 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfKMNSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:18:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 65B6A68BFE; Wed, 13 Nov 2019 14:18:02 +0100 (CET)
Date:   Wed, 13 Nov 2019 14:18:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v6
Message-ID: <20191113131802.GA9996@lst.de>
References: <20191028121043.22934-1-hch@lst.de> <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com> <20191111094729.GA11878@lst.de> <alpine.DEB.2.21.999.1911111702030.30304@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.1911111702030.30304@utopia.booyaka.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:02:51PM +0000, Paul Walmsley wrote:
> Hi Christoph,
> 
> On Mon, 11 Nov 2019, Christoph Hellwig wrote:
> 
> > what is the status of this series?
> 
> At the moment I'm waiting for acks from other maintainers.

I think you should have all ACK now, the only ones missing were the
onces for the trivial search and replace in the time driver which
really is maintained by us anyway, but Thomas was so nice to take
a look.
