Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03E2C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AB020721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575875622;
	bh=Ls1BxSGCCmrksG+dUOE+ytDExKsdaPUzeME+nCny69U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wLD1fTDQ2M93vuOhBfECoXti+AWNlrGxw5PIsGWJCmc2j7tAKYBVzlLyZr3C+7n9K
	 RNPgdVdAnC8xz+iNgJZc5TXZfjabfYnS9L28S0Y9+UzE1fLSrRfNPuG7m8eOue2Bel
	 Yk6AqxI/y/tTr+XGwPaUyEJHq1A9yvSS+M+iuvGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfLIHNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfLIHNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:13:41 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE59D206D3;
        Mon,  9 Dec 2019 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575875620;
        bh=Ls1BxSGCCmrksG+dUOE+ytDExKsdaPUzeME+nCny69U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKnEyEm9bTWvnOemkZIRhnikeZmDKsXl91uW7hVFn4q6spe5XS8lGQLevM8RZKei+
         wFTMdWu+b+NLyJOVmHzPf480OFVudWtoHPL+SE82N1Hl45fm4JHWIBCwSr8ByKTnyT
         2v6J9nYc15iILrvZSzjZve0Yn560bCRc0VB0MDAI=
Date:   Mon, 9 Dec 2019 15:13:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: imx8mq: Add eLCDIF controller
Message-ID: <20191209071317.GE3365@dragon>
References: <cover.1574693313.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1574693313.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 03:50:05PM +0100, Guido Günther wrote:
> With some minimal support on imx8mq we might as well add it to the DT
> 
> Changes from v1:
> - Per review comments by Fabio Estevam
>   - Document compatible
>   - use lcd-controller instead of lcdif as node name
> - Add Reviewed-by: from Fabio Estevam, thanks!
> 
> Guido Günther (2):
>   dt-bindings: mxsfb: Add compatible for iMX8MQ
>   arm64: dts: imx8mq: Add eLCDIF controller

Applied both, thanks.
