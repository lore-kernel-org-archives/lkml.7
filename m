Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007DC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D20720726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575878382;
	bh=/GDSAbwa+5Rfjx3NyL//+7tHWlsU4b2DACP4NCUjuqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=txLzxbfNC2K3eQpF6xJ0Z8WmWSCpE/NoXaoU/J1O3+0UIeUlvQtl0nO0dE5fGVzFO
	 zp5XPOHi06B+vkJGFpzsSsM8fsupofY67mtfDdyuDglnc+Ocr8Ho4oSnloRBzOUJFK
	 4TYD/y4VEGRUnXSxWD4eEqn9AWkcPHe4JjQJFHEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLIH7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:59:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIH7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:59:41 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E19D9206D3;
        Mon,  9 Dec 2019 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575878380;
        bh=/GDSAbwa+5Rfjx3NyL//+7tHWlsU4b2DACP4NCUjuqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQh3/U8SjkohY65/zdLAgeGBAo8aOdOXyNb6PLAJFEvqNzfnzHunAqqm6OAPkpmN1
         zrsk2OG9UhVlMNtJZx6Q4VDrKoalaOO1zFoH2L2L0O2q9eDWLYft0ZwJrSukUybUV7
         GkYpfIYsVDfjzjGtuSexH0VhF3BDfRmH/e08dX2U=
Date:   Mon, 9 Dec 2019 15:59:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: correct wrong pinmuxing and
 add comments
Message-ID: <20191209075920.GJ3365@dragon>
References: <20191128171345.10533-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128171345.10533-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 05:14:14PM +0000, Philippe Schenker wrote:
> Some pinmuxings are obviously wrong, originating from a copy/paste
> error. This patch corrects that with the following strategy:
> 
> - Set all reserved bits to zero
> - Leave drive strength and slew rate as is
> - Add sensible pull and hysteresis depending on the function of the pin
> - Not used pins are muxed to their reset-value defined by the SoC
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

It doesn't apply to my imx/dt branch.  Can you please rebase and resend?

Shawn
