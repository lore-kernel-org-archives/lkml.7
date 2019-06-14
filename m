Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA0FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF5F2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfFNOrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:47:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:39119 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfFNOrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:47:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 07:47:10 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2019 07:47:07 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hbnTu-0007w7-JT; Fri, 14 Jun 2019 17:47:06 +0300
Date:   Fri, 14 Jun 2019 17:47:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drivers: Provide devm_platform_ioremap_resource_byname()
Message-ID: <20190614144706.GO9224@smile.fi.intel.com>
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de>
 <20190614133840.GN9224@smile.fi.intel.com>
 <20190614141004.GC7234@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614141004.GC7234@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:10:04PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 14, 2019 at 04:38:40PM +0300, Andy Shevchenko wrote:
> > +Cc: Jack Ping, who did internally the same
> > 
> > On Fri, Jun 14, 2019 at 03:26:25PM +0200, Markus Elfring wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Fri, 14 Jun 2019 15:15:14 +0200
> > > 
> > > The functions “platform_get_resource_byname” and “devm_ioremap_resource”
> > > are called together in 181 source files.
> > > This implementation detail can be determined also with the help
> > > of the semantic patch language (Coccinelle software).
> > > 
> > > Wrap these two calls into another helper function.
> > > Thus a local variable does not need to be declared for a resource
> > > structure pointer before and a redundant argument can be omitted
> > > for the resource type.
> > 
> > This one makes sense.
> > Though I'm not sure Greg will see your message.
> 
> Nope, didn't see it, don't want to see it, it will only cause more work
> in the longrun...
> 
> > Rafael, maybe you can apply this one?
> 
> Um, don't go around maintainers please, that's rude.  

I won't do it, how should we proceed if de facto this functionality is good to
have besides the fact of coming new user in the future?

> There is a reason
> this specific developer is in my blacklist, and perhaps they should be
> in yours as well :)

Perhaps.

> I don't like adding new apis with no user.

Perhaps Jack Ping will send it as a first patch of his series where he utilizes
this functionality. Would it be acceptable?

That's why I Cc'ed him as well.

-- 
With Best Regards,
Andy Shevchenko


