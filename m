Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933BFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B41821882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfGCUAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:00:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfGCUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:00:05 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hilQ1-0007N7-UG; Wed, 03 Jul 2019 21:59:54 +0200
Date:   Wed, 3 Jul 2019 21:59:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Helen Koike <helen.koike@collabora.com>
cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        eddie.cai.linux@gmail.com, mchehab@kernel.org, heiko@sntech.de,
        jacob2.chen@rock-chips.com, jeffy.chen@rock-chips.com,
        zyc@rock-chips.com, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        kernel@collabora.com, ezequiel@collabora.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhengsq@rock-chips.com, Zheng Yang <zhengyang@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v7 04/14] media: rkisp1: add Rockchip MIPI Synopsys DPHY
 driver
In-Reply-To: <20190703190910.32633-5-helen.koike@collabora.com>
Message-ID: <alpine.DEB.2.21.1907032153410.1802@nanos.tec.linutronix.de>
References: <20190703190910.32633-1-helen.koike@collabora.com> <20190703190910.32633-5-helen.koike@collabora.com>
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

Helen,

On Wed, 3 Jul 2019, Helen Koike wrote:

> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Rockchip MIPI Synopsys DPHY driver
> + *
> + * Based on:
> + *
> + * Copyright (C) 2016 FuZhou Rockchip Co., Ltd.
> + * Author: Yakir Yang <ykk@@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.

So the SPDX-Identifiers says: GPL-2.0+ and here someone copied a broken
boiler plate text which could be interpreted as GPLv2 only because the 'or
at your option any later version' part was removed.

Can you please remove that boiler plate language? It's redundant
information. The SPDX license identifier is unambiguous, machine readable
and legally binding license information.

Thanks,

	tglx
