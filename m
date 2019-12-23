Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A28C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9420709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577084339;
	bh=KmMe9R9H+pA1DgqDHLdO2Z0mTYL8FBrsbBRJqdM9EUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UHmt00+GGcSzVVHrtvwDEFATM0RmgqsuHfVhY7z/8YKW5hasHn11x+sw9thgnh13g
	 7Y8tGhh6pDAqPMxY/nwktvSP7cm/CdvEZd/sVuK5Au5Qse6gS69M6b+0HD61/3ogfj
	 lM2uBshGFHA9IsH32hcbQsgR/y2BKyJu6Zg7dSkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfLWG66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfLWG65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:58:57 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D35920663;
        Mon, 23 Dec 2019 06:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577084337;
        bh=KmMe9R9H+pA1DgqDHLdO2Z0mTYL8FBrsbBRJqdM9EUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYmJz88A+8mZsqG9JO+S456uSI+KW7sfu79Ud/KPNiCgHYecQbAUbrHkr07AGjB/y
         jKKqGrOUGoYv8fi9yv/RxZYsuaEc96KffINiot+mb2kizOMIrU3ZlruOuC5sToANDi
         JhIBaIKytAnLx2M11+H0WkVwUhccCKvjsyiOYhsI=
Date:   Mon, 23 Dec 2019 14:58:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Stefan Agner <stefan.agner@toradex.com>,
        marcel.ziswiler@toradex.com, linux-kernel@vger.kernel.org,
        philippe.schenker@toradex.com, robh+dt@kernel.org,
        max.krummenacher@toradex.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-apalis: mux HDMI CEC pin
Message-ID: <20191223065831.GP11523@dragon>
References: <20191213134937.257840-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213134937.257840-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:49:37PM +0100, Stefan Agner wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
> 
> Mux the HDMI CEC pin to make HDMI CEC working. With this change HDMI CEC
> seems to work fine on a Apalis iMX6 on Ixora using cec-ctl.
> 
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>

Applied, thanks.
