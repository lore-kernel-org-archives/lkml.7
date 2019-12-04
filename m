Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F30C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582FF2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575458536;
	bh=ijCQMg+I4v9UZfD0SAZVzu/QGpOIi8890Lg3FWPILXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XKlftaSfn3HUe6nbu90JNVRsCBYMNjIHwCb/lSUZ5U1Mjv4ZAiNQOwJlz2Ig+FDp2
	 EElAddj8GImuhYf4FALDFZcRDDc7yNN3T19blDIj8aZptt2MfBnf77YojyPcFW4j9u
	 jewaJm6+EyGT2CaEHanz+VoVVQwCsr+r4R1ICpCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfLDLWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:22:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfLDLWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:22:15 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477B720637;
        Wed,  4 Dec 2019 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575458534;
        bh=ijCQMg+I4v9UZfD0SAZVzu/QGpOIi8890Lg3FWPILXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZYUif7wX9fDkbQbJPKpEjJq9IOAvAPmHuCMZ7cgMdf8sC8xuONOKcCCJiJq+fahp
         PnvPAPyD6gY4+FCfBSTGLdWOxK83AGTh/NPBxk5Mu0RX9EYxfhGpvh5yW0Zri63buv
         4ZgzCmzxh1ItBUQzn2QBDJ9q59WWz4QwMwWqaPwc=
Date:   Wed, 4 Dec 2019 19:22:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        daniel.baluta@nxp.com, peng.fan@nxp.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8qxp: Remove unnecessary
 "interrupt-parent" property
Message-ID: <20191204112205.GF3365@dragon>
References: <1573097435-19814-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573097435-19814-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:30:35AM +0800, Anson Huang wrote:
> gic is appointed as default interrupt parent for devices, so no need
> to specify it again in device nodes which use it as interrupt parent.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
