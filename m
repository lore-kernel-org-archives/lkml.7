Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31EC2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558393230;
	bh=dwYdtJFqgk5WnKGN1vdh3maFVGEpJsAMNi0isL1qAB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bxabszo31AnRkFfIDeY02ebKXKK/shUP76iONyPHtXWjsPz28sazhywYgOGlYbPWE
	 YzoKiqs/exzXxRi28zXyvoAmDWJOd5I/5TbS4YAqEvTuBs/Log9nAIeDXge3o5uVNI
	 ZBsT4BE8auBd8ZQZGj9FeEYavst/zzoKiVdkymxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfETXAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfETXA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:00:29 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2296621743;
        Mon, 20 May 2019 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558393229;
        bh=dwYdtJFqgk5WnKGN1vdh3maFVGEpJsAMNi0isL1qAB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NmszipmjVLQy7SLs59z9lKtKWq+QtPHVSITYnoLhwAGWqtIXAZCjFd8jEZFwmc93a
         /UTG5ZdSBX1Aerbx4DUCTkBFQz23ty1+z5j5x37XIibSqDE0cMTWgLMuS92PvAlico
         wFVRB81vmtPy2hP91lSkicmIs+ZC07XlgYYOqiiw=
Received: by mail-qt1-f172.google.com with SMTP id l3so7554831qtj.5;
        Mon, 20 May 2019 16:00:29 -0700 (PDT)
X-Gm-Message-State: APjAAAWMq58hJyWPDYYpZZQiEcZuss0hUojiQV8Ct8mYclMKaRiE47i0
        vkyk8qhex7/3mlMuL8zNxHmus3bWPI7TvGwWZA==
X-Google-Smtp-Source: APXvYqw6CYhSggwUV7gsQLnkXGG6PApsuzJwfZ9MrjtG0br/Nx22pSC3kEjLcum6EYWMFL81vS6NoJzqn+y5HYSvGKA=
X-Received: by 2002:ac8:6b14:: with SMTP id w20mr44046792qts.110.1558393228435;
 Mon, 20 May 2019 16:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190520142330.3556-1-angus@akkea.ca> <20190520142330.3556-4-angus@akkea.ca>
In-Reply-To: <20190520142330.3556-4-angus@akkea.ca>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 May 2019 18:00:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nEdz-k9MLdVjXR7iC1BSM_93LyhVR3W31tESNSzHwYA@mail.gmail.com>
Message-ID: <CAL_Jsq+nEdz-k9MLdVjXR7iC1BSM_93LyhVR3W31tESNSzHwYA@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] dt-bindings: Add an entry for Purism SPC
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 9:23 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add an entry for Purism, SPC
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
