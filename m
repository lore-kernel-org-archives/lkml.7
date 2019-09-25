Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B3C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC6621D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390272AbfIYPm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:42:58 -0400
Received: from 8bytes.org ([81.169.241.247]:55902 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfIYPm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:42:58 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BA63F447; Wed, 25 Sep 2019 17:42:56 +0200 (CEST)
Date:   Wed, 25 Sep 2019 17:42:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Kurt Garloff <kurt@garloff.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: IOMMU vs Ryzen embedded EMMC controller
Message-ID: <20190925154256.GB4643@8bytes.org>
References: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de>
 <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de>
 <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 05:27:32PM +0200, Jiri Kosina wrote:
> On Sat, 21 Sep 2019, Kurt Garloff wrote:
> > [12916.740274] mmc0: sdhci: ============================================
> > [12916.740337] mmc0: error -5 whilst initialising MMC card
> 
> Do you have BAR memory allocation failures in dmesg with IOMMU on? 
> Actually, sharing both working and non-working dmesg, as well as 
> /proc/iomem contents, would be helpful.

Yes, can you please grab dmesg from a boot with iommu enabled and add
'amd_iommu_dump' to the kernel command line? That should give some hints
on what is going on.

Regards,

	Joerg
