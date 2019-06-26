Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20B9C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DE0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfFZRlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:41:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:40948 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZRlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:41:42 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 655782AE;
        Wed, 26 Jun 2019 17:41:41 +0000 (UTC)
Date:   Wed, 26 Jun 2019 11:41:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: platform: Delete
 x86-laptop-drivers.txt
Message-ID: <20190626114140.52af4bb5@lwn.net>
In-Reply-To: <CAHp75Ve+v7o=Ar=5Vc7yZndCxUNf3sn8YwpCHXMwdeJxuLKMoA@mail.gmail.com>
References: <20190620183827.23704-1-puranjay12@gmail.com>
        <CAHp75Ve+v7o=Ar=5Vc7yZndCxUNf3sn8YwpCHXMwdeJxuLKMoA@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 22:50:17 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 20, 2019 at 9:38 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > The list of laptops supported by drivers in PDx86 subsystem is quite
> > big and growing. x86-laptop-drivers.txt contains details of very few
> > laptop models. Remove it because it does not  serve any purpose.
> >  
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

I have applied this, thanks.

jon
