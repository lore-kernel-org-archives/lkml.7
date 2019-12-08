Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB0CC2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E145320637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLHVSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 16:18:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:41456 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfLHVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 16:18:00 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 054F5200ABF;
        Sun,  8 Dec 2019 21:09:39 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 5D6B520AC7; Sun,  8 Dec 2019 21:52:53 +0100 (CET)
Date:   Sun, 8 Dec 2019 21:52:53 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Simon Geis <simon.geis@fau.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH 09/12] PCMCIA: shorten the lines with over 80 characters
Message-ID: <20191208205253.GE240074@light.dominikbrodowski.net>
References: <20191208160947.20694-2-simon.geis@fau.de>
 <20191208160947.20694-10-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208160947.20694-10-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 05:09:44PM +0100, Simon Geis wrote:
> Adding a new variable 'int check' in 'i82092aa_interrupt' in which the
> flags are stored for comparison. This makes it possible to shorten 
> the lines to less than 80 characters.

... but this makes the code *less* readable, IMO. So this part of the patch
needs more thought, I think...

Thanks,
	Dominik
