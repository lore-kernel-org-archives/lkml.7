Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FEC48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3CB2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561502917;
	bh=pb5ovXb0zeOxnunbndzV3GrY3lbUPIvRAV9/N0BT1co=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=OkjyAZnv2lHgC2TwSsF1HIZ/bHspr48hemgFYftBBgu5UqxvvAYO43pYBqes4WwGY
	 6TcsHcEFCDGGRlE4Qvp44GyysKRmSIm1+yil+RD0INkEpntl2q0qQhoXluGVEae6Zp
	 3A1fYDGhCzEa2qNnJIPQM0ugZvY6iUZUIDky6oKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFYWsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFYWsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:48:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BEAF20645;
        Tue, 25 Jun 2019 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502914;
        bh=pb5ovXb0zeOxnunbndzV3GrY3lbUPIvRAV9/N0BT1co=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=bwcAF5vykiCIf86n4i2Xh1mnupdT8BkNDcHO83ix2w3l+c6FxyQHtyK1TnS810Q7j
         ftA8vl1I2y/2t4fSVAF4mJcYiaABVn/SImdjHDC18EFudVRD480omETVcxRK0ePBBj
         LhyzLnxZfbTzzLS0IyqF7K9XXzcRi8vZ1Q2u584Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611180757.32299-2-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net> <20190611180757.32299-2-paul@crapouillou.net>
To:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/5] clk: ingenic: Handle setting the Low-Power Mode bit
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:48:33 -0700
Message-Id: <20190625224834.4BEAF20645@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-06-11 11:07:54)
> The Low-Power Mode, when enabled, will make the "wait" MIPS instruction
> suspend the system.
>=20
> This is not really clock-related, but this bit happens to be in the
> register set of the CGU.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

