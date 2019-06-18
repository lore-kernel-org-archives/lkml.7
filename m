Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135ADC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9542085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560864492;
	bh=RDwm7cqlA7kxiru7hO8Sr4amKpAdU9f3OR/1UMtFrWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eNaG83fkFkiGqUhuj7BhPpqPam8msHl3ihzsKLRKSOp5xoYn8DIs4XQKfpypQ2miy
	 sQ+GATy+Zca4+AVm+CrQe6oIqZGIXba+iBTYzq21K762E+8D0+/FqmepgxGgM6RTHG
	 dlRigLMe3DZGNvB0M8Qxv/M+kQeOCGkjcUAsQEKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfFRN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRN2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:28:10 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B1342085A;
        Tue, 18 Jun 2019 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560864489;
        bh=RDwm7cqlA7kxiru7hO8Sr4amKpAdU9f3OR/1UMtFrWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVSSL5HK1R3vnjfDctoFE3waIkcb/NhczSYPrD/DsZS0GN4oufPLVigDpVDVaGrRU
         aUUuDUkz6EziUmDzVB7/8cd/5G2msenFLrxZ+YN+xZAyRrzfg9STDzluMt1B4f0LP6
         HWE2pCLJddjYTAIbOGzMlffWuB1A+KLHYfOjjP1M=
Date:   Tue, 18 Jun 2019 21:27:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V2] soc: imx8: Use existing of_root directly
Message-ID: <20190618132713.GG1959@dragon>
References: <20190618094338.11183-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618094338.11183-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 05:43:38PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> There is common of_root for reference, no need to find it
> from DT again, use of_root directly to make driver simple.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
