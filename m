Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0795121556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576074546;
	bh=N8PbFLkORFvjWt9sLI4T9YHFqVWqnofZgm531GGx/5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yBQtl44wnj88R4FdgkL6UjeAmFE+IVILlWHnW7yWxI7N+YgKoBYNdSW3Qz15YdUpR
	 jD8GGJgtogytSoJMbJThkmxT0tkfSI7IvFP62tK2iAlq0Nij2uffz61wTz1qH3g5+j
	 RR4GbktvfN53KlBvg5AD4/wE5jfLsOA6Byfl16Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfLKO3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfLKO3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:29:04 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D453C22B48;
        Wed, 11 Dec 2019 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576074544;
        bh=N8PbFLkORFvjWt9sLI4T9YHFqVWqnofZgm531GGx/5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/vHswAa4Py9NtwngVg0E+ERq9UCWTuf40G9x6bs+Qa5YGvhxP55rO15r5AqfsuJH
         2PvUT0gv7XO2QvD7ipJK2H4nU7mf3DJp9SrEHCBzWSXZwqBuNCxqIQxvScy7g0tdX2
         uRUotylziv8axWluuyh6XFmtVzD4iB5hUXX4EybQ=
Received: by mail-qv1-f47.google.com with SMTP id t7so5794868qve.4;
        Wed, 11 Dec 2019 06:29:03 -0800 (PST)
X-Gm-Message-State: APjAAAXL/qxRrMyG04jhHBrDv0zePHRADHuijmGWIs3jpvOsEZHm9L8N
        NcKV1XC2V2EdA04ZkmIwzTH224nJyTmAGy+U+w==
X-Google-Smtp-Source: APXvYqyslXHQeTlnxyWBHE+KQno4F7yO5jXM3IgMVqdVyPdAJw+emUIKIy0nf6WbxEaL8liKiMq7CxtC86P/ZYmk4FI=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr3244655qvo.20.1576074542962;
 Wed, 11 Dec 2019 06:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20191209233305.18619-1-michael@walle.cc>
In-Reply-To: <20191209233305.18619-1-michael@walle.cc>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Dec 2019 08:28:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJB5oeUmtzV0jT0f-Rh22Cf3OzMVpfZvRa6xOEhx3e2cA@mail.gmail.com>
Message-ID: <CAL_JsqJB5oeUmtzV0jT0f-Rh22Cf3OzMVpfZvRa6xOEhx3e2cA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: document the fsl-sai driver
To:     Michael Walle <michael@walle.cc>
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 5:33 PM Michael Walle <michael@walle.cc> wrote:
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - dual license gpl-2.0-only and bsd-2-clause
>  - add "additionalProperties: false"
>  - wrap example in soc {} node with correct #address-cells and #size-cells
>
>  .../bindings/clock/fsl,sai-clock.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
