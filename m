Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97878CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DAE21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571983536;
	bh=fBJRRwheXU1MJ98d8dPNJRL9K8CPlTP6wigRKmHU5H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YB7NfRFSjfDJkDonrexEcHwcd7yWoMjqI9NSDp7/2AvWNJurVEymjq/sKeeb/l98S
	 hyUlL/O7V4SsZvkSqTWhzyWA0cAx28ePwV/+Ghg5u5su+wW6plUW0/+qPBxRzPsCNz
	 6F5cdYmqhvctAbU5vMJHwUvlPKj/FQ4a4mGFutcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394068AbfJYGFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393713AbfJYGFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:05:09 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFE621929;
        Fri, 25 Oct 2019 06:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571983507;
        bh=fBJRRwheXU1MJ98d8dPNJRL9K8CPlTP6wigRKmHU5H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CItcbHo19ZH8Tsjrxq66F0Ak0UPU72fpIEjLBf71IiAhSTnjilyrxdbhpXaEkrbx/
         EEVqNgzKCjJN4DHwBsSbSDkB4IHkyI2ze7TTjScrr+5gfiRzj+XaasvDNI2Cpt+G2m
         Zjt5zct0NmzVQMqoR5FNSXyJlyFoVicy02V/9Ajo=
Date:   Fri, 25 Oct 2019 14:04:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        ccaione@baylibre.com, daniel.baluta@nxp.com,
        andrew.smirnov@gmail.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: VDD_ARM power rail is always ON
Message-ID: <20191025060444.GC3208@dragon>
References: <1570604659-28314-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570604659-28314-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:04:19PM +0800, Anson Huang wrote:
> On i.MX8MQ EVK board, VDD_ARM is from a DC-DC converter which
> is always ON, the GPIO1_IO13 is ONLY to switch VDD_ARM's voltage
> between 0.9V and 1V for CPU DVFS, so VDD_ARM's GPIO regulator
> should be always ON to avoid below confusion after kernel boot
> up:
> 
> imx8mqevk login:
> [   31.776619] vdd_arm: disabling
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
