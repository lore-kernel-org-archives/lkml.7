Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A4C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0761F2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570346305;
	bh=Dx2ngyCt4BCp8rcZLEP0l/DTMAqBneUTAAXlZNm0TwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EcKPnKFa50mjgNgbndvNWbZFvmIQOUG0Ouh/m+Di9dPrIgpUHjnxvpzdncBcDMcAe
	 rUhltru1zHDybmCquHtKjpnYtaJOu9FGvKKUvmgEFDieAlkfzOzOXB7Z4paiQexlGY
	 C00VUKtA1ktNrUixV0RU4KrF8YcZKQE5MP4kLPH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfJFHSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 03:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJFHSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 03:18:24 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6D520835;
        Sun,  6 Oct 2019 07:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570346303;
        bh=Dx2ngyCt4BCp8rcZLEP0l/DTMAqBneUTAAXlZNm0TwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSgvJNTzYFqurlcEcPNpcX2m/FODAiB2HL+3jqObfh94KqVd5bFa3Je2nZshTRB1n
         9HSzOSQ65Np+nhNLI9xORa7PNZcoPhsbGExbj0ycJOjDAEdv0keyVOO/CsWSPsN5Pu
         cWU/zlYUJfBqAd840NnmedHqJ8upLnh/6MyHIo48=
Date:   Sun, 6 Oct 2019 15:17:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Add system counter node
Message-ID: <20191006071743.GR7150@dragon>
References: <1568129118-31114-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568129118-31114-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 11:25:17AM -0400, Anson Huang wrote:
> Add i.MX8MN system counter node to enable timer-imx-sysctr
> broadcast timer driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
