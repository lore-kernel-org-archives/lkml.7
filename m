Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288E320850
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfCKJ1K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:27:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:58611 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfCKJ1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:27:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 02:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,467,1544515200"; 
   d="scan'208";a="150541335"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2019 02:27:08 -0700
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.205]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.152]) with mapi id 14.03.0415.000;
 Mon, 11 Mar 2019 09:27:07 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Tony Jones <tonyj@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: RE: [PATCH v3 0/4] perf script python: add Python3 support
Thread-Topic: [PATCH v3 0/4] perf script python: add Python3 support
Thread-Index: AQHU1gumA3GbZN5o1kuYlU0u6ArAyaYGLLow
Date:   Mon, 11 Mar 2019 09:27:07 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C48CE08@IRSMSX106.ger.corp.intel.com>
References: <20190309000518.2438-1-tonyj@suse.de>
In-Reply-To: <20190309000518.2438-1-tonyj@suse.de>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzAyN2Q5N2MtODEyMy00ZTNlLWJhZWItY2FiNmViMmRlYTMzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTHZNWUxTQWlcL0VzbDN4bE85aG1SRktGNFROUEJMTUw2VVFKblhVSXI5TFwvOVwvc01GNSsybXRyU3hPYWhtMHIxVSJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tony Jones [mailto:tonyj@suse.de]
> Sent: Saturday, March 9, 2019 2:05 AM
> To: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org; acme@kernel.org; Tony Jones
> <tonyj@suse.de>; Hunter, Adrian <adrian.hunter@intel.com>; Arnaldo
> Carvalho de Melo <acme@redhat.com>; Seeteena Thoufeek
> <s1seetee@linux.vnet.ibm.com>
> Subject: [PATCH v3 0/4] perf script python: add Python3 support
> 
> This is v3 of my version of the patchset.
> 
> The exporter and viewer changes were all in one patch for V2.
> For V3 I split them into 3 patches for the reasons below.
> 
> Patch#1 adds Python3 support to exported-sql-viewer
> Patch#2 adds Python3 support to export-to-postgresql
> Patch#3 adds Python3 support to export-to-sqlite
> Patch#4 cleans up some repeated use of date functions in the code.
> 
> I added Adrian's signed-off-by to Patch#2 per the revised patch he sent in his
> review of V2.
> 
> The content of patches 1, 3 and 4 is unchanged from V2 but I'm including all
> the patches again to hopefully make your application easier. I added Adrian's
> Acked-by to Patch#4 per his review of that patch in V2.
> 
> Once these are applied I believe this is everything needed to run on a system
> without Python2.

All look fine to me.  Here is my ack as needed:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

