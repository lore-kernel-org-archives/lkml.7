Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C7C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC54214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576150802;
	bh=dVMm7Esi2DBpBpD7/SKuK2wM+ZF9Kl3Z8wYXQN8FSP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uB8ItZ/vVLDWFGa3hJyhCpSfqPsCL3dwuBCt70kBmvYuwnxs9YH+WLgqX8MB8mEtD
	 /jiDbMG7BDuVhf4OmqF3ax/xrdpmOLwKoV9CyHl9VR1F5QNR2kDo8KJyDyvjeu3jBW
	 W18tmTZfXaYokP+oQ5SFNG6XGPGaV9FMDKkzp7HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfLLLkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbfLLLkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:40:01 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADB420663;
        Thu, 12 Dec 2019 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576150800;
        bh=dVMm7Esi2DBpBpD7/SKuK2wM+ZF9Kl3Z8wYXQN8FSP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0ZEj5qy9x1LVm7IZA9vRoLZbJZY7cCoJDSgRzvTEP0Wj9Sve2Kb8UVyZYvWLdglX
         P1P6adnSEHZU1TxIlU7K+UkNaN5LGrazPy9L0twYSnQmQX3tGQEWmtR6vq41XXcwie
         2TWV5ayXhfujs6Z6obItBXOUoq5u31GRpRxO2FP8=
Date:   Thu, 12 Dec 2019 19:39:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3] ARM: dts: colibri-imx6ull: correct wrong pinmuxing
 and add comments
Message-ID: <20191212113942.GJ15858@dragon>
References: <20191212103745.44672-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212103745.44672-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:38:10AM +0000, Philippe Schenker wrote:
> Some pinmuxings are obviously wrong, originating from a copy/paste
> error. This patch corrects that with the following strategy:
> 
> - Set all reserved bits to zero
> - Leave drive strength and slew rate as is
> - Add sensible pull and hysteresis depending on the function of the pin
> - Not used pins are muxed to their reset-value defined by the SoC
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks.
