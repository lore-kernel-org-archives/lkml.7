Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC5C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B472133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfFZP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:28:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:40304 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfFZP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:28:19 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AE76C4BF;
        Wed, 26 Jun 2019 15:28:18 +0000 (UTC)
Date:   Wed, 26 Jun 2019 09:28:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: On Nitrokey Pro's ECC support
Message-ID: <20190626092817.3e5343e6@lwn.net>
In-Reply-To: <20190626152138.GA28688@chatter.i7.local>
References: <c9c1e7f83a55bc5fb621e2e4e1dab90c5b3aac01.camel@iki.fi>
        <20190626082541.2cd5897c@lwn.net>
        <20190626152138.GA28688@chatter.i7.local>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 11:21:38 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> >Maybe Konstantin (copied) might be willing to supply an update to the
> >document to reflect this?  
> 
> Hello:
> 
> I just sent a patch with updates that reflect ECC capabilities in newer 
> devices.

Hey, man, that took you just under an hour to get done.  We can't all just
wait around while you twiddle your thumbs... :)

Seriously, though, thanks for doing this,

jon
