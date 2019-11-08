Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BA5FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3645E21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573231736;
	bh=9w0yj2YakXAi8n7djqtc+u+Gst/eMLDRpOqSpIO+PbM=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=ix0kOX1/Pc4pBLAeSUARb1Ym+i+LDXo4qp0/1BLDrkx/VjbGXCLcUc+u2c8Rkq3zM
	 EI/QKln0jkEWpS7to+52YWO39+MJ5wtnATJ1lbrAMPDImkKosYLYLLtSx+tZ4avazc
	 QKI8Rllp3LGS8gQFB+FXaANZ+ojBKyiOHR5fTbQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKHQsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHQsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:48:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1C22178F;
        Fri,  8 Nov 2019 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573231734;
        bh=9w0yj2YakXAi8n7djqtc+u+Gst/eMLDRpOqSpIO+PbM=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=cwFruo+s6FIdcnltcZTO1uzlzvCFUQn4AfTGqqEaPcp7m10fznEESpWHOpJG4FNuj
         YupXHvI//X/Wcca950+q3tzgDQ3h4he8U8iDZ7wSin1Lwra4ICJZEvsklftPKvbvQ5
         ZXur/0ZzPEyniH+s0ji4nzcKxnWcBguh34pw7h64=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191010020725.3990-3-andrew@aj.id.au>
References: <20191010020725.3990-1-andrew@aj.id.au> <20191010020725.3990-3-andrew@aj.id.au>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, joel@jms.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: ast2600: Add RMII RCLK gates for all four MACs
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 08:48:53 -0800
Message-Id: <20191108164853.EA1C22178F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Jeffery (2019-10-09 19:07:25)
> RCLK is a fixed 50MHz clock derived from HPLL/HCLK that is described by a
> single gate for each MAC.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-next

