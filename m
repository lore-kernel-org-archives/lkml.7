Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEEC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84801206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575443007;
	bh=KdcqJ1Du5b1fFi3mrE7QihV/xxYnqKSs8F+4VKxDpDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PoTyJR3jtB3fZSxy5FiJrPDituvNGrK9gqDj+Y5ugZDbS/3jeK6KaOeRMMbSNgFfI
	 gk7ei5mr1uVkzQyXMNyAPuksP3Hricvang6NDUSbAJ11cQs4FIr6Q3YHYCjbA4uSC5
	 MA0ip2m02THhow9G8UMHozFhM2uMnmm6yKuRYY7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLDHD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:03:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfLDHD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:03:26 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF8920640;
        Wed,  4 Dec 2019 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575443005;
        bh=KdcqJ1Du5b1fFi3mrE7QihV/xxYnqKSs8F+4VKxDpDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=10UoHMKtcJGHaoz1X74ZDcJNcOTZKLq8BhqT70Kxvjzo7Yjqx7KB2Ve0zHfOIVZ28
         WaHL78a4qNAueypXn/yy42WJx7MDJ0T5zm0e3/CvhFmV5o0bGK8GyFdrel/AYlcIxL
         T0K1IHthf/JhGPmHsNrJn23qr4373/BKqXq+MBDs=
Date:   Wed, 4 Dec 2019 15:03:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx6sx-sdb-reva: Add revision in board
 compatible string
Message-ID: <20191204070310.GD3365@dragon>
References: <1573091764-20483-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573091764-20483-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:56:03AM +0800, Anson Huang wrote:
> i.MX6SX SDB Rev-A board should use its own board compatible
> string instead of default i.MX6SX SDB board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
