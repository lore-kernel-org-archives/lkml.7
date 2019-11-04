Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D3CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6722021D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572831026;
	bh=zRruFl5aWKeVnB/KgtmxCkK8RaqiUCdgP2GFJ2RerMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZoNLtNDHy2RcUceLYjieDQ6l9KGYdx+oxSfR8C+dzQIkRoh7Yo/Kivqw4xroOLHp8
	 Mw9qMrL7unPy64TmRVtgteKW8jFW5ZCQKIv+MaiTchbA1XrOHi52hlmTXFxR/TeN37
	 JDUHrYWz2JATqoMoI2gUl/ZEjfNyZlxjUMvyeGD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfKDBaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfKDBaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:30:25 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC5682190F;
        Mon,  4 Nov 2019 01:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572831024;
        bh=zRruFl5aWKeVnB/KgtmxCkK8RaqiUCdgP2GFJ2RerMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIvLPfhkNHotstJIK8js2nteX06h0qxfRko/rWJgz/969/dql604F65gmVmkXolxF
         EpTZ8iAOQ7xiU8lbghmJ9RGqGrWyQCmAPjDVsxxZsT/WEYcLupMIOyBAZ/MmI9/RgQ
         xzBDuSQA1P9bic/YAOuwiIcySXqyiTvrmspA5xtw=
Date:   Mon, 4 Nov 2019 09:29:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] arm: dts: vf-colibri: fix typo in top-level
 module compatible
Message-ID: <20191104012957.GI24620@dragon>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191104011657.GE24620@dragon>
 <20191104012034.GF24620@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104012034.GF24620@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 09:20:35AM +0800, Shawn Guo wrote:
> > Also as a practise, we use 'ARM: ...' for arch/arm/ patches going through
> > IMX tree.
> 
> I fixed it up and applied the series.

Just let you know that I did not receive patch #3.

Shawn
