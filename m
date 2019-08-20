Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F50C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D984E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfHTOVB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:21:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:47343 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfHTOVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:21:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 07:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="262181576"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2019 07:20:50 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 20 Aug 2019 07:20:50 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.103]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.63]) with mapi id 14.03.0439.000;
 Tue, 20 Aug 2019 07:20:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Thread-Topic: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Thread-Index: AQHVVAtPItVoj2QCs0iMi5CgkdSiDKcEcSSA//+RyjWAAH7hAP//mwkO
Date:   Tue, 20 Aug 2019 14:20:49 +0000
Message-ID: <60F69B0F-F225-400E-B9D0-AFA69ABE2047@intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>,<20190820132212.GM30120@smile.fi.intel.com>
In-Reply-To: <20190820132212.GM30120@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Aug 7 10:17:27 2018 -0700
> 
>    x86/cpu: Sanitize FAM6_ATOM naming
> 
> 
> What 2 or 3 or other number means?

In this case I want it to mean “This is an Airmont derived core. Mostly like original Airmont, so you might see some places where we have the same model specific actions. But enough different that it has a new model ID so places where it is different can do something else”.

-Tony


