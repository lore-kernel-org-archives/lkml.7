Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B39C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E4521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCTRdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:33:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5045 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfCTRdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:33:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92CEB30B24DE;
        Wed, 20 Mar 2019 17:33:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4EFD604CE;
        Wed, 20 Mar 2019 17:33:05 +0000 (UTC)
Message-ID: <80d6ac26870b52d4df95dacb067a9c6f181b1581.camel@redhat.com>
Subject: Re: your mail
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        John Ferlan <jferlan@redhat.com>
Date:   Wed, 20 Mar 2019 19:33:05 +0200
In-Reply-To: <20190320170321.GA27462@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <20190319152212.GC24176@localhost.localdomain>
         <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>
         <20190320170321.GA27462@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 20 Mar 2019 17:33:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 11:03 -0600, Keith Busch wrote:
> On Wed, Mar 20, 2019 at 06:30:29PM +0200, Maxim Levitsky wrote:
> > Or instead I can use the block backend, 
> > (but note that currently the block back-end doesn't support polling which is
> > critical for the performance).
> 
> Oh, I think you can do polling through there. For reference, fs/io_uring.c
> has a pretty good implementation that aligns with how you could use it.


That is exactly my thought. The polling recently got lot of improvements in the
block layer, which migh make this feasable.

I will give it a try.

Best regards,
	Maxim Levitsky

