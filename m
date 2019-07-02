Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D9AC06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DFD2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfGBPOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:14:33 -0400
Received: from 8bytes.org ([81.169.241.247]:33790 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfGBPOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:14:33 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 97E623D0; Tue,  2 Jul 2019 17:14:31 +0200 (CEST)
Date:   Tue, 2 Jul 2019 17:14:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     Zhangshaokun <zhangshaokun@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 2
Message-ID: <20190702151431.GC3310@8bytes.org>
References: <20190702195158.79aa5517@canb.auug.org.au>
 <000f56ac-2abc-bc6a-e2db-5ae38779d276@hisilicon.com>
 <20190702120321.v3224ofd4aaxvytk@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702120321.v3224ofd4aaxvytk@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 01:03:22PM +0100, Will Deacon wrote:
> Joerg -- please can you take this on top of the SMMUv3 patches queued
> for 5.3?

Applied, thanks.
