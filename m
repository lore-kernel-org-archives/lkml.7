Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F50C2D0CA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E007C206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576145822;
	bh=JoDcYEvG7zpceyqUHXgQlnP+hg+AM0QPa/7Dc2/+Iq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g+n32B74423NAVqn+dhSS1HnfCacu4P0nxnJ19nVTz949klCacCRRqi8jKDxDeywf
	 idwJ4NDrxcassrs5HltXicAyEUC2a5Si6t8pUI4+yFIRY12fZ4aCkway3YTfHs01E+
	 Gn21HZJSNIW1vdnmAUgJ/xGrkHbBvscMYclw47hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfLLKRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:17:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfLLKRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:17:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D532173E;
        Thu, 12 Dec 2019 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576145819;
        bh=JoDcYEvG7zpceyqUHXgQlnP+hg+AM0QPa/7Dc2/+Iq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WX8TNnVhicst0bwMRBSe6lp41HNZulLKkhFuRsNRP/8vQY682MbMjZIdACs/lyTEE
         q61Wz/BPE1Q7BomxD6lCOfy8k9JlVbpQURxdODWnj+mxFTIvcKuZHd1/jyDBJCYUEz
         rjM8zTPNfyf+YLyN5iBTym3kMCQtj32wDuFaHzWc=
Date:   Thu, 12 Dec 2019 10:16:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/24] compat: ARM64: always include asm-generic/compat.h
Message-ID: <20191212101654.GA12950@willie-the-truck>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211204306.1207817-2-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:42:35PM +0100, Arnd Bergmann wrote:
> In order to use compat_* type defininitions in device drivers
> outside of CONFIG_COMPAT, move the inclusion of asm-generic/compat.h
> ahead of the #ifdef.
> 
> All other architectures already do this.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/compat.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

(Please let me know if you'd prefer this patch to be routed via the arm64
tree).

Will
