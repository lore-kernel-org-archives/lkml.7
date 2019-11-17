Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89FC43141
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DEE2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfKQLqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 06:46:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:43003 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfKQLqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 06:46:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 03:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,316,1569308400"; 
   d="scan'208";a="236612084"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.135])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2019 03:46:51 -0800
Date:   Sun, 17 Nov 2019 19:54:07 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Subject: Re: [LKP] Re: [scsi] 9393c8de62: Initramfs_unpacking_failed
Message-ID: <20191117115407.GA9578@xsang-OptiPlex-9020>
References: <20191108072255.GX29418@shao2-debian>
 <alpine.LNX.2.21.1.1911091123280.9@nippy.intranet>
 <6ad8eeef-101e-58ba-734d-1725c998a909@gmail.com>
 <yq1v9rtvlv8.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v9rtvlv8.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 09:12:27PM -0500, Martin K. Petersen wrote:
> 
> Michael,
> 
> >>> [    1.278970] Trying to unpack rootfs image as initramfs...
> >>> [    4.011404] Initramfs unpacking failed: broken padding
> >>
> >> Was this test failure unrelated to commit 9393c8de62?
> >
> > Seems to be unrelated - a m68k kernel with that commit included, SCSI
> > core included but low-level driver built as a module(*)  boots into
> > the initramfs just fine.
> >
> > (*) well-known emulator bug.
> 
> I'm scratching my head too. I have tested a variety of systems and all
> of them boot and work fine.

sorry, it's our fault. the kernel built automatically seems broken at some stage.
After we recomplied the kernel, the issue gone. Sorry for any inconvenience.

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
