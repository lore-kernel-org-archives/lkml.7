Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD01C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1E92075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfKYNeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:34:37 -0500
Received: from ns.iliad.fr ([212.27.33.1]:60626 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbfKYNeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:34:36 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4D17020C37;
        Mon, 25 Nov 2019 14:34:35 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3BAEB20C1C;
        Mon, 25 Nov 2019 14:34:35 +0100 (CET)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125231.GO25745@shell.armlinux.org.uk>
 <45730e3c-efc7-4433-4980-e6aefebdcbff@free.fr>
 <20191125133103.GR25745@shell.armlinux.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <7373182d-753c-a87b-8408-ffe4b7ac341f@free.fr>
Date:   Mon, 25 Nov 2019 14:34:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125133103.GR25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Nov 25 14:34:35 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 14:31, Russell King - ARM Linux admin wrote:

> The clk API and CCF are two different things.  I look after the clk API.
> The CCF is an implementation of the clk API.  Do not introduce clk API
> code in files that are CCF specific.

CCF is the acronym for Common Clock Framework?
