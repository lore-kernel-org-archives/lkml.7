Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C2C17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9305207FA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 00:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfKIA3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 19:29:47 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:41372 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKIA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:29:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 1A6162A2CF;
        Fri,  8 Nov 2019 19:29:34 -0500 (EST)
Date:   Sat, 9 Nov 2019 11:29:35 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     kernel test robot <lkp@intel.com>
cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Subject: Re: [scsi] 9393c8de62: Initramfs_unpacking_failed
In-Reply-To: <20191108072255.GX29418@shao2-debian>
Message-ID: <alpine.LNX.2.21.1.1911091123280.9@nippy.intranet>
References: <20191108072255.GX29418@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> ...
> [    1.278970] Trying to unpack rootfs image as initramfs...
> [    4.011404] Initramfs unpacking failed: broken padding

Was this test failure unrelated to commit 9393c8de62?

-- 
