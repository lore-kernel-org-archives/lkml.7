Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2378EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F02086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfHSNwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfHSNwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:52:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 573411089041;
        Mon, 19 Aug 2019 13:52:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B77FE27CDB;
        Mon, 19 Aug 2019 13:52:23 +0000 (UTC)
Date:   Mon, 19 Aug 2019 21:52:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH V6 2/2] genirq/affinity: Spread vectors on node according
 to nr_cpu ratio
Message-ID: <20190819135217.GA10108@ming.t460p>
References: <20190819124937.9948-1-ming.lei@redhat.com>
 <20190819124937.9948-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1908191511440.2147@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908191511440.2147@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Mon, 19 Aug 2019 13:52:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:13:58PM +0200, Thomas Gleixner wrote:
> On Mon, 19 Aug 2019, Ming Lei wrote:
> 
> > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Reported-by: Jon Derrick <jonathan.derrick@intel.com>
> > Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> This version is sufficiently different from the previous one, so I do not
> consider the reviewed-by tags still being valid and meaningful. Don't
> include them unless you just do cosmetic changes.

Fine.

However, the V6 only change isn't big, just for addressing the un-initialized
warning, and the change is only done on function of irq_build_affinity_masks().

Thanks,
Ming
