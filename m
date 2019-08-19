Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7CBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C64214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566241499;
	bh=g+l2+zh4XmFO/8rBiCLB79CWSua+bEB7GY7mMkA0vfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GVZV0LKbugBOh4RmE2N8r3ZUiEXi5pumPgN0QIhz61mU9bXnF6hHSHZVLcTGoeIUq
	 ZVv8m0vO/l4STt7+AR/vYld31A2jczwssoEZUTZdxSsYWTuEvX6OezPpbIKpQUzTIR
	 fgKZblYVViBxONukvwCAvSs6NxoPl+WsyySg4M9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfHSTE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfHSTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:04:58 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655E122CEC;
        Mon, 19 Aug 2019 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566241497;
        bh=g+l2+zh4XmFO/8rBiCLB79CWSua+bEB7GY7mMkA0vfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zb6DGbwP1Y5p9aufmWC7I/NvG/liUM04r4ChEz3Z1PEPWxgJ2GkzaxHnqPJJtnclj
         hnRiu9+1BXePWtrJoTEG93wG1o4FOuBF1aFb3lpZI4bjUXew9iF24UnHGBVPBG77Gb
         v/lHDWjcmkJ0fwDJUJHCjzbALTkE3SsrpQ8NtL68=
Received: by mail-qk1-f178.google.com with SMTP id 125so2362410qkl.6;
        Mon, 19 Aug 2019 12:04:57 -0700 (PDT)
X-Gm-Message-State: APjAAAX+Gh+On1Xxn/tu0BNB5HCMFJHXvgleKadhU8diVOACT7KrpeVN
        zh/MCKt4du2SHztlFCwX8CcWugmNd3h9uAKdDA==
X-Google-Smtp-Source: APXvYqwA2SjNSoVoQTjKoWrws6Xv9owHy2CJpILgSiuSxS3tYOqCq0Hh+e2lXIQ4Qhqn6fxIUQ08R2wQZn7Rxv135B8=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr21480176qkn.254.1566241496563;
 Mon, 19 Aug 2019 12:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190819182039.24892-1-mripard@kernel.org>
In-Reply-To: <20190819182039.24892-1-mripard@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Aug 2019 14:04:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+jb+jVLuXeEDVwu19_4YinZEyD9Q5-=-ZGS7YoCrf=2Q@mail.gmail.com>
Message-ID: <CAL_Jsq+jb+jVLuXeEDVwu19_4YinZEyD9Q5-=-ZGS7YoCrf=2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: watchdog: Add YAML schemas for the
 generic watchdog bindings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:20 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The watchdogs have a bunch of generic properties that are needed in a
> device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - New patch
> ---
>  .../bindings/watchdog/watchdog.yaml           | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
