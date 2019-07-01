Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8010C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F0920663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfGAG44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:56:56 -0400
Received: from verein.lst.de ([213.95.11.211]:58764 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfGAG4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:56:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7147E68B20; Mon,  1 Jul 2019 08:56:54 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:56:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-mm@kvack.org, Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v2
Message-ID: <20190701065654.GA21117@lst.de>
References: <20190624054311.30256-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624054311.30256-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer, Paul,

any comments?  Let me know if you think it is too late for 5.3
for the full series, then I can at least feed the mm bits to
Andrew.

On Mon, Jun 24, 2019 at 07:42:54AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> below is a series to support nommu mode on RISC-V.  For now this series
> just works under qemu with the qemu-virt platform, but Damien has also
> been able to get kernel based on this tree with additional driver hacks
> to work on the Kendryte KD210, but that will take a while to cleanup
> an upstream.
> 
> To be useful this series also require the RISC-V binfmt_flat support,
> which I've sent out separately.
> 
> A branch that includes this series and the binfmt_flat support is
> available here:
> 
>     git://git.infradead.org/users/hch/riscv.git riscv-nommu.2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-nommu.2
> 
> I've also pushed out a builtroot branch that can build a RISC-V nommu
> root filesystem here:
> 
>    git://git.infradead.org/users/hch/buildroot.git riscv-nommu.2
> 
> Gitweb:
> 
>    http://git.infradead.org/users/hch/buildroot.git/shortlog/refs/heads/riscv-nommu.2
> 
> Changes since v1:
>  - fixes so that a kernel with this series still work on builds with an
>    IOMMU
>  - small clint cleanups
>  - the binfmt_flat base and buildroot now don't put arguments on the stack
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
---end quoted text---
