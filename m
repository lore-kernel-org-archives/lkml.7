Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD07C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9502072B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLPLYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:24:12 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49862 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfLPLYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:24:01 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8C949200AC6;
        Mon, 16 Dec 2019 11:23:58 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id C8E3E20BBE; Mon, 16 Dec 2019 11:35:48 +0100 (CET)
Date:   Mon, 16 Dec 2019 11:35:48 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Simon Geis <simon.geis@fau.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH v3 08/10] PCMCIA/i82092: include <linux/io.h> instead of
 <asm/io.h>
Message-ID: <20191216103548.GH159459@light.dominikbrodowski.net>
References: <20191213135311.9111-1-simon.geis@fau.de>
 <20191213135311.9111-9-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213135311.9111-9-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:53:12PM +0100, Simon Geis wrote:
> Include the more general linux/io.h instead of asm/io.h
> as checkpatch suggests.
> 
> Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Simon Geis <simon.geis@fau.de>

Applied, thanks
	Dominik
