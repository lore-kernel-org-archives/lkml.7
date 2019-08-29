Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5A52189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfH2Nhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:37:43 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35770 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfH2Nhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:37:42 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3KcH-000130-QZ; Thu, 29 Aug 2019 15:37:33 +0200
Message-ID: <696734afb27182d7a1a9218dd3cfa01f47a76093.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Neville <dark@volatile.bz>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Aug 2019 15:37:32 +0200
In-Reply-To: <20190828204609.02a7ff70@TheDarkness>
References: <20190828204609.02a7ff70@TheDarkness>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 21:44 -0400, Alexander Neville wrote:
> The old driver had a bug that would cause it to outright stop working if
> the host's /dev/random were to block. Instead of trying to track down
> the cause of said bug, rewriting it from scratch turned out to be a much
> better option as it came with a few benefits:
> 
>  - The new driver properly registers itself as an hardware RNG.
> 
>  - The code is simpler and therefore easier to maintain.
> 
>  - It serves as a minimal example of writing a hardware RNG driver.
> 
> I also edited the Kconfig symbol to bring it up to more modern
> standards.

I realize that it's still easier to use, but theoretically you could
just use the virtio implementation, and use that driver with a suitable
small vhost device implementation. :-)

johannes

