Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77844C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A772186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566821465;
	bh=RQQYenaHO1We36aA/sTFhPjRCVJtTam6Xh8rOSVyZIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DxUyKMsO9jmWpcIbX4Qan3VRoThfsHj7NbWoN2+8C8ofUGkLKZ9xJyCQ3bEY/3qD2
	 Ij4Ha0THVC+OiC0uSxlrUujWvm9BXHt5gPIioD2LaKy7f4U/U+pWnSf4JqaeG2zIca
	 q2Ki6q7UUYVjB24BCpcA8QtDQGXTgqyNGPNXcJsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfHZMLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730841AbfHZMLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:11:03 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5A32186A;
        Mon, 26 Aug 2019 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566821463;
        bh=RQQYenaHO1We36aA/sTFhPjRCVJtTam6Xh8rOSVyZIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LfkBmC+XCAqE+tHlu7Y94bpSTLY9+aTQUEYNIA8XTpKecTBsW+LPD+0ul3iwGyMU7
         F9Tk8tVr4lTWV06j+QbfE0wtFPpfvVWDEWyNFxIwPBG9r0T80bzkJXK/610CMeMHEn
         R39GJUGMQItyoh8yuCKvXkVvShYfTvIt1W5hljUI=
Received: by mail-qt1-f178.google.com with SMTP id y26so17594539qto.4;
        Mon, 26 Aug 2019 05:11:03 -0700 (PDT)
X-Gm-Message-State: APjAAAU6W+lHyNMdY1tUt/TTrCGZUqNRbntxkzWVOxqdKtJicKXcP5Qv
        ol254H3Xm6b65MCM/oIxk2s/MVlA+8FcGQon4A==
X-Google-Smtp-Source: APXvYqwoiMD5LlRk2/FPphU9B2qUd5FKFbojCZmShFSHNq7fBlsxlxPuXEu3AGwHM//EAWDsRS+w6+ti9+Fdn1RuB6E=
X-Received: by 2002:ad4:4050:: with SMTP id r16mr15134256qvp.200.1566821462484;
 Mon, 26 Aug 2019 05:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com> <1566633850-9421-2-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1566633850-9421-2-git-send-email-christianshewitt@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Aug 2019 07:10:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKXnpHf5=2aRxvx_wpKg2e0phDPL5PRNGkVUELyni5NDg@mail.gmail.com>
Message-ID: <CAL_JsqKXnpHf5=2aRxvx_wpKg2e0phDPL5PRNGkVUELyni5NDg@mail.gmail.com>
Subject: Re: [PATCH v2,1/3] dt-bindings: Add vendor prefix for Ugoos
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Ivanov <balbes-150@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 3:05 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Ugoos Industrial Co., Ltd. are a manufacturer of ARM based TV Boxes,
> Dongles, Digital Signage and Advertisement Solutions [0].
>
> [0] (https://ugoos.com)
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
