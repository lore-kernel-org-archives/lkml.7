Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED779C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49DD20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392712AbfIQHn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:43:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbfIQHn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:43:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12BB9AD3A;
        Tue, 17 Sep 2019 07:43:26 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
References: <mhng-5091669f-461c-4e62-a71c-e16957801fad@palmer-si-x1c4>
X-Yow:  Wait..  is this a FUN THING or the END of LIFE in Petticoat Junction??
Date:   Tue, 17 Sep 2019 09:43:25 +0200
In-Reply-To: <mhng-5091669f-461c-4e62-a71c-e16957801fad@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Mon, 16 Sep 2019 14:38:39 -0700 (PDT)")
Message-ID: <mvma7b3e5b6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> but we don't set it for the HiFive Unleashed.  I'd call that a bug,
> something like this
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 93d68cbd64fe..6d0ec76d93fe 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -13,6 +13,7 @@
>        compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
>
>        chosen {
> +               stdout-path = &uart0;
>        };
>
>        cpus {
>
> should fix it.  LMK if I've misunderstood something.

If that's how it's supposed to work, ok.  Other platforms add it in
u-boot.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
