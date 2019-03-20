Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6CE2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfCTWYq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:24:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:12424 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfCTWYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:24:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 15:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,250,1549958400"; 
   d="scan'208";a="136018556"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2019 15:24:46 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.155]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.133]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 15:24:45 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "Joe Perches" <golf@perches.com>
CC:     Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] checkpatch: fix camel case seeding when run with --root
Thread-Topic: [PATCH] checkpatch: fix camel case seeding when run with --root
Thread-Index: AQHU2ss2CnInC/0Woki3g/1NaWN2raYU+4eAgACJHoD//5zfIA==
Date:   Wed, 20 Mar 2019 22:24:45 +0000
Message-ID: <02874ECE860811409154E81DA85FBB589232E843@ORSMSX121.amr.corp.intel.com>
References: <20190315010334.5707-1-jacob.e.keller@intel.com>
         <02874ECE860811409154E81DA85FBB589232E64D@ORSMSX121.amr.corp.intel.com>
 <52138d9db7b1765133f21fe08b0f3ad37da9d799.camel@perches.com>
In-Reply-To: <52138d9db7b1765133f21fe08b0f3ad37da9d799.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGRlOWQzNGUtMDRjOC00YWMyLWI4ODItNWI5NjNhYWNhODQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRVFqVnRDbjZ1YnVDN3h2MU5VMmFRVUV2TXZ2WjlQMThoU2s3UU9JVkJSa29JVFBiZHBjTCs1QjhcL0pBeXlBckIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Wednesday, March 20, 2019 2:18 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; linux-kernel@vger.kernel.org;
> apw@canonical.com; Joe Perches <golf@perches.com>
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev@vger.kernel.org
> Subject: Re: [PATCH] checkpatch: fix camel case seeding when run with --root
> 
> On Wed, 2019-03-20 at 20:09 +0000, Keller, Jacob E wrote:
> > > -----Original Message-----
> > > From: Keller, Jacob E
> > > Sent: Thursday, March 14, 2019 6:04 PM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev@vger.kernel.org;
> > > Keller, Jacob E <jacob.e.keller@intel.com>; joe@perches.com
> > > Subject: [PATCH] checkpatch: fix camel case seeding when run with --root
> > >
> > > checkpatch.pl avoids warning about camel case of some definitions by
> > > seeding a file that tracks all of the currently committed camel case
> > > definitions.
> > >
> > > To build this seed file, checkpatch.pl decides between using git or the
> > > --root parameter.
> > >
> > > This works as long as you don't run checkpatch.pl from within
> > > a different git tree that is not the Linux kernel.
> 
> Odd use case, but I'll forward it on as it doesn't
> seem to have any other effect.
> 
> cheers, Joe

We run checkpatch.pl on Linux driver code which is out-of-tree to start with, and then will eventually be migrated into the in-tree kernel later as we develop it.

Without this patch, the use of checkpatch.pl with --root causes bogus hits with camel case issues.

Thanks,
Jake
