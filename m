Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C98FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796902077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221071;
	bh=2jOOJKRuldVlKdG1vdOiNTCxHtbBcbVUPeZBYITDKpY=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=nooNdAwMdaXUNOovkqOP9knpmhFdVo5YeZLSVhK4Zok8u7jylHMzSHAAoKkaAziID
	 anTPlW3FWwiPaPMi6edS0n8FNrMteup71mF0yDPkrfxIJLlHI0yCZEuzrIJEiQw0hT
	 zfzL73f5LeNGl29KyZ0LGk2YDa5l2PCDQvngzonI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfDYThu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfDYTht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:37:49 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F90205ED;
        Thu, 25 Apr 2019 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221069;
        bh=2jOOJKRuldVlKdG1vdOiNTCxHtbBcbVUPeZBYITDKpY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=wImAg5dq3tfS6qSRKUicKcKtddu4jEGTEnW6UTyKNd/jPw8d1UVFAcd+L+NdQck4v
         OEg7Jsig1JYegU0qbN40WMssH/baeQX91DpWQSE3H+0Q4pEZdEqDX7Hv7qqDfHCgKx
         MzZ6u010VLRbREVaYmz81yr1ndFtl81yoFJxpUx0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190402125056.21509-7-alexandre.belloni@bootlin.com>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-7-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: clk: at91: add bindings for SAM9X60 pmc
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622106786.15276.14620545036413291474@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:37:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-02 05:50:55)
> Add SAM9X60 PMC compatible string.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

