Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655AEC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD7821901
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfHGU0U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:26:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:43937 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbfHGU0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:26:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 13:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="168747316"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2019 13:26:18 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 7 Aug 2019 13:26:18 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.63]) with mapi id 14.03.0439.000;
 Wed, 7 Aug 2019 13:26:18 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     'Christoph Hellwig' <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     'Arnd Bergmann' <arnd@arndb.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'linux-ia64@vger.kernel.org'" <linux-ia64@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: remove sn2, hpsim and ia64 machvecs
Thread-Topic: remove sn2, hpsim and ia64 machvecs
Thread-Index: AQHVTSRfz+iOhLFk9UKAwDm9GuTPAKbv/SBAgAAkXyA=
Date:   Wed, 7 Aug 2019 20:26:17 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4143CB@ORSMSX115.amr.corp.intel.com>
References: <20190807133049.20893-1-hch@lst.de>
 <3908561D78D1C84285E8C5FCA982C28F7F41388B@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F41388B@ORSMSX115.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDQ3YzgwMjYtNDcwNi00NmM4LWI2NDEtMmE3NDhjYWIyNmNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS21ic3BtbkNTWVhab2NzZ1owaGlqd2NQMVVMWDFVXC8zb29nXC9jWGNRbGs5cmg0MmFBNnptXC85WEhiUmtJQlBSWiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Even if I explicitly run:
>
> $ make compressed
>
> It still doesn't build it.  Weird.

Ugh! The rule to do the compression was in arch/ia64/hp/sim/boot/Makefile
which went away as part of the deletion of hpsim.

-Tony
