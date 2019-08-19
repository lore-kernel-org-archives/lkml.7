Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC1AC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E812085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566212989;
	bh=U1a/uOsVYdda+EoUQKvlOm9uL+7t7B84efnJy0yBXvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f51iV0lJ8GrqRBmD14dkhEdys11tNP5xG8T1iydvdT79OJQ2jZiW8xgwUgSo/GokT
	 Ic3lZZPfdbOgUXKQaSO4Imgb8C+hibMs56BZ6475zaG8Weep74OqoOG/FlXd+SvtmD
	 W2BlGEiccbHGUUPNQk4ZsVWsuXlBflUMclFyy/d4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfHSLJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfHSLJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:09:47 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA72A2082A;
        Mon, 19 Aug 2019 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566212986;
        bh=U1a/uOsVYdda+EoUQKvlOm9uL+7t7B84efnJy0yBXvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m36uSd9RiP5g8KrEB7POblNbq6xs9xtnvPWxsnsgLoCIYCtSwlgs+du67Zz/p9di9
         2NeX791FPElRYtceWaFCSs6j1kmsjv0DakOGuplJya//LmZTVABjbbh7p8swyoSlL1
         kCg5uaztP1HdOZjXcCitqFGUbe32Lt9m81bLUJgo=
Date:   Mon, 19 Aug 2019 13:09:34 +0200
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
Subject: Re: [PATCH v4 03/21] ARM: dts: imx7-colibri: prepare module device
 tree for FlexCAN
Message-ID: <20190819110934.GM5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-4-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-4-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:18PM +0000, Philippe Schenker wrote:
> Prepare FlexCAN use on SODIMM 55/63 178/188. Those SODIMM pins are
> compatible for CAN bus use with several modules from the Colibri
> family.
> Add Better drivestrength and also add flexcan2.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks.
