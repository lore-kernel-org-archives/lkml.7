Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B969C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfFFNii convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:38:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:45261 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfFFNii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:38:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 06:38:37 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2019 06:38:37 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 06:38:37 -0700
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 6 Jun 2019 06:38:37 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.13]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.51]) with mapi id 14.03.0415.000;
 Thu, 6 Jun 2019 16:38:35 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [char-misc-next 3/7] mei: docs: update mei documentation
Thread-Topic: [char-misc-next 3/7] mei: docs: update mei documentation
Thread-Index: AQHVHGoWO4Utlvjpi0SwPiedjXwn9KaOnBHA
Date:   Thu, 6 Jun 2019 13:38:34 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DC34206@hasmsx108.ger.corp.intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
 <20190603091406.28915-4-tomas.winkler@intel.com>
 <20190606131633.GA6083@kroah.com>
In-Reply-To: <20190606131633.GA6083@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.184.70.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, June 06, 2019 16:17
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Usyskin, Alexander <alexander.usyskin@intel.com>; linux-
> kernel@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>; linux-
> doc@vger.kernel.org
> Subject: Re: [char-misc-next 3/7] mei: docs: update mei documentation
> 
> On Mon, Jun 03, 2019 at 12:14:02PM +0300, Tomas Winkler wrote:
> > The mei driver went via multiple changes, update the documentation and
> > fix formatting.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  Documentation/driver-api/mei/mei.rst | 96
> > ++++++++++++++++++----------
> >  1 file changed, 61 insertions(+), 35 deletions(-)
> 
> This patch is corrupted and can not apply.  Did you try to edit it by hand after
> generating it?

I have a script that strips some internal metadata, now I see it has some issues with 'Notes:' keywords. 
I've checked sand only this patch is affected. 

> Can you resend it alone?
On the way.
Thanks
Tomas

