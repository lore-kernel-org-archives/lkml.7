Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B17C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECF421917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553215399;
	bh=YAuGZYUYgplnRpQhhooeSNKv4cEcpX4tMDvfRmtXkQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GFhqNme/N/6HawbZQwmlLYY52dHbf2wOsP5swmUJ05Kea72RDMB1nZGYNnUE+ie/a
	 PVAqkz9Anvq3RUUlf0sYQKcNz+LiunvtfjzK+jEk958awwQYjEe2hD8P5OICrruCId
	 92nhEsaXAoCAxrOYEpZ+vW4zw3SZd6WOziIApV8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCVAnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfCVAnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:43:18 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1834421902;
        Fri, 22 Mar 2019 00:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553215397;
        bh=YAuGZYUYgplnRpQhhooeSNKv4cEcpX4tMDvfRmtXkQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ymv3CgCQH57EM7ldqj1lgr2Gty8nl3YR+pv4980mt+4QMFK4Kw8Ujvy6NjnWW4L84
         LCAUtVmp48h7cCpcPDStjElgwVmzV5+n+7FeZkrSbRF84mn1GJOvhpPz7ZOnXgBl1N
         RPlS+EHalaq2T4MmX/WgCk5jgsKeHSVKQVxxLiiI=
Date:   Fri, 22 Mar 2019 08:42:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi
Message-ID: <20190322004253.GM12513@dragon>
References: <20190318163009.5093-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318163009.5093-1-standby24x7@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:30:09AM +0900, Masanari Iida wrote:
> This patch fixes a spelling typo.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Applied, thanks.
