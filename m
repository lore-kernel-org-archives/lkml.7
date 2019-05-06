Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DF8C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3085206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfEFUk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:40:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEFUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:40:28 -0400
Received: from excalibur.cnev.de ([81.173.131.93]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhULz-1gkogl17Qp-00eajU; Mon, 06 May 2019 22:40:00 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hNkOz-0001uJ-1N; Mon, 06 May 2019 22:39:57 +0200
Date:   Mon, 6 May 2019 22:39:56 +0200
From:   Karsten Merker <merker@debian.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Karsten Merker <merker@debian.org>,
        Alexander Graf <agraf@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de
Subject: Re: [U-Boot] [v4 PATCH] RISCV: image: Add booti support
Message-ID: <20190506203956.ty6gkmhm4dlylld4@excalibur.cnev.de>
References: <20190506181134.9575-1-atish.patra@wdc.com>
 <251ea152-6407-02e2-076c-7ee377f6181d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <251ea152-6407-02e2-076c-7ee377f6181d@gmx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:j9vbx5B588gOFFRAxO/ZjvtJjBPlHp5f7SziyV6bnBqvT0xcY7N
 wDqXPjt3tfFBGUX7H/fx9BVIVx9PlQZPrYiJfmAPdDe9cXMpP82RA/8wiHMyNk4LSATuVmO
 wNJ4IX4m2z/BVUetfMc6kjFesuVcVMAPHtRl0FSkBYdfdCFh2PsI92fPRvC0fTE2jX/IoYo
 Qd4o2/wkx+jIDrjZkvOjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZZNtQIMnrhk=:lBxcmfvk+j7wZ7KOl2q+is
 9XzqwW6xPnLZqFqdlOXRso78t9GgJf7ExTrDu1YxyfDKVUYlrRs6moa/XtKlpftg+53CXDFjq
 d3XVlQt8DrLejSAgVADeOpHZCvGyhhUETpQ23uGVrc3cvfc/Ns0M3mWN50n64WMtBbqaiRIXw
 T26Xi1PfLXHnlbDeohlghc0G6PS34Oi2V7qe4dr0+js2H+JEPEXKDVwNMKgleKMG8kQ3B8TBz
 9ojkmeEtI/S5WRyNPiQP9HykpkIV3lg/eO/Ctl4PpKciDU07n460rJlDPAcIacdnomfTeT7gI
 RXRhZ9+U1TVslYwBn6r+ddE05Q5V4q2XuZVZHeBQ8VORQGUTEbWBCnI0NtGb58VtZWtWipmL7
 gQjYuEFLlbi4GOdZPZXgacgEBiL07aFRWeGFFmf06r3VLYhu18Df4GXKoQ8iRQej0wVOqFmwX
 dZB69mqx/kiXCkJzSDZB7kz1/t5xE6xFFtbCvin2NDjwJ8QLofNQ/5oqUVANs9vdaoV6UiPSo
 yJH5FAAFEvLVX+xwxgSgn9mXLxAc4KA3UxLh1E3PxHCw6H0xqvIP0syw0ySAFMchf0B51cjVi
 +pRYpT7NDhtBk74BK2VqAWUwz3bM7sn3X8Vtyc8a7LtJdJL8SMP8rWIPvua/EoM4VXJeH5xPl
 o1cSKZrOZ1sAtRNMURTx6W6g/96Nt9GDCthWWN6a8j/1eUEdXK0rIiOwwbiO0EWgrjiTduqOv
 oyryRH1xL9IO3E4l1zebAnCnfgfAH0AhV88eDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 10:06:39PM +0200, Heinrich Schuchardt wrote:
> On 5/6/19 8:11 PM, Atish Patra wrote:
> > This patch adds booti support for RISC-V Linux kernel. The existing
> > bootm method will also continue to work as it is.
[...]
> > +	"boot arm64/riscv Linux Image image from memory", booti_help_text
> 
> %s/Image image/image/
> 
> "arm64/riscv" is distracting. If I am on RISC-V I cannot boot an ARM64
> image here. Remove the reference to the architecture, please.

Hello,

I'm not sure about the last point - ISTR (please correct me if my
memory betrays me here) that an arm64 U-Boot can in principle be
used to boot either an arm64 or an armv7 kernel, but the commands
are different in those cases (booti for an arm64 "Image" format
kernel and bootz for an armv7 "zImage" format kernel), so having
the information which kernel format is supported by the
respective commands appears useful to me.  If the arm64 kernel
image format would have a distinctive name (like "zImage" on
armv7 or "bzImage" on x86) that would be less problematic, but
with the confusion potential of "boot a Linux Image" (as in the
arm64/riscv-specific "Image" format) vs "boot a Linux image" (as
in generally some form of kernel image), I think explicitly
mentioning the supported architectures makes sense.

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
