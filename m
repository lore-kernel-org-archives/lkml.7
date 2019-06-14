Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7577AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811F208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFNNEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:04:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37893 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfFNNEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:04:54 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hblst-0004De-V0; Fri, 14 Jun 2019 15:04:48 +0200
Date:   Fri, 14 Jun 2019 15:04:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Kitt <steve@sk2.org>
cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Drop unused isa_page_to_bus
In-Reply-To: <20190613161155.16946-1-steve@sk2.org>
Message-ID: <alpine.DEB.2.21.1906141504230.1722@nanos.tec.linutronix.de>
References: <20190613161155.16946-1-steve@sk2.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Stephen Kitt wrote:

> isa_page_to_bus is deprecated and no longer used anywhere, this patch
> removes it entirely.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
