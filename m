Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00083C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA39620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566213758;
	bh=jcfwe8RBMpvwSqfd/qn//fInobCO8g6/22CazOxRl0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SwiRN8+jDKl61ImWDfZIliy9lCrN9XmBaEJXRcovNNoc9YxfGa6g7avXhZW6ypZlb
	 cYhviRLAHDBPaCcOLNFRzDmslnFBQ8KwajQzUq/KVHVa6yhOXHrg/xWr0VzA8syEWa
	 75VwufpfZTX7hdAV1miR/GJCAP1k9hSjAWTUWUfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfHSLWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfHSLWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:32 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875672086C;
        Mon, 19 Aug 2019 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213752;
        bh=jcfwe8RBMpvwSqfd/qn//fInobCO8g6/22CazOxRl0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXUIuE1GKuM8F3wLXfV7caE/N3S7TUbh6kEZ3G/rawiLlFJ/HFZyd0kqhvx37rdUj
         s1YuJjGCLr13eRgAe5fQ0HfeYCQgtV45drST70VoAJKIcPMnMdrxvX/duuR0lUaFpN
         zwpV6g/W3yyXjZiD4/XPSQyX6G7ooaPrvPSMRxfo=
Date:   Mon, 19 Aug 2019 13:22:19 +0200
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
Subject: Re: [PATCH v4 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Message-ID: <20190819112218.GS5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-10-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-10-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:28PM +0000, Philippe Schenker wrote:
> Add the phy-node and mdio bus to the fec-node, represented as is on
> hardware.
> This commit includes micrel,led-mode that is set to the default
> value, prepared for someone who wants to change this.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks.
