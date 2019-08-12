Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B5EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2404C206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHLQJh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:09:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:45604 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfHLQJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:09:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 09:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="327396124"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2019 09:09:36 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.170]) with mapi id 14.03.0439.000;
 Mon, 12 Aug 2019 09:09:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "saurav.girepuneje@hotmail.com" <saurav.girepuneje@hotmail.com>
Subject: RE: [PATCH] arch: ia64: sn: pci: Use kmemdup in tioce_bus_fixup
Thread-Topic: [PATCH] arch: ia64: sn: pci: Use kmemdup in tioce_bus_fixup
Thread-Index: AQHVUCnb8RVTmMbfq0+HjsmDDpSBR6b3r8JA
Date:   Mon, 12 Aug 2019 16:09:35 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F41A62D@ORSMSX115.amr.corp.intel.com>
References: <20190811094748.GA26241@saurav>
In-Reply-To: <20190811094748.GA26241@saurav>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDg1M2U5YmQtNTI3YS00NjJkLWJjMTItYTdlNjY5OGNkZjZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMDA0bHdJWTVrc1dZUG5cL1wvcUttTVFiQ3lma1lVQXFnTDFhOFZTR1ZGTWpLSWpRZE5nZ2YybnZEdnUzbEZmeGpxIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/ia64/sn/pci/tioce_provider.c | 4 ++--

Thanks for the patch, but Christoph is working on a patch series that deletes all of arch/ia64/sn/

-Tony
