Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6396EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB91218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfCUQMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUQMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:12:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ABAD308FBAC;
        Thu, 21 Mar 2019 16:12:44 +0000 (UTC)
Received: from localhost (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B5105D6A6;
        Thu, 21 Mar 2019 16:12:40 +0000 (UTC)
Date:   Thu, 21 Mar 2019 16:12:39 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Felipe Franciosi <felipe@nutanix.com>, Fam Zheng <fam@euphon.net>,
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
Subject: Re: 
Message-ID: <20190321161239.GH31434@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Content-Disposition: inline
In-Reply-To: <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 21 Mar 2019 16:12:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 09:08:37PM +0200, Maxim Levitsky wrote:
> On Wed, 2019-03-20 at 11:03 +0000, Felipe Franciosi wrote:
> > > On Mar 19, 2019, at 2:41 PM, Maxim Levitsky <mlevitsk@redhat.com> wro=
te:
> > >=20
> > > Date: Tue, 19 Mar 2019 14:45:45 +0200
> > > Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
> > >=20
> > > Hi everyone!
> > >=20
> > > In this patch series, I would like to introduce my take on the proble=
m of
> > > doing=20
> > > as fast as possible virtualization of storage with emphasis on low la=
tency.
> > >=20
> > > In this patch series I implemented a kernel vfio based, mediated devi=
ce
> > > that=20
> > > allows the user to pass through a partition and/or whole namespace to=
 a
> > > guest.
> >=20
> > Hey Maxim!
> >=20
> > I'm really excited to see this series, as it aligns to some extent with=
 what
> > we discussed in last year's KVM Forum VFIO BoF.
> >=20
> > There's no arguing that we need a better story to efficiently virtualis=
e NVMe
> > devices. So far, for Qemu-based VMs, Changpeng's vhost-user-nvme is the=
 best
> > attempt at that. However, I seem to recall there was some pushback from=
 qemu-
> > devel in the sense that they would rather see investment in virtio-blk.=
 I'm
> > not sure what's the latest on that work and what are the next steps.
> I agree with that. All my benchmarks were agains his vhost-user-nvme driv=
er, and
> I am able to get pretty much the same througput and latency.
>=20
> The ssd I tested on died just recently (Murphy law), not due to bug in my=
 driver
> but some internal fault (even though most of my tests were reads, plus
> occassional 'nvme format's.
> We are in process of buying an replacement.
>=20
> >=20
> > The pushback drove the discussion towards pursuing an mdev approach, wh=
ich is
> > why I'm excited to see your patches.
> >=20
> > What I'm thinking is that passing through namespaces or partitions is v=
ery
> > restrictive. It leaves no room to implement more elaborate virtualisati=
on
> > stacks like replicating data across multiple devices (local or remote),
> > storage migration, software-managed thin provisioning, encryption,
> > deduplication, compression, etc. In summary, anything that requires sof=
tware
> > intervention in the datapath. (Worth noting: vhost-user-nvme allows all=
 of
> > that to be easily done in SPDK's bdev layer.)
>=20
> Hi Felipe!
>=20
> I guess that my driver is not geared toward more complicated use cases li=
ke you
> mentioned, but instead it is focused to get as fast as possible performan=
ce for
> the common case.
>=20
> One thing that I can do which would solve several of the above problems i=
s to
> accept an map betwent virtual and real logical blocks, pretty much in exa=
ctly
> the same way as EPT does it.
> Then userspace can map any portions of the device anywhere, while still k=
eeping
> the dataplane in the kernel, and having minimal overhead.
>=20
> On top of that, note that the direction of IO virtualization is to do dat=
aplane
> in hardware, which will probably give you even worse partition granuality=
 /
> features but will be the fastest option aviable,
> like for instance SR-IOV which alrady exists and just allows to split by
> namespaces without any more fine grained control.
>=20
> Think of nvme-mdev as a very low level driver, which currntly uses pollin=
g, but
> eventually will use PASID based IOMMU to provide the guest with raw PCI d=
evice.
> The userspace / qemu can build on top of that with varios software layers.
>=20
> On top of that I am thinking to solve the problem of migration in Qemu, by
> creating a 'vfio-nvme' driver which would bind vfio to bind to device exp=
osed by
> the kernel, and would pass through all the doorbells and queues to the gu=
est,
> while intercepting the admin queue. Such driver I think can be made to su=
pport
> migration while beeing able to run on top both SR-IOV device, my vfio-nvm=
e abit
> with double admin queue emulation (its a bit ugly but won't affect perfor=
mance
> at all) and on top of even regular NVME device vfio assigned to guest.

mdev-nvme seems like a duplication of SPDK.  The performance is not
better and the features are more limited, so why focus on this approach?

One argument might be that the kernel NVMe subsystem wants to offer this
functionality and loading the kernel module is more convenient than
managing SPDK to some users.

Thoughts?

Stefan

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJck7f3AAoJEJykq7OBq3PIdvQIAI2JvGRL95rIVTMNa1YDdkD4
F/zRh+BWQ0sd3UbWCyX9agIn0eshIVpQOqzW4mFi0+uUaetW/ZnMgXK/YtFZHf9m
U9i5OhXYH0OexOzqM+31wGHwJ6nUatzAsnoAelYoFIoWinLWiCyrF+u9o4CSvZBl
vXnKbYEN9HpfGSnqw64+qhAN7sSD8jSaQBPYHIJ40D5vaunOAW8erzR/MmOGWPvI
1ATq0cX8ScTVWhCKvfNeZtVYoBBtEC8sJ9amVeTbcKRSY4SbSk2Xephxi8eSwK48
AHVru89VPVuUJKqZbnxq909Ht2O0YoPQoP9FyFRko56coSE0L4TFldaF47PiiLQ=
=zWZp
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
