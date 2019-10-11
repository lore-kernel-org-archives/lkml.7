Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E529ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A03E21835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfJKUGl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:50453 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfJKUGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 13:06:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,285,1566889200"; 
   d="scan'208";a="194433064"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2019 13:06:38 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 13:06:38 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.88]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.232]) with mapi id 14.03.0439.000;
 Fri, 11 Oct 2019 13:06:38 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: RE: linux-next: Fixes tag needs some work in the net tree
Thread-Topic: linux-next: Fixes tag needs some work in the net tree
Thread-Index: AQHVf+n3tASYqcvLsUKPslnmzJJ6DKdV3oNQ
Date:   Fri, 11 Oct 2019 20:06:38 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5896925B2B@ORSMSX121.amr.corp.intel.com>
References: <20191011151117.46bc6981@canb.auug.org.au>
In-Reply-To: <20191011151117.46bc6981@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWY3NWE2YTEtZDgwNS00YWUzLTgxMTItZmVlZGYyNWZlOTJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRERKXC9aOHVQYWt2a0lcL0JRM29ZRjZ5b3M1YmdKQXVBQ0M3XC9KcG91V1B4eUo1aDhvdm9HM0RvWDNSXC9ReTFMRWgifQ==
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

> -----Original Message-----
> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
> Behalf Of Stephen Rothwell
> Sent: Thursday, October 10, 2019 9:11 PM
> To: David Miller <davem@davemloft.net>; Networking
> <netdev@vger.kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Jakub Kicinski <jakub.kicinski@netronome.com>
> Subject: linux-next: Fixes tag needs some work in the net tree
> 
> Hi all,
> 
> In commit
> 
>   2168da459404 ("net: update net_dim documentation after rename")
> 
> Fixes tag
> 
>   Fixes: 8960b38932be ("linux/dim: Rename externally used net_dim members",
> 2019-06-25)
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> Fixes tag
> 
>   Fixes: c002bd529d71 ("linux/dim: Rename externally exposed macros", 2019-06-
> 25)
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'

Right, that was my mistake. I have an alias for this that is what was used by other projects (which prefer adding the date), and it's supposed to be set to only this in my local tree for the kernel, but not sure what happened there.

> --
> Cheers,
> Stephen Rothwell
