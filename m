Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C802133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfEWNTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:19:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:19:21 -0400
Received: from [5.158.153.53] (helo=nanos.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hTnco-00045s-PI; Thu, 23 May 2019 15:19:14 +0200
Date:   Thu, 23 May 2019 15:19:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     TonyWWang-oc <TonyWWang-oc@zhaoxin.com>
cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v1 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
In-Reply-To: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1905231516350.2291@nanos.tec.linutronix.de>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, TonyWWang-oc wrote:
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/zhaoxin.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zhaoxin Processor Support for Linux
> + *
> + * Copyright (c) 2019 Shanghai Zhaoxin Semiconductor Co., Ltd.
> + *
> + * Author: David Wang <davidwang@zhaoxin.com>
> + *
> + * This file is licensed under the terms of the GNU General
> + * License v2.0 or later. See file COPYING for details.

Please remove this boilerplate text. The SPDX license identifier is
sufficient, but looking at that:

> +// SPDX-License-Identifier: GPL-2.0

That clearly disagrees with your boilerplate text which says 'v2.0 or
later'. Assumed that you want or later, then the SPDX id needs to say so.

// SPDX-License-Identifier: GPL-2.0-or-later

Thanks,

	tglx




