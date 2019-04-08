Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B3208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDHIFk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:05:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:12370 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:05:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 01:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="138430221"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2019 01:05:39 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 8 Apr 2019 01:05:39 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 8 Apr 2019 01:05:39 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.164]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.93]) with mapi id 14.03.0415.000;
 Mon, 8 Apr 2019 16:05:22 +0800
From:   "Wu, Binbin" <binbin.wu@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH] intel-lpss: Set the device in reset state when init
Thread-Topic: [PATCH] intel-lpss: Set the device in reset state when init
Thread-Index: AQHU7c6A3z56tKCXLUSePsHIjKPFo6YxW6oAgACMCYA=
Date:   Mon, 8 Apr 2019 08:05:21 +0000
Message-ID: <9A6FEF68D1963C4FAD959D223192905A72C12922@SHSMSX101.ccr.corp.intel.com>
References: <1554702118-20184-1-git-send-email-binbin.wu@intel.com>
 <20190408074302.GD3622@lahna.fi.intel.com>
In-Reply-To: <20190408074302.GD3622@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTZmYWUwNDgtM2QyNC00ZmViLTlkMjEtYjAyZWEwODY1MTJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSk1xMVFcLzRhbjJqdEh4WjJQTHpPbEdQOVN5aDlVbjRndlE0SHNWNDlXZDFMZkhlMkRsTGpHejFtMERcL2xMcmdKIn0=
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

Will correct the title line in the next version.
Thanks.

--
Best wishes,
Binbin


> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Monday, April 8, 2019 3:43 PM
> To: Wu, Binbin <binbin.wu@intel.com>
> Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org;
> gregkh@linuxfoundation.org; lee.jones@linaro.org; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org;
> andriy.shevchenko@linux.intel.com
> Subject: Re: [PATCH] intel-lpss: Set the device in reset state when init
> 
> On Mon, Apr 08, 2019 at 01:41:58PM +0800, Binbin Wu wrote:
> > In virtualized setup, when system reboots due to warm reset interrupt
> > storm is seen.
> >
> > Call Trace:
> > <IRQ>
> > dump_stack+0x70/0xa5
> > __report_bad_irq+0x2e/0xc0
> > note_interrupt+0x248/0x290
> > ? add_interrupt_randomness+0x30/0x220
> > handle_irq_event_percpu+0x54/0x80
> > handle_irq_event+0x39/0x60
> > handle_fasteoi_irq+0x91/0x150
> > handle_irq+0x108/0x180
> > do_IRQ+0x52/0xf0
> > common_interrupt+0xf/0xf
> > </IRQ>
> > RIP: 0033:0x76fc2cfabc1d
> > Code: 24 28 bf 03 00 00 00 31 c0 48 8d 35 63 77 0e 00 48 8d 15 2e
> > 94 0e 00 4c 89 f9 49 89 d9 4c 89 d3 e8 b8 e2 01 00 48 8b 54 24 18 <48>
> > 89 ef 48 89 de 4c 89 e1 e8 d5 97 01 00 84 c0 74 2d 48 8b 04
> > 24
> > RSP: 002b:00007ffd247c1fc0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffffda
> > RAX: 0000000000000000 RBX: 00007ffd247c1ff0 RCX: 000000000003d3ce
> > RDX: 0000000000000000 RSI: 00007ffd247c1ff0 RDI: 000076fc2cbb6010
> > RBP: 000076fc2cded010 R08: 00007ffd247c2210 R09: 00007ffd247c22a0
> > R10: 000076fc29465470 R11: 0000000000000000 R12: 00007ffd247c1fc0
> > R13: 000076fc2ce8e470 R14: 000076fc27ec9960 R15: 0000000000000414
> > handlers:
> > [<000000000d3fa913>] idma64_irq
> > Disabling IRQ #27
> >
> > To avoid interrupt storm, set the device in reset state before
> > bringing out the device from reset state.
> >
> > Signed-off-by: Binbin Wu <binbin.wu@intel.com>
> 
> I think the correct subject line should be:
> 
>  "mfd: intel-lpss: Set the device in reset state when init"
> 
> Regardless of that,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
