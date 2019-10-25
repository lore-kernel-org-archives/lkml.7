Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02044CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE0521929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571991594;
	bh=mxSD1yFRMTz9TnhEbFhz9Kun4feNsEval2ddjomqsO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YRMjqvwItNeg3tbX1S2zRjofOsySFIkwGLyO6gBiuklrGD6t89iscEsg8spgHrYfW
	 FkE8LimXc5JhB1AObboGtV7emsTj7nBVkQ2xY5YCv20XNZdDQYHprKdRjasNaCiJmx
	 6SnIk+7tSggJ2cG8mNuLaGq9Pf7XIe6S3huuyBmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408012AbfJYITx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405453AbfJYITx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:19:53 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B1B21872;
        Fri, 25 Oct 2019 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571991592;
        bh=mxSD1yFRMTz9TnhEbFhz9Kun4feNsEval2ddjomqsO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFAqe/2s6ePycLmtuct1pUpPxQ2c0S5G2gRoUZ0dIra5kvDDE7q8tMhhMG9jzgQTa
         5Mn0Pd3bAlkrx8Nxje85jEpjalyndVooeCuRFBdEF+mGpDkm9f2p39FOh80g6YKZDl
         TDGaJsgTRpDu5Wfoor3Idl4Szuoo0+JfN8+19ugg=
Date:   Fri, 25 Oct 2019 16:19:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: lx2160a: add tmu device node
Message-ID: <20191025081936.GF3208@dragon>
References: <20191010083022.6700-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010083022.6700-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:30:22PM +0800, Yuantian Tang wrote:
> Add the TMU (Thermal Monitoring Unit) device node to enable
> TMU feature.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied, thanks.
