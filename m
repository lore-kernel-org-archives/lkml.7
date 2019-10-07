Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB80C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A664620679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfJGIOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:55208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbfJGIOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:14:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CD96AD45;
        Mon,  7 Oct 2019 08:14:13 +0000 (UTC)
Date:   Mon, 7 Oct 2019 10:14:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     akpm@linux-foundation.org
Cc:     andy.shevchenko@gmail.com, sergey.senozhatsky.work@gmail.com,
        hughd@google.com, uwe@kleine-koenig.org,
        jani.nikula@linux.intel.com, corbet@lwn.net,
        mike.kravetz@oracle.com, joe@perches.com, linux@rasmusvillemoes.dk,
        aarcange@redhat.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: Re: + printf-add-support-for-printing-symbolic-error-codes.patch
 added to -mm tree
Message-ID: <20191007081411.fyvbvnjbvmpi4nla@pathway.suse.cz>
References: <20191005215200.OEG97MjOa%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005215200.OEG97MjOa%akpm@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat 2019-10-05 14:52:00, Andrew Morton wrote:
> 
> The patch titled
>      Subject: vsprintf: add support for printing symbolic error codes
> has been added to the -mm tree.  Its filename is
>      printf-add-support-for-printing-symbolic-error-codes.patch

The patch is still under discussion. AFAIK, Rasmus is working on v4.
The main points are:

  + Rename the ambiguous "errcode" to "errname".

  + Introduce "%pe" instead of enhancing plain %p. First, the plain %p
    has become almost useless (hashing) on purpose (avoid leaking
    addresses). Second, we need something that will be explicitly
    used to print error codes.

  + Plus there are few more cosmetic issues.

I planed to take the patch via printk.git once ready.

Best Regards,
Petr
