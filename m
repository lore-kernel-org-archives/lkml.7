Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A85EC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF27D2339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfHTIqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:46:45 -0400
Received: from ns.iliad.fr ([212.27.33.1]:55198 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfHTIqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:46:45 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 42788213EB;
        Tue, 20 Aug 2019 10:46:43 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 2BEBE201B3;
        Tue, 20 Aug 2019 10:46:43 +0200 (CEST)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
Message-ID: <96b30b79-1e9b-bbdb-8bd5-b1e82b83e78c@free.fr>
Date:   Tue, 20 Aug 2019 10:46:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Aug 20 10:46:43 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2019 17:34, Marc Gonzalez wrote:

> Provide devm variants for automatic resource release on device removal.
> probe() error-handling is simpler, and remove is no longer required.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  Documentation/driver-model/devres.rst |  3 +++
>  drivers/clk/clk.c                     | 24 ++++++++++++++++++++++++
>  include/linux/clk.h                   |  8 ++++++++
>  3 files changed, 35 insertions(+)

Stephen, Mike,

Thoughts? Comments?

Regards.
