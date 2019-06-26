Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAEEC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D202085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfFZOZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:25:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:40056 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfFZOZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:25:43 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1305C2AE;
        Wed, 26 Jun 2019 14:25:43 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:25:41 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Subject: Re: On Nitrokey Pro's ECC support
Message-ID: <20190626082541.2cd5897c@lwn.net>
In-Reply-To: <c9c1e7f83a55bc5fb621e2e4e1dab90c5b3aac01.camel@iki.fi>
References: <c9c1e7f83a55bc5fb621e2e4e1dab90c5b3aac01.camel@iki.fi>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 17:11:46 +0300
Jarkko Sakkinen <jarkko.sakkinen@iki.fi> wrote:

> I was getting myself a smartcard stick and looked for options from [1].
> The documentation says that Nitrokey Pro does not support ECC while it
> actually does [2]. I was already canceling my order when Jan Suhr, the
> CEO of that company, kindly pointed out to me this.
> 
> [1] https://www.kernel.org/doc/html/latest/process/maintainer-pgp-guide.html
> [2] https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3

Maybe Konstantin (copied) might be willing to supply an update to the
document to reflect this?

Thanks,

jon
