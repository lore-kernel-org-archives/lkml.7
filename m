Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19049C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC682073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574791401;
	bh=lfNjQBTmt+kHikceMt6iNpKMRgU8TUOlnbDKg4LsAOk=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=oGAr2fLAmeZC+05DMDtvyXZRCmyY4uAcsNcXCdUWXAKM4w672eZDGttv7ELgW+FEu
	 t1dhp3fQ/Fbhr9IQFAPuUZH8n3F9Wmtg2oTlsRr5jezpQqfh7f/aYZUIsOABz8/suQ
	 6f04adICgtjd+ab09p1QQY3h3dnAz70dR9JDHL9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfKZSDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKZSDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:03:20 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2132071A;
        Tue, 26 Nov 2019 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574791400;
        bh=lfNjQBTmt+kHikceMt6iNpKMRgU8TUOlnbDKg4LsAOk=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=oqbVI4lZRGKqQyDqD2DfujjISi/M7UWx06DI4SoYVIIM1M/Snw+z1wsOpoCGect4u
         ipfYf/iAK2GBXloYMf1hO3aM300HT6UuDk9pLETdCBRvNnqcOGiN08S5ntNdqybsj7
         EAWs8ZzzkBxwle9eb8Ksr2M0mCys8m3ztfnFMz4o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191010020655.3776-3-andrew@aj.id.au>
References: <20191010020655.3776-1-andrew@aj.id.au> <20191010020655.3776-3-andrew@aj.id.au>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500 MACs
Cc:     mturquette@baylibre.com, joel@jms.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 26 Nov 2019 10:03:19 -0800
Message-Id: <20191126180320.1A2132071A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Jeffery (2019-10-09 19:06:55)
> RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> single gate for each MAC.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-next

