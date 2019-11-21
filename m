Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E58CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0BC20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKUKDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:03:31 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34062 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:03:25 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 34EEC200A6A;
        Thu, 21 Nov 2019 10:03:23 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 671FD200ED; Thu, 21 Nov 2019 11:03:14 +0100 (CET)
Date:   Thu, 21 Nov 2019 11:03:14 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: include cs_internal.h for missing declarations
Message-ID: <20191121100314.GE129595@light.dominikbrodowski.net>
References: <20191017114059.10989-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017114059.10989-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:40:59PM +0100, Ben Dooks (Codethink) wrote:
> Include cs_internal.h (and pcmcia/cistpl.h as required by
> cs_internal.h) for the declearions of cb_alloc and cb_free
> to silence the following sparse warnings;
> 
> drivers/pcmcia/cardbus.c:64:11: warning: symbol 'cb_alloc' was not declared. Should it be static?
> drivers/pcmcia/cardbus.c:103:6: warning: symbol 'cb_free' was not declared. Should it be static?

Applied to the pcmcia tree (but with ":" instead of ";")

Thanks,
	Dominik
