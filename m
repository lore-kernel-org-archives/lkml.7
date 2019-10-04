Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9EC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4612133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ITH2eGdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfJDOyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:54:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388870AbfJDOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gTXRQBbhy1ecaEZJAUNNxhjec8+HvQ9vY4ubPHtV8dE=; b=ITH2eGdB8rd5ve8IB36pLbbOA
        CH+AoVH2wSGY542uFnBO99w5AGjDmY9HZrE/M4VrsCNMH6h2K+69Xxfm9l03VVs68BGUm+5GJm1CD
        hpPnKVPZFEdowycUGDvaiHKrZAtR4RSZU/0es8+c9KDXwkdsg5gTggbMvfymrJXNH//0M2lQexOS0
        /G7zF7FnOIkXmKbiPsENe/6zV02l3BfkFlg4Rljhr0rI11MEBOUpxlnUyT4wUVeRqI1mbjhJvShwi
        NfnHXn3mptwNiylcaxiCvDfA86oUdIKI05GywXwzeJKoSOmy3UyUHmhLP6eDP+1YNzWq51ilCSsLe
        BBs/bKEEg==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGOyd-00058J-UY; Fri, 04 Oct 2019 14:54:39 +0000
Subject: Re: linux-next: Tree for Oct 4 (amdgpu)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20191004155929.3ac043b5@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <06969836-ac7f-0d18-1866-159e48018d98@infradead.org>
Date:   Fri, 4 Oct 2019 07:54:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004155929.3ac043b5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/19 10:59 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191003:
> 

on x86_64:
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMDGPU_GART_DEBUGFS=y

ld: drivers/gpu/drm/amd/amdkfd/kfd_device.o:(.rodata+0xf60): undefined reference to `gfx_v7_kfd2kgd'

-- 
~Randy
