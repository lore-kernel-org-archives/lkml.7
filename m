Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09452C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9AA20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfGKDrB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 23:47:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:16529 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbfGKDrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:47:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 20:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="177043503"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2019 20:46:58 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 20:46:57 -0700
Received: from bgsmsx106.gar.corp.intel.com (10.223.43.196) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 20:46:57 -0700
Received: from bgsmsx101.gar.corp.intel.com ([169.254.1.46]) by
 BGSMSX106.gar.corp.intel.com ([169.254.1.194]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 09:16:54 +0530
From:   "Gote, Nitin R" <nitin.r.gote@intel.com>
To:     'Joe Perches' <joe@perches.com>, "corbet@lwn.net" <corbet@lwn.net>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
Subject: RE: [PATCH v4] Added warnings in checkpatch.pl script to :
Thread-Topic: [PATCH v4] Added warnings in checkpatch.pl script to :
Thread-Index: AQHVNm3hVzOhL9haf0KMxjtR64B8zqbCGIgAgAFiYNA=
Date:   Thu, 11 Jul 2019 03:46:53 +0000
Message-ID: <12356C813DFF6F479B608F81178A5615878BFA@BGSMSX101.gar.corp.intel.com>
References: <20190709154806.26363-1-nitin.r.gote@intel.com>
 <040b50f00501ae131256bb13a5362731ebdd6bfe.camel@perches.com>
In-Reply-To: <040b50f00501ae131256bb13a5362731ebdd6bfe.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGE2YzA0YmEtOGQ4MC00MTJkLTg5NTgtZDAwYTljOTVlYjYwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTlVmU3pPaTFySlpBV0ZVOEhBekFpcGYzQjJTS2JiZXAweWozOVBFeURlXC9TS3B1RVVtWHlnS21mUXBOQTduQTYifQ==
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Tuesday, July 9, 2019 9:40 PM
> To: Gote, Nitin R <nitin.r.gote@intel.com>; corbet@lwn.net
> Cc: akpm@linux-foundation.org; apw@canonical.com;
> keescook@chromium.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-hardening@lists.openwall.com
> Subject: Re: [PATCH v4] Added warnings in checkpatch.pl script to :
> 
> On Tue, 2019-07-09 at 21:18 +0530, NitinGote wrote:
> > From: Nitin Gote <nitin.r.gote@intel.com>
> >
> > 1. Deprecate strcpy() in favor of strscpy().
> > 2. Deprecate strlcpy() in favor of strscpy().
> > 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> >
> > Updated strncpy() section in Documentation/process/deprecated.rst
> > to cover strscpy_pad() case.
> 
> Please slow down your patch submission rate for this instance and respond
> appropriately to the comments you've been given.

Sure, I will explore this things more. And sorry, I missed to incorporate one comment. 
I will take care of such things.

> 
> This stuff is not critical bug fixing.
> 
Noted.

> The subject could be something like:
> 
> Subject: [PATCH v#] Documentation/checkpatch: Prefer strscpy over
> strcpy/strlcpy
> 

How about this  :
Subject: [PATCH v#] Doc/checkpatch: Prefer strscpy/strscpy_pad over strcpy/strlcpy/strncpy

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -605,6 +605,20 @@ foreach my $entry (keys %deprecated_apis) {  }
> > $deprecated_apis_search = "(?:${deprecated_apis_search})";
> >
> > +our %deprecated_string_apis = (
> > +        "strcpy"				=> "strscpy",
> > +        "strlcpy"				=> "strscpy",
> > +        "strncpy"				=> "strscpy, strscpy_pad or
> for non-NUL-terminated strings, strncpy() can still be used, but destinations
> should be marked with the __nonstring",
> 
> 'the' is not necessary.

Noted.

> 
> There could likely also be a strscat created for strcat, strlcat and strncat.
>

I have not found reference for strscat in kernel.
Could you please give any reference for strscat ?
 
> btw:
> 
> There were several defects in the kernel for misuses of strlcpy.
> 
> Did you or anyone else have an opinion on stracpy to avoid duplicating the
> first argument in a sizeof()?
> 
> 	strlcpy(foo, bar, sizeof(foo))
> to
> 	stracpy(foo, bar)
> 
> where foo must be char array compatible ?
> 
> https://lore.kernel.org/lkml/d1524130f91d7cfd61bc736623409693d2895f57.
> camel@perches.com/
> 
>

As I understood, your trying to give new interface like stracpy(), to avoid duplication of first 
argument in a sizeof(), we can also make it more robust for users by adding check or warn in 
checkpatch.pl to prefer stracpy().

Did you or anyone has opinion on this ?


Thanks,
Nitin Gote
