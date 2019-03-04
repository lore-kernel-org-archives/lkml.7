Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671E5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F6220835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="2k1OgDds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfCDAYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:24:42 -0500
Received: from tomli.me ([153.92.126.73]:42926 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfCDAYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:24:42 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id af83b442;
        Mon, 4 Mar 2019 00:24:39 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 00:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=DTZBnQX/0sVb4WUV/kiNo5pPv8ABNI+ejo/DyALhMrU=; b=2k1OgDdsCJDITcOV+nxJNDAJ/d6+6Ghm5k86Dw1nGq8cYfU/BWkosXXHwAF2GIUCJniGvV6br9Q7tiNUecOvfE7pO4bGcGsfOkUnjnyHy9qPmVtTbEpLlELjVDGTC4uOygLL04mA24WB1Y6veuXAhM2+gscJhqKYCbI/IiAEo5xpUMHyzJm4p/EfHAsyDIlHzFsS1RPOoK7mjUn68T/iR/QOhNTaoI/0gvbaXTbwlgBeBCNPwnkkFTrrZGLsyLYMA8jUUVN4ViPb/0SOeiO2PE704QBD163ZPeLU4x3+0AxAB0bAVz5bGSEs+Mbl6vqJxdX9K0/jraOpJ+DgFnNAqA==
Date:   Mon, 4 Mar 2019 08:24:29 +0800
From:   Tom Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     kbuild-all@01.org, Yifeng Li <tomli@tomli.me>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mfd: yeeloong_kb3310b: support KB3310B EC for Lemote
 Yeeloong laptops.
Message-ID: <20190304002428.GA1043@localhost.localdomain>
References: <20190302175334.5103-2-tomli@tomli.me>
 <201903040432.qyPxOrOQ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903040432.qyPxOrOQ%fengguang.wu@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    drivers/mfd/yeeloong_kb3310b.c: In function 'kb3310b_read':
> >> drivers/mfd/yeeloong_kb3310b.c:70:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
>      outb((reg & 0xff00) >> 8, KB3310B_IO_PORT_HIGH);
>      ^~~~
> >> drivers/mfd/yeeloong_kb3310b.c:72:8: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
>      val = inb(KB3310B_IO_PORT_DATA);
>            ^~~

Nice bot.

I'll send out PATCH v2 soon with this fixed.

Cheers,
Tom Li
