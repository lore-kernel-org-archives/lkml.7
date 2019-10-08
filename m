Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DA2C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60674206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfJHIvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:51:55 -0400
Received: from 8bytes.org ([81.169.241.247]:46442 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbfJHIvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:51:55 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1A49F3D0; Tue,  8 Oct 2019 10:51:54 +0200 (CEST)
Date:   Tue, 8 Oct 2019 10:51:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 5.4-rc2
Message-ID: <20191008085153.GA2514@8bytes.org>
References: <20191002131258.ne5r6clp7hq6lxmx@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002131258.ne5r6clp7hq6lxmx@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 02:12:59PM +0100, Will Deacon wrote:
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

Pulled, thanks Will.

