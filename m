Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B62BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCA621479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfEJT3f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:29:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:20934 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbfEJT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:29:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 12:29:34 -0700
X-ExtLoop1: 1
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2019 12:29:34 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 10 May 2019 12:29:34 -0700
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.121]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.86]) with mapi id 14.03.0415.000;
 Fri, 10 May 2019 12:29:33 -0700
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Andre Przywara <andre.przywara@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <James.Morse@arm.com>
Subject: RE: [PATCH v7 12/13] selftests/resctrl: Disable MBA and MBM tests
 for AMD
Thread-Topic: [PATCH v7 12/13] selftests/resctrl: Disable MBA and MBM tests
 for AMD
Thread-Index: AQHVB1dvBTxRScZUuEe/0MxFRkWs3KZkvcvg
Date:   Fri, 10 May 2019 19:29:34 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D8A3C19@ORSMSX106.amr.corp.intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
        <1549767042-95827-13-git-send-email-fenghua.yu@intel.com>
 <20190510184011.210794fc@donnerap.cambridge.arm.com>
In-Reply-To: <20190510184011.210794fc@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday, May 10, 2019 10:40 AM
> Andre Przywara [mailto:andre.przywara@arm.com] wrote:
> To: Yu, Fenghua <fenghua.yu@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>; Luck, Tony <tony.luck@intel.com>; Chatre, Reinette
> <reinette.chatre@intel.com>; Shankar, Ravi V <ravi.v.shankar@intel.com>;
> Shen, Xiaochen <xiaochen.shen@intel.com>; Pathan, Arshiya Hayatkhan
> <arshiya.hayatkhan.pathan@intel.com>; Prakhya, Sai Praneeth
> <sai.praneeth.prakhya@intel.com>; Babu Moger <babu.moger@amd.com>;
> linux-kernel <linux-kernel@vger.kernel.org>; James Morse
> <James.Morse@arm.com>
> Subject: Re: [PATCH v7 12/13] selftests/resctrl: Disable MBA and MBM tests
> for AMD
> 
> On Sat,  9 Feb 2019 18:50:41 -0800
> Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> Hi,
> 
> > From: Babu Moger <babu.moger@amd.com>
> >
> > For now, disable MBA and MBM tests for AMD. Deciding test pass/fail is
> > not clear right now. We can enable when we have some clarity.
> 
> I don't think this is the right way. The availability of features should be
> queryable, for instance by looking into /sys/fs/resctrl/info. Checking for a
> certain vendor to skip tests just sounds wrong to me, and is definitely not
> scalable or future proof.
> 
> We should really check the availability of a feature, then skip the whole
> subsystem test in resctrl_tests.c.

Babu may correct if I'm wrong: AMD does support the MBA and MBM features. So if querying the info directory, the features are there. But AMD doesn't want to support the testing for the features in the current patch set. They may support the testing in the future.

Thanks.

-Fenghua
