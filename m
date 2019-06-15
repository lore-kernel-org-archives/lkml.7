Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1773C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11A021848
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFOIod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 04:44:33 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49642 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbfFOIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 04:44:32 -0400
X-IronPort-AV: E=Sophos;i="5.63,377,1557180000"; 
   d="scan'208";a="387534746"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2019 10:44:31 +0200
Date:   Sat, 15 Jun 2019 10:44:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Ping CHNG <jack.ping.chng@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: drivers: Provide devm_platform_ioremap_resource_byname()
In-Reply-To: <48877575-90b9-3db5-7a25-53cf3817b2ee@web.de>
Message-ID: <alpine.DEB.2.21.1906151044160.2614@hadrien>
References: <39e46643-d799-94b7-4aa5-d6d99d738f99@web.de> <20190614133840.GN9224@smile.fi.intel.com> <20190614141004.GC7234@kroah.com> <20190614144706.GO9224@smile.fi.intel.com> <48877575-90b9-3db5-7a25-53cf3817b2ee@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jun 2019, Markus Elfring wrote:

> >> I don't like adding new apis with no user.
> >
> > Perhaps Jack Ping will send it as a first patch of his series where he utilizes
> > this functionality. Would it be acceptable?
>
> The proposed function can get wider application in a reasonable time frame
> if a corresponding script for the semantic patch language (Coccinelle software)
> would perform an automatic source code conversion (for example)
> according to your change acceptance.
> How do you think about to support a bit more collateral software evolution?

Why don't you just do what is asked for?

julia
