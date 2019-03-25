Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B47C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98E720883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfCYD2K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:28:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:24967 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfCYD2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:28:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 20:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="310110596"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2019 20:28:09 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 24 Mar 2019 20:28:09 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 24 Mar 2019 20:28:07 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.158]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.223]) with mapi id 14.03.0415.000;
 Mon, 25 Mar 2019 11:24:28 +0800
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
Subject: RE: [RFC PATCH 1/3] arch/x86: add ACRN hypervisor guest
Thread-Topic: [RFC PATCH 1/3] arch/x86: add ACRN hypervisor guest
Thread-Index: AQHU1IozWOWfBeGHH0aA1MWBA/FtoKYXVkiAgARpQTA=
Date:   Mon, 25 Mar 2019 03:24:28 +0000
Message-ID: <01363028D91B0B448414F51B4258CAA574CD37C0@SHSMSX101.ccr.corp.intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
 <1551924251-19466-2-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1903221615500.1729@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903221615500.1729@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjQ1ZjI1NmEtZjk2Ni00MmIyLTkxNWMtZWIwNGFmYzlkNjVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTDZFRkFjZWp1RDgzdlJwTXpCNW44OVFNS1FPTnAySHFFakNab2hcL3dsc1hCTnlKc2tIU3d2QXh6alNQSTljcEgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Tglx

       Thanks for your nice review. 
>-----Original Message-----
>From: Thomas Gleixner [mailto:tglx@linutronix.de]
>Sent: Friday, March 22, 2019 11:20 PM
>To: Zhao, Yakui <yakui.zhao@intel.com>
>Cc: linux-kernel@vger.kernel.org; x86@kernel.org; Chen, Jason CJ
><jason.cj.chen@intel.com>
>Subject: Re: [RFC PATCH 1/3] arch/x86: add ACRN hypervisor guest
>
>Zhao,
>
>On Thu, 7 Mar 2019, Zhao Yakui wrote:
>
>> ACRN is one open-source hypervisour, which is maintained by Linux
>> foundation. This is to add the para-virtualization support so that it
>> allows to enable the Linux guest on acrn-hypervisor.
>>
>> This adds x86_hyper_acrn into supported hypervisors array, which
>> enables ACRN services guest running on ACRN hypervisor. It is
>
>What is a ACRN services guest?

It should be "ACRN guest".

>
>> restricted to X86_64.
>>
>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>
>This SOB chain is wrong. If Jason wrote the patch, then there should be a
>'From: Jason ..' line at the top of the change log. If you both wrote it then
>Jason's SOB wants to be preceeded by a 'Co-developed-by: Jason....'
>line. See Documentation/process/

Sure. It will be updated to "Co-developed-by: Jason" in next version.

>
>> +config ACRN
>> +	bool "Enable services on ACRN hypervisor"
>> +	depends on X86_64 && PARAVIRT
>> +	help
>> +	  This option allows to run Linux as guest in ACRN hypervisor.
>> +	  It is needed if you want to run ACRN services linux on top of
>> +	  ACRN hypervisor.
>
>This help text does not make any sense to me.

"Enable Services on ACRN hypervisor" is a little confusing. 
In next version it will be changed to "ACRN_GUEST". How about the below:
config ACRN_GUEST
        bool "ACRN Guest Support"
        depends on X86_64 && PARAVIRT
        help
          This option allows to run Linux as guest in ACRN hypervisor. Enabling this will allow the
          kernel to boot in a paravirtualized environment under the  ACRN hypervisor

>
>> +const struct hypervisor_x86 x86_hyper_acrn = {
>> +	.name                   = "ACRN",
>> +	.detect                 = acrn_detect,
>> +	.type			= X86_HYPER_ACRN,
>> +	.init.init_platform     = acrn_init_platform,
>> +	.init.x2apic_available  = acrn_x2apic_available, };
>> +EXPORT_SYMBOL(x86_hyper_acrn);
>
>Whay is this exported? The only user of this is hypervisor.c and that is built in.
>Please remove.

You are right.
It will be removed and the x86_hyper_acrn will also be added into "__initconst" section.

>
>Thanks,
>
>	tglx
