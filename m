Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025D2C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 06:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03582084C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 06:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfGUGwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 02:52:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32979 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGUGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 02:52:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 93B38803CA; Sun, 21 Jul 2019 08:52:21 +0200 (CEST)
Date:   Sat, 20 Jul 2019 11:18:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Is Linux Kernel 5.2.1 able to support Intel Core i9-9980XE
 Extreme Edition or AMD Ryzen 9 3950X?
Message-ID: <20190720091835.GA1730@xo-6d-61-c0.localdomain>
References: <SG2PR01MB2141849E366930977335B8FD87C80@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB2141849E366930977335B8FD87C80@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-07-18 16:49:46, Turritopsis Dohrnii Teo En Ming wrote:
> Good morning from Singapore,
> 
> Is Linux Kernel 5.2.1 able to support Intel Core i9-9980XE Extreme Edition or AMD Ryzen 9 3950X?
> 
> Intel Core i9-9980XE Extreme Edition has 18 cores and 36 threads while AMD Ryzen 9 3950X has 16 cores and 32 threads.
> 
> Intel Core i9-9980XE Extreme Edition technical specifications:
> 
> https://ark.intel.com/content/www/us/en/ark/products/189126/intel-core-i9-9980xe-extreme-edition-processor-24-75m-cache-up-to-4-50-ghz.html
> 
> AMD Ryzen 9 3950X technical specifications:
> 
> https://www.amd.com/en/products/cpu/amd-ryzen-9-3950x
> 
> What I am trying to ask is, is Linux Kernel 5.2.1 able to support and make full use of so many CPU cores and so many threads?
> 

If your userland has enough paralelism, yes, you can use all the cores.

Build using make -j 36 will use them just fine.

									Pavel
