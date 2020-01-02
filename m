Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7822FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB59215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577965059;
	bh=dVLZU28mf4rEeV3D9kqoKamX2gSw2vFcl/WB8a+iNKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0DU9Km1mZjLI0LHF5/7A1r8/LpAnThE3+SZjw8ugCY696BGnBq/z6tdNtb27sgyGB
	 jxknEvjjPTxj0cOKpE2CrNOC9q1jIzDOfe7Sy/yJBoLup5GVoGM7E56liro3G7t9Jt
	 WOcY0EQpw7lSQIjNH8+J9Ah2eHwuJR0j+Vhd+0SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgABLhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgABLhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:37:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F0B215A4;
        Thu,  2 Jan 2020 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577965056;
        bh=dVLZU28mf4rEeV3D9kqoKamX2gSw2vFcl/WB8a+iNKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjpVsgNA64z8Vt+dlQ8jB6BAvdFasxa7kU/hOlfwIu/lcqYVrlgFNPZS+w87StMV4
         O1MGt0372QdKHtjdeXNwsanA4rmM77Vnn7nC5OidP4Zd4STOAkmg2w4AsqFPyUPdU6
         ft65Ts5RqXj1zksypEYRBMkZPxxSwngRZeMUqzKQ=
Date:   Thu, 2 Jan 2020 12:37:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: for 5.5 -rc
Message-ID: <20200102113723.GA3987146@kroah.com>
References: <20191231111541.29702-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231111541.29702-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 04:45:41PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.5 -rc cycle.
> 
> It includes a bunch of bug fixes for cpcap-usb PHY driver which is used
> for configuring USB PHY and debug UART used in certain Motorola droid4
> phones. It also includes a minor fix in qcom-qmp PHY driver and
> rockchip-inno-hdmi causing a display issue in RK3328.
> 
> Please see the tag message below for the complete list of changes and
> let me know If I have to change something.
> 
> Thanks
> Kishon
> 
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> 
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.5-rc

Pulled and pushed out, thanks.

greg k-h
