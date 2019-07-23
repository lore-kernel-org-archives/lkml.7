Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3EAC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEE0217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfGWPjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:39:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:46098 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfGWPjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:39:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 08:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="344776871"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2019 08:39:04 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpwsY-0004Nk-76; Tue, 23 Jul 2019 18:39:02 +0300
Date:   Tue, 23 Jul 2019 18:39:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
Message-ID: <20190723153902.GM9224@smile.fi.intel.com>
References: <cover.1550768574.git.hns@goldelico.com>
 <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
 <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:42:59AM +0200, Linus Walleij wrote:
> On Thu, Feb 21, 2019 at 6:03 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> > From: Linus Walleij <linus.walleij@linaro.org>
> 
> It is fair for you to change authorship to yourself at this point.
> Just keeping my Signed-off-by is sufficient.

...or Co-developed-by: can be used.

-- 
With Best Regards,
Andy Shevchenko


