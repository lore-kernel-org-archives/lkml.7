Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C1EC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9482199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563831658;
	bh=y0mcCIsdo0FcATXDcOqG1yEJ21Gs2qykOfjRdssCnxw=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=fcUFX1zwCpqlzW5lgVMdlvggHWCJy3oge9u999gGQVRInEXT714uZgrQjFKb0pWWn
	 Cctqb2p5wr+qGu+7Lz/JBdf6kyfVqzMW4pK33Z0SH/Yqe+qbunpywY2UJPJhW/uJ8X
	 8PYsemAWF+i5OGMgrqaOKmzv6tm22diXUtfpNFe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfGVVkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732789AbfGVVkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:40:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D9F21951;
        Mon, 22 Jul 2019 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831640;
        bh=y0mcCIsdo0FcATXDcOqG1yEJ21Gs2qykOfjRdssCnxw=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=LlEINdah35joUMLAd7h7JkAX4r+iajAkvWTpl0RJK1BI/wTmyCqxiaVOpZR6MmL5C
         tShW8EN8CPJ5jy8e+ctwKH1V6MC+kxBVXl/FZNH8197I1dU170tYoYePP+4OsklIyt
         GVBnYiV2pgosObI4Xw/E4i54QatiK2/6phwyLAlY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190709182018.23193-2-gch981213@gmail.com>
References: <20190709182018.23193-1-gch981213@gmail.com> <20190709182018.23193-2-gch981213@gmail.com>
Subject: Re: [PATCH 1/5] MIPS: ralink: add dt binding header for mt7621-pll
To:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weijie Gao <hackpascal@gmail.com>, NeilBrown <neil@brown.name>,
        Chuanhong Guo <gch981213@gmail.com>,
        Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:40:39 -0700
Message-Id: <20190722214039.E9D9F21951@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject of this patch is confusing. Not sure what it has to do with
"MIPS:" so maybe remove that and prefix it "dt-bindings: clock:"
instead.

Quoting Chuanhong Guo (2019-07-09 11:20:14)
> This patch adds dt binding header for mediatek,mt7621-pll
>=20
> Signed-off-by: Weijie Gao <hackpascal@gmail.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Otherwise looks ok to me. Should I apply it to clk tree?

>  include/dt-bindings/clock/mt7621-clk.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt7621-clk.h
>=20
