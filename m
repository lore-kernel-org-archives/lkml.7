Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F113FC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ABB21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576034293;
	bh=kLxDvysWfIkrsHjdaUyETI6sk4hgGH41h30oWXgMtZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QresIXRw4TlqJekh7nzyX5q5neMgBcbrefjW4/caRahe1b1ZS2VrcbFeAxlhM2MRL
	 In72F9CTno/j2ftSdkUpakkOG+q73XVpx7/EnRsL8wCcBejEmXFsqx9icf4r1arH1g
	 jFTyJf603LAPlsGP6Tj0RSMNRj9KzlmtIHa3dIKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLKDSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfLKDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:18:12 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76DC020836;
        Wed, 11 Dec 2019 03:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576034291;
        bh=kLxDvysWfIkrsHjdaUyETI6sk4hgGH41h30oWXgMtZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aoe/Pi0EhdH/Wd6om7KZ13rv4vRlkKEO4OPEDvYo3wsTTbbbaOR0q/M7A1UeQXAak
         doHbNeuvVNZJ/y8l7yGpGQNUgYT9CjUXSSN2+ZrH/LrwOW1DwPzQUGdUNepHNg/Duk
         rJTQiSoLw84yO5iwLm95dcyd77t6uCDkzcj5xsTs=
Date:   Wed, 11 Dec 2019 11:18:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: lx2160a: add EMDIO1 and phy nodes
Message-ID: <20191211031802.GH15858@dragon>
References: <20191204165828.29893-1-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204165828.29893-1-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:58:26PM +0200, Ioana Ciornei wrote:
> This patch set adds the External MDIO1 node and the two
> RGMII PHYs connected to it.
> 
> Changes in v2:
>  - added a newline between nodes in 2/2
>  - moved the WRIOP node (sorted by unit address) in 1/2
> 
> Ioana Ciornei (2):
>   arm64: dts: lx2160a: add emdio1 node
>   arm64: dts: lx2160a: add RGMII phy nodes

Applied both, thanks.
