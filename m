Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F373C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46071217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEKU5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 16:57:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 16:57:37 -0400
Received: from excalibur.cnev.de ([213.196.205.140]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0o7f-1gTB542I2X-00wkTo; Sat, 11 May 2019 22:57:15 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hPZ3P-00048x-9K; Sat, 11 May 2019 22:57:11 +0200
Date:   Sat, 11 May 2019 22:57:11 +0200
From:   Karsten Merker <merker@debian.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>, mark.rutland@arm.com,
        merker@debian.org
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
Message-ID: <20190511205711.pp54kufgret662xv@excalibur.cnev.de>
References: <20190501195607.32553-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501195607.32553-1-atish.patra@wdc.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:/xkbM78ealdbZdv6ETAtl6zu3DJ7y7eSvM3/2gU2x4ECT24NeAa
 rNckyR3vQzZx26gazhyfoMO9JxisyplzfzWdzXjBbBcCWjJztS1tdI+GcuvR8WKLGNEFIEf
 EHy/COzluWqK3GUcak3ovhmW2fdR9scfEKNQAiQjSKdtKflSnCU4CDxpgaDPlsLhuP27t/A
 5wTm4FmJaQGjOtyJsqz3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkYxWV8zqxQ=:C+40/wcclDkdRJjoNXAH9b
 foQwVXtiwpM4A22L8QPZYvhPA+dSAmKtPRoBPMSkIidqslY5MwRJLU1CuvgIcbTk5p30AmiZR
 2PorYLUQmAcN6M94BB5iOEBAySmi+3vOhBBgIewxM8Uw0pD2gv+5WQ+NfkX7pwapgrU8WrBs4
 WeMaPn6qz3l8BojlAGtkeXH1t/hitRot+IA4adf9Wnt8JpzAcVLjThULOtMsyzDhhXnZQ/Dlg
 P7AmExDg4+UNHqYyP2fCdsRb2rTIdtGW3tWlBflPuANZpWydhSOp4H7NqoS01ln6QU1yx4QRU
 zIgiBc06sPQfLT7lF5g18w2YZ+v2JwxlCK6RjY+AqJHZeHUmtEseTn5iT2W7Lfj/vtBxDIYYF
 fXOzHeAZ8go5YyUnltPL7OobTi6d1QXKPgRMFChkXoO+Sk24QN+vIDfHBveY2iD4nx56BSrtZ
 MN0EzwbZ5muF/N4p63DmNkG2s5QNZ/DJaXjwm/r13hx44+UrZ+Yiso0SqRFmxVLnz63UdeVMW
 1dggahU8zMKYT0kw3zqP+dEwra+oMQt1+3wgTFz5XTzKwBKL4AJn8Zm02zUov8J0aJgzG2b0L
 hMAVG3Fs0ml96w4kS7UI5Ca6kBNLc5FLbbaNV64Ho+Gm9cVp2B2qKCrCGEowJYDsn6TgFuFT+
 o73uxQ8mx6fWHHDt8ipn6dMfWfi752VxvDXzVFO11BR/eNtn3bvSc4AdNWCEz0d+JQrNfF5bw
 oyg65AGEOMnO0HAVhLuYvQOXaTva6K0VFFDYiA==
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

Hello Palmer,

it would be great if this patch could go in with the 5.2 merge
window. Is there anything particular blocking its acceptance?

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
