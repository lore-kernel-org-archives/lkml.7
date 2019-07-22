Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CC1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F2C21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="R6d8KVuz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QWJi5LI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfGVXpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:45:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52082 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbfGVXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 56C6A8EE1CB;
        Mon, 22 Jul 2019 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563839146;
        bh=zuFi5LHgpWt2lzZ1Fsbhz0W4ImV5Jj1U5z7uxIPSLis=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R6d8KVuzAKe4GBHmpQou8gzes7qSjjCGIY23huG4H99hosV+6rTdnT/YcgX1zvMUy
         yQ3lT4uJ5UuqqP5Zh+ITC9KhsGtqMr1w1xjtPANcMgdczS4IN55ptjNqBK94FfI0bH
         0X/FnFCbClTaAPNz9q5xhcRM5bhDxRaLKYgtkOfU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5-zHbAwKzrlX; Mon, 22 Jul 2019 16:45:45 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 772A68EE0CE;
        Mon, 22 Jul 2019 16:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563839145;
        bh=zuFi5LHgpWt2lzZ1Fsbhz0W4ImV5Jj1U5z7uxIPSLis=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QWJi5LI/siCk5E225NDyuaPxE1vCvvsOcaS84ZaETvLpH9LUI+X+jCq6jwygbKtYj
         7/2W0gyLxZmsqY1XCkNNeeO731MLgJXupVzolsfbE3AVk/sh56nt3ZwPPb5KmsZ6Y4
         ziV5V0/lHylopU0biGv8ffsRK2lpGNXQsqGqQZk0=
Message-ID: <1563839144.2504.5.camel@HansenPartnership.com>
Subject: Re: Linux 5.3-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Mon, 22 Jul 2019 16:45:44 -0700
In-Reply-To: <20190722222126.GA27291@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
         <20190722222126.GA27291@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[linux-scsi added to cc]
On Mon, 2019-07-22 at 15:21 -0700, Guenter Roeck wrote:
> On Sun, Jul 21, 2019 at 02:33:38PM -0700, Linus Torvalds wrote:
> 
> [ ... ]
> > 
> > Go test,
> > 
> 
> Things looked pretty good until a few days ago. Unfortunately,
> the last few days brought in a couple of issues.
> 
> riscv:virt:defconfig:scsi[virtio]
> riscv:virt:defconfig:scsi[virtio-pci]
> 
> Boot tests crash with no useful backtrace. Bisect points to
> merge ac60602a6d8f ("Merge tag 'dma-mapping-5.3-1'"). Log is at
> https://kerneltests.org/builders/qemu-riscv64-master/builds/238/steps
> /qemubuildcommand_1/logs/stdio
> 
> ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112
> ppc64:pseries:pseries_defconfig:sata-sii3112
> ppc64:pseries:pseries_defconfig:little:sata-sii3112
> ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112
> 
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.00: failed command: READ DMA
> 
> and many similar errors. Boot ultimately times out. Bisect points to
> merge
> f65420df914a ("Merge tag 'scsi-fixes'").
> 
> Logs:
> https://kerneltests.org/builders/qemu-ppc64-master/builds/1212/steps/
> qemubuildcommand/logs/stdio
> https://kerneltests.org/builders/qemu-ppc-master/builds/1255/steps/qe
> mubuildcommand/logs/stdio
> 
> Guenter
> 
> ---
> riscv bisect log
> 
> # bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
> # good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take
> the DMA max mapping size into account
> git bisect start 'HEAD' 'bdd17bdef7d8'
> # good: [237f83dfbe668443b5e31c3c7576125871cca674] Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect good 237f83dfbe668443b5e31c3c7576125871cca674
> # good: [be8454afc50f43016ca8b6130d9673bdd0bd56ec] Merge tag 'drm-
> next-2019-07-16' of git://anongit.freedesktop.org/drm/drm
> git bisect good be8454afc50f43016ca8b6130d9673bdd0bd56ec
> # good: [d4df33b0e9925c158b313a586fb1557cf29cfdf4] Merge branch 'for-
> linus-5.2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb
> git bisect good d4df33b0e9925c158b313a586fb1557cf29cfdf4
> # good: [f90b8fda3a9d72a9422ea80ae95843697f94ea4a] ARM: dts: gemini:
> Set DIR-685 SPI CS as active low
> git bisect good f90b8fda3a9d72a9422ea80ae95843697f94ea4a
> # good: [31cc088a4f5d83481c6f5041bd6eb06115b974af] Merge tag 'drm-
> next-2019-07-19' of git://anongit.freedesktop.org/drm/drm
> git bisect good 31cc088a4f5d83481c6f5041bd6eb06115b974af
> # good: [ad21a4ce040cc41b4a085417169b558e86af56b7] dt-bindings:
> pinctrl: aspeed: Fix 'compatible' schema errors
> git bisect good ad21a4ce040cc41b4a085417169b558e86af56b7
> # good: [e6023adc5c6af79ac8ac5b17939f58091fa0d870] Merge branch
> 'core-urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good e6023adc5c6af79ac8ac5b17939f58091fa0d870
> # bad: [ac60602a6d8f6830dee89f4b87ee005f62eb7171] Merge tag 'dma-
> mapping-5.3-1' of git://git.infradead.org/users/hch/dma-mapping
> git bisect bad ac60602a6d8f6830dee89f4b87ee005f62eb7171
> # good: [6e67d77d673d785631b0c52314b60d3c68ebe809] perf vendor events
> s390: Add JSON files for machine type 8561
> git bisect good 6e67d77d673d785631b0c52314b60d3c68ebe809
> # good: [a0d14b8909de55139b8702fe0c7e80b69763dcfb] x86/mm, tracing:
> Fix CR2 corruption
> git bisect good a0d14b8909de55139b8702fe0c7e80b69763dcfb
> # good: [6879298bd0673840cadd1fb36d7225485504ceb4] x86/entry/64:
> Prevent clobbering of saved CR2 value
> git bisect good 6879298bd0673840cadd1fb36d7225485504ceb4
> # good: [449fa54d6815be8c2c1f68fa9dbbae9384a7c03e] dma-direct:
> correct the physical addr in dma_direct_sync_sg_for_cpu/device
> git bisect good 449fa54d6815be8c2c1f68fa9dbbae9384a7c03e
> # good: [e0c5c5e308ee9b3548844f0d88da937782b895ef] Merge tag 'perf-
> core-for-mingo-5.3-20190715' of
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into
> perf/urgent
> git bisect good e0c5c5e308ee9b3548844f0d88da937782b895ef
> # good: [c6dd78fcb8eefa15dd861889e0f59d301cb5230c] Merge branch 'x86-
> urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good c6dd78fcb8eefa15dd861889e0f59d301cb5230c
> # first bad commit: [ac60602a6d8f6830dee89f4b87ee005f62eb7171] Merge
> tag 'dma-mapping-5.3-1' of git://git.infradead.org/users/hch/dma-
> mapping
> 
> ---------
> ppc/ppc64 bisect log
> 
> # bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
> # good: [abdfd52a295fb5731ab07b5c9013e2e39f4d1cbe] Merge tag 'armsoc-
> defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect start 'HEAD' 'abdfd52a295f'
> # bad: [e6023adc5c6af79ac8ac5b17939f58091fa0d870] Merge branch 'core-
> urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad e6023adc5c6af79ac8ac5b17939f58091fa0d870
> # bad: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge tag 'scsi-
> fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect bad f65420df914a85e33b2c8b1cab310858b2abb7c0
> # good: [168c79971b4a7be7011e73bf488b740a8e1135c8] Merge tag 'kbuild-
> v5.3-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect good 168c79971b4a7be7011e73bf488b740a8e1135c8
> # good: [106d45f350c7cac876844dc685845cba4ffdb70b] scsi: zfcp: fix
> request object use-after-free in send path causing wrong traces
> git bisect good 106d45f350c7cac876844dc685845cba4ffdb70b
> # good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take
> the DMA max mapping size into account
> git bisect good bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
> # good: [09a4460ba4434ef0327cd26bf25f2d7afb973251] scsi: IB/iser: set
> virt_boundary_mask in the scsi host
> git bisect good 09a4460ba4434ef0327cd26bf25f2d7afb973251
> # good: [ce0ad853109733d772d26224297fda0de313bf13] scsi: mpt3sas: set
> an unlimited max_segment_size for SAS 3.0 HBAs
> git bisect good ce0ad853109733d772d26224297fda0de313bf13
> # good: [07d9aa14346489d6facae5777ceb267a1dcadbc5] scsi:
> megaraid_sas: set an unlimited max_segment_size
> git bisect good 07d9aa14346489d6facae5777ceb267a1dcadbc5
> # first bad commit: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge
> tag 'scsi-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi

When a bisect lands on a merge commit it usually indicates bad
interaction between two trees.  The way to find it is to do a bisect,
but merge up to the other side of the scsi-fixes pull before running
tests so the interaction is exposed in the bisect.

However my money is on:


commit bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 17 14:19:54 2019 +0200

    scsi: core: take the DMA max mapping size into account
 
Now that I look at the code again:


+       shost->max_sectors = min_t(unsigned int, shost->max_sectors,
+                       dma_max_mapping_size(dev) << SECTOR_SHIFT);

That shift looks to be the wrong way around (should be >>).  I bet
something is giving a very large number which becomes zero on left
shift, meaning max_sectors gets set to zero.

James

