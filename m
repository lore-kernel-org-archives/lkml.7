Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A25C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59258217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfDYGUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:20:16 -0400
Received: from verein.lst.de ([213.95.11.211]:59407 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfDYGUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:20:15 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F2BA368C4E; Thu, 25 Apr 2019 08:19:58 +0200 (CEST)
Date:   Thu, 25 Apr 2019 08:19:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Michael Ellerman <michael@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: powerpc hugepage leak caused by 576ed913 "block: use
 bio_add_page in bio_iov_iter_get_pages"
Message-ID: <20190425061958.GA7881@lst.de>
References: <20190423054131.GB31496@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423054131.GB31496@umbus.fritz.box>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just curious:  What exact trees do you see this with?  This area
changed a lot with the multipage bvec support, and subsequent fixes.

So I'd be really curious if it can be reproduced with Jens' latest
block for-5.2 tree (which should be in latest linux-next).
