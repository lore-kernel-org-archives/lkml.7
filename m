Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1709C20645
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfCJKYO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:24:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:46588 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfCJKYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:24:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2019 03:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,463,1544515200"; 
   d="scan'208";a="327213455"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2019 03:24:13 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 10 Mar 2019 03:24:13 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 10 Mar 2019 03:24:12 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.237]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.4]) with mapi id 14.03.0415.000;
 Sun, 10 Mar 2019 12:24:10 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc] mei: convert to SPDX license tags
Thread-Topic: [char-misc] mei: convert to SPDX license tags
Thread-Index: AQHU1ybJNips0XONy0yJUSiwdKR3g6YEn8Cw///mjYCAACHOQA==
Date:   Sun, 10 Mar 2019 10:24:10 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DAC7EF7@hasmsx108.ger.corp.intel.com>
References: <20190310100323.6912-1-tomas.winkler@intel.com>
 <20190310094817.GA2987@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DAC7ED3@hasmsx108.ger.corp.intel.com>
 <20190310102147.GA4603@kroah.com>
In-Reply-To: <20190310102147.GA4603@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.119.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Sun, Mar 10, 2019 at 10:14:03AM +0000, Winkler, Tomas wrote:
> > > Please break this up into two (at the least) patches and resend as a series.
> >
> > Can you be please,  more specific what split are you expecting.
> 
> You are doing lots of different types of things in the same patch.
> Break up the logical changes into different patches.  For example, one patch
> that updates copyright years, one that removes boiler plate license crud, and
> another that adds missing spdx lines.
Okay
Thanks
Tomas

