Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B0D2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554289212;
	bh=+onxICJS9Ff8viNiXm+GubEEGAxUP/pm4S4E8mI6ud4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nfTWXkCKWr55Pnj8ujeP9hPZpWPuWXda5XgwpKE4OptLkjRTXY5OOrfh3WInqH5Ht
	 cHJ2DpB5jMWXRbmhcMPw5ye06maHeB6RP/8qoDfuW3DPDS0HTTufozRSjMG/6gMP6+
	 3XirGwSwo1bhhMbK7oywxuqWqdEn2ggWsasB+kWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDCLAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDCLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:00:11 -0400
Received: from X250 (unknown [147.50.13.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4102120882;
        Wed,  3 Apr 2019 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554289210;
        bh=+onxICJS9Ff8viNiXm+GubEEGAxUP/pm4S4E8mI6ud4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diKI17mZmEKAAVJHGBDKSgstUnGmOjBv+ksCb4JSQF3b9tvx0p8n/HfFxv4EdilGM
         /3lng5NU8RSgkVRg0KpNT5pXbHletIBZjDOD9W/cTXMO5gr9DKT+YNABpyLnqnJVYg
         9GHH0vrGzmsfKWXl2nwA53jce2WCwBHHokNSft64=
Date:   Wed, 3 Apr 2019 18:00:00 +0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mq: Change ahb clock for imx8mq
Message-ID: <20190403105959.GJ7932@X250>
References: <20190328133828.20999-1-angus@akkea.ca>
 <20190329152130.18411-1-angus@akkea.ca>
 <20190329152130.18411-4-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152130.18411-4-angus@akkea.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 08:21:30AM -0700, Angus Ainslie (Purism) wrote:
> Set ahb clock on sdma1 to get rid of "Timeout waiting for CH0"
> on the imx8mq.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Applied, thanks.
