Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88765C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6889220693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfGHBTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:19:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfGHBTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfw1DV0z9sP8; Mon,  8 Jul 2019 11:19:35 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 14b2f7d908c374df57792410bc0100dd71be4e5c
In-Reply-To: <1559635233-21385-1-git-send-email-krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] powerpc/configs: Remove useless UEVENT_HELPER_PATH
Message-Id: <45hnfw1DV0z9sP8@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-04 at 08:00:33 UTC, Krzysztof Kozlowski wrote:
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

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/14b2f7d908c374df57792410bc0100dd71be4e5c

cheers
