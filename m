Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B5EC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673D62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404639AbfFKILp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:11:45 -0400
Received: from verein.lst.de ([213.95.11.211]:49067 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404272AbfFKILp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:11:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A40C568B02; Tue, 11 Jun 2019 10:11:17 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:11:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: binfmt_flat cleanups and RISC-V support
Message-ID: <20190611081117.GA22110@lst.de>
References: <20190610212015.9157-1-hch@lst.de> <4f000219-4baf-b03e-9003-26482640d3de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f000219-4baf-b03e-9003-26482640d3de@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:05:45AM +0100, Vladimir Murzin wrote:
> I'm wondering if you have a branch with these changes so I can give
> it a try on ARM NOMMU platforms?


    git://git.infradead.org/users/hch/riscv.git riscv-flat
