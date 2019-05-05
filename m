Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B1C43219
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 00:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D565420700
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 00:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEEAiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 20:38:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEEAiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 20:38:15 -0400
Received: from excalibur.cnev.de ([213.196.205.91]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MlNgx-1gtmE80RPp-00llXS; Sun, 05 May 2019 02:37:45 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hN59x-0003eA-LV; Sun, 05 May 2019 02:37:41 +0200
Date:   Sun, 5 May 2019 02:37:41 +0200
From:   Karsten Merker <merker@debian.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>, mark.rutland@arm.com,
        merker@debian.org
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
Message-ID: <20190505003741.xbhyxhb3yg4q2afm@excalibur.cnev.de>
References: <20190501195607.32553-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501195607.32553-1-atish.patra@wdc.com>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:sxTbgCJmLRiraLBFNTdNLGrOPVUH3uIGoJxJS1d4KvT2AdRG3CP
 ARmYczCeXzMQmYpQrL9iP4waOb8+b/S1pKzwMvIT1vRbx3Zg1iOg1pgbYcv6w/2itRxVRe6
 RcTOqmTdBN+0m7v+5KbOwmVqiCJYv8vWI0CtVjNX5RbGb58ISM5BClnrEEwNtVSOkRi+fex
 25t4rZamoBAz2EtVonjtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMBAA9Hi7sQ=:Lyd/q7qOyI6Zbo9rgcHKZf
 t+fl5iINlqilHbEP7mylVippUEKJJdhqcLQsrcu8UehARi12ogvjb+O4aiVNt+zGeB56ebj8A
 r6AxtBBhpYbVP3zmwkaqS/xfmwZaIrE4kq0lW33CC3vlgAh0Uc2W0FJeRrPpK3MEZHZ9eAHUf
 BLKnChMHld1n8rYCKEopQ4JybcI+wYovMH9B012/eTsx736omXGhp5Zgg/SegqbQ/4RVZ5syf
 4GKqu0sP9BQ4sCH3XxqyF+aQfAg2rESLYmt4yf7/oYc4wHbq/NVQUXdYCBOfDJQ9VbHWJNZU0
 +RWOi+1WrmlZeoElSRu+Um9Ec5Wri6fR9b+MU0dwBzIq9P1Bcc6zB6N5co2q7+yMsy1jbISHP
 ELdYkg3KcT/vn3nrgTZyipeR5NaauKNl634Q2dSjvCV51LNC64tgLkY2FMzTFQXpzT3Lek4dS
 f+cqa9ob6eH+1aMq3KTGtc2dyXyRfTfqQZnty8M+9b8wUKW2R8LiC9BOmWzMC5YSeoAu+m6dX
 K1cr22X520Uis+jeREf9+KOVl0BBw7U1YlTuH05vqSM/7BqS8t0NkQJ0ruIQ+7tK5ITp3/Pz2
 /LNCPjLRsbKMr5ukKB66jqyHmf79wROLWRusWdLYxiiM6muoMxvuvCVMb7JwaA+YKQ5gELwbV
 ZUMPuo/x3j5C0AWmrl31q0ZBaHciLjG9WNMS6P4zitGrDu8AFhZFbe+pi1pQY9XszdvK8QWDo
 36ZlhDFuRkFgHTVC9sI9DZiPuY1pnudvQqORng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 12:56:07PM -0700, Atish Patra wrote:

> Currently, last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot flows.
> 
> Add a PE/COFF compliant image header that boot loaders can parse and
> directly load kernel flat Image. The existing booting methods will continue
> to work as it is.
> 
> Another goal of this header is to support EFI stub for RISC-V in future.
> EFI specification needs PE/COFF image header in the beginning of the kernel
> image in order to load it as an EFI application. In order to support
> EFI stub, code0 should be replaced with "MZ" magic string and res5(at
> offset 0x3c) should point to the rest of the PE/COFF header (which will
> be added during EFI support).
> 
> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks good to me.

Reviewed-by: Karsten Merker <merker@debian.org>
Tested-by: Karsten Merker <merker@debian.org> (QEMU+OpenSBI+U-Boot)

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
