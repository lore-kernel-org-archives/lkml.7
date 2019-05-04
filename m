Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66058C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354D920645
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfEDGt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:49:59 -0400
Received: from verein.lst.de ([213.95.11.211]:41739 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfEDGt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:49:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ECAD168AFE; Sat,  4 May 2019 08:49:38 +0200 (CEST)
Date:   Sat, 4 May 2019 08:49:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Fam Zheng <fam@euphon.net>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Liang Cunming <cunming.liang@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 06/10] nvme/core: add mdev interfaces
Message-ID: <20190504064938.GA30814@lst.de>
References: <20190502114801.23116-1-mlevitsk@redhat.com> <20190502114801.23116-7-mlevitsk@redhat.com> <20190503122902.GA5081@infradead.org> <d1c0c7ae-1a7d-06e5-d8bb-765a7fd5e41d@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1c0c7ae-1a7d-06e5-d8bb-765a7fd5e41d@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 10:00:54PM +0300, Max Gurtovoy wrote:
> Don't see a big difference of taking NVMe queue and namespace/partition to 
> guest OS or to P2P since IO is issued by external entity and pooled outside 
> the pci driver.

We are not going to the queue aside either way..  That is where the
last patch in this series is already working to, and which would be
the sensible vhost model to start with.
