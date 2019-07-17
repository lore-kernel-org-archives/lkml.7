Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24698C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16B02173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfGQGvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:51:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:46893 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQGvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:51:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 23:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; 
   d="scan'208";a="195145932"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2019 23:51:13 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Shannon Nelson <snelson@pensando.io>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Christopher S . Hall" <christopher.s.hall@intel.com>
Subject: Re: [RFC PATCH 5/5] PTP: Add support for Intel PMC Timed GPIO Controller
In-Reply-To: <33864ede-1ce1-92f2-f049-a975060b2743@pensando.io>
References: <20190716072038.8408-1-felipe.balbi@linux.intel.com> <20190716072038.8408-6-felipe.balbi@linux.intel.com> <33864ede-1ce1-92f2-f049-a975060b2743@pensando.io>
Date:   Wed, 17 Jul 2019 09:51:13 +0300
Message-ID: <87h87l2ly6.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Shannon Nelson <snelson@pensando.io> writes:

> On 7/16/19 12:20 AM, Felipe Balbi wrote:
>> Add a driver supporting Intel Timed GPIO controller available as part
>> of some Intel PMCs.
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>
> Hi Felipe, just a couple of quick comments:
>
> There are several places where a line is continued on the next line, but 
> should be indented to match the opening parenthesis on a function call 
> or 'if' expression.
>
> Shouldn't there be a kthread_stop() in intel_pmc_tgpio_remove(), or did 
> I miss that somewhere?

Oops :-p

I could've sworn I had added it when disabling the pin. I'll review
that, sure.

-- 
balbi
