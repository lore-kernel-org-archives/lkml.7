Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F53220656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfH0Uo0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:44:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:51798 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfH0UoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:44:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 13:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="209887206"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2019 13:44:24 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.103]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.221]) with mapi id 14.03.0439.000;
 Tue, 27 Aug 2019 13:44:24 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH -v2 0/5] Further sanitize INTEL_FAM6 naming
Thread-Topic: [PATCH -v2 0/5] Further sanitize INTEL_FAM6 naming
Thread-Index: AQHVXRDqlpnMikYX8Eizf6xwimEi3acPdVJg
Date:   Tue, 27 Aug 2019 20:44:23 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F43EC93@ORSMSX115.amr.corp.intel.com>
References: <20190827194820.378516765@infradead.org>
In-Reply-To: <20190827194820.378516765@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2Q4OGUyZGItOWU4Ni00ZDljLTljNTgtN2Q1NTBlM2NjYWU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia012dWtJZWE3UHltS2pvUEZKbEY0Q3p1N2NVOXN0RGJ3MVNwd0Jpd2dsdzAxenhINjdxSHE1MGVhWFF0Z0VzOCJ9
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

> I'm reposting because the version Ingo applied and partially fixed up still
> generates build bot failure.

Looks like this version gets them all. I built my standard config, allmodconfig and allyesconfig.

Reviewed-by: Tony Luck <tony.luck@intel.com>

What happens next? Will Ingo back out the previous set & his partial fixup and replace
with this series?  Or just slap one extra patch on top of what is already in tip?

First option changes a TIP branch

Second option leaves some bisection breakage in the history.

-Tony


