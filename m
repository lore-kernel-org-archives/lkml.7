Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD86C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7C1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKLKjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:39:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfKLKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:39:15 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUTZm-0007zU-0Z; Tue, 12 Nov 2019 11:39:10 +0100
Date:   Tue, 12 Nov 2019 11:39:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/12] riscv: add support for MMIO access to the timer
 registers
In-Reply-To: <20191028121043.22934-7-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1911121138580.1833@nanos.tec.linutronix.de>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-7-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> When running in M-mode we can't use the SBI to set the timer, and
> don't have access to the time CSR as that usually is emulated by
> M-mode.  Instead provide code that directly accesses the MMIO for
> the timer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/sbi.h      |  3 ++-
>  arch/riscv/include/asm/timex.h    | 19 +++++++++++++++++--
>  drivers/clocksource/timer-riscv.c | 21 +++++++++++++++++----

Acked-by: Thomas Gleixner <tglx@linutronix.de>
