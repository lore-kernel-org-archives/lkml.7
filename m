Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7765CC00306
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 04:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E60E20854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 04:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394252AbfIGEjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 00:39:15 -0400
Received: from verein.lst.de ([213.95.11.211]:34310 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbfIGEjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 00:39:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95CBF68B05; Sat,  7 Sep 2019 06:39:11 +0200 (CEST)
Date:   Sat, 7 Sep 2019 06:39:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@sifive.com, bp@alien8.de,
        mchehab@kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190907043911.GA21510@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:27:44PM -0700, Paul Walmsley wrote:
> - Since the patch doesn't fix any bugs, there shouldn't be a Fixes: line.  
> Please let me know whether I can drop the line locally before I apply the 
> patch, or whether you'd like to resend it.

It fixes the bug that we build code into a default RISC-V image that
we absolutely should not.  And it fixes the bug that the patch placed
code in absolutely the wrong place.
