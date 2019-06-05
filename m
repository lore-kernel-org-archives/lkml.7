Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C22CC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128F820866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfFEJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:01:11 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:47647 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbfFEJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:01:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A54AA7584;
        Wed,  5 Jun 2019 09:01:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: noise93_270f2bb399346
X-Filterd-Recvd-Size: 1649
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Jun 2019 09:01:08 +0000 (UTC)
Message-ID: <fee93f8714deec96657e5b6df2a987960de4473f.camel@perches.com>
Subject: Re: [PATCH] pci: hotplug: ibmphp: Fix 'line over 80 characters'
 Warning
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        benniciemanuel78@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 05 Jun 2019 02:01:07 -0700
In-Reply-To: <CAHp75VfEREXJTr_QpADTsqBr10t16SaJqeM+tbxp6QZgc8Gfjg@mail.gmail.com>
References: <20190602162546.3470-1-benniciemanuel78@gmail.com>
         <CAHp75VfEREXJTr_QpADTsqBr10t16SaJqeM+tbxp6QZgc8Gfjg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 11:41 +0300, Andy Shevchenko wrote:
> On Sun, Jun 2, 2019 at 7:25 PM Emanuel Bennici
> <benniciemanuel78@gmail.com> wrote:
[]
> > +                               debug("%s - call process_changeinstatus for"
> > +                                     "slot[%d]\n", __func__, i);
> 
> Do not split string literals like this.

Especially because it's common to miss the
space required between words when the
compiler coalesces the string fragments.

Like here.

