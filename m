Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A7C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8407920675
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfEDGiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:38:17 -0400
Received: from verein.lst.de ([213.95.11.211]:41684 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfEDGiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:38:16 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D473568AFE; Sat,  4 May 2019 08:37:57 +0200 (CEST)
Date:   Sat, 4 May 2019 08:37:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>, "Luck, Tony" <tony.luck@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>, lkp <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: Re: ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
Message-ID: <20190504063757.GA30617@lst.de>
References: <201905032019.tzlqufi0%lkp@intel.com> <4e48dcb2-6e82-4bbe-3920-e1c5fd5c265a@infradead.org> <3908561D78D1C84285E8C5FCA982C28F7E91BABF@ORSMSX104.amr.corp.intel.com> <0f33a863-4371-06cb-f4bd-1f95165b18f1@physik.fu-berlin.de> <20190504062734.GA30427@lst.de> <d535e505-7dd2-d5fb-95b5-34a93c0f9322@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d535e505-7dd2-d5fb-95b5-34a93c0f9322@physik.fu-berlin.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 08:33:53AM +0200, John Paul Adrian Glaubitz wrote:
> On 5/4/19 8:27 AM, Christoph Hellwig wrote:
> >> Just as a heads-up: There are updated installation images available
> >> for Debian unstable for ia64 [1]. Those install a fresh system using GRUB
> >> as a bootloader and come with the latest versions of the toolchain.
> > 
> > Do we also have an x86 to ia64 cross compiler package for Debian?
> > Those packages really help me with changes to other architectures, and
> > the lack of them for ia64 makes compile-testing ia64 code rather painful.
> 
> Hmm, I just realized that building the cross-compiler for ia64 is disabled
> at the moment because we were having issues with libunwind back then. But
> normally, on Debian and Ubuntu, you can just install the compiler with:
> 
> # apt install gcc-8-$ARCH-linux-gnu
> 
> And that should also be the case for ia64, hence I will look into fixing this
> as it should have been long time ago. Thanks for the reminder.

Yes, and I've done that for all other architectures available, it is
just ia64 that has been missing.
