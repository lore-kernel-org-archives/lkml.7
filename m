Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C6AC47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5B12087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pHzvRaMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfJaPWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:22:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfJaPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sgrMvBbAcxzy+4KwQdMq66yggcI8NHasGmiIST40A5M=; b=pHzvRaMdEqIFmWP8StXMN7OmI
        zOmpX6T+C1CCeXRvYooEkBsilXT4vwxlGygyrS/7mJ45389gEbcFnuKXNAgAv3bpaDYtVxv9Z7PL6
        MZowD9oZvLIkuH5TjdP4p/UrnhcuPTKYvYULOk2bKYFcQgxridU2jI2DGl0fMbebXFpopHuM0wEVY
        Bv0v693VGGqOpCJs/BKYoQJ3ImKDwTIPJvAl9p80hf64gtcW6DsPoJuS36o6UyzYiZqMhkqi+eFOX
        beJQ9G4dx4/QifUd4szCkNUcUhJTHLwu7/pE1Xeov0mDx3KbRkE5e6Kfm/7C8t2cRS8Z8DOYuh6x/
        HvP1ydz7w==;
Received: from [2601:1c0:6280:3f0::4ba1]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQCHP-0004Nz-2N; Thu, 31 Oct 2019 15:22:31 +0000
Subject: Re: linux-next: Tree for Oct 31 (gpu/drm/drm_dp_mst_topology.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20191031175224.2e313bef@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <423f4936-d979-5ce9-7c75-ec7973f108d9@infradead.org>
Date:   Thu, 31 Oct 2019 08:22:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031175224.2e313bef@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/19 11:52 PM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next releases on Friday (Nov 1) or Monday
> (Nov 4).
> 
> Changes since 20191030:
> 


on i386:

ld: drivers/gpu/drm/drm_dp_mst_topology.o: in function `__dump_topology_ref_history':
drm_dp_mst_topology.c:(.text+0xfeb): undefined reference to `__udivdi3'



-- 
~Randy

