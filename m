Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09996C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D1F20665
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfFPUsD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 16:48:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:31045 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfFPUsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 16:48:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 13:48:03 -0700
X-ExtLoop1: 1
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2019 13:48:03 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Jun 2019 13:48:03 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Jun 2019 13:48:02 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.187]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.210]) with mapi id 14.03.0439.000;
 Sun, 16 Jun 2019 14:48:00 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for FSGSBASE
Thread-Topic: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for
 FSGSBASE
Thread-Index: AQHVBb/wZjduerPLCE6RrgdTn3cIcqabVRAAgADdggCAAjFkAIAAMyQAgABBkwCAADJ4AIAACIuAgABO9AA=
Date:   Sun, 16 Jun 2019 20:48:00 +0000
Message-ID: <9DA78352-E4B8-4548-A593-35F4339AB1F9@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
 <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
 <EEACF240-4772-417A-B516-95D9003D0D11@intel.com>
 <89BE934A-A392-4CED-83E5-CA4FADDAE6DF@intel.com>
 <alpine.DEB.2.21.1906161038160.1760@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906161433390.1760@nanos.tec.linutronix.de>
 <62430B9C-95B6-4EB3-94FA-C16A02B9BD7C@intel.com>
 <alpine.DEB.2.21.1906161804570.1760@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906161804570.1760@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.190.226]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBAEF8FF942A9A4CAD7BD3C7ED679023@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 16, 2019, at 09:05, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Sun, 16 Jun 2019, Bae, Chang Seok wrote:
>> 
>> Thanks. This is the diff though.
>> ...
> 
> WHAT? How is this related ?

No. Sigh on me.. Instead of the garbage, I hoped to point out these small version things.
(The delta against the WIP.x86/cpu branch)

diff --git a/Documentation/x86/x86_64/fsgs.rst b/Documentation/x86/x86_64/fsgs.rst
index 380c0b5..d5588e00 100644
--- a/Documentation/x86/x86_64/fsgs.rst
+++ b/Documentation/x86/x86_64/fsgs.rst
@@ -125,7 +125,7 @@ FSGSBASE instructions enablement
 FSGSBASE instructions compiler support
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
+GCC version 6 and newer provide instrinsics for the FSGSBASE
 instructions. Clang supports them as well.
 
   =================== ===========================
@@ -141,7 +141,7 @@ code and the compiler option -mfsgsbase has to be added.
 Compiler support for FS/GS based addressing
 -------------------------------------------
 
-GCC version 6 and newer provide support for FS/GS based addressing via
+GCC version 4.6.4 and newer provide support for FS/GS based addressing via
 Named Address Spaces. GCC implements the following address space
 identifiers for x86:
