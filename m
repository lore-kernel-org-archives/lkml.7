Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89ECA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B06E21835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572269172;
	bh=3pE89ZCUoD6XHadsRN7ScSgeFYmrH/IyK9AtjIgnGqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FK6kxCkQNtokdpVgEa0l+QBiWlUUteY87pIhIYWCHUz62RDcrQI7QOuevlkNo9nrm
	 YrDSTnaF9MdGf4GvYXJ/SYdP4ESeTeGCEtFX+gGw9HH6RqW4aXG1YwWWzHTEjRD76G
	 xtmwYq7ilfR9a9iIMdj3GWsgOwZmuzC5FoSTkfxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfJ1N0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfJ1N0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:26:11 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FBA20663;
        Mon, 28 Oct 2019 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572269170;
        bh=3pE89ZCUoD6XHadsRN7ScSgeFYmrH/IyK9AtjIgnGqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2fTGg4H7kVVcs3Lsth4IpuAZ9rhGzYgtOfAE2DrCKQ4Hshr8jQrepxZQcDQm+StiX
         VkO/PljdhiW8zbnGd2u3E+bs10LLutkI9SC9qG3ajwm8prXQFHYf0CB7LR94P8xxfS
         FNgIZ/RsIqSwB3O+GZEhm7pkbJHD3jFUp/ATkErg=
Date:   Mon, 28 Oct 2019 21:25:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: Document Variscite i.MX6q
 devicetree
Message-ID: <20191028132534.GM16985@dragon>
References: <20191024092019.4020-1-oliver.graute@kococonnector.com>
 <20191028113826.GD16985@dragon>
 <20191028120519.GA4147@optiplex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028120519.GA4147@optiplex>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:07:32PM +0000, Oliver Graute wrote:
> On 28/10/19, Shawn Guo wrote:
> > On Thu, Oct 24, 2019 at 09:22:37AM +0000, Oliver Graute wrote:
> > > Document the Variscite i.MX6qdl board devicetree binding
> > > already supported:
> > > 
> > > - variscite,dt6customboard
> > > 
> > > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > 
> > Please organise it into the patch series, where it's being used.
> 
> I think this was just forgotten on this commit:

Ah, sorry, missed the fact.  Applied, thanks.

Shawn

> 
> commit 26b7784b29e90da926ff3c290107f7e78c807314
> Author: Neil Armstrong <narmstrong@baylibre.com>
> Date:   Mon Dec 4 10:21:09 2017 +0100
> 
>     ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board support
> 
>     This patch adds support for the i.MX6 Quad variant of the Variscite DART-MX6
>     SoM Carrier-Board.
