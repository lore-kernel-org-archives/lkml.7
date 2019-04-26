Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE68C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D78206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfDZO17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:27:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:35831 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfDZO17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:27:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 07:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="139069614"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2019 07:27:55 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hK1pS-0005IZ-7c; Fri, 26 Apr 2019 17:27:54 +0300
Date:   Fri, 26 Apr 2019 17:27:54 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Message-ID: <20190426142754.GU9224@smile.fi.intel.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
 <20190422210606.GA8805@kroah.com>
 <86ea407aaa891e50a3bdaf2c3653636a365076ee.camel@analog.com>
 <20190424133455.00002909@huawei.com>
 <20190425193736.GA11458@kroah.com>
 <CA+U=DsoyPQyNDX6CDx=xE73H9A=66BGKhTseEvZcZZPnpPAfQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsoyPQyNDX6CDx=xE73H9A=66BGKhTseEvZcZZPnpPAfQw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:29:11PM +0300, Alexandru Ardelean wrote:

> Hmm, I actually did not give much thought to that -1.
> I'll check into this and see about a V3.
> It may make more sense to just fix the original
> `__sysfs_match_string()`, but I'll need to go through the users of
> this function and see.

I was thinking about existing users of such (with "gaps") cases.
Not all of them have NULL there and would like to avoid some members.
Though, I think that we may ignore NULL items if -1 is supplied.

Think as well about ARRAY_SIZE() as given to that.

And consider to fix match_string() accordingly.

-- 
With Best Regards,
Andy Shevchenko


