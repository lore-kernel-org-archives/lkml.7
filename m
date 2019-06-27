Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C0C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D992146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561659771;
	bh=g49iXxzydUpzQ6EBIqU04G6r6Dgb76zA9MVuso4mGfk=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=zRGply0LEPpTpsqzB6npiq30rIE4rSyZgxA84prlUoHVTxClgJLkp66b7dcD9plPp
	 HBxCEItHfVL38j+x1Cp+EL74Q2TOJ8fPW5KekgGnNmLIk/P3UK9ZIW4geK7px6vlHI
	 5sCTcYV7k6vuBMoyz1ua++3W/m5QaXEMcLTqmfy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfF0SWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfF0SWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:22:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C30FB20B7C;
        Thu, 27 Jun 2019 18:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561659766;
        bh=g49iXxzydUpzQ6EBIqU04G6r6Dgb76zA9MVuso4mGfk=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=OY2WtXEs0Ev9EbXML0VOUPi7JIzPT+gwB+jdNCAGgWNS5wwauziKecsb7rPreWCnk
         FHheUXmnKc0nbUk2lZrD3S1D1ELk4nkl6vLs3p5HDOAVAHyYX0Etk/ZR6NmA4Jl1Kp
         upbgF1s36hpPOW3HuoFLVz30xhzbwINjesD+5dCo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561650825-11213-5-git-send-email-claudiu.beznea@microchip.com>
References: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com> <1561650825-11213-5-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 4/7] clk: at91: sckc: improve error path for sam9x5 sck register
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 11:22:46 -0700
Message-Id: <20190627182246.C30FB20B7C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2019-06-27 08:53:42)
> Improve error path for sam9x5 slow clock registration.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

