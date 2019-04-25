Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E2C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9500206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfDYTzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:07 -0400
Received: from verein.lst.de ([213.95.11.211]:37681 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387881AbfDYTzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:55:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 02E9868C4E; Thu, 25 Apr 2019 21:54:47 +0200 (CEST)
Date:   Thu, 25 Apr 2019 21:54:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] riscv: remove duplicate macros from ptrace.h
Message-ID: <20190425195447.GA22587@lst.de>
References: <20190411115623.5749-1-hch@lst.de> <20190411115623.5749-8-hch@lst.de> <alpine.DEB.2.21.9999.1904251208140.17442@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1904251208140.17442@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:13:18PM -0700, Paul Walmsley wrote:
> 
> 
> On Thu, 11 Apr 2019, Christoph Hellwig wrote:
> 
> > No need to have two names for the same thing.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This is probably worth cleaning up across the entire tree.  
> 
> asm-{generic,x86,arm64,powerpc}/ptrace.h all define similar GET_IP/SET_IP
> macros - although it seems that arch/riscv is the only architecture that 
> uses them.

Yes, we had that discussion before.  I've started on a series for that,
but it is unlikely to touch riscv.
