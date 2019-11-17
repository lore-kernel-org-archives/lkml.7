Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A301BC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6AB206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfKQLvx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 06:51:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:3898 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfKQLvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 06:51:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 03:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,316,1569308400"; 
   d="scan'208";a="236612782"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2019 03:51:52 -0800
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 17 Nov 2019 03:51:52 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 17 Nov 2019 03:51:51 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.215]) with mapi id 14.03.0439.000;
 Sun, 17 Nov 2019 19:51:50 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "kvm-pmu@eclists.intel.com" <kvm-pmu@eclists.intel.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 0/4] Enable PEBS when only have PEBS via PT w/o DS
Thread-Topic: [PATCH v1 0/4] Enable PEBS when only have PEBS via PT w/o DS
Thread-Index: AQHVmeoIPfTHl4y/ukGghigk57hp6aeLZhIAgAPdu5A=
Date:   Sun, 17 Nov 2019 11:51:49 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E17383C77D@SHSMSX104.ccr.corp.intel.com>
References: <1573672574-25247-1-git-send-email-luwei.kang@intel.com>
 <87h835edqn.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87h835edqn.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjA1ODg4MDgtZmI3NC00MmJkLTlhYjEtYjI1OGM0NTM1ZjRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYmk2cTBtajE1a0FReG1scldablh5ZGsxQkM5XC9QMndzd21OekowZ1A1dGh0R21aZlBsbFFHMUZDY1BPVjhYUVMifQ==
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
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Sent: Friday, November 15, 2019 4:38 PM
> To: Kang, Luwei <luwei.kang@intel.com>; kvm-pmu@eclists.intel.com
> Cc: ak@linux.intel.com; kan.liang@linux.intel.com; Kang, Luwei <luwei.kang@intel.com>; peterz@infradead.org; linux-
> kernel@vger.kernel.org; alexander.shishkin@linux.intel.com
> Subject: Re: [PATCH v1 0/4] Enable PEBS when only have PEBS via PT w/o DS
> 
> You forgot to CC Peter and LKML.
> 
> Luwei Kang <luwei.kang@intel.com> writes:
> 
> > This patchset is purely perf event system changes that to enable the
> > PEBS when the system only supports PEBS via Intel PT w/o DS.
> > Currently, there don't have such hardware which only supports PEBS via
> > PT w/o DS but it is possible in KVM guest. In Tremont Atom platforms,
> > PEBS via PT is the only way to enabled PEBS in KVM guest.
> 
> I don't understand what this says. If PEBS-via-PT is available and DS is not available, what happens and why?

This is an internal review before sending it to community.
In current software implementation, PEBS depends on the HW support of DS feature even if we have PEBS via PT( e.g. in intel_ds_init() function). This patchset just removes the dependency of PEBS and DS because there have a new path PEBS via Intel PT. I think there don't have any problem in host, but PEBS may not work in KVM guest when only have PEBS via PT w/o DS.

Thanks,
Luwei Kang

> 
> Regards,
> --
> Alex
