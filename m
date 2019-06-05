Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA9C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DB32086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559725556;
	bh=Pz8YyhuVAwCFqXMPjBkm0rXnp/wYpoIIb3ZnyUKQR9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JbSSwA4CGrqpAtNc0OXheLo7n2Jf87q89cplHrywe8f9CV/3vxNBszmbaLf2FQi3t
	 ZNLJ1ugX5kojvGUDiN3U4oAFjmrygsvXOvajroMv/Wf7IdDR1yMRcTX0pH0YpW8HQr
	 eDBmq73uNocfHEpQK+RC89PQSz2p5PZSMHigBJyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFEJFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEJFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:05:54 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE1D2075C;
        Wed,  5 Jun 2019 09:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559725554;
        bh=Pz8YyhuVAwCFqXMPjBkm0rXnp/wYpoIIb3ZnyUKQR9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXhfq/jef0DTyI4dpjhJOr/cbHlgFXdhlDWgp6xowWFON7r5FMh/3IF6Agq8QmeQz
         4flXb7AgIdZRiCFrGMfXQD7vZ4XHbCsv5PHPV91oSLyOZDqxZs57ayVjrVXl8uRRLK
         fFOEhex0mtbrW+u1E6OnnEeicHHRPvBZ0CZe5lkg=
Date:   Wed, 5 Jun 2019 17:05:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: fsl: imx8mq: add the snvs power key node
Message-ID: <20190605090533.GK29853@dragon>
References: <20190528161101.28919-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528161101.28919-1-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 09:11:01AM -0700, Angus Ainslie (Purism) wrote:
> Add a node for the snvs power key, "disabled" by default.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Applied, thanks.
