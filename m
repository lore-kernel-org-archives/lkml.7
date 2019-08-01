Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D89C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C1D206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbfHAT6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:58:13 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:53768 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388600AbfHAT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:58:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 006F340FC;
        Thu,  1 Aug 2019 19:58:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bird94_47673eb66b536
X-Filterd-Recvd-Size: 1978
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 19:58:09 +0000 (UTC)
Message-ID: <98acdfce0da0d7c3b33571528064935c107cbbc5.camel@perches.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Date:   Thu, 01 Aug 2019 12:58:08 -0700
In-Reply-To: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
References: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 22:29 +0300, Andy Shevchenko wrote:
> There were discussions in the past about use cases for
> simple_strto<foo>() functions and, in some rare cases,
> they have a benefit over kstrto<foo>() ones.
[]
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
[]
> @@ -334,8 +334,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> - * be checked.
> + * Used as a replacement for the simple_strtoull. Return code must be checked.

Using 'the' here is unnecessary and somewhat confusing.

Perhaps:

 * Preferred over simple_strtoull() unless the end position is required
 * Return value must be checked

> 

