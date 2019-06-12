Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE022C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AD720874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560336367;
	bh=IsJrTQH115vRdp8/kWOCGywofNW8Qe6Yfu6oD/Z6iqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vqZR2bzH9MdzdxE25mvblxFUOmCJ51NMj7MtgysV5rHsNnLH9Q8dcZmgONn6cZNjB
	 wdiJXe9gpUVKEBg+Ru2q3S5kZQwKTtWUKfdUX8WozmFI7p6eU2JF2/qrfmC1L13Ols
	 4h5Z7bCfHTMnOb2Y/5yzwhGEcObdwuF+PvmB5Yf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407933AbfFLKqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407373AbfFLKqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:46:06 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB362082C;
        Wed, 12 Jun 2019 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560336366;
        bh=IsJrTQH115vRdp8/kWOCGywofNW8Qe6Yfu6oD/Z6iqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTF4AM3QNNf0Itscw45TFmiMySxDLCsf90cXyVTHyB9jSE4zqWJCTJb/eOUp6Zm5H
         pYGNQjmoNq42e1t/bSV7GJ4uifQDPBH3GntFKV1fKwwp905sH8P2PYo2xYtvdQ3SFx
         +/qit9/NM+WPh1PLDpHhvFLpxpQPmRP/KOhYfEd4=
Date:   Wed, 12 Jun 2019 18:45:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        marcel@ziswiler.com, marcel.ziswiler@toradex.com, stefan@agner.ch
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
Message-ID: <20190612104526.GF11086@dragon>
References: <20190606090612.16685-1-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606090612.16685-1-igor.opaniuk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 12:06:12PM +0300, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Allows to use the SD interface at a higher speed mode if the card
> supports it. For this the signaling voltage is switched from 3.3V to
> 1.8V under the usdhc1's drivers control.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Applied, thanks.
