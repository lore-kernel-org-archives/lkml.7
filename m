Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5352C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F83208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436756AbfHIPje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:39:34 -0400
Received: from 8bytes.org ([81.169.241.247]:48598 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436715AbfHIPje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:39:34 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F27853D0; Fri,  9 Aug 2019 17:39:32 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:39:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
 systems
Message-ID: <20190809153931.GG12930@8bytes.org>
References: <20190808101707.16783-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808101707.16783-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:17:07PM +0800, Kai-Heng Feng wrote:
> Raven Ridge systems may have malfunction touchpad or hang at boot if
> incorrect IVRS IOAPIC is provided by BIOS.
> 
> Users already found correct "ivrs_ioapic=" values, let's put them inside
> kernel to workaround buggy BIOS.

Will that still work when a fixed BIOS for these laptops is released?


	Joerg
