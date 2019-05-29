Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD486C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EF6239B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfE2ORB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:17:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:33178 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfE2ORB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:17:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,527,1549958400"; 
   d="scan'208";a="179591712"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2019 07:16:59 -0700
Received: from irsmsx103.ger.corp.intel.com ([169.254.3.133]) by
 IRSMSX101.ger.corp.intel.com ([169.254.1.10]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 15:16:58 +0100
From:   "Zavras, Alexios" <alexios.zavras@intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: RE: [GIT PULL] SPDX update for 5.2-rc1 - round 1
Thread-Topic: [GIT PULL] SPDX update for 5.2-rc1 - round 1
Thread-Index: AQHVFiBRwj4Amv2o30qKXyQ2uEjvW6aCFsaQ
Date:   Wed, 29 May 2019 14:16:58 +0000
Message-ID: <27E3B830FA35C7429A77DAEEDEB7344771E641C9@IRSMSX103.ger.corp.intel.com>
References: <20190521133257.GA21471@kroah.com>
 <20190529131300.GV3274@piout.net>
In-Reply-To: <20190529131300.GV3274@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: linux-spdx-owner@vger.kernel.org <linux-spdx-owner@vger.kernel.org>
> On Behalf Of Alexandre Belloni
> Sent: Wednesday, 29 May, 2019 15:13
> Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
> 
> Hello,
> 
> On 21/05/2019 15:32:57+0200, Greg KH wrote:
> >   - Add GPL-2.0-only or GPL-2.0-or-later tags to files where our scan
> 
> I'm very confused by those two tags because they are not mentioned in the
> SPDX 2.1 specification or the kernel documentation and seem to just be from
> https://spdx.org/ids-howi which doesn't seem to be versionned anywhere.
> While I understand the rationale behind those, I believe the correct way of
> introducing them would be first to add them in the spec and documentation
> and then make use of them.

The "GPL-2.0-only" and "GPL-2.0-or-later" are license short identifiers.
They do not belong to the SPDX spec, but rather on the license list.
They were introduced in the SPDX License List v3.0 (current version is 3.5):
https://spdx.org/licenses/ 

It seems the examples in the kernel documentation use identifiers
from earlier versions of the license list.


> Now, what should we do with all the GPL-2.0 and GPL-2.0+ tags that we have?

These are still valid identifiers (albeit deprecated), 
so there is no urgent need to have them replaced.

-- zvr -
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

