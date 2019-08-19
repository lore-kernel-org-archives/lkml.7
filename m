Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C34C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481D62086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566215052;
	bh=r0OPZPIxUcPgKZr7nyEhnsGS2UrWBUJ/5F9ZYsYwZQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MmC4Ku0GZFWkUr+y1gkubjC7UELE25Qm7SNKucygzQph1TypHw7hvLNnbHIH/CBqw
	 34IiqIrXITbmMsMzzr00S7xY0lgD7bNVnJAzHrINGZ9oEmPt7TQW2+VsUufgwn+Zb+
	 EHpJBzTMpGvdTm4feR6xMG6EaRF2TukatHr3r+bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfHSLoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHSLoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:44:11 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D006C206BB;
        Mon, 19 Aug 2019 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566215050;
        bh=r0OPZPIxUcPgKZr7nyEhnsGS2UrWBUJ/5F9ZYsYwZQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDKi8+6VopfQgz+ynwtHyDQqvj3Lx/w2KIJo1Er/+LrfsTn1iEDmyKrz4X219Gyei
         pL1rE54EAZ6cg2Cq/4s1CmBWKlHa38Hxnd5wjMCrm4OnzAjy3ncfPYDo1qFf4QpFS+
         yERVphpNvGB6Z2QfYB9f7gqXU7deTG1ZpHOd8jow=
Date:   Mon, 19 Aug 2019 13:43:59 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1088a: fix gpio node
Message-ID: <20190819114358.GX5999@X250>
References: <20190813020457.45370-1-hui.song_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813020457.45370-1-hui.song_1@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:04:57AM +0800, Hui Song wrote:
> From: Song Hui <hui.song_1@nxp.com>
> 
> Update the nodes to include little-endian
> property to be consistent with the hardware
> and add ls1088a gpio specify compatible.
> 
> Signed-off-by: Song Hui <hui.song_1@nxp.com>

Applied, thanks.
