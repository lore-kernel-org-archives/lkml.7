Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D98C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209E0217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555704830;
	bh=VbqRI+AkRPQryIDVA3IC39LqL3aoZpYR+1xwc2U4n+s=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=LUuK03js1DldP67gIMrBWTfJwn1lwwh+9m6G6arJ8m9CuzIn7w3VhBSylDS7TlzLo
	 6bpkdEk+o+t0usn7AAZprlBZWIvPeAT0iTxVtCih/OZFto6hL3kJ1TGBR4jCYg6D2Z
	 LI6iQuPj+DhaYvZ3Iny9UO34WsRZS1Mn0WD3aE6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfDSUNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfDSUNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:13:48 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C69E20663;
        Fri, 19 Apr 2019 20:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555704827;
        bh=VbqRI+AkRPQryIDVA3IC39LqL3aoZpYR+1xwc2U4n+s=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Lb2pDn2PiCvn0TMuRlX5n6HjkHdKl/NF38L7w8hfYdL2aLc/5Fps4NSriygXJB2P0
         H2TsCM3ENo/J36UfABDeYGQC+bO8gM1zHPtm9eRx5rAfeFpF28pjylAe77hwJmYkyg
         31FPgnR6jS2rlaWJQylPYRDq5cbANFLXt4+8M3wM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1555662781-22570-5-git-send-email-peter.griffin@linaro.org>
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org> <1555662781-22570-5-git-send-email-peter.griffin@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, lima@lists.freedesktop.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 4/6] reset: hi6220: Add support for AO reset controller
To:     Peter Griffin <peter.griffin@linaro.org>, airlied@linux.ie,
        daniel@ffwll.ch, john.stultz@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, xuwei5@hisilicon.com,
        yuq825@gmail.com
Message-ID: <155570482647.15276.10153086772852393750@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 13:13:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Griffin (2019-04-19 01:32:59)
> This is required to bring Mali450 gpu out of reset. Also
> we now use CLK_OF_DECLARE_DRIVER to probe in both the
> clock and reset drivers. The clock and reset parts have
> been done as one atomic commit to avoid a bisection hole.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> ---

>  drivers/clk/hisilicon/clk-hi6220.c        |  3 +-

Acked-by: Stephen Boyd <sboyd@kernel.org>

