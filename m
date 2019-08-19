Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2969C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D682087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566212340;
	bh=7pJzR92/KfmkyZf/ZVxil5dpCtvinbiGCp6B8gTgNyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xTDIHWZd/XAg+F18o/nInBxq2SrEJspUI+HbpZCGpSzE6hJscW9yfh6JGqo7F54z4
	 AoAhLjHEYCXLqEJsioFe3MjETf+4KfBFVUQDGlqnNtAK9vHYgII0nIjiNa1hSQ6TLh
	 mgv4HQ1lfbqXUVpbXMo4JvvAhI0uS0J60vnFg0L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHSK67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfHSK67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:58:59 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28E420844;
        Mon, 19 Aug 2019 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566212339;
        bh=7pJzR92/KfmkyZf/ZVxil5dpCtvinbiGCp6B8gTgNyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J06WMwqDyY9PgZCipa89DTO1crj5XXdEvK/u8WegX55sT12ovtvb0djOksELozzyz
         F53E51eBDnSlFtuwV7LLeN4+ONabKFtfb/sfbix1EkKSjJfmalYmlV7K6239uPro2L
         LMElJsxf8Eid1kw3uDt+ScakY8sygftPFmoxDpYc=
Date:   Mon, 19 Aug 2019 12:58:46 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 01/21] ARM: dts: imx7-colibri: make sure module
 supplies are always on
Message-ID: <20190819105845.GK5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-2-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-2-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:15PM +0000, Philippe Schenker wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Prevent regulators from being switched off.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks.
