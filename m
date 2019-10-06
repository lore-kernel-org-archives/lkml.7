Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EA42087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfJFKJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:09:29 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:52988 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfJFKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:09:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0D0B318224D86;
        Sun,  6 Oct 2019 10:09:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: night97_5277490531e42
X-Filterd-Recvd-Size: 1619
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Oct 2019 10:09:26 +0000 (UTC)
Message-ID: <2ed3bf96312dbd9abcd626868ce84e01a066b201.camel@perches.com>
Subject: Re: [PATCH] staging: greybus: add blank line after declarations
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 06 Oct 2019 03:09:25 -0700
In-Reply-To: <20191006095042.GA2918514@kroah.com>
References: <20191005210046.27224-1-gabrielabittencourt00@gmail.com>
         <20191006095042.GA2918514@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-06 at 11:50 +0200, Greg KH wrote:
> On Sat, Oct 05, 2019 at 06:00:46PM -0300, Gabriela Bittencourt wrote:
> > Fix CHECK: add blank line after declarations
[]
> > diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
[]
> > @@ -24,6 +24,7 @@ struct gb_control {
> >  	char *vendor_string;
> >  	char *product_string;
> >  };
> > +
> >  #define to_gb_control(d) container_of(d, struct gb_control, dev)
> 
> No, the original code is "better" here, it's a common pattern despite
> what checkpatch.pl tells you, sorry.

Statistics please.

I believe it's not a common pattern.


