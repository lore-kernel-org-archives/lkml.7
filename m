Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FAEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5858C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfC0Imo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:42:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:44922 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0Imo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:42:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 01:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="126242976"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2019 01:42:42 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 27 Mar 2019 01:42:41 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 27 Mar 2019 01:42:40 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.163]) with mapi id 14.03.0415.000;
 Wed, 27 Mar 2019 16:42:38 +0800
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
Thread-Index: AQHU3n+esUAe9/isNUydLtMfe2TJLqYUYO3wgAAAWwCAAvOvgIAE1eUAgAGyJzD//7LrAIABn1bQ
Date:   Wed, 27 Mar 2019 08:42:38 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439E4E815@SHSMSX104.ccr.corp.intel.com>
References: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
        <1552378703-11202-2-git-send-email-yi.l.liu@intel.com>
        <20190319121416.27495651@x1.home>
        <A2975661238FB949B60364EF0F2C257439E48CA9@SHSMSX104.ccr.corp.intel.com>
        <20190320132202.6279a190@x1.home>
        <A2975661238FB949B60364EF0F2C257439E4BBF2@SHSMSX104.ccr.corp.intel.com>
        <20190325121720.53935577@x1.home>
        <A2975661238FB949B60364EF0F2C257439E4DB32@SHSMSX104.ccr.corp.intel.com>
 <20190326093520.24c211ab@x1.home>
In-Reply-To: <20190326093520.24c211ab@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjk0OTIyOTYtZTZlOS00Y2IyLThjNDEtMTE1NTcwZDYzOTJhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVHBtaHpqWVFCRTdjK0REZ2c2RDZqRVB5cWtaTVc4Mk91cFB5SkZOeStIK3J0QzVIaXdvU29jRGFyYUxZN3JFaCJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, March 26, 2019 11:35 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
> 
> On Tue, 26 Mar 2019 12:37:37 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Tuesday, March 26, 2019 2:17 AM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
> > >
> > > On Sat, 23 Mar 2019 11:06:44 +0000
> > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > > > Hi Alex,
> >
> > [...]
> >
> > > >
> > > > I tried to get a common file which includes the definitions of the module
> > > > options and the common interfaces and get it linked separately with each
> > > > module. It works well when linked separately by config the
> > > > CONFIG_VFIO_PCI=m and CONFIG_VFIO_PCI_MDEV=m in kernel
> > > > configuration file. CONFIG_VFIO_PCI_MDEV is a new Kconfig macro
> > > > for the mdev wrapped version driver. However, if building the vfio-pci
> > > > and the mdev wrapped version into kernel image (config the
> > > > CONFIG_VFIO_PCI=y and CONFIG_VFIO_PCI_MDEV=y), then the symbols
> > > > defined in the common file will be shared thus doesn't allow dissimilar
> > > > user settings.
> > > >
> > > > Per my understanding, I think we expect to allow simultaneous usage of
> > > > the two drivers. So I think the way above doesn't meet our expectation.
> > >
> > > I agree.  They should be related in implementation only, from a user
> > > perspective they should be entirely separate.
> > >
> > > > I considered a possible proposal as below. May listen to your opinion
> > > > on it before heading to cook. Also, better idea is welcomed. :-)
> > > >
> > > > - get a common file includes interfaces which are common and have
> > > >   input parameters to differentiate the calling from vfio-pci and the
> > > >   wrapped version. e.g. vfio_pci_rw(). may call it as vfio_pci_common.c.
> > > >
> > > > - get another common file includes the definitions of the module options,
> > > >   and the functions which referred the options. Define all of them as static.
> > > >   may call it as common.c
> > > >
> > > > - get vfio_pci.c which includes the module_init/exit interfaces and driver
> > > >   registration operations of vfio-pci.ko. This file should include the
> common.c
> > > >   above to have same module options with the mdev wrapped version.
> > > >
> > > > - get vfio_pci_mdev.c which includes the module_init/exit interfaces and
> > > >   driver registration operations of vfio-pci-mdev.ko. It should also include
> > > >   the common.c above to have same module options with vfio-pci.ko.
> > > >
> > > > - Makefile:
> > > > vfio-pci-y := vfio_pci.o vfio_pci_common.o vfio_pci_intrs.o
> vfio_pci_rdwr.o
> > > vfio_pci_config.o
> > > > vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > > > vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
> > > >
> > > > vfio-pci-mdev-y := vfio_pci_mdev.o vfio_pci_common.o vfio_pci_intrs.o
> > > vfio_pci_rdwr.o vfio_pci_config.o
> > > > vfio-pci-mdev-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > > > vfio-pci-mdev-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
> > > >
> > > > obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
> > > > obj-$(CONFIG_VFIO_PCI_MDEV) += vfio-pci-mdev.o
> > >
> > > Each module needs it's own module_init/exit and will register its own
> > > struct pci_driver, which gives us separate control of the probe and
> >
> > Agreed.
> >
> > > remove callbacks.  I think we want the drivers to have the same module
> > > parameters initially, but we don't necessarily want to require it for
> > > any future options, so we can duplicate the parameter declarations.
> > > Then to support the shared code, I think we can easily push nointxmask,
> > > disable_vga, and disable_idle_d3 into bools on the struct
> > > vfio_pci_device, which would be allocated and set by each module's
> > > probe function before calling the shared probe function.
> >
> > sounds good to me.
> >
> > > vfio_fill_ids() could take a pointer to the array to keep them separate
> > > between modules.
> >
> > Agreed.
> >
> > > I think that just leaves the config permission bits,
> > > vfio_pci_{un}init_perm_bits(). Could we use a simple atomic reference
> > > counter on those to potentially share them so they get initialized by
> > > the first caller and freed by the last user, at least in the case of
> > > both drivers being compiled statically into the kernel?  Thanks,
> >
> > Sure, I can add it. The two modules will still share the cap_perms and
> > ecap_perms config bits when built statically in kernel. However, I think
> > such share is reasonable. I'll check if any other similar bits in other files.
> >
> > > Alex
> >
> > Thanks for the suggestions, Alex. Let me prepare another RFC.
> 
> Thank Yi, I appreciate your work on this.  Also, I wonder if we might
> want to reconsider placing this driver in samples, the Makefile might
> be a little bit ugly with paths back to drivers/vfio/pci, but I don't
> think we run into the same barriers as you did with previous
> approaches.  Placing it in samples would at least alleviate any
> confusion that this isn't a vfio-pci replacement, but more of an mdev
> wrapper proof of concept.  Thanks,

Hi Alex,

My pleasure. Honestly, placing this driver in samples is also my first
choice at the beginning. I didn't go ahead with it due to the fear of
huge code duplication with drivers/vfio/pci. I can make the changes
based on the discussions in this thread and place the wrapped driver
under samples with its Makefile path back to drivers/vfio/pci. I believe
letting Makefile paths back to drivers/vfio/pci is fine as there is existing
case of such manner in kernel. Pls feel free to let me know your latest
idea or anything I missed. Thanks.

Regards,
Yi Liu
