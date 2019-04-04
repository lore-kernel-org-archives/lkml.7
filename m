Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2233204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfDDQyA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:54:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:34123 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfDDQx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:53:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 09:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="131480547"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 04 Apr 2019 09:53:57 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 4 Apr 2019 09:53:57 -0700
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 4 Apr 2019 09:53:56 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.94]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.30]) with mapi id 14.03.0415.000;
 Thu, 4 Apr 2019 10:53:54 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     William Kucharski <william.kucharski@oracle.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm/gup.c: fix the wrong comments
Thread-Topic: [PATCH] mm/gup.c: fix the wrong comments
Thread-Index: AQHU6rdootqQqf6MVU2Y2vuXC43Qn6YsVAoA///ka7A=
Date:   Thu, 4 Apr 2019 16:53:53 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79C99E19@CRSMSX101.amr.corp.intel.com>
References: <20190404072347.3440-1-sjhuang@iluvatar.ai>
 <3D9A544A-D447-4FD2-87A5-211588D6F3E5@oracle.com>
In-Reply-To: <3D9A544A-D447-4FD2-87A5-211588D6F3E5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWUxNTc1MTUtNzE0Yy00ZDI0LWI3OWMtMDlmNGMyZWI3YzJhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicTBnNXhTUlFqVktYb0lncnA4QVJsSFlLaHZIQ3VUTHdDUUVzQVJ0ODd6ZHFLVUtBYnlxZ09SNXkraEFZQXBcL2UifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Apr 4, 2019, at 1:23 AM, Huang Shijie <sjhuang@iluvatar.ai> wrote:
> >
> >
> > + * This function is different from the get_user_pages_unlocked():
> > + *      The @pages may has different page order with the result
> > + *      got by get_user_pages_unlocked().
> > + *
> 
> I suggest a slight rewrite of the comment, something like:
> 
> * Note this routine may fill the pages array with entries in a
> * different order than get_user_pages_unlocked(), which may cause
> * issues for callers expecting the routines to be equivalent.

This is good too.  :-D

Ira

