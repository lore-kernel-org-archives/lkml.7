Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AECCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32325222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410499AbfJRPZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:25:24 -0400
Received: from verein.lst.de ([213.95.11.211]:48218 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406633AbfJRPZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:25:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 960B868AFE; Fri, 18 Oct 2019 17:25:20 +0200 (CEST)
Date:   Fri, 18 Oct 2019 17:25:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: RISC-V nommu support v5
Message-ID: <20191018152520.GA32281@lst.de>
References: <20191017173743.5430-1-hch@lst.de> <CAAhSdy1dvFzEh_WZ8aDNyCKi968Dwxm+ru6D0DF08QoOq3JjLA@mail.gmail.com> <alpine.DEB.2.21.9999.1910172029170.3156@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910172029170.3156@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 08:29:59PM -0700, Paul Walmsley wrote:
> On Fri, 18 Oct 2019, Anup Patel wrote:
> 
> > It will be really cool to have this series for Linux-5.4-rcX.
> 
> It's way too big to go in via the -rc series.  I'm hoping to have it ready 
> to go for v5.5-rc1.

Yes, this is 5.5 material.  Btw, the buildbot found two issues that
require one liner fixes, so I'll resend again this weekend.
