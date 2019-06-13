Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A780C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE03521743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560437967;
	bh=GYf/+gkGyncHp31uy7FPojBQ7mL+yl6nzbXTfvhlMGc=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=Rg/SVHcf0oStPwvwPkLlkhp65pwXtRbL07ipeR3YR4Vk2Y5V2k/vhssLv+JU/k/Nn
	 kObiWs3L8MfDnQr8ZEfJDnIewP8TvyWXLdOEwbrUuhnx/hy+rtL5msbF89+wh84N+o
	 g+V/riEbxThJ2tWrbotydX9vo10LGIaJlppW/MSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbfFMO70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 10:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732611AbfFMOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:54:07 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82BB2175B;
        Thu, 13 Jun 2019 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560437647;
        bh=GYf/+gkGyncHp31uy7FPojBQ7mL+yl6nzbXTfvhlMGc=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=TcJCjqavWAlojNJrYEhlAxJC2cZ5+UcNQ+J8ry2eA6PDcyKHn5GTWrvlFPceYjtSN
         fNESd+v8TcrthsynLoOq6/UUiPKuYYYpkBjUXEUYtQvUnIEhzpGldliabELRtYoQf4
         H75jbCoov7obKq4HVZrmdfy9zEZ/PwTSrtP3JxCc=
Received: by mail-lj1-f182.google.com with SMTP id k18so18822574ljc.11;
        Thu, 13 Jun 2019 07:54:06 -0700 (PDT)
X-Gm-Message-State: APjAAAV6XUq9F9E39O5SnpoMeGacdv0A3u8+bNEknKmJ8R7Hq8pUXmxb
        zRI4+rKoLbLikeEtjCjloRJ44nNXNOhJlB2X4sE=
X-Google-Smtp-Source: APXvYqxHuV7Q03SqzPQJxsXIaEVNMtkbU1nrHhyj83hOaQCq0FDxpomV2Y8SgjCcQw0UPaOf6ZfRnkeRkUssQQzCFAM=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr39255568lje.143.1560437645055;
 Thu, 13 Jun 2019 07:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190604185229.7393-1-krzk@kernel.org>
In-Reply-To: <20190604185229.7393-1-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 13 Jun 2019 16:53:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd4LVFGgonbsuxii-5Fu5wWhxU9yotLHw+OXsPcxYw_3g@mail.gmail.com>
Message-ID: <CAJKOXPd4LVFGgonbsuxii-5Fu5wWhxU9yotLHw+OXsPcxYw_3g@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: configs: Remove useless UEVENT_HELPER_PATH
To:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 at 20:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> For vexpress:
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> ---
>
> Changes since v2:
> 1. Remove unrelated files.
> 2. Add Geert's ack.
>
> Changes sice v3:
> 1. Change also mini2440_defconfig.
> 2. Add more acks.

Hi Arnd and Olof,

Do you want to apply it directly or maybe I can send it along with
other my defconfig pull request?

Best regards,
Krzysztof
