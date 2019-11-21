Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBECC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFB220878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUBZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:25:49 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:32924 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUBZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:25:49 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iXbE5-0005zr-FJ; Thu, 21 Nov 2019 09:25:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iXbDx-0002KX-Bf; Thu, 21 Nov 2019 09:25:33 +0800
Date:   Thu, 21 Nov 2019 09:25:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     linux@armlinux.org.uk, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, vincent.whitchurch@axis.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rabinv@axis.com,
        Richard.Earnshaw@arm.com
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read
 hazard
Message-ID: <20191121012533.3h6akm4oczswj7zr@gondor.apana.org.au>
References: <20191113104945.GC25900@willie-the-truck>
 <20191114132848.55atqtjshjmi2udl@gondor.apana.org.au>
 <20191120191839.GF4799@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120191839.GF4799@willie-the-truck>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 07:18:40PM +0000, Will Deacon wrote:
>
> > The Alpha barrier matters for pointers, how could it make a
> > difference for individual bits?
> 
> I guess you could use the result of test_bit to index into an array or
> something?

Can Alpha Assembly even do this without using a branch?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
