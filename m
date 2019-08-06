Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F2DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A2420C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565102920;
	bh=x7+zuhPSgSXmr3tQYyWqjuUN30oPsXPwF0umtxRNEHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FD/8sCm4elfF4VXaY9uQgzCARQJTFmYeLNejExOXqRO/rYy3uYCZpCpoK6Loq5k7r
	 gY5QDxfDpIndR7K6TtnXzse5l1cuEGb3MpFaOVqt5G2ZkVOkTTj+TcUGJ7rniiHQZ6
	 dQfxTi4/Q7eCCchqZkSXql9lKHVW3QR8QT5uPWjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfHFOsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbfHFOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:48:39 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87FB2173B;
        Tue,  6 Aug 2019 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565102918;
        bh=x7+zuhPSgSXmr3tQYyWqjuUN30oPsXPwF0umtxRNEHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w19qnzWgKd1l9VJRONLsxahJe2Zq24AjsLOh/sS/sRdya6nJo0NcopWNDa+xlwwhp
         SNMhuFLrRJzo9AN2RT4Lh4pEmbuCY8hXM9gveqVbnExdRBM3Z8FAvp3moXTTWjQm5X
         N21od/+8QLv9Jso9txuCarmFtzgOq725DPDRolCQ=
Received: by mail-qt1-f181.google.com with SMTP id h21so84726755qtn.13;
        Tue, 06 Aug 2019 07:48:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWOga4peFWYkrmb2pFdzA3S8SQ8/X0qQiacPil+c+6ZHfJQCyv0
        D+RQlXV4EOUM1UyVGspdyJON5mnnVsQXZ2Gp8w==
X-Google-Smtp-Source: APXvYqzdOZglR4quROk3FUKY2+tfejjSYSYfOGLsawyMXpxA6lYUzY//ZPC4x3/JKIJvpf2DMxrxuZM012h5EesF4sA=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr3347606qtb.224.1565102917107;
 Tue, 06 Aug 2019 07:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190805124037.10597-1-andyshrk@gmail.com>
In-Reply-To: <20190805124037.10597-1-andyshrk@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Aug 2019 08:48:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6_J1pR-MYK5kmUN5Q+tX32UNFqLW81tmBf=pYxtAmjg@mail.gmail.com>
Message-ID: <CAL_JsqJ6_J1pR-MYK5kmUN5Q+tX32UNFqLW81tmBf=pYxtAmjg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dts for Leez RK3399 P710 SBC
To:     Andy Yan <andyshrk@gmail.com>
Cc:     "heiko@sntech.de" <heiko@sntech.de>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 6:40 AM Andy Yan <andyshrk@gmail.com> wrote:
>
> P710 is a RK3399 based SBC, designed by Leez [0].
>
> Specification
> - Rockchip RK3399
> - 4/2GB LPDDR4
> - TF sd scard slot
> - eMMC
> - M.2 B-Key for 4G LTE
> - AP6256 for WiFi + BT
> - Gigabit ethernet
> - HDMI out
> - 40 pin header
> - USB 2.0 x 2
> - USB 3.0 x 1
> - USB 3.0 Type-C x 1
> - TYPE-C Power supply
>
> [0]https://leez.lenovo.com

I'm not really convinced Leez is a vendor. Looks like branding to me.
We have enough with company names changing, we don't need changing
brands too. Use 'lenovo'.

Rob
