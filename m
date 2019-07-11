Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EBDC74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2622221019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfGKBDx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:03:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:52278 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGKBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 21:03:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 18:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="174010588"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2019 18:03:53 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 18:03:52 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 18:03:52 -0700
Received: from shsmsx106.ccr.corp.intel.com ([169.254.10.240]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.174]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 09:03:51 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Denis Efremov <efremov@linux.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ahci: Remove the exporting of ahci_em_messages
Thread-Topic: [PATCH] ahci: Remove the exporting of ahci_em_messages
Thread-Index: AQHVNzRORsXS/jaDikWyr5fUt3NLt6bEmZxA
Date:   Thu, 11 Jul 2019 01:03:51 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A60BCAAEE@SHSMSX106.ccr.corp.intel.com>
References: <20190710152923.25562-1-efremov@linux.com>
In-Reply-To: <20190710152923.25562-1-efremov@linux.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTE1OTJmZWItMTcwZS00M2ViLWFmMzUtZTQ4N2JmZjkxMDI2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMUZzSHlVYW9GK1BXRWpZV0RSY0MrbmlqVExsSjNGNjdcLzhrcnZEUDR4bzA0QVZCNEtGbDFWeW9GTTZUWDJ5eE0ifQ==
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Denis Efremov [mailto:efremov@linux.com]
> Sent: Wednesday, July 10, 2019 11:29 PM
> To: Liu, Chuansheng <chuansheng.liu@intel.com>
> Cc: Denis Efremov <efremov@linux.com>; Jens Axboe <axboe@kernel.dk>;
> linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] ahci: Remove the exporting of ahci_em_messages
> 
> The variable ahci_em_messages is declared static and marked
> EXPORT_SYMBOL_GPL, which is at best an odd combination. Because the
> variable is not used outside of the drivers/ata/libahci.c file it is
> defined in, this commit removes the EXPORT_SYMBOL_GPL() marking.

Sounds good to me, thanks.
Reviewed-by: Chuansheng Liu <chuansheng.liu@linux.intel.com>

