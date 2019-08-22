Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1307BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF01233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566513371;
	bh=ZGarLzb1z82pc97B8UD712DtY9qzv28qrg/DgYfSiuM=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=TEfopXZ3zo4gI+UxUedKnLlBLopqeFLzJ90X3ZXJI+NJKnLJF82L1TuJNcWq/vp+X
	 zslcI7UM8/6+ZTbYxe21H80Qic0QhZ1RoCih+ttUiGlMXDc7cNlDoRVakxLv5Ebxur
	 3LjoFZs0XQres22505+9DMrVfr6MXUHrs0LraSZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbfHVWgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390875AbfHVWgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:36:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E4921848;
        Thu, 22 Aug 2019 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566513369;
        bh=ZGarLzb1z82pc97B8UD712DtY9qzv28qrg/DgYfSiuM=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=shjdmtvcHkqgJpZxt1Cw4yGlVgFdLPayN6eGqrM79ndoZ9gils2taxUgCoKjjL+Nw
         jHH/zWFHC8o8whwhsWWpUdAq2XnbDmr59SpffYnQJrmKxt43QBXXEZZFmlBpDWX6+b
         1kZt0afG+eQspwGdCzWYKnGqz6QK2HLN1MIEZ38k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1e13a307539b47b8d874bdc5c36b705ba7a72f7e.camel@v3.sk>
References: <20190816185716.530013-1-lkundrak@v3.sk> <20190816192707.DCC022133F@mail.kernel.org> <1e13a307539b47b8d874bdc5c36b705ba7a72f7e.camel@v3.sk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: tidy up the help tags in Kconfig
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 22 Aug 2019 15:36:08 -0700
Message-Id: <20190822223609.53E4921848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-08-22 02:36:02)
> On Fri, 2019-08-16 at 12:27 -0700, Stephen Boyd wrote:
> > Quoting Lubomir Rintel (2019-08-16 11:57:16)
> > > Sometimes an extraneous "---help---" follows "help". That is probably=
 a
> > > copy&paste error stemming from their inconsistent use. Let's just rep=
lace
> > > them all with "help", removing the extra ones along the way.
> >=20
> > Can you just send the patch to remove the extra ones? I don't really
> > care to make it consistent in the same patch.
>=20
> Sure. Just done so.
>=20
> Do you also care about making it consistent, or is it okay to just
> leave it as it is?
>=20
>=20

I don't think it matters. We just need to not duplicate it. Maybe we
could add some check to Kconfig to detect duplicate help sections too.

