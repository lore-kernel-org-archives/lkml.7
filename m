Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF5EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC812184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfCTLtm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:49:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:13761 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfCTLtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:49:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 04:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="156659104"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2019 04:49:40 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 20 Mar 2019 04:49:40 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.121]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 19:49:38 +0800
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
Thread-Index: AQHU3n+esUAe9/isNUydLtMfe2TJLqYUYO3w
Date:   Wed, 20 Mar 2019 11:49:37 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439E48CA9@SHSMSX104.ccr.corp.intel.com>
References: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
        <1552378703-11202-2-git-send-email-yi.l.liu@intel.com>
 <20190319121416.27495651@x1.home>
In-Reply-To: <20190319121416.27495651@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzhmZGZlMjYtYzBmZi00ODEwLTliZjYtNTA1ODdkYWVhODg2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWG1MZFhZR0RFK3NcL1Q5aE5zNDk2YnA0XC81U2dLaER0clVNa3M0dXBwemY5KzVWVFBpQ2tKeERqUW5qaDNpcFV6In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, March 20, 2019 2:14 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
> 
> On Tue, 12 Mar 2019 16:18:22 +0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > This patch exports the following symbols from vfio-pci driver
> > for vfio-pci alike driver. e.g. vfio-pci-mdev driver
> >
> > *) vfio_pci_set_vga_decode();
> > *) vfio_pci_release();
> > *) vfio_pci_open();
> > *) vfio_pci_register_dev_region();
> > *) vfio_pci_ioctl();
> > *) vfio_pci_rw();
> > *) vfio_pci_mmap();
> > *) vfio_pci_request();
> > *) vfio_pci_probe_misc();
> > *) vfio_pci_remove_misc();
> > *) vfio_err_handlers;
> > *) vfio_pci_reflck_attach();
> > *) vfio_pci_reflck_put();
> 
> Exporting all these symbols scares me a bit.  They're GPL and we don't
> guarantee a kernel ABI, but I don't really want to support arbitrary
> use cases either.  What if we re-factored the shared bits into a common
> file and just linked them together?  Thanks,

Hi, Alex,

Before refactor the code, I'd like to check with you on the module
parameters for the two modules. The existing vfio-pci driver has
some module parameters. e.g. ids, nointxmask, disable_idle_d3.
For future usage and maintain, I think it is better to let the two
drivers have same parameters. However, I'm not 100% on whether
we want to allow user load vfio-pci.ko and vfio-pci-mdev.ko with
different parameter value? e.g. load vfio-pci.ko with nointxmask=false
while load vfio-pci-mdev.ko with nointxmask=true. How about your
opinion on it?

> 
> Alex

Thanks,
Yi Liu
