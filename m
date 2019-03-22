Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4EF21874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfCVKcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:32:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfCVKcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B3B5307D9D0;
        Fri, 22 Mar 2019 10:32:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BED341001DC9;
        Fri, 22 Mar 2019 10:32:03 +0000 (UTC)
Message-ID: <99a767f4b71510882a11b6369bef1070ec200de6.camel@redhat.com>
Subject: Re:
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Felipe Franciosi <felipe@nutanix.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Fam Zheng <fam@euphon.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Harris, James R" <james.r.harris@intel.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thanos Makatos <thanos.makatos@nutanix.com>,
        John Ferlan <jferlan@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Date:   Fri, 22 Mar 2019 12:32:02 +0200
In-Reply-To: <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
         <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
         <20190321161239.GH31434@stefanha-x1.localdomain>
         <20190321162140.GA29342@localhost.localdomain>
         <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
         <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
         <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 22 Mar 2019 10:32:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 07:54 +0000, Felipe Franciosi wrote:
> > On Mar 21, 2019, at 5:04 PM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > 
> > On Thu, 2019-03-21 at 16:41 +0000, Felipe Franciosi wrote:
> > > > On Mar 21, 2019, at 4:21 PM, Keith Busch <kbusch@kernel.org> wrote:
> > > > 
> > > > On Thu, Mar 21, 2019 at 04:12:39PM +0000, Stefan Hajnoczi wrote:
> > > > > mdev-nvme seems like a duplication of SPDK.  The performance is not
> > > > > better and the features are more limited, so why focus on this
> > > > > approach?
> > > > > 
> > > > > One argument might be that the kernel NVMe subsystem wants to offer
> > > > > this
> > > > > functionality and loading the kernel module is more convenient than
> > > > > managing SPDK to some users.
> > > > > 
> > > > > Thoughts?
> > > > 
> > > > Doesn't SPDK bind a controller to a single process? mdev binds to
> > > > namespaces (or their partitions), so you could have many mdev's assigned
> > > > to many VMs accessing a single controller.
> > > 
> > > Yes, it binds to a single process which can drive the datapath of multiple
> > > virtual controllers for multiple VMs (similar to what you described for
> > > mdev).
> > > You can therefore efficiently poll multiple VM submission queues (and
> > > multiple
> > > device completion queues) from a single physical CPU.
> > > 
> > > The same could be done in the kernel, but the code gets complicated as you
> > > add
> > > more functionality to it. As this is a direct interface with an untrusted
> > > front-end (the guest), it's also arguably safer to do in userspace.
> > > 
> > > Worth noting: you can eventually have a single physical core polling all
> > > sorts
> > > of virtual devices (eg. virtual storage or network controllers) very
> > > efficiently. And this is quite configurable, too. In the interest of
> > > fairness,
> > > performance or efficiency, you can choose to dynamically add or remove
> > > queues
> > > to the poll thread or spawn more threads and redistribute the work.
> > > 
> > > F.
> > 
> > Note though that SPDK doesn't support sharing the device between host and
> > the
> > guests, it takes over the nvme device, thus it makes the kernel nvme driver
> > unbind from it.
> 
> That is absolutely true. However, I find it not to be a problem in practice.
> 
> Hypervisor products, specially those caring about performance, efficiency and
> fairness, will dedicate NVMe devices for a particular purpose (eg. vDisk
> storage, cache, metadata) and will not share these devices for other use
> cases. That's because these products want to deterministically control the
> performance aspects of the device, which you just cannot do if you are sharing
> the device with a subsystem you do not control.
> 
> For scenarios where the device must be shared and such fine grained control is
> not required, it looks like using the kernel driver with io_uring offers very
> good performance with flexibility


I see the host/guest parition in the following way:
The guest assigned partitions are for guests that need lowest possible latency,
and in between these guests it is possible to guarantee good enough level of
fairness in my driver.
For example, in the current implementation of my driver, each guest gets its own
host submission queue.

On the other hand, the host assigned partitions are for significantly higher
latency IO, with no guarantees, and/or for guests that need all the more
advanced features of full IO virtualization, for instance snapshots, thin
provisioning, replication/backup over network, etc.
io_uring can be used here to speed things up but it won't reach the nvme-mdev
levels of latency.

Furthermore on NVME drives that support WRRU, its possible to let queues of
guest's assigned partitions to belong to the high priority class and let the
host queues use the regular medium/low priority class.
For drives that don't support WRRU, the IO throttling can be done in software on
the host queues.

Host assigned partitions also don't need polling, thus allowing polling to be
used only for guests that actually need low latency IO.
This reduces the number of cores that would be otherwise lost to polling,
because the less work the polling core does, the less latency it contributes to
overall latency, thus with less users, you could use less cores to achieve the
same levels of latency.

For Stefan's argument, we can look at it in a slightly different way too:
While the nvme-mdev can be seen as a duplication of SPDK, the SPDK can also be
seen as duplication of an existing kernel functionality which nvme-mdev can
reuse for free.

Best regards,
	Maxim Levitsky




