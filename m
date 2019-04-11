Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24BBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45D420850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554961558;
	bh=xMFA9k2aAZ/2KWRIol4/Fr9unAldZHNiAgrbz+nckB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ygJfsGg5K1bEfGDnms548ivIcXvA0E+IzHgGmA1qAQxDE323acm2I53pxI96+QJQO
	 wq3oY3++NrljK7CpoN8JwMr1+EhgOXDOg3Sby4Ae6VTjh7sBYh9eRNQxnovNnkvHRe
	 V9Is8FhrRuykmGD9e+Tq/at6milbtpWFGSwa284c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDKFp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKFp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:45:57 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E6A2083E;
        Thu, 11 Apr 2019 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554961556;
        bh=xMFA9k2aAZ/2KWRIol4/Fr9unAldZHNiAgrbz+nckB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCQReaacZTVssH3K5Fq4VW9lBbkJGzdtZ8Zt9fEYVe+X5jWoF5gB2SndtOd4lNWry
         hum4FsWNDqrUCyPx+g7eAo/781jZJ/RpyPBPJkXXO9Z869BeGEzpl+JT68On+cRMD6
         95GvX6o9ThcRjIt0PK83FaWkfkYyygjHJnuXEGaA=
Date:   Thu, 11 Apr 2019 13:45:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, adam.ford@logicpd.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: imx6q-logicpd: Reduce inrush current on
 start
Message-ID: <20190411054541.GS26817@dragon>
References: <20190402191908.4306-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402191908.4306-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:19:08PM -0500, Adam Ford wrote:
> The main 3.3V regulator sources a series of additional regulators.
> This patch adds a small delay, so when the 3.3V regulator comes
> on it delays a bit before the subsequent regulators can come on.
> This reduces the inrush current a bit on the external DC power
> supply to help prevent a situation where the sourcing power supply
> cannot source enough current and overloads and the kit fails to
> start.
> 
> Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
> i.MX6QD EVM")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
