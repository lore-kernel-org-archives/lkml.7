Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F156320811
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfCUO7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:59:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:2400 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfCUO7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:59:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 07:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="157068148"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2019 07:59:01 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] docs: Explicitly state ordering requirements for Co-developed-by
In-Reply-To: <alpine.DEB.2.21.1903211537340.1784@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190320151140.32432-1-sean.j.christopherson@intel.com> <87lg18e4nx.fsf@intel.com> <20190321142622.GA6519@linux.intel.com> <alpine.DEB.2.21.1903211537340.1784@nanos.tec.linutronix.de>
Date:   Thu, 21 Mar 2019 17:00:45 +0200
Message-ID: <87ftrge0gy.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 21 Mar 2019, Sean Christopherson wrote:
>> On Thu, Mar 21, 2019 at 03:30:10PM +0200, Jani Nikula wrote:
>> Hmm, and my experience is exclusively limited to contributing code to
>> someone else's patches.  Rather than dictate exact ordering, what about
>> deferring to standard sign-off procedure?
>> 
>> E.g.:
>> 
>>   A Co-developed-by: states that the patch was also created by another developer
>>   along with the original author.  This is useful at times when multiple people
>>   work on a single patch.  Co-developed-by: must be immediately followed by a
>>   Signed-off-by: of the co-author(s).  As per standard sign-off procedure, the
>>   ordering of Co-developed-by:/Signed-off-by: pairs should reflect the patch's
>>   handling insofar as possible.  Notably, the last Signed-off-by: must always be
>>   that of the developer submitting the patch, regardless of whether they are the
>>   original author or a co-author.
>
> Yes, that makes sense.

Agreed.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
