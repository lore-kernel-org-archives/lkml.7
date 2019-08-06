Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E93C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2EB216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbfHFP2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:28:14 -0400
Received: from 8bytes.org ([81.169.241.247]:48060 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbfHFP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:28:14 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4DEA53D5; Tue,  6 Aug 2019 17:28:13 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:28:12 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v2] iommu: arm-smmu-v3: Mark expected switch fall-through
Message-ID: <20190806152811.GD1198@8bytes.org>
References: <20190730152012.2615-1-anders.roxell@linaro.org>
 <20190730152600.643mg43y6567pchi@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730152600.643mg43y6567pchi@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 04:26:01PM +0100, Will Deacon wrote:
> Joerg -- if you'd like to pick this up as a fix, feel free, otherwise I'll
> include it in my pull request for 5.4.

Applied to iommu/fixes, thanks.
