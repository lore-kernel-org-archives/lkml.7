Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C23C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137DA20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556216591;
	bh=Dkpm5jvZtTt4Uun/tsIkJYxq+8w/x/1xFGWTshAHXVo=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=IsxXsPGjW/1Uocvi5g22gixkNYCWQmY+UJyyRD4cvsF+1xNIuB+B9H8tbT3AzZWMR
	 /uVBy1qkfvMzz96AGqXGKG89Ds2YGAJzy74RzzGESRbf0l8e5H5U9abX8vPFPmRIDv
	 R5uebeLMHH3uneia4EOSOElG7T9/M9P20z2x6yWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfDYSXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYSXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:23:06 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890DD20717;
        Thu, 25 Apr 2019 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556216586;
        bh=Dkpm5jvZtTt4Uun/tsIkJYxq+8w/x/1xFGWTshAHXVo=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=GIdRgh68evjjN2FxCzPwD/IJQwKXFG2GkkKZMajmueKsUHqkm+Rghwidaiu1yGdxH
         siH+AozGajNSos+746+0U3bQSnyo8fXSNfVFledAiUrUvpw3wZnLIfI9uwIC+jw9i+
         3PY6qbGfe7lAJ1kVC4was23j7nYfVaHPrysHG7x4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190422091509.3181-2-andy.tang@nxp.com>
References: <20190422091509.3181-1-andy.tang@nxp.com> <20190422091509.3181-2-andy.tang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: qoriq: add more PLL divider clocks support
To:     andy.tang@nxp.com, mturquette@baylibre.com
Message-ID: <155621658525.15276.10875911078203745396@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:23:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting andy.tang@nxp.com (2019-04-22 02:15:09)
> From: Yuantian Tang <andy.tang@nxp.com>
>=20
> More PLL divider clocks are needed by clock consumer IP. So enlarge
> the PLL divider array to accommodate more divider clocks.
>=20
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---

Applied to clk-next

