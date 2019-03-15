Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EE5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A29E218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfCOPYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:24:52 -0400
Received: from 8bytes.org ([81.169.241.247]:57910 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfCOPYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:24:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 72AA2329; Fri, 15 Mar 2019 16:24:50 +0100 (CET)
Date:   Fri, 15 Mar 2019 16:24:47 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] iommu/amd: Fix NULL dereference bug in
 match_hid_uid
Message-ID: <20190315152447.GA16974@8bytes.org>
References: <1552485204-11381-1-git-send-email-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552485204-11381-1-git-send-email-aaron.ma@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:53:24PM +0800, Aaron Ma wrote:
> Add a non-NULL check to fix potential NULL pointer dereference
> Cleanup code to call function once.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/iommu/amd_iommu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied with cleaned-up coding style and a Fixes tag, thanks.
