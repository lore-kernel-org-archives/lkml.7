Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F47C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA312086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436625AbfHIPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:33:45 -0400
Received: from 8bytes.org ([81.169.241.247]:48568 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406607AbfHIPdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:33:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3E5F93D0; Fri,  9 Aug 2019 17:33:44 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:33:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 22/57] iommu: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190809153342.GD12930@8bytes.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-23-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-23-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:15:22AM -0700, Stephen Boyd wrote:
> Please apply directly to subsystem trees

Applied, thanks.
