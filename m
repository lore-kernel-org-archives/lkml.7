Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B305FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FE120820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408000AbfJQHQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:16:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:58545 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfJQHQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:16:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 00:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="208177221"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2019 00:16:29 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iL01M-0008Pi-8X; Thu, 17 Oct 2019 10:16:28 +0300
Date:   Thu, 17 Oct 2019 10:16:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 10/14] software node: rename is_array to is_inline
Message-ID: <20191017071628.GD32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-11-dmitry.torokhov@gmail.com>
 <20191014073720.GH32742@smile.fi.intel.com>
 <20191015182206.GF105649@dtor-ws>
 <20191016075940.GP32742@smile.fi.intel.com>
 <20191016165430.GD35946@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016165430.GD35946@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:54:30AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 16, 2019 at 10:59:40AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 15, 2019 at 11:22:06AM -0700, Dmitry Torokhov wrote:
> > > On Mon, Oct 14, 2019 at 10:37:20AM +0300, Andy Shevchenko wrote:
> > > > On Fri, Oct 11, 2019 at 04:07:17PM -0700, Dmitry Torokhov wrote:

> > > > 'stored inline' -> 'embedded in the &struct...' ?
> > > 
> > > I was trying to have a link "stored inline" -> "is_inline".
> > > 
> > > Do we want to change the flag to be "is_embedded"?
> > 
> > In dictionaries I have
> > 
> > embedded <-> unilateral
> 
> Are you trying to show synonym or antonym here? But I am pretty sure
> "unilateral" is either.

Antonyms. The 'unilateral' is marked as so in the dictionary.

> Antonyms for our use of "embedded" are likely "detached" or
> "disconnected".
> 
> > inline <-> ???
> 
> "out of line" but I still believe "stored separately" explains precisely
> what we have here.

No, 'out of line' is idiom with a special meaning.

-- 
With Best Regards,
Andy Shevchenko


