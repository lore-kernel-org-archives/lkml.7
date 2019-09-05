Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A58C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5547322CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbfIEJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:28:09 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:55489 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727900AbfIEJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:28:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 714A418224D73;
        Thu,  5 Sep 2019 09:28:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk22_63dfa8e714b22
X-Filterd-Recvd-Size: 2042
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Sep 2019 09:28:06 +0000 (UTC)
Message-ID: <f65bf8e7bc3234358d5956f94e3b4df81bc204e6.camel@perches.com>
Subject: Re: [PATCH] media: siano: Use the correct style for SPDX License
 Identifier
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Sep 2019 02:28:05 -0700
In-Reply-To: <20190905055614.7958918b@coco.lan>
References: <20190831151147.GA7082@nishad>
         <20190904153432.7fb54f02@coco.lan> <20190904183608.GA495@kroah.com>
         <20190904160010.4532c3f5@coco.lan> <20190905055430.GA23826@kroah.com>
         <20190905055614.7958918b@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 05:56 -0300, Mauro Carvalho Chehab wrote:
> I'll accept
> this patch and keep such rule in mind for next SPDX changes.
> 
> Anyway, with regards to script, we need to change the rules in order to
> allow adding SPDX for python scripts, as otherwise the addition of SPDX
> headers may cause regressions.

Not really.

$ git grep -n '^# SPDX-License-Identifier' -- '*.py' | wc -l
62
$ git grep -n '^# SPDX-License-Identifier' -- '*.py' | \
  cut -f2 -d: | sort | uniq -c
     32 1
     27 2
      3 3
$ git grep -n '^# SPDX-License-Identifier' -- '*.py' | \
  cut -f1 -d: | xargs ./scripts/spdxcheck.py --verbose

License files:               14
Exception files:              2
License IDs                  19
Exception IDs                 2

Files checked:               62
Lines checked:               95
Files with SPDX:             62
Files with errors:            0


