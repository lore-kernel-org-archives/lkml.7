Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F251C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39984218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCWLGt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:06:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:28080 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfCWLGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:06:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 04:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="136590245"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2019 04:06:48 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 23 Mar 2019 04:06:48 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 23 Mar 2019 04:06:47 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.26]) with mapi id 14.03.0415.000;
 Sat, 23 Mar 2019 19:06:45 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
Thread-Topic: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
Thread-Index: AQHU3n+esUAe9/isNUydLtMfe2TJLqYUYO3wgAAAWwCAAvOvgA==
Date:   Sat, 23 Mar 2019 11:06:44 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439E4BBF2@SHSMSX104.ccr.corp.intel.com>
References: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
        <1552378703-11202-2-git-send-email-yi.l.liu@intel.com>
        <20190319121416.27495651@x1.home>
        <A2975661238FB949B60364EF0F2C257439E48CA9@SHSMSX104.ccr.corp.intel.com>
 <20190320132202.6279a190@x1.home>
In-Reply-To: <20190320132202.6279a190@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjM4MjM5NjItNzRlNS00NmIzLTgxYzgtZmJiNjcxZTIxYjUwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMUpWb2pEZEpTeld4KzVLY3kzbThrcmdkNzF0OFN1cytLT29aczQzUWg5Q2JvMzZ2WVwvXC9NSVJpc3hmSVlIalBlIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Thursday, March 21, 2019 3:22 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
> 
> On Wed, 20 Mar 2019 11:49:37 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Wednesday, March 20, 2019 2:14 AM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
> > >
> > > On Tue, 12 Mar 2019 16:18:22 +0800
> > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > >
> > > > This patch exports the following symbols from vfio-pci driver
> > > > for vfio-pci alike driver. e.g. vfio-pci-mdev driver
> > > >
> > > > *) vfio_pci_set_vga_decode();
> > > > *) vfio_pci_release();
> > > > *) vfio_pci_open();
> > > > *) vfio_pci_register_dev_region();
> > > > *) vfio_pci_ioctl();
> > > > *) vfio_pci_rw();
> > > > *) vfio_pci_mmap();
> > > > *) vfio_pci_request();
> > > > *) vfio_pci_probe_misc();
> > > > *) vfio_pci_remove_misc();
> > > > *) vfio_err_handlers;
> > > > *) vfio_pci_reflck_attach();
> > > > *) vfio_pci_reflck_put();
> > >
> > > Exporting all these symbols scares me a bit.  They're GPL and we don't
> > > guarantee a kernel ABI, but I don't really want to support arbitrary
> > > use cases either.  What if we re-factored the shared bits into a common
> > > file and just linked them together?  Thanks,
> >
> > Hi, Alex,
> >
> > Before refactor the code, I'd like to check with you on the module
> > parameters for the two modules. The existing vfio-pci driver has
> > some module parameters. e.g. ids, nointxmask, disable_idle_d3.
> > For future usage and maintain, I think it is better to let the two
> > drivers have same parameters. However, I'm not 100% on whether
> > we want to allow user load vfio-pci.ko and vfio-pci-mdev.ko with
> > different parameter value? e.g. load vfio-pci.ko with nointxmask=false
> > while load vfio-pci-mdev.ko with nointxmask=true. How about your
> > opinion on it?
> 
> Hi Yi,
> 
> I agree that it makes sense to retain the module options for the mdev
> wrapped version, but I expect we should also allow dissimilar user
> settings.  If those lived in the common code that gets linked separately
> with each module, that should work fine, I think.  We can worry about
> refactoring for future driver that might not want those options later.

Hi Alex,

I tried to get a common file which includes the definitions of the module
options and the common interfaces and get it linked separately with each
module. It works well when linked separately by config the
CONFIG_VFIO_PCI=m and CONFIG_VFIO_PCI_MDEV=m in kernel
configuration file. CONFIG_VFIO_PCI_MDEV is a new Kconfig macro
for the mdev wrapped version driver. However, if building the vfio-pci
and the mdev wrapped version into kernel image (config the
CONFIG_VFIO_PCI=y and CONFIG_VFIO_PCI_MDEV=y), then the symbols
defined in the common file will be shared thus doesn't allow dissimilar
user settings.

Per my understanding, I think we expect to allow simultaneous usage of
the two drivers. So I think the way above doesn't meet our expectation.
I considered a possible proposal as below. May listen to your opinion
on it before heading to cook. Also, better idea is welcomed. :-)

- get a common file includes interfaces which are common and have
  input parameters to differentiate the calling from vfio-pci and the
  wrapped version. e.g. vfio_pci_rw(). may call it as vfio_pci_common.c.

- get another common file includes the definitions of the module options,
  and the functions which referred the options. Define all of them as static.
  may call it as common.c

- get vfio_pci.c which includes the module_init/exit interfaces and driver
  registration operations of vfio-pci.ko. This file should include the common.c
  above to have same module options with the mdev wrapped version.

- get vfio_pci_mdev.c which includes the module_init/exit interfaces and
  driver registration operations of vfio-pci-mdev.ko. It should also include
  the common.c above to have same module options with vfio-pci.ko.

- Makefile:
vfio-pci-y := vfio_pci.o vfio_pci_common.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o

vfio-pci-mdev-y := vfio_pci_mdev.o vfio_pci_common.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
vfio-pci-mdev-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
vfio-pci-mdev-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o

obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
obj-$(CONFIG_VFIO_PCI_MDEV) += vfio-pci-mdev.o

Thanks,
Yi Liu

