Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D0C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101B5208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfIBRvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:51:46 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:33488 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBRvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:51:46 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-83-161-nat.elisa-mobile.fi [85.76.83.161])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id DF51BB0335;
        Mon,  2 Sep 2019 20:51:42 +0300 (EEST)
Date:   Mon, 2 Sep 2019 20:51:42 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, chenhc@lemote.com,
        paul.burton@mips.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.co, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/13] MIPS: Loongson64: Sepreate loongson2ef/loongson64
 code
Message-ID: <20190902175142.GB4339@darkstar.musicnaut.iki.fi>
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
 <20190827085302.5197-3-jiaxun.yang@flygoat.com>
 <20190827220506.GK30291@darkstar.musicnaut.iki.fi>
 <c03045cd-25df-a3b9-3b3b-cf09b7fdd3fa@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c03045cd-25df-a3b9-3b3b-cf09b7fdd3fa@flygoat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:37:34AM +0800, Jiaxun Yang wrote:
> On 2019/8/28 上午6:05, Aaro Koskinen wrote:
> Hi Aaro,
> >You need to update lemote2f_defconfig with his patch.
> 
> How to generate this config? We should not edit it manually right?

It's possible to edit changed symbols by hand. Minimal defconfigs are
generated with "make savedefconfig".

A.
