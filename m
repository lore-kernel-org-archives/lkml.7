Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD51DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860592171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfHOKGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:06:15 -0400
Received: from verein.lst.de ([213.95.11.211]:45339 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOKGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:06:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AB6168AFE; Thu, 15 Aug 2019 12:06:11 +0200 (CEST)
Date:   Thu, 15 Aug 2019 12:06:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/radeon: handle PCIe root ports with addressing
 limitations
Message-ID: <20190815100610.GA28728@lst.de>
References: <20190815072703.7010-1-hch@lst.de> <20190815072703.7010-2-hch@lst.de> <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 08:34:10AM +0000, Koenig, Christian wrote:
> Looks sane to me. Reviewed-by: Christian König <christian.koenig@amd.com>.
> 
> Should we merge this through our normal amdgpu/radeon branches or do you 
> want to send this upstream somehow else?

This is intended for your trees.
