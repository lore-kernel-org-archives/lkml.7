Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A332EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE6D2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560444897;
	bh=vPst04mhCl3KIJo/LpaMenWyVwtqXqolMhGHFBGokHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sPnYu6xPxMbyZJVyIEq8MkzwwdVH1AbCGAU0ePLZoXGnPSpsF/SRnQQEx0SzS3tRr
	 yqMwmNzQ2qDYfibF/6lUfk3FJQSnMNGUaUHk7hBh+IG8oJ5XD2qTH5b3VHsSfGJ4vE
	 +HCm8cLlseKYCdN4ffe3mKbTxmsnHLcGFCYLsPgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404378AbfFMQyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbfFMCf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:35:29 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC58420B7C;
        Thu, 13 Jun 2019 02:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560393329;
        bh=vPst04mhCl3KIJo/LpaMenWyVwtqXqolMhGHFBGokHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3dX+Ct9uOVCm6ikypOSf56jJ0R6OqUWb3PzVg+C5Z5emu7tcZLbFmLlrPknQhoDS
         xSzdLAw8clUVDiesy1W6VFdoWHLhVM8+gOtoFzyFNJRBOGE88NWgqwNJMI5XYp12TS
         WpIbalQ91kg3+LqIFJV2Wq/PjiGHbfsTncngghCE=
Date:   Thu, 13 Jun 2019 10:34:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] ARM: dts: Introduce the NXP LS1021A-TSN board
Message-ID: <20190613023452.GF20747@dragon>
References: <20190606222817.14223-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606222817.14223-1-olteanv@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 01:28:17AM +0300, Vladimir Oltean wrote:
> The LS1021A-TSN is a development board built by VVDN/Argonboards in
> partnership with NXP.
> 
> It features the LS1021A SoC and the first-generation SJA1105T Ethernet
> switch for prototyping implementations of a subset of IEEE 802.1 TSN
> standards.
> 
> It has two regular Ethernet ports and four switched, TSN-capable ports.
> 
> It also features:
> - One Arduino header
> - One expansion header
> - Two USB 3.0 ports
> - One mini PCIe slot
> - One SATA interface
> - Accelerometer, gyroscope, temperature sensors
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Applied, thanks.
