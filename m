Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B232C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2637C20679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKKRG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:06:28 -0500
Received: from utopia.booyaka.com ([74.50.51.50]:38950 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:06:27 -0500
Received: (qmail 31259 invoked by uid 1019); 11 Nov 2019 17:06:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2019 17:06:26 -0000
Date:   Mon, 11 Nov 2019 17:06:26 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
In-Reply-To: <20191111133421.14390-1-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.999.1911111705350.30304@utopia.booyaka.com>
References: <20191111133421.14390-1-anup.patel@wdc.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019, Anup Patel wrote:

> We can use SYSCON reboot and poweroff drivers for the
> SiFive test device found on QEMU virt machine and SiFive
> SOCs.
> 
> This patch enables SYSCON reboot and poweroff drivers
> in RV64 and RV32 defconfigs.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

I'd much prefer Christoph's driver, once it's fixed up per my earlier 
comments.  This business with writing random registers based on what's in 
the DT data has always been a bad idea.


- Paul
