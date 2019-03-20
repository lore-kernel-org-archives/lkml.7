Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C621841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553069406;
	bh=YaVRyq5vKrV86ffYinhOJ+OZY793tkKJXOVI2W8GqBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y+pPaZZ24tr07jA7rw5DQzXoUhKRDU9X5IigXWHahd8wvybLsbLikh5Dbe+QmqGrK
	 QEYOrgHbXM/KfLyqtW6C8Q69Skmeji5PtQlRjgIwUfvatfQIioCPcMpDYOX/LMhEJy
	 COZAV74PPp2IlUPdhCaKFJWPQ8EDgKCyK/M0OJY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfCTIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfCTIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:10:04 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DC92146E;
        Wed, 20 Mar 2019 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553069404;
        bh=YaVRyq5vKrV86ffYinhOJ+OZY793tkKJXOVI2W8GqBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKOphAfTSkZoJmiVjX+Wxb8vNFJ3rlBCyUtbMURmvKUwyvlw6Tv5ulUMAkrTnPpjL
         cJVUSa8RNx9T6bB7jbWczOZE19rWsFd7liLzq+hZkpwIuOITDu0c4LXqu/+MZPNMmc
         aTzoGJuo2LFs5NFCnfVLPQ6NBdLZ3Xowqpd077kQ=
Date:   Wed, 20 Mar 2019 16:09:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pierre-Jean Texier <pjtexier@koncepto.io>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx7s-warp: PMIC swbst boot-on/always-on
Message-ID: <20190320080940.GD4980@dragon>
References: <1551565949-13843-1-git-send-email-pjtexier@koncepto.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551565949-13843-1-git-send-email-pjtexier@koncepto.io>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 11:32:29PM +0100, Pierre-Jean Texier wrote:
> PMIC swbst regulator is used for the MikroBUS socket (pin +5V).
> 
> We have to set the regulator to "boot-on" and "always-on"
> to output a voltage of 5V on this socket.
> 
> Signed-off-by: Pierre-Jean Texier <pjtexier@koncepto.io>

Applied, thanks.
