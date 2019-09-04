Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F41C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67AA2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfIDT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:26:50 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:36854 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729740AbfIDT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:26:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2178C182CED5B;
        Wed,  4 Sep 2019 19:26:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sign82_1e205b955f54d
X-Filterd-Recvd-Size: 2459
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Sep 2019 19:26:46 +0000 (UTC)
Message-ID: <ab957f98a62390dbc603632704c60d39596095c1.camel@perches.com>
Subject: Re: [PATCH] media: siano: Use the correct style for SPDX License
 Identifier
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 12:26:45 -0700
In-Reply-To: <20190904160010.4532c3f5@coco.lan>
References: <20190831151147.GA7082@nishad>
         <20190904153432.7fb54f02@coco.lan> <20190904183608.GA495@kroah.com>
         <20190904160010.4532c3f5@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 16:00 -0300, Mauro Carvalho Chehab wrote:
> With Python, you can't even use the second line, as it is reserved
> for charset encoding. 
> 
> So, realistically, the SPDX header could be up to the third line of
> a given file.
> 
> Besides that, I vaguely remember some discussions we had, back on the
> days SPDX was introduced, envolving Thomas, Linus and others. My 
> understanding for such discussions is that something like this:
> 
> /*
>  * SPDX-License-Identifier: GPL-2.0+
>  *
>  * some other notes about the file
>  */
> 
> Would be acceptable, as the first line of the comment (with is at
> the beginning of the file) is the SPDX tag.

Using the 2nd line of a .[ch] file does not follow the
documented mechanisms.

Documentation/process/license-rules.rst-1. Placement:
Documentation/process/license-rules.rst-
Documentation/process/license-rules.rst-   The SPDX license identifier in kernel files shall be added at the first
Documentation/process/license-rules.rst:   possible line in a file which can contain a comment.  For the majority
Documentation/process/license-rules.rst:   of files this is the first line, except for scripts which require the
Documentation/process/license-rules.rst:   '#!PATH_TO_INTERPRETER' in the first line.  For those scripts the SPDX
Documentation/process/license-rules.rst:   identifier goes into the second line.


