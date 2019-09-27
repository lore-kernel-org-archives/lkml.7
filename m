Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29990C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E4021924
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfI0VuP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:50:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:46274 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0VuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:50:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 14:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="390116625"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2019 14:50:15 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Sep 2019 14:50:15 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Sep 2019 14:50:14 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 27 Sep 2019 14:50:14 -0700
Received: from crsmsx102.amr.corp.intel.com ([169.254.2.63]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.218]) with mapi id 14.03.0439.000;
 Fri, 27 Sep 2019 15:50:12 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v8 17/17] Documentation/x86/64: Add documentation for
 GS/FS addressing mode
Thread-Topic: [PATCH v8 17/17] Documentation/x86/64: Add documentation for
 GS/FS addressing mode
Thread-Index: AQHVaaXOiWvwyUABdEWVCmEO1Cb4fadAhXsAgAAG4IA=
Date:   Fri, 27 Sep 2019 21:50:11 +0000
Message-ID: <1273E528-944F-40B8-90C6-BAFE64ADB505@intel.com>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
 <1568318818-4091-18-git-send-email-chang.seok.bae@intel.com>
 <3942a0ed-2aa5-ff31-5f71-dcfa546e9def@infradead.org>
In-Reply-To: <3942a0ed-2aa5-ff31-5f71-dcfa546e9def@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.155.235]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34BAFB4F141B5C4C87671386FEAD1850@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 27, 2019, at 14:25, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Hi,
> Some doc comments/fixes below...
> 
> On 9/12/19 1:06 PM, Chang S. Bae wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 

[snip]

>> +There exist two mechanisms to read and write the FS/FS base address:
> 
>                                                    FS/GS

[snip]

>> + The arch_prctl(2) based mechanism is available on all 64bit CPUs and all
> 
>                                                          64-bit

[snip]

>> +	mov %reg, %gs:offset
>> \ No newline at end of file
> oops.

Thanks. Let me include this in my v9 submission.

Chang
