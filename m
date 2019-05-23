Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19355C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE44221773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558648633;
	bh=K7Ymiz4+fPrsKgYXj1NMNSj74aVdvdxXEIM9UQF+vkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JBlEH1nXPi5/DGa8RljUhmfKYPby+VMOy4F4Wu4TS+k/hk2Xh+3LCYGg7/svS1E+J
	 9LEPI/KVDkXo3Mx0UVBXrt6SYrfDefiSfdWsf2x5kZzcM3dljMdAXNfTLSE3pxgzlC
	 uY8rIQU7ot34jyrv+C06uSI7TyBc+L6HTSoW0XmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbfEWV5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:57:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:13516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387616AbfEWV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:57:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 14:57:07 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2019 14:57:07 -0700
Date:   Thu, 23 May 2019 15:52:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the block tree
Message-ID: <20190523215206.GA15192@localhost.localdomain>
References: <20190524074500.1fde68d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524074500.1fde68d6@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 07:45:00AM +1000, Stephen Rothwell wrote:
> Commits
> 
>   5fb4aac756ac ("nvme: release namespace SRCU protection before performing controller ioctls")
>   90ec611adcf2 ("nvme: merge nvme_ns_ioctl into nvme_ioctl")
>   3f98bcc58cd5 ("nvme: remove the ifdef around nvme_nvm_ioctl")
>   100c815cbd56 ("nvme: fix srcu locking on error return in nvme_get_ns_from_disk")
> 
> are missing a Signed-off-by from their committer.

Oops, I'd only added my Reviewed-by. Do I need to update the commit
messages and resend, or is this just putting me on notice for next time?
