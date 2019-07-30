Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EEBC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EF720665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfG3JR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:17:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56169 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfG3JR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:17:59 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsOGb-0003Bm-GN; Tue, 30 Jul 2019 11:17:57 +0200
Date:   Tue, 30 Jul 2019 11:17:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chuhong Yuan <hslester96@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 05/12] genirq/debugfs: Replace strncmp with
 str_has_prefix
In-Reply-To: <20190729151435.9498-1-hslester96@gmail.com>
Message-ID: <alpine.DEB.2.21.1907301113580.1738@nanos.tec.linutronix.de>
References: <20190729151435.9498-1-hslester96@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019, Chuhong Yuan wrote:

> strncmp(str, const, len) is error-prone.
> We had better use newly introduced
> str_has_prefix() instead of it.

Can you please provide a proper explanation why the below strncmp() is
error prone?

Just running a script and copying some boiler plate changelog saying
'strncmp() is error prone' does not cut it.

> -	if (!strncmp(buf, "trigger", size)) {
> +	if (str_has_prefix(buf, "trigger")) {

Especially when the resulting code is not equivalent.

Thanks,

	tglx
