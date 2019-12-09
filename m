Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F4C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492DF205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLIU7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:59:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:37072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfLIU7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:59:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 12:59:36 -0800
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="207033068"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 12:59:36 -0800
Message-ID: <bda264051bc86ad9674c655f3a0c91326088bcdd.camel@linux.intel.com>
Subject: Re: [PATCH] driver core: Fix test_async_driver_probe if NUMA is
 disabled
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Dec 2019 12:59:36 -0800
In-Reply-To: <20191209204440.GA1584@roeck-us.net>
References: <20191127202453.28087-1-linux@roeck-us.net>
         <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
         <377feb00-9288-e03c-b8a7-26ba87e24927@roeck-us.net>
         <b5826338cd4479b724835ea5469c5a8318e88e2c.camel@linux.intel.com>
         <dfc50096-d95f-8e57-4ba2-3fc122626af8@roeck-us.net>
         <f82041432512481569071a83e727cfb9f128126d.camel@linux.intel.com>
         <20191209204440.GA1584@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-09 at 12:44 -0800, Guenter Roeck wrote:
> On Wed, Dec 04, 2019 at 09:18:28AM -0800, Alexander Duyck wrote:
> > > I thought the code is specifically checking devices which it previously
> > > created, which are well defined and understood test devices. After all,
> > > the check is in the test driver's probe function. Guess I really don't
> > > understand the code. Please take my patch as bug report, and submit
> > > whatever fix you think is correct.
> > 
> > Sorry I had overlooked that this is the test code.
> > 
> > I suppose it should be fine since we specify the node ID for all instances
> > where we register an asychronous test device.
> > 
> 
> That isn't exacly an endorsement. Would you mind submitting a patch
> that is acceptable for you ? I'll be more than happy to test it.
> 
> Thanks,
> Guenter

It isn't really worth the trouble.

I would have been concerned if the patch was in something other than test
code, and I hasn't paid close attention to the specific file being edited.

Your patch is more than enough to address the original issue you reported.

Thanks.

Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

