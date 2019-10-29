Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287ECA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D6A20830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572313328;
	bh=ALunPfJtB8RbV0cQjCfp2WxTp3KG1vPT8vRZfOf8jOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1HE4VBkTDu5n9tT3Q9gv2EdSnP9KELecd9ZxNLdyyWohKcUtzFrco1wjw1nULI04Y
	 JjyRQ/C4bpnUQwTbk2MVNpbAEma1Tas2zs0an2ElFFEfWeq6wtd+O+ohRxdSkt46dA
	 hnauxQAeRqKXRKwtPbKDT/PlzcRiYi0zd+tvrbJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfJ2BmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfJ2BmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:42:07 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B0F20663;
        Tue, 29 Oct 2019 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572313326;
        bh=ALunPfJtB8RbV0cQjCfp2WxTp3KG1vPT8vRZfOf8jOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExgU/O/xUPZaE5t1oMZ0ZuyZg6DnNwnOc6ndbxxPozuugRdEDmgG06MGTx3H+Y5nn
         FhQmRSnNULgUxuPNdh+VmMPa67695oJZrKOvj6I5NKVFZhiOocRqjPWvLeOioeY+cG
         OO4EDfNHXXNgg0fitGm5X86KxI3hpH4miw+vfjAg=
Date:   Tue, 29 Oct 2019 09:42:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20191029014156.GP16985@dragon>
References: <20191029073838.146df408@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029073838.146df408@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:38:38AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   5a7fd0deda7a ("arm64: defconfig: Enable CONFIG_KEYBOARD_IMX_SC_KEY as module")
> 
> is missing a Signed-off-by from its committer.

Thanks much for reporting, Stephen.  I just got it fixed.

Shawn
