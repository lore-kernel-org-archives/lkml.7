Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E6ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D52070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572090546;
	bh=HEElGzk65GBzExbILyhqFsb4zbZh3puZKjQps/d8zfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AnUyf3AeLUmK32qJVGTJNoj9AcKF5VNLOLow0uKBCrmW0Wi1GpVHFde+9pQJZSVmz
	 bkx1/5AbxQuMn2ltc23kI4U7jIJ6SwwR77dh50Qn+8bMjZymmYb+YjHcNNwdTKBglx
	 t0SDz9E9ychC1YRsMhfoCfGhI9M/4n4jmqYUKTao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfJZLtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfJZLtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:49:05 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99275206DD;
        Sat, 26 Oct 2019 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572090544;
        bh=HEElGzk65GBzExbILyhqFsb4zbZh3puZKjQps/d8zfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLmWLLym75gW8Jo25Tvk5fVHa5fMRHTMyOj/gMC+LVOs8KG8JXO4uJ3VN0asmNDIz
         iCOAU5/4sZGBuPAVVXL8/yqPv1IqDwSNNV42108h1vF8VMSCwjI+FUtvtE1aKUHusf
         RNq8I3nHPI3hyS08mfn8MhioUPgp3btrhQKeTxY0=
Date:   Sat, 26 Oct 2019 19:48:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: gpc: fix initialiser format
Message-ID: <20191026114849.GI14401@dragon>
References: <20191015140909.778-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015140909.778-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:09:09PM +0100, Ben Dooks wrote:
> Make the initialiers in imx_gpc_domains C99 format to fix the
> following sparse warnings:
> 
> drivers/soc/imx/gpc.c:252:30: warning: obsolete array initializer, use C99 syntax
> drivers/soc/imx/gpc.c:258:29: warning: obsolete array initializer, use C99 syntax
> drivers/soc/imx/gpc.c:269:34: warning: obsolete array initializer, use C99 syntax
> drivers/soc/imx/gpc.c:278:30: warning: obsolete array initializer, use C99 syntax
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks.
