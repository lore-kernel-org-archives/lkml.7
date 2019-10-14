Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA4ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525CD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571053384;
	bh=y42jZmNs97lPpsMonWbWpkTNatYRIuNBn+7YgUpSTWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t9PjSc6BKmeCFDYtHmPe3VVPeSqKiiyl7UzKx64vl83UnH6719x1eyZwK+padOhI+
	 W4X04mTra8q6vl7RoioT1TBR1WiMO6st0AzjYzaza2F13YGQepqXRj5kcVfTV9LY3t
	 UO7vKurr4aswMSZjUPESyPhaUjEIRwPZSlyUSCoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfJNLnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730335AbfJNLnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:43:03 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF2C207FF;
        Mon, 14 Oct 2019 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571053382;
        bh=y42jZmNs97lPpsMonWbWpkTNatYRIuNBn+7YgUpSTWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzRVFy1T7t1VVVHi/ECepRBtSId5iIGP1qTxEBOSpulz4/9osVJPfPH92TNlnSrud
         VnZXkB7/sukmjlSd6yAexBO7LyaiCLgpw63YpbtmYeqn7qhtVmt/qepLnOwGJboCG8
         QczzUGccMpa3WbK8BzfPDD9wRA3JFSyBTWmWNH4s=
Date:   Mon, 14 Oct 2019 19:42:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: dts: imx7s: Correct GPT's ipg clock source
Message-ID: <20191014114246.GQ12262@dragon>
References: <1570409022-20442-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570409022-20442-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 08:43:42AM +0800, Anson Huang wrote:
> i.MX7S/D's GPT ipg clock should be from GPT clock root and
> controlled by CCM's GPT CCGR, using correct clock source for
> GPT ipg clock instead of IMX7D_CLK_DUMMY.
> 
> Fixes: 3ef79ca6bd1d ("ARM: dts: imx7d: use imx7s.dtsi as base device tree")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
