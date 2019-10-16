Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7313FFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4712821848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571268775;
	bh=FruXimfHXB1YIGkV3rE/gM/CQoezrduzhSd1vIpjjB4=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=E0HAUCC6SG00jFOl60WgyezE5pJA+oonNbJXVGZW4xVrvoj9ZiGZJ1teee34fgWlX
	 O7c2n4gUUrF3Yshl74JAK0F+PC7Qni0W9f5y1pvwCI52UdQIu5eXH+t4mBfwmFAyve
	 lbQXH4CsszNrLmjCOBxSPD9R00m0idOsA1E0tUTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438187AbfJPXcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391320AbfJPXcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:32:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2A82168B;
        Wed, 16 Oct 2019 23:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268773;
        bh=FruXimfHXB1YIGkV3rE/gM/CQoezrduzhSd1vIpjjB4=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=Db6KU9cjBeF4Xs8lec1peCdoAeQQKFnqZCz3mzsPrVsGmgBq3bbrzWfZDRUgEcHHj
         mieUErv9i9QrPYdBPfnhXnqAoxMt9o2oIGlaUYByjNwA6SdVOPVO909/bNIuPfaHBE
         o2LX4KQRAJ9MET/a4drIogHPYUhVIzADMZwHZxPw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191014144407.23264-1-yuehaibing@huawei.com>
References: <20191014144407.23264-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, david@lechnology.com,
        mturquette@baylibre.com, nsekhar@ti.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: davinci: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:32:52 -0700
Message-Id: <20191016233252.EB2A82168B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-14 07:44:07)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

